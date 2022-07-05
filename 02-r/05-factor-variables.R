# Factor Variables
# Misk Academy Data Science Immersive
# Factor with levels, like categorical variable with groups
# i.e. A small and known number of discrete groups

glimpse(PlantGrowth)

# Notice that the levels are printed:
PlantGrowth$weight
PlantGrowth$group

# So what is it actually?
typeof(PlantGrowth$group) # int
class(PlantGrowth$group) # 

# Factor is a special class of type integer
# Where each integer is associated with a label call "level"

# e.g. structure:
str(PlantGrowth)

# ASIDE: Main problem: In pre R 4.0:
# doing math on factors and coercion
test <- c(23:26, "bob")
test

# Old behavior when making a data frame: chr become fct
test_df <- data.frame(test, stringsAsFactors = TRUE)
test_df$test

# But tibbles won't switch types:
test_tb <- tibble(test)
test_tb$test

# Coercion ----
# With a factor of numerical values coercion can be difficult
mean(test_df$test)
# Solution: 
as.numeric(test_df$test) # no!
# First coerce to character
as.numeric(as.character(test_df$test))

# Change levels easily:
attributes(PlantGrowth)
attributes(PlantGrowth$group)
levels(PlantGrowth$group) <- c("Control", "Fertilizer A", "Fertilizer B")
# View
PlantGrowth
PlantGrowth$group

ggplot(PlantGrowth, aes(group, weight)) +
  geom_boxplot()


# Reorder levels easily: as.factor() #coerce to a factor
PlantGrowth$group <- factor(PlantGrowth$group, levels = c("Fertilizer A", "Fertilizer B", "Control"))

# PlantGrowth %>% 
#   mutate(group = factor(group, levels = c("Fertilizer A", "Fertilizer B", "Control")))

ggplot(PlantGrowth, aes(group, weight)) +
  geom_boxplot()

# View
PlantGrowth
PlantGrowth$group

# There are also ordered factor variables (ordinal variabl equivalent)
glimpse(diamonds)
levels(diamonds$cut)
diamonds$cut
