# 04_figures.R
# Figures for nomophobia (NMP-Q) and insomnia: pre–post by group.

library(dplyr)
library(ggplot2)

# Assumes data80 (baseline) and post80 (pre–post) exist
# If needed:
# source("01_import_clean.R")
# source("03_change_analyses.R")

## Figure 1: Nomophobia (NMP-Q) pre vs post by group

# 1. Baseline NMP-Q by group
base_nmp <- data80 %>%
  group_by(Group) %>%
  summarise(
    mean_nmp = mean(`NMP-Q SCORE`, na.rm = TRUE),
    sd_nmp   = sd(`NMP-Q SCORE`, na.rm = TRUE),
    n        = n(),
    se_nmp   = sd_nmp / sqrt(n)
  )

# 2. Post NMP-Q by group
post_nmp <- post80 %>%
  group_by(Group) %>%
  summarise(
    mean_nmp = mean(Post_NMP, na.rm = TRUE),
    sd_nmp   = sd(Post_NMP, na.rm = TRUE),
    n        = n(),
    se_nmp   = sd_nmp / sqrt(n)
  )

# 3. Combine for plotting
fig1_dat <- bind_rows(
  base_nmp %>% mutate(Time = "Pre"),
  post_nmp %>% mutate(Time = "Post")
)

fig1_dat$Time <- factor(fig1_dat$Time, levels = c("Pre", "Post"))
fig1_dat$Group <- factor(
  fig1_dat$Group,
  levels = c("Control", "Guided imagery", "Sports activity", "Composite")
)

# 4. Plot: group on x-axis, pre/post as separate lines with error bars
fig1 <- ggplot(fig1_dat,
               aes(x = Group, y = mean_nmp, group = Time, color = Time)) +
  geom_line(position = position_dodge(width = 0.2)) +
  geom_point(position = position_dodge(width = 0.2), size = 2.8) +
  geom_errorbar(aes(ymin = mean_nmp - se_nmp,
                    ymax = mean_nmp + se_nmp),
                width = 0.15,
                position = position_dodge(width = 0.2)) +
  labs(
    x = "Group",
    y = "Mean NMP-Q score",
    color = "Time"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right"
  )

fig1  # print when running interactively

## Figure 2: Insomnia pre vs post by group

# 1. Baseline insomnia by group
base_ins <- data80 %>%
  group_by(Group) %>%
  summarise(
    mean_ins = mean(INSOMNIA_RAW, na.rm = TRUE),
    sd_ins   = sd(INSOMNIA_RAW, na.rm = TRUE),
    n        = n(),
    se_ins   = sd_ins / sqrt(n)
  )

# 2. Post insomnia by group
post_ins <- post80 %>%
  group_by(Group) %>%
  summarise(
    mean_ins = mean(Post_INS, na.rm = TRUE),
    sd_ins   = sd(Post_INS, na.rm = TRUE),
    n        = n(),
    se_ins   = sd_ins / sqrt(n)
  )

# 3. Combine for plotting
fig2_dat <- bind_rows(
  base_ins %>% mutate(Time = "Pre"),
  post_ins %>% mutate(Time = "Post")
)

fig2_dat$Time <- factor(fig2_dat$Time, levels = c("Pre", "Post"))
fig2_dat$Group <- factor(
  fig2_dat$Group,
  levels = c("Control", "Guided imagery", "Sports activity", "Composite")
)

# 4. Plot: same style as Figure 1
fig2 <- ggplot(fig2_dat,
               aes(x = Group, y = mean_ins, group = Time, color = Time)) +
  geom_line(position = position_dodge(width = 0.2)) +
  geom_point(position = position_dodge(width = 0.2), size = 2.8) +
  geom_errorbar(aes(ymin = mean_ins - se_ins,
                    ymax = mean_ins + se_ins),
                width = 0.15,
                position = position_dodge(width = 0.2)) +
  labs(
    x = "Group",
    y = "Mean insomnia score",
    color = "Time"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right"
  )

fig2  # print when running interactively
