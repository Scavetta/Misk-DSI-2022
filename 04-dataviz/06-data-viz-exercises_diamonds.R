# Data Viz coding challenge, 
# DSI-2022-01
# Diamonds - High-density data

# Load packages
library(tidyverse)

# Data
diamonds

# price vs carat (cont ~ cont)
ggplot(diamonds, aes(carat, price)) +
  geom_point()

# How to deal with overplotting
# jittering is NOT approriate here
# shape = 1 helps a bit, but not much
# alpha = set transparency this would help see distributions
# size = smallest -> shape = ".", or set size = integer

ggplot(diamonds, aes(carat, price)) +
  geom_point(alpha = 0.25, shape = ".")


# Other geoms for high-density plots (GOLD = Graphics of Large Datasets)
