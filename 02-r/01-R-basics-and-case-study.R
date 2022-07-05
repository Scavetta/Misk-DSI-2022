# R Basics basics and case study
# Misk Academy Data Science Immersive

# Try to begin your R scripts with a descriptive header

# Load packages ----
# Install once, but initialize each time you start a new session
# We'll come back to this packages soon later on. I put this 
# command here since it's good practice to list all your used 
# packages at the beginning of a script
library(tidyverse)

# Basic R syntax ----
# What does this command do?
n <- log2(8) # 2^n = 8

# Exercise 1 ----
# Can you identify all the parts of the above commands?

# Exercise 2 ----
# Incomplete commands :/
# What happens if you execute this command?
# n <- log2(8)

# Plant Growth Case Study ----

# A built-in data set ----
read.csv("00-data/plantgrowth.csv")
read_csv("00-data/plantgrowth.csv")

PlantGrowth # already available in base R
data(PlantGrowth) # This will make it appear in your environment

# We're going to do something quite modern in R, which is to use a 
# tibble instead of a data.frame. That doesn't mean anything to you 
# now, but we'll get to it soon.
# First, make sure you have the tidyverse package installed and
# that you have executed the library(tidyverse) command
# above, after installing, so that you have initialized the package.
PlantGrowth <- as_tibble(PlantGrowth) # convert this to a "tibble" (more on this later)

# 1. Descriptive Statistics ----
# The "global mean" of all the weight values
# 3 things: func, dataframe, column
mean(PlantGrowth$weight)
# DO NOT do this:
# attach(PlantGrowth)
# weight
# detach(PlantGrowth)
# weight

# Would this work on the group column?
mean(PlantGrowth$group)

# Group-wise statistics
# Here, using functions from dplyr, a part of the Tidyverse
# Using Tidyverse notation:
# %>% is the "the (forward) pipe operator"
# Pronounce it as "... and then ..."
# Type it using shift + ctrl + m

# Use summarise() for aggregation functions
PlantGrowth %>% 
  group_by(group) %>% 
  summarise(avg = mean(PlantGrowth$weight),
            stdev = sd(weight),
            min = min(weight),
            max = max(weight),
            range = diff(range(weight)))
# range: max - min
# diff(range(1:10))
# diff(c(5, 20))
# to see a list of the dataframes
  # group_split()

# This is saying:
summarise(group_by(PlantGrowth, group), avg = mean(weight), stdev = sd(weight))

PlantGrowth %>% 
  group_by(group)

# We DON'T need to write the full path to a variable
# e.g. PlantGrowth$weight:
PlantGrowth %>% 
  group_by(group) %>% 
  summarise(avg = mean(weight),
            # avg = mean(PlantGrowth$weight), # This takes the global mean
            stdev = sd(weight))
# ..1, ..2

# Or... an atypical example, but it can still be useful:
# The apply family of functions
lapply(PlantGrowth, mean)
# How to do the grouping with the apply functions.
t_values <- tapply(PlantGrowth$weight, PlantGrowth$group, mean)
typeof(t_values)
attributes(t_values)
dimnames(t_values)
str(t_values)
t_values$ctrl # can't call using $ syntax
t_values[1]*1000

# What about using mutate() with an aggregration function?
PlantGrowth %>% 
  group_by(group) %>% 
  mutate(avg = mean(weight))

# For transformation functions: e.g. z-score within each group
# (x_i - x_bar)/x_sd (Signal-to-noise)
# function: scale()
# typical use mutate()
PlantGrowth %>% 
  group_by(group) %>% 
  # group_split()
  mutate(Z_score = scale(weight),
         # avg = mean(weight),                          # We can use an aggregation function
         Z_score_dollar = scale(PlantGrowth$weight),  # But not a transformation that is longer than what is expected
         x10 = weight * 10) %>%
  slice(1:3)

# But this will still work even though summarise is 
# supposed to be used for aggregation functions.
PlantGrowth %>% 
  group_by(group) %>% 
  summarise(Z_score = scale(weight))

# or... transform all of the values in a column
# e.g. multiply by 10 
# (no grouping)
# Base R way:
# PlantGrowth$weight <- PlantGrowth$weight * 10
scale(PlantGrowth$weight)




# Let's review the two most common syntax paradigms in R
# (This is kind of like different dialects of the same language,
#  some things are the same or very similar but there are key
#  differences that make them distinct systems.)
# Typical base pkg syntax
mean(PlantGrowth$weight)

# Tidyverse syntax
PlantGrowth$weight %>% 
  mean()
# %>% says take the object on the left (i.e. a dataframe) and insert it
# into the first position of the function on the right

# 2. Data Visualization ----
# Here, using functions from ggplot2, a part of the Tidyverse
# 3 essential components
# 1 - The data
# 2 - Aesthetics - "mapping" variables onto scales 
# scales: x, y, color, size, shape, linetype
# in the aes()
# 3 - Geometry - how the plot will look

# box plot -  display distribution in the form of quartiles
ggplot(PlantGrowth, aes(group, weight)) +
  geom_boxplot()
 
# Assign some (1 or more) layers to an object when
# you need to reuse it:
p <- ggplot(PlantGrowth, aes(group, weight))

p

p +
  geom_boxplot()
# Dots: "outliers"
# bottom dot or line to the top dot or line: Range
# median, Q2: Horizontal line
# middle 50%, split at (Q2 & Q3): Box lower and upper half
# lower and upper 25% of the data (Q1, 4Q): Whiskers, lower and upper
# Lines are drawn up to the closest point inside Q3+1.5*IQR
# IQR = Interquartile Range (Q3 - Q1)

# Contrasts to Range (Q4-Q0, max - min)

# "dot plot" (mean +/- 1SD)
p +
  geom_jitter(width = 0.2, shape = 16, alpha = 0.75) +
  stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), col = "red")

# What if I didn't use jittering:
p + 
  geom_point(hello = TRUE)

# We can combine layers in many ways:
p +
  geom_boxplot() +
  geom_jitter(width = 0.2, shape = 16, alpha = 0.75, color = "pink")

# 3. Inferential Statistics ----
# first step: define a linear model
# ~ means "described by"
Plant.lm <- lm(weight ~ group, data = PlantGrowth)

# It's not necessary, but we could have used 
# "tidyverse" notation if we wanted to:
PlantGrowth %>% 
  lm(weight ~ group, data = .)

# 1-way ANOVA
Plant.anova <- anova(Plant.lm)





# For all pair-wise comparisons use:



