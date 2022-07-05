# Martian analysis
# Rick Scavetta
# 08.10.2020

# Load packages
library(tidyverse)

# Read in the data
martian <- read_tsv("data/martian.txt")

# Explore the data:
glimpse(martian)

# Descriptive statistics ---- 
# For the height varible at Site I only
# Try to calculate from scratch (first principles)

# Mean
siteI_mean <- martian %>%
  filter(Site == "Site I") %>%
  summarise(avg = sum(Height)/ length(Height))
# but this is a data frame:
siteI_mean$avg

# This way will give a 1-element long vector:
martian_siteI <- martian$Height[martian$Site == "Site I"]
siteI_mean <- sum(martian_siteI)/length(martian_siteI)
# mean(martian_siteI)

# Variance
siteI_var <- sum((martian_siteI - siteI_mean)^2)/(length(martian_siteI) - 1)
# var(martian_siteI)

# Standard deviation
siteI_sd <- sqrt(siteI_var)
# sd(martian_siteI)

# The mean is the value that reduces the variance to the
# smallest possible value. i.e. it MINIMIZES the variance (loss, residuals)
sum((martian_siteI - 200.5)^2)/(length(martian_siteI) - 1)
sum((martian_siteI - 199.5)^2)/(length(martian_siteI) - 1)