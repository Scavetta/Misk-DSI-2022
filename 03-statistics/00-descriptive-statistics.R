# Intro to R
# Rick Scavetta
# 13.09.2021
# Misk DSI 2021 Explore the Martian dataset

# R syntax
n <- log2(8) # The logarithm of 8 to base 2
n 
log2(16)
# print(n)
y <- 32
y_log2 <- log2(x = y)

# Functions - name followed by () - like verbs in grammar, they do things 
# Arguments - input to functions (named or unnamed, access by name or position)
#           - Can be a number, character, object, function
# Comment - anything after a # (it will be ignored by the R interpreter)
# Object - anything in our environment - like a noun, it's a thing that you can handle

# Parameter - sometimes used instead of arguments but only in specific cases
#           - we'll see this more in Machine Learning and Deep Learning

# Package - collection of functions, e.g. base package
# Library - collection of packages

# Load packages
library(tidyverse)

# Import data
martian_df <- read.delim("data/martians.txt")
martian_tb <- read_tsv("data/martians.txt")

martian_df # data.frame
martian_tb # tibble, a variety of data.frame

rm(martian_df)

# Explore your data
glimpse(martian_tb)
# str(martian_tb)
summary(martian_tb)

# Intro Case Study
PlantGrowth
PlantGrowth <- as_tibble(PlantGrowth)

# Typical dplyr command
# "Literate programming"
# %>% = "The (forward) pipe operator"
# pronounce as "... and then ..."
# %>% is literally => take the object on the LHS
# and put it as the first argument of the function 
# on the RHS
PlantGrowth %>%
  group_by(group) %>%
  summarise(avg = mean(weight),
            stdev = sd(weight))

summarise(
  group_by(
    PlantGrowth
    , group)
  , avg = mean(weight), 
  stdev = sd(weight)
  )

# Use the commands we've seen so far to calculate
# Some descriptive statistics (that we saw in class) 
# on the Height variable in the martian_tb dataset 
# (either as a whole, or split by site)

# mean, stdev, median, IQR, Q0 (min), Q4 (max), Range (Q4 - Q0), variance
martian_tb %>%
  group_by(Site) %>%
  summarise(avg = mean(Height),
            stdev = sd(Height),
            median = median(Height),
            Q4 = max(Height),
            Q0 = min(Height),
            IQR = IQR(Height),
            variance = var(Height),
            range = Q4 - Q0,
            avg2 = sum(Height)/n())

# diff(range(martian_tb$Height))
# Extra challenge:  try to calculate some of these from scratch


Plant_lm <- lm(weight ~ group, data = PlantGrowth)
Plant_anova <- anova(Plant_lm)
