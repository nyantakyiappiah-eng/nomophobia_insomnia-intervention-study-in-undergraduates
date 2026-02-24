# 01_import_clean.R
# Import baseline and pre-post data and perform basic cleaning.

library(readxl)
library(dplyr)

# Path to Excel file
data_file <- "FINAL PRE  DATA 80.xlsx"

# Read sheets
baseline <- read_excel(data_file, sheet = 1)
pre_post  <- read_excel(data_file, sheet = 2)

# Clean names (example placeholder)
baseline <- baseline |>
  rename(
    group   = Group,
    nmpq    = Nomophobia,
    insomnia = Insomnia
    # add other renames as needed
  )

pre_post <- pre_post  # to be updated

# Quick checks
str(baseline)
summary(baseline)
