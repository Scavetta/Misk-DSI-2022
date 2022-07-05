# Data Viz coding challenge, 
# DSI-2022-01

# Load packages
library(tidyverse)

data(iris)

iris %>% 
  as_tibble() -> iris

iris

# Making our plot - a basic scatter plot
# 1 - Create the base layer for a scatter plot
#   - Aesthetic mapping aes()
#     x axis = sepal length,
#     y axis = sepal width 
#   - Geometry
#     geom_*()
# Basic plot with lots of over-plotting
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point()

# Causes for overplotting:
# 1 - Low-precision data
# 2 - Categorical x axis w many levels, all dots are aligned
# 3 - Integer data
# 4 - High-density data

# Solutions for over-plotting
# jitter position on the points
# alpha-blending - change the transparency (0 = transparent, 1 = opaque)
# hollow points instead of filled points
# facet or show subsets
# size of points
# Use a different geom

# How to jitter:
# Most basic
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(position = "jitter", shape = 16, alpha = 0.5) +
  coord_fixed()

# More flexible (can specify height and width)
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_jitter(shape = 16, alpha = 0.5)

# Most robust (define position separately, set the seed)
# seed is the random seed generator (any integer) 
posn_j <- position_jitter(seed = 136)

ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(position = posn_j, shape = 16, alpha = 0.5)

# Hollow circles, opaque outline
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point(position = posn_j, shape = 1)

# 3 - Change colors to use the "Dark2" palette from RColorBrewer
#   - Change any aspect of an aesthetic with the matching scale_*_*() function
#   - Recall: discrete, categorical, factor, qualitative


ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(position = posn_j, shape = 16, alpha = 0.5) +
  scale_color_brewer(palette = "Dark2")


# Add models and adjust names on scales:
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(position = posn_j, shape = 16, alpha = 0.5) +
  # geom_smooth(se = FALSE, span = 0.9) +
  geom_smooth(method = "lm", se = FALSE) +
  # facet_wrap(~ Species, ncol = 2) +
  # facet_grid(. ~ Species, scales = "free") +
  # facet_grid(Species ~ ., scales = "free") +
  scale_color_brewer(palette = "Dark2") +
  labs(title = "The iris dataset",
       caption = "Anderson, 1931",
       color = "Species",
       x = "Sepal length (cm)",
       y = "Sepal width (cm)") +
  theme_classic() +
  theme(rect = element_blank(),
        legend.position = c(0.1, 0.9),
        axis.text = element_text(color = "black")) +
  NULL

# e.g.
lm(Sepal.Width ~ Sepal.Length, data = iris)


# Adjust positions of e.g. legends
# Adjust the theme
# Adjust facets

# Make your own theme adjustments as an object
theme_rick <- theme(axis.title = element_text(color = "red"))

# Call as an additional layer
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(position = posn_j, shape = 16, alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_rick

# Set the default theme for the entire project
theme_set(theme_rick)

# Which is called by default
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(position = posn_j, shape = 16, alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE)

# revert back to the usual defual theme
theme_set(theme_gray())
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(position = posn_j, shape = 16, alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE)

# How to plot all the variables:
library(GGally)

# Use a splom: scatterplot matrix (aka pairs plot)
ggpairs(iris, aes(color = Species))

# parallel coordinate plot:
# by default z-score
ggparcoord(iris, columns = 1:4, groupColumn = 5)

ggparcoord(iris, columns = 1:4, groupColumn = 5, scale = "uniminmax")


