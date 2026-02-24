# 03_change_analyses.R
# Pre–post change-score models for nomophobia and insomnia.

library(readxl)
library(dplyr)

# Assumes 01_import_clean.R has been run and data80 exists
# If needed:
# source("01_import_clean.R")

# 1. Read Sheet 2 (pre–post data)
post <- read_excel("FINAL PRE  DATA 80.xlsx", sheet = 2)

# Inspect raw structure (optional)
# str(post)
# head(post)

# 2. Drop first header row (row 1) and keep the 80 participants
post <- post[-1, ]

# 3. Rename columns to meaningful names
post <- post %>%
  rename(
    ID          = ...1,
    Pre_NMP     = `Pre...5`,
    Post_NMP    = `Post...7`,
    Pre_INS     = `Pre...9`,
    Post_INS    = `Post...11`,
    Pre_SI      = `Pre...13`,
    Post_SI     = `Post...15`,
    Pre_NEUR    = `Pre...17`,
    Post_NEUR   = `Post...19`,
    Pre_TACHY   = `Pre...21`,
    Post_TACHY  = `Post...22`
  )

# 4. Coerce pre–post scores to numeric
post <- post %>%
  mutate(
    Pre_NMP    = as.numeric(Pre_NMP),
    Post_NMP   = as.numeric(Post_NMP),
    Pre_INS    = as.numeric(Pre_INS),
    Post_INS   = as.numeric(Post_INS),
    Pre_SI     = as.numeric(Pre_SI),
    Post_SI    = as.numeric(Post_SI),
    Pre_NEUR   = as.numeric(Pre_NEUR),
    Post_NEUR  = as.numeric(Post_NEUR),
    Pre_TACHY  = as.numeric(Pre_TACHY),
    Post_TACHY = as.numeric(Post_TACHY)
  )

# 5. Restrict to first 80 rows to match data80 (80 participants)
post80 <- post[1:80, ]

# 6. Add Group and AGE from baseline dataset
post80$Group <- data80$Group
post80$AGE   <- data80$AGE

# 7. Compute change scores (Post – Pre)
post80 <- post80 %>%
  mutate(
    Delta_NMP   = Post_NMP   - Pre_NMP,
    Delta_INS   = Post_INS   - Pre_INS,
    Delta_SI    = Post_SI    - Pre_SI,
    Delta_NEUR  = Post_NEUR  - Pre_NEUR,
    Delta_TACHY = Post_TACHY - Pre_TACHY
  )

# 8. Change in nomophobia: regression model
lm_delta_nmp <- lm(Delta_NMP ~ Group + AGE + Pre_NMP, data = post80)
summary(lm_delta_nmp)

# 9. Change in insomnia: regression model
lm_delta_ins <- lm(Delta_INS ~ Group + AGE + Pre_INS, data = post80)
summary(lm_delta_ins)

# Optional: check row alignment
# nrow(data80); nrow(post80)
# head(data80$`ITEM NO.`); head(post80$ID)
