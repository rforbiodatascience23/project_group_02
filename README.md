# project_group_02

## Project contributors

| Contributor name                  | Student ID | GitHub username  |
|-----------------------------------|------------|------------------|
| Anna Keisha Mercy Kyei Boateng    | 175562     | KeishaBoateng97  |
| Anne Kargaard Gjelstrup           | 194530     | Anne-KG          |
| Marlies Jilles Francine Goedknegt | 220675     | MarliesJFrancine |
| Katja Naasunnguaq Jagd            | 185395     | Katja-Jagd       |
| Olivia Ronnenberg                 | 183359     | Oliv3460         |

## Introduction

### Background information

This project analyzes genetic expression data. Specifically, from a study on the influence of disease modifying anti-rheumatic drugs (DMARD) treatment in rheumatoid arthritis (RA) patients. The paper found certain genetic regulator molecules to be of interest, for example due to their drastic change in expression under DMARD treatment.

The paper focuses on genetic expression in 19 RA patients, compared to a comparable number of healthy control samples.

### Project aim

As an additional research question, this project investigates the difference in regulators and target molecules in RA patients before and after treatment. To further analyze the effects of DMARD drugs and potentially discover further drug targets.

## Data accessibility

For this analysis, data from the study *Triple DMARD treatment in early rheumatoid arthritis modulates synovial T cell activation and plasmablast/plasma cell differentiation pathways* by Walsh et.al. is used. It is gene expression data, obtained from synovial tissue biopsy samples from rheumatoid arthritis patients.

### How to download the data used for this analysis

The data can be found by clicking this link: <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5580991/>. Or via this DOI: 10.1371/journal.pone.0183928.

Navigate to **"Associated Data"** and then **"Supplementary Materials"** to find the Supplementary data tables. Data table **1 (pone.0183928.s001.xlsx)** and **3 (pone.0183928.s003.xlsx)** are used for this analysis.

### How to add the data to the correct location

After downloading these two .xlsx files, add them to a folder \*\*/data/\_raw\*\* within your directory where you have downloaded this repository. ***Please note that it is important that your .Rproj file is in the same location as the /data folder.***

## How to run the analysis

The analysis can be run in one step by using the **00_all.qmd** file, have fun analyzing!

For further details, and a step-by-step in-depth view of the analysis, please find each individual .qmd file.
