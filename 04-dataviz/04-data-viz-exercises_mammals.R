# Data Viz coding challenge, 
# DSI-2022-01

# Load packages
library(tidyverse)

# The mammals dataset
msleep %>% 
  select(vore, sleep_total) %>% 
  na.omit() -> msleep_total

# basic plot ----
ggplot(msleep_total, aes(vore, sleep_total)) +
  geom_point()

# Jitter ----
# jittering (width 0 = no jittering, 1 = max)
ggplot(msleep_total, aes(vore, sleep_total)) +
  geom_jitter(width = 0.2, alpha = 0.5, shape = 16)

# too little control on jittering width
# ggplot(msleep_total, aes(vore, sleep_total)) +
#   geom_point(position = "jitter", alpha = 0.5, shape = 16)

# different geoms to visualize - boxplot, density, violin, mean + sd

# boxplot ----
# Boxplot: Sometimes helpful but not here
ggplot(msleep_total, aes(vore, sleep_total)) +
  geom_boxplot()

# Density plots ----
# Density plot for all together
ggplot(msleep_total, aes(x = sleep_total)) +
  geom_density()

# Density plot w color and default y
ggplot(msleep_total, aes(x = sleep_total, color = vore)) +
  geom_density()

# using fill and default y
ggplot(msleep_total, aes(x = sleep_total, fill = vore)) +
  geom_density(color = NA, alpha = 0.5)

# using fill and default y, explicityl stated
ggplot(msleep_total, aes(x = sleep_total, y = ..density.., fill = vore)) +
  geom_density(color = NA, alpha = 0.5)

# using fill and y, explicit as count
ggplot(msleep_total, aes(x = sleep_total, y = ..count.., fill = vore)) +
  geom_density(color = NA, alpha = 0.5)

# Each density plot is scaled to the max being 1
ggplot(msleep_total, aes(x = sleep_total, y = ..scaled.., fill = vore)) +
  geom_density(color = NA, alpha = 0.5)
# just like ..scaled..
ggplot(msleep_total, aes(x = sleep_total, y = ..ndensity.., fill = vore)) +
  geom_density(color = NA, alpha = 0.5)

# Bar plots ---- 
# Bar plot of absolute counts
ggplot(msleep_total, aes(vore)) +
  geom_bar()

# violin plot (vertical and mirrored density plot)
ggplot(msleep_total, aes(vore, sleep_total)) +
  geom_violin(scale = "count") # adjust for n in each group

# Mean and SD ----
# The mean and SD are poor metrics here
ggplot(msleep_total, aes(vore, sleep_total)) +
  geom_jitter(width = 0.2, alpha = 0.5, shape = 16) +
  stat_summary(fun.data = mean_sdl, 
               fun.args = list(mult = 1))
