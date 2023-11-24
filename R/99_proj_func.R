# Function that changes header names, and selects relevant columns 
fix_headers_and_values <- function(data, suffix) {
  data <- data |>
    mutate("Expr Log Ratio" = as.numeric(`Expr Log Ratio`),
           "p-value of overlap" = as.numeric(`p-value of overlap`)) |> 
    rename_with(~str_c(.,
                       suffix), 
                starts_with(c("Expr",
                              "p-value",
                              "Target"))) |> 
    rename_all(~ str_replace_all(., "[^a-zA-Z]", "_")) |>
    rename_all(str_to_lower) |> 
    select(!c("mechanistic_network",
              "predicted_activation_state",
              "activation_z_score"))
  return (data)
}

# Function that only keeps significant observations 
filter_significant_observations <- function(data, p_column, expr_column) {
  data <- data |>
    filter({{p_column}} <= 0.05) |> 
    filter({{expr_column}} > 1.5 | {{expr_column}} < -1.5)
  return (data)
}

# Function that takes the columns relevant for the expression data of two
# data frames and joins them
all_expression_data <- function(data1, data2) {
  data1 <- data1 |>
    select(-contains("target")) 
  
  expr_data <- data2 |>
    select(-contains("target")) |> 
    inner_join(data1,
               by = c("upstream_regulator",
                      "molecule_type")) |> 
    relocate("expr_log_ratio_after",
             .after = "expr_log_ratio_before") |> 
    relocate("p_value_of_overlap_after",
             .after = "p_value_of_overlap_before")
  return (expr_data)
}

# Function that takes the columns relevant for the target molecule data 
# of two data frames and joins them
all_target_data <- function(data1, data2) {
  data1 <- data1 |>
    select(starts_with("upstream") | starts_with("target")) 
  
  target_data <- data2 |>
    select(starts_with("upstream") | starts_with("target")) |> 
    inner_join(data1,
               by = "upstream_regulator") |> 
    relocate("target_molecules_in_dataset_after",
             .after = "target_molecules_in_dataset_before")
  
  return (target_data)
}

# Functions that separates many values in one cell into one value per cell
split_cells <- function(data, crowded_column, suffix) {
  max_n_molecules <- data |>
    mutate(n_molecules = str_count({{crowded_column}},
                                   ",") + 1) |>
    summarize(max_n = max(n_molecules)) |> 
    pull()
  
  data <- data |> 
    separate({{crowded_column}},
             str_c("target_molecule_",
                          suffix,
                          "_",
                          1:max_n_molecules),
             ",")
  return (data)
}

# Function that creates a column with a class label for being significant or not
# And adding -log10 p-values 
significant_label <- function(data, p_column, expr_column, suffix) {
  data <- data |> 
    mutate(is_significant = case_when({{p_column}} <= 0.05 &
                                        {{expr_column}} > 1.5  ~ "yes",
                                      {{p_column}} <= 0.05 &
                                        {{expr_column}} < -1.5  ~ "yes")) |> 
    mutate(is_significant = coalesce(is_significant, "no")) |> 
    mutate("-log10_p_value" = -log10({{p_column}}))
  return (data)
}


# Function that counts how many times a candidate regulator has target molecules
# in the different modules
module_counter <- function(data, ID) {
  data <- data |> 
    filter(upstream_regulator == ID) |>
    select(contains("molecule_before")) |>
    map_df( ~ coexpression_clean |> 
              filter(gene == .x) |>
              select(c("modules",
                       gene))) |>
    count(modules, name = ID)
  
  return (data)
}