# Data handling
# Misk Academy Data Science Immersive

# Part 1: Functions (i.e. "verbs") ----
# Everything that happens, is because of a function

# Arithmetic operators ----
# e.g. type a math equation


# BEDMAS - order of operations
# brackets, expon, div, mult, add, sub
# How are these different?
2 - 3/4
(2 - 3)/4

# Use objects in place of numbers
n <- 34
p <- 6
# so...
n + p

# multiply two objects (single numbers)
# and then add the larger value to this
(n * p) + max(n, p)

# 1 - Generic functions have a form:
# fun_name(fun_arg = ...)

# 2 - Call arguments by name or position

# i.e. Can you tell the difference in these function calls?
# Which ones work and which one will produce an error?
log(x = 8, base = 2) # long form, named
log(8, 2) # long form, position
log(8, base = 10/5) # long form, combo
log(base = 2, 8) # bad style
log(8, b = 2) # long form, combo using partial naming
log2(8)
log10(10000) # 4

# 3 - Functions can have 0 to many un-named args
# Can you think of an example?
c()
list()
library(tidyverse)
list.files(recursive = TRUE, pattern = ".csv")
list.files() # ls in the command line
Sys.time()
getwd()
R.Version()

# 4 - Args can be named or un-named

# c() for combine ----
# With numbers:
xx <- c(3, 8, 9, 23)
xx

# With characters:
myNames <- c("healthy","tissue","quantity")
myNames

# As an aside: recall, everything is a function...
# How is + a function?
p + n
# 1,+,3
# +,1,3
# 3,1,+
# this is actually...
`+`(p, n)

# seq() for a regular sequence of numbers ----
seq(from = 1, to = 100, by = 7)
# Can you write this in a shorter form?
# Assign the output to foo1

foo1 <- seq(1, 100, 7)

# seq(seq(1, 100, 1), 7)

# We can use objects in functions:
foo2 <- seq(1, n, p)
seq(0, 30, 6)

# get the numbers 1 to 30
seq(1, 30, 1)
1:30
# group them into 5 groups (1-6, 7-12, ... 25-30)
cut(seq(1, 30, 1), 5) # 5 groups after ordering
cut(seq(1, 30, 1), c(0,10, 20,30))
# name them A-F

table(cut(PlantGrowth$weight, c(0,5,10), c("low", "high")))



# The colon operator ----
# regular sequence of 1 interval from p to n 
seq(p, n, 1)
# Use the colon operator instead:


# we can rename objects
hello <- foo1
rm(foo1)

# We can change the default number of sig digits displayed in the console
# options(digits = 3)
options(digits = 7)

# tempnames <- c("hallo", "there", "hier")
# tempvalues <- list(1:30, 4:7, 45:98)
# assign("hi", 3:8)
# walk2(.x = tempnames, .y = tempvalues, assign)

# Applying math functions ----
# Two major types of math functions:
# Aggregation functions
# 1 output value (typically)
# mean, sd, n, var, median, max, min, sum, prod
sum(c(3,7,1))

# Transformation functions
# same number of output as input
# log, [0,1], z-scores, sqrt, exponents
# subtract background
# +, -, /, ...
# 1 input (operator) -> 1 transformed output
34 + 6

# Exercise: Are these transformation or aggregation?
# Don't execute the commands, try to guess what the output will be!
foo2 + 100 # trans
foo2 + foo2 # trans
sum(foo2) + foo2 # 96 + foo2 ... agg plus trans
1:3 + foo2 # trans

paste(1+2, 1:3, sep = "+")
paste(3, c(1,2,3), sep = "+")
sum(foo2) + foo2
(1+2) + 1:3

# FUNDAMENTAL CONCEPT: VECTOR RECYCLING ----
1:4 + foo2



# Now we're starting to see different kinds of feedback from R
# There are 3 types of messages:
# Information: Neutral
# Warning: Possible problem
# Error: Full stop

# Exercises ----
# Calculate y = 1.12x − 0.4 for xx




# Make a basic function that does this






# Part 2: Objects (nouns) ----
# Anything that exists is an object

# Vectors - 1-dimensional, homogenous ----
# Everything in the values section
foo1
myNames

# "user-defined atomic vector types" ----
# What do you the 4 most common ones are used to represent? 
# Logical - TRUE/FALSE, T/F, 1/0 (Boolean)
# Integer - whole numbers
# Double - real numbers (float) (<dbl> in tidy)
# Character - All values (string)

# Numeric - Generic class refer to int or dbl
"hello" + "world"
# check
typeof(foo1)
typeof(myNames)

# Let's make some more vectors for later on:
foo3 <- c("Liver", "Brain", "Testes", "Muscle",
          "Intestine", "Heart")
typeof(foo3)

foo4 <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
typeof(foo4)

# Homogeneous types:
typeof(1:10)
test <- c(1:10, "bob")
test
typeof(test)

# We can't do math:
mean(test)

# R has a type hierarchy

# Solution: Coercion to another type
# use an as.*() function
test <- as.numeric(test)
test

# Now we can do math: 
mean(test)
sd(test)
length(test)
# but we need to deal with the NA
mean(test, na.rm = TRUE)

# na.omit()
# NA
# NaN
# log(-54)

# Lists - 1-dimensional, heterogeneous ----
library(tidyverse)
# martian_tb <- read_tsv("data/martians.txt")
plant_lm <- lm(weight ~ group, data = PlantGrowth)
plant_anova <- anova(plant_lm)
typeof(plant_lm)

# how many elements:
length(plant_lm)
length(foo2) # also works for vectors

# data("PlantGrowth")

# attributes (meta data)
attributes(plant_lm)
# 13 named elements
# attributes(PlantGrowth)

# use common "accessor" functions for attributes
names(plant_lm)
# attributes(plant_lm)$names
str(plant_lm)
plant_lm
length(plant_lm)
# Anything that's named can be called with $
plant_lm$coefficients # a 3-element named dbl (numeric) vector
plant_lm$residuals # a 30-element dbl vector
plant_lm$model # data.frame
plant_lm$qr$qraux

# As an aside: You can even add comments:
comment(plant_lm) <- "I love R!"
attributes(plant_lm)

# Add comment as an actual list item:
plant_lm$myComment <- "But python also :)"
plant_lm$myComment

# What is class?
# An attribute to an object
attributes(plant_lm)
# can also access with "accessor" function:
class(plant_lm)
class(plant_anova)
# class tells R functions what to do with this object
# e.g.
summary(plant_lm) # get t-test and ANOVA summary from an "lm"
plant_anova
# summary(plant_anova) # Works because the object is a data.frame, 
# but this isn't necessary or useful
summary(PlantGrowth) # summarise each column in a "dataframe"

# Dataframes - 2-dimensional, heterogenous ----
class(PlantGrowth)
# A special class of type list...
typeof(PlantGrowth)

# look at a tibble
typeof(martian_tb)
class(martian_tb)
length(martian_tb)
# ...where each element is a vector of the SAME length!
# Rows = observations
# Columns = variables

list("apple" = 1:6,
     "pears" = 9:1)

list(1:6,
     9:1)

data.frame("apple" = 76,
           "pears" = 9:1)

tibble("apple" = 54,
       "pears" = 9:1)

# Make a data frame from scratch using data.frame(), or...
# You can use the modern variant  
# Note, I put _df on the end of the name to remind us that this is a
# data frame (well, a tibble), but it's not necessary.
foo_df <- tibble(foo4, foo3, foo2)
foo_df
typeof(foo_df)
class(foo_df)
# To modify the column names, what you're actually doing is
# Change an attribute (think metadata). The most common attributes
# can be accessed with accessor functions, in this case names()
names(foo_df) <- myNames
foo_df

# How can you call each variable (i.e. column) by name:
foo_df$quantity


# Basic functions:
# Display the structure of foo_df using a base R function:
str(foo_df)
# Now using a tidyverse function:
glimpse(foo_df)

# Can you get a short summary of every variable with one command?
summary(foo_df)

# Can you print out the number of rows & columns?
dim(foo_df) # 6 3
length(foo_df) # 3 (list of 3 elements)

# How about just the number of rows?
nrow(foo_df) # 6

# How about just the number of columns? 
ncol(foo_df) # 3


library(RColorBrewer)

library("Biobase")


library(datasets)
data(faithful)
faithful_lm <- lm(eruptions ~ waiting, data = faithful)
faithful_lm$coefficients
predict(faithful_lm, data.frame(waiting <- 45))

aa <- as.array(1:4)
class(aa)
typeof(aa)
