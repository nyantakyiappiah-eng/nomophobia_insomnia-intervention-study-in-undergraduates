# 01_import_clean.R
# Import baseline data (Sheet 1), clean variables, create group factor,
# and run basic descriptive and correlation analyses.

# 1. Load packages
library(readxl)
library(dplyr)
library(psych)

# 2. Import baseline data (Sheet 1 of the Excel file in the project root)
data <- read_excel("FINAL PRE  DATA 80.xlsx", sheet = 1)

# Quick check
str(data)
head(data)

# 3. Rename raw-score columns to clean names
# From inspection:
# - RAW SCORE...7  = insomnia raw
# - RAW SCORE...9  = social intelligence raw
# - RAW SCORE...11 = neuroticism raw
data <- data %>%
  rename(
    INSOMNIA_RAW    = `RAW SCORE...7`,
    SI_RAW          = `RAW SCORE...9`,
    NEUROTICISM_RAW = `RAW SCORE...11`
  )

# 4. Create grouping factor
# Adjust row ranges if needed; current mapping assumes 4 groups of 20 + 1 extra row
data$Group <- NA
data$Group[1:20]  <- "Guided imagery"
data$Group[21:40] <- "Sports activity"
data$Group[41:60] <- "Composite"
data$Group[61:80] <- "Control"

data$Group <- factor(
  data$Group,
  levels = c("Control", "Guided imagery", "Sports activity", "Composite")
)

# 5. Remove any rows with missing Group (e.g., extra header/blank row)
data80 <- data %>% filter(!is.na(Group))

# 6. Descriptive statistics by group for key variables
descr_by_group <- data80 %>%
  group_by(Group) %>%
  summarise(
    n          = n(),
    age_mean   = mean(AGE, na.rm = TRUE),
    NMP_mean   = mean(`NMP-Q SCORE`, na.rm = TRUE),
    NMP_sd     = sd(`NMP-Q SCORE`, na.rm = TRUE),
    Ins_mean   = mean(INSOMNIA_RAW, na.rm = TRUE),
    Ins_sd     = sd(INSOMNIA_RAW, na.rm = TRUE),
    SI_mean    = mean(SI_RAW, na.rm = TRUE),
    SI_sd      = sd(SI_RAW, na.rm = TRUE),
    Tachy_mean = mean(TACHYCARDIYA, na.rm = TRUE),
    Tachy_sd   = sd(TACHYCARDIYA, na.rm = TRUE)
  )

descr_by_group

# 7. Correlation matrix for baseline continuous variables
vars <- data80 %>%
  select(`NMP-Q SCORE`, INSOMNIA_RAW, SI_RAW, NEUROTICISM_RAW, TACHYCARDIYA)

corr_results <- psych::corr.test(vars)
corr_results
