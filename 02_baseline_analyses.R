# 02_baseline_analyses.R
# Baseline ANOVAs, effect sizes, and assumption checks.

library(dplyr)
library(effectsize)
library(car)

# Assume 01_import_clean.R has already been run, so data80 exists
# If not, you can source it:
# source("01_import_clean.R")

# 1. One-way ANOVAs at baseline
aov_nmp  <- aov(`NMP-Q SCORE`   ~ Group, data = data80)
aov_ins  <- aov(INSOMNIA_RAW    ~ Group, data = data80)
aov_SI   <- aov(SI_RAW          ~ Group, data = data80)
aov_tach <- aov(TACHYCARDIYA    ~ Group, data = data80)
aov_neur <- aov(NEUROTICISM_RAW ~ Group, data = data80)

summary(aov_nmp)
summary(aov_ins)
summary(aov_SI)
summary(aov_tach)
summary(aov_neur)

# 2. Effect sizes (eta-squared)
eta_nmp  <- eta_squared(aov_nmp,  partial = TRUE)
eta_ins  <- eta_squared(aov_ins,  partial = TRUE)
eta_SI   <- eta_squared(aov_SI,   partial = TRUE)
eta_tach <- eta_squared(aov_tach, partial = TRUE)
eta_neur <- eta_squared(aov_neur, partial = TRUE)

eta_nmp
eta_ins
eta_SI
eta_tach
eta_neur

# 3. Assumption checks for insomnia ANOVA (example)
levene_ins  <- leveneTest(INSOMNIA_RAW ~ Group, data = data80)
shapiro_ins <- shapiro.test(residuals(aov_ins))

levene_ins
shapiro_ins

# 4. Regression model predicting baseline insomnia from NMP-Q, age, and group
data80$Group <- relevel(data80$Group, ref = "Control")

model_ins <- lm(INSOMNIA_RAW ~ `NMP-Q SCORE` + AGE + Group, data = data80)
summary(model_ins)

# Optional: diagnostic plots (run interactively)
# par(mfrow = c(2, 2))
# plot(model_ins)
# par(mfrow = c(1, 1))
