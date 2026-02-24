# Nomophobia–Insomnia Intervention Study in Undergraduates

This repository contains data and analysis code for a quasi-experimental study on the effects of guided imagery, sports activity, and a composite program on nomophobia, insomnia, and related psychological variables in undergraduate students.

## Repository structure

- `FINAL PRE  DATA 80.xlsx` – Original Excel workbook with:
  - Sheet 1: Baseline data (nomophobia, insomnia, social intelligence, neuroticism, tachycardia, group).
  - Sheet 2: Pre–post scores for all outcomes.
- `01_import_clean.R` – R script to import the Excel file, do basic cleaning, and run initial checks.
- `data/` – Placeholder folder for derived datasets and outputs.
- `README.md` – This description.
- `LICENSE` – MIT license for the code.
- `02_baseline_analyses.R` – Baseline ANOVAs, effect sizes, and assumption checks.
- `03_change_analyses.R` – Pre–post change-score models for nomophobia and insomnia.
- `04_figures.R` – Code to generate NMP-Q and insomnia figures.
  
## Software

Analyses were conducted in:

- R version 4.5.2 (2025-10-31, “[Not] Part in a Rumble”)
- Main packages: `readxl`, `dplyr`, `psych`, `ggplot2`, `effectsize`, `car`

## Planned scripts

Additional R scripts may be added later, for example:

1. `02_baseline_analyses.R` – Descriptive statistics, correlations, baseline ANOVAs and effect sizes.
2. `03_change_analyses.R` – Pre–post change scores, regression/ANCOVA models.
3. `04_figures.R` – Code to generate figures for nomophobia, insomnia, and other outcomes.


## How to use

1. Download this repository (Code → Download ZIP) and unzip locally.
2. Open R or RStudio in the project folder.
3. Run the scripts in numerical order once they are added to `scripts/` to reproduce the analyses and figures used in the manuscript.
