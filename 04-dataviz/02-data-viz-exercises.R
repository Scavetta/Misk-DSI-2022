# Data Viz coding challenge

# The iris dataset
data(iris)

Blues <- brewer.pal(9, "Blues")[c(4,6,8)]
myDark2 <- brewer.pal(3, "Dark2")

# Making our plot
# 1 - Create the base layer for a scatter plot
#   - Aesthetic mapping
#   - Geometry
# 2 - Make adjustments for over-plotting
#   - Size and shape won't help us here
#   - Use alpha and jittering
# 3 - Change colors to use the "Dark2" palette from RColorBrewer
#   - Change any aspect of an aesthetic with the matching scale_*_*() function
#   - Recall: discrete, categorical, factor, qualitative
# 4 - Add our model lines
# 5 - Set the theme
# Make sure to set the seed for jittering to avoid losing values
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(shape = 16, alpha = 0.75, position = "jitter") +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette = "Dark2") +
  # scale_x_continuous(limits = c(4,8), breaks = 4:8, expand = c(0,0)) +
  # scale_y_continuous(limits = c(2,5), breaks = 2:5, expand = c(0,0)) +
  coord_equal(xlim = c(4,8), ylim = c(2,5), expand = 0) +
  # # facet_grid(rows = vars(Species)) +
  #facet_grid(. ~ Species) +
  # # facet_grid(Species ~ .) +
  # # facet_wrap(~ Species, ncol = 2) +
  labs(x = "Sepal Length (cm)",
       y = "Sepal Width (cm)",
       title = "The Iris Dataset, again!",
       color = "Iris Species",
       caption = "Anderson, 1931") +
  theme_classic() +
  theme(rect = element_blank(),
        legend.position = c(0.1, 0.9)) +
  NULL

# Automatically define limits instead of hard-coding
xLimits <- c(floor(min(iris$Sepal.Length)), ceiling(max(iris$Sepal.Length)))

# not with floor and ceiling, but with round:
# round(range(iris$Sepal.Length))
# DANGEROUS!


# scale_color_manual("Species", values = myDark2)

# other ways to get jittering
# 1 - Use geom_jitter()
# geom_jitter(shape = 16, alpha = 0.75) +
# 2 - Set position with a character
# geom_point(shape = 16, alpha = 0.75, position = "jitter") +
# 3 - Use a position_*() function and call within a geom_*()
# posn_j <- position_jitter(seed = 136) 
# geom_point(shape = 16, alpha = 0.75, position = posn_j)


# Another example for over-plotting
# Just use shape = 1 here
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 1)

