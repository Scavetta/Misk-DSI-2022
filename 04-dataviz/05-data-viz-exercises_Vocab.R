# Data Viz coding challenge, 
# DSI-2022-01

# Load packages
library(tidyverse)
library(car) # Companion to Applied Regression in R

# The vocab dataset
Vocab %>% 
  as_tibble() -> Vocab
# 4 variables:
#  year (when the test was given), 
#  sex, 
#  education (years of education), 
#  vocabulary (score on a test)
# Does score on a vocabulary test (y, depedent variable) improve with years of education (independent variable) a student has
# Y ~ X, how we describe y given x, 
# What kind of a plot would answer this question?
Vocab



# plot:
ggplot(Vocab, aes(education, vocabulary)) +
  geom_point()

# just jittering on width, but height is still default
ggplot(Vocab, aes(education, vocabulary)) +
  geom_jitter(width = 0.05, shape = 1)

# Nicest version
ggplot(Vocab, aes(education, vocabulary)) +
  geom_jitter(alpha = 0.15, shape = 16) +
  coord_fixed()
# + 
#   stat_summary(fun.data = mean_sdl, fun.args = list(mult = 1), color="red")

# A different geom? or statistic:
# "count" the number of observations
ggplot(Vocab, aes(education, vocabulary)) +
  stat_sum()



# # look at later:
# ggplot(Vocab, aes(x=year, y=vocabulary, color=year)) +
#   geom_jitter(shape=1) +
#   geom_smooth()
# 
# # Not really answering the question
# Vocab %>% 
#   group_by(year) %>% 
#   summarise(voc_avg = mean(vocabulary)) %>% 
#   ggplot(aes(x=year,y=voc_avg ))+
#   geom_point()+
#   geom_smooth()


# Using facets and lm according to sex and year (the remaining two variables)

Vocab %>% 
  # filter(year %in% c(1974, 2016)) %>% 
  ggplot(aes(education, vocabulary, color = factor(year))) +
  stat_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ sex)

# gganimate
library(gganimate)
# An example, but needs to be improved
anim <- Vocab %>% 
  # filter(year %in% c(1974, 2016)) %>% 
  ggplot(aes(education, vocabulary, color = factor(year))) +
  stat_smooth(method = "lm", se = FALSE) +
  facet_grid(. ~ sex) +
  transition_reveal(year)
anim