# tidyverse - tidy data with tidyr
# Misk Academy Data Science Immersive, 2020

library(tidyverse)

# The rules of "tidy data"
# 1. 1 observation per row
# 2. 1 variable per column
# 3. 1 Observational unit per data.frame

# "tidy data", aka "long data"
PlantGrowth

# "messy data", aka "wide data"
# Use pivot_wider():
PG_wide <- PlantGrowth %>% 
  mutate(id = rep(1:10,3)) %>%
  pivot_wider(names_from = group, values_from = weight) %>% 
  select(-id)

glimpse(PG_wide)
PG_wide

# What about these variables? are they they same?
# Can they be grouped into one columnm?
head(iris)
# First, conside what are the "true" variables
# e.g 1: Can we combine length + width
# When you execute glimpse(x), what do you want to see:
# Variables: 
# Dimension (<fct> w 2 levels "Length", "Width"). -----> from MEASURE variables
# Part (<fct> w 2 levels "Sepal", "Petal").       -----> from MEASURE variables
# Species: (as per the original)             ----------> an ID variable: Species
# Value: (<dbl> #)

# To get tidy data:
# Define columns to EXCLUDE (ID variables)
# look at the names_to and values_to arguments
iris %>% 
  pivot_longer(-Species) %>% 
  separate(name, c("Part", "Dimension")) %>% 
  head()

# Define columns to INCLUIDE (MEASURE variables)
iris %>% 
  pivot_longer()



# Another example ----
# Get a play data set:
PlayData <- read_tsv("00-data/PlayData.txt")

# Exercises on messy data ----
# Part 1 - Calculate height/width for each group:
# A, Time 1 (i.e. height/width =  0.20)
# A, Time 2 (i.e. height/width =  0.33)
# B, Time 1 (i.e. height/width =  0.42)
# B, Time 2 (i.e. height/width =  0.50)


# Part 2 - Calculate time 2 - time 1 for each group:
# A, Height (i.e. 20 - 10 = 10)
# B, Height (i.e. 40 - 30 = 10)
# A, Width (i.e. 60 - 50 = 10)
# B, Width (i.e. 80 - 70 = 10)


# Part 3 - Calculate A/B for each group:
# Width, Time 1
# Width, Time 2
# Height, Time 1
# Height, Time 2


# Pivoting to tidy data ----
# Tidy data would be a better structure than wide data to use for
# exercises part 2 & 3, above 

# Use pivot_longer(), and specify either ID or MEASURE variables:
# Option 1 - Specify the ID variables (i.e. _exclude_ them):
# ID variables = Categorical before and after pivoting - specify with -
PlayData %>% 
  pivot_longer(-c(type, time)) -> PlayData_t

# Option 2 - Specify the MEASURE variables (i.e. _include_ them)
# MEASURE variables = Continuous before but actually levels in a factor variable
PlayData %>% 
  pivot_longer(c(height, width))

# Exercises on tidy data ----
# Repeat the exercises above, but this time use tidy data
# Part 1 - Calculate height/width for each group:

# Part 2 - Calculate time 2 - time 1 for each group:

# Part 3 - Calculate A/B for each group:

