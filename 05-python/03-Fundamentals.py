## Chapter 3: Python Fundamentals

# Four key types
a = 1 # int (whole numbers)
type(a)
b = 0.25 # float (numeric, real numbers)
type(b)
c = 'Berlin' # str (object)
type(c)
d = True # bool (binary, logical, True/False)
type(d)

# Arithmetic operators, table section 3.2
32 % 6 # remainder
32 // 6 # int division
2 ** 3 # exponents

1 + 1 # basic addition
'1' + '1' # add str
'1' * 5 # multiply str
'1' '1' # bad syntax :/
'1' * 11.65

import math # literally from math import *
import numpy as np
import pandas as pd
import seaborn as sns # High level Plotting
from plotnine import * # ggplot2 in Python

# Functions
# e.g. 
numb = 8
np.log(8, 2) # This won't work because 8 is not an "Array"
np.log2(numb) # (2 ** x = 8)
math.log2(8)
math.log(8, 2)

# Lists - Data containers, pt 1
# A builtin type
# 1-dimensional
# Defined with []
# heterogenous, i.e. many different data types

[1, 6, 9, 36]
[1, 6, 9, 36] + 100 # TypeError
[1, 6, 9, 36] + [100] # Add two lists together
[1, 6, 9, 36] + [10, 100]
[1, 6, 9, 36] + [100, 200, 300, 400]
[1, 6, 9, 36] + [100, 'dogs', 300, 400]

heights = [167, 188, 178, 194, 171, 169]

# Table 3.1 for typical functions
sum(heights)
len(heights)
np.mean(heights)

# Exercise 3.3:
lower95 = np.mean(heights) - 1.96 * np.std(heights)/(len(heights)**0.5)
upper95 = np.mean(heights) + 1.96 * np.std(heights)/(len(heights)**0.5)
# np.sqrt(100)
# 100**0.5
# x ** 2 = 100, solve for x
# x = 100**0.5
lower95
upper95
# Exercise 3.4:
cities = ['Munich', 'Paris', 'Amsterdam', 'Madrid', 'Istanbul']
dist = [584, 1054, 653, 2301, 2191]

len(dist)
max(dist)
min(dist)
np.mean(dist)

# Exercise 3.5:
# np.histogram(dist)
sns.stripplot(dist)
sns.stripplot(cities, dist)
sns.distplot(dist)

# ggplot-style histogram
# We need a pandas DataFrame
# ggplot(dist, aes(x=???))
#     + geom_histogram()


# Defining functions
# Basic form:

# A multi line comment: use """..."""
"""This is 
a long description
about my work...
"""

# Use them to also add "docstrings" to a function
def addNumbs(x, y):
    """Add two numbers together"""
    z = x + y
    return z

# Call the function
addNumbs(5,8)

# doc strings can be called as a method:
addNumbs.__doc__

# Exercise 3.6: Write a function to return lower95 for any list
def confInt(x):
    z = np.mean(x) - 1.96 * np.std(x)/np.sqrt(len(x))
    return z

confInt(heights)
confInt([3,4,3,2,2,1,3,4,3,4,5])

# def confInt(x):
#    z = (np.mean(x) - 1.96 * np.std(x)/np.sqrt(len(x)),np.mean(x) + 1.96 * np.std(x)/np.sqrt(len(x)))
#    return z
# confInt([3,4,3,2,2,1,3,4,3,4,5])


# Returning two values - output is a tuple
# like a list, but use () instead of []
# tuples are immutable - they can't be modified
def mathFun(x, y = 6):
    """Add and subtract two numbers together"""
    result = (x + y, x - y)
    
    return result

myOutput = mathFun(4)
type(myOutput)
myOutput

# Exercise 3.7 Return a tuple of two values (lower and upper limit)
def confInt(x):
    lower = np.mean(x) - 1.96 * np.std(x)/np.sqrt(len(x))
    upper = np.mean(x) + 1.96 * np.std(x)/np.sqrt(len(x))
    return (lower, upper)

confInt(heights)

# inner functions
# Define three_shouts
def three_shouts(word1, word2, word3):
    """Returns a tuple of strings
    concatenated with '!!!'."""

    # Define inner
    def inner(word):
        """Returns a string concatenated with '!!!'."""
        return word + '!!!'

    # Return a tuple of strings
    return (inner(word1), inner(word2), inner(word3))

three_shouts('A', 'B', 'C')
# inner('hello') # no access to inner()

# Exercise 3.8 Inner functions
def confInt(x):
    """calculate the conf int"""

    def error(x):
        return 1.96 * np.std(x)/np.sqrt(len(x))

    lower = np.mean(x) - error(x)
    upper = np.mean(x) + error(x)

    return (lower, upper)

confInt(heights)

# Function generators - Functions that make new functions
def raise_value(n):
    """return a function"""

    def inner(x):
        """raise x to the power of n"""  
        raised = x ** n
        return raised
    
    return inner

raise_2 = raise_value(2)
raise_2(3)

raise_4 = raise_value(4)
raise_4(3)
3**4

# For conf ints, using the N dist we have 1.96
# For t-dist, this is dependent on n (smaple size)
# e.g. n=10, use 2.26

# Exercise 3.9: Function generators
def setCorrection(c):
    def confInt(x):
        """calculate the conf int"""

        def error(x):
            return c * np.std(x)/np.sqrt(len(x))

        lower = np.mean(x) - error(x)
        upper = np.mean(x) + error(x)

        return (lower, upper)

    return confInt

CI_Norm = setCorrection(1.96)
CI_Norm(heights)

CI_n10 = setCorrection(2.26)
CI_n10(heights)

# Setting default values
def confInt(x, correct = 1.96):
    """calculate the conf int"""

    lower = np.mean(x) - correct * np.std(x)/np.sqrt(len(x))
    upper = np.mean(x) + correct * np.std(x)/np.sqrt(len(x))

    return (lower, upper)

confInt(heights, 1.96)
confInt(heights)
confInt(heights, 2.26)

# Determine the correction factor dependent on 
# Sample size on a t-distbutions
# i.e. df (degrees of freedom) = n-1
# First, get the t distribution
# from scipy.stats import t

def confInt(x):
    """calculate the conf int"""

    correct = stats.t.ppf(0.975,  len(x)-1 )

    lower = np.mean(x) - correct * np.std(x)/np.sqrt(len(x))
    upper = np.mean(x) + correct * np.std(x)/np.sqrt(len(x))

    return (lower, upper)

confInt(heights)

# 3.7.8 lambda functions
def raise_to_power(x):
    return x ** 2

raise_to_power(5)

# anonymous, unnamed, lambda
lambda x: x ** 2

nums = [3, 5, 6, 8, 3]
nums**2 
# unsupported operand type(s) for ** or pow(): 'list' and 'int'
# nums + [2]
# import keyword
# keyword.kwlist

# Solutions to getting **2 applied to a list
# 1 - for loop
# 2 - change the type to something that allows vectorization
# 3 - map each value of the list onto a function 1-by-1 
square_all = map(lambda num: num ** 2, nums)
list(square_all)

nums_a = np.array([3, 5, 6, 8, 3])
nums_a
type(nums_a)
nums_a**2

# e.g. we saw it already in the context of a DataFrame
# the \ breaks up a long command onto the next line
# chick.groupby(['feed'])['weight']. \
#    transform(lambda x: stats.zscore(x, ddof = 1))

# or use the map()
# heights ** 3 # lists are not iterable
cubed = map(lambda x: x ** 3, heights)
# This results in a map object
# Which we can convert to a list 
list(cubed)

# cubed_2 = map(lambda x, y: x ** y, {heights, 3})
# This results in a map object
# Which we can convert to a list 
# list(cubed_2)

# map without lambda
list(map(np.mean, [[1,2,3], [4,5,6]]))

# e.g. filter()
list(filter(lambda x: x > 175, heights))

# Exercise 3.14 Returning meaningful messages:
# i.e. a function that returns:
# There is a 95% chance that the true population 
# parameter is covered by the region XX, YY
def confInt(x):
    """calculate the conf int"""

    correct = stats.t.ppf(0.975,  len(x)-1)

    lower = np.mean(x) - correct * np.std(x)/np.sqrt(len(x))
    upper = np.mean(x) + correct * np.std(x)/np.sqrt(len(x))

    print(f"There is a 95% chance that the true population parameter is covered by the region [{round(lower, 2)}, {round(upper, 2)}].")

confInt(heights)

# See section 3.8
# use f-string formatting
name = 'Rick'
print(f"Hi my name is {name}")
print(f"{100 * 566} is a big number,\nbut {100 / 566} is not")
print(f"{np.mean([1,2,3])} is the mean of 1,2,3")

# Methods:
# access using the . notation

# like, but not the same as...
np.mean(heights) # a function in the np module
len(heights) # a function

# len is not a method
# heights.len()
# 'list' object (heights) has no attribute 'len'

# Function takes an object as an argument
# Objects call methods
# Methods are just functions specific to a given class of object

l = [1, '2', True]
l
l.append('appended value')
l

name = "Berlin"
name.upper()
name.lower()

dist
dist.append(560)
dist
dist.pop(3) # extract a value
dist # one less value

cities = ['Munich', 'Paris', 'Amsterdam', 'Madrid', 'Istanbul']
dist = [584, 1054, 653, 2301, 2191]
dist
dist.sort()
dist
dist.sort(reverse = True)
dist
dist.remove(653)
dist # one less value

# Exercise 3.15
# try these methods that we haven't explored yet:
# copy()
heights
heights_2 = heights.copy()
heights_2
heights_2.append(455)
heights_2
heights

# clear()
heights_2.clear()
heights_2

# A list of lists
heights.append([45, 74, 23])
heights

# Reset list
heights = [167, 188, 178, 194, 171, 169]
heights

# reverse()
heights.reverse()
heights

# count()
heights.count(194)

# These are methods we already saw,
# but the are NOT methods for lists!
# heights.value_counts()
# heights.mean() # called as a builtin method

# index()
heights
heights.index(194)

# Revisit for iterables
range(3)
list(range(3)) # 0,1,2

heights.extend(range(3))
heights
heights.extend([4,6,8])
heights

# insert()
heights.insert(8, 653)
heights

help(round)

# Attributes
l.__len__

len(l)

addNumbs.__doc__
setattr(addNumbs, '__doc__', "hello")
addNumbs.__doc__


# __ are reserved names from python
# but you can use them like all other attributes!
# pronunce them as "dunder"
# don't define you own variables, etc, using __xx__

# Attributes on a data frame
plant_growth.shape
plant_growth.columns

# A method
plant_growth.info()

# Methods are class functions, i.e. functions specific to a type of object
# Attributes are class parameters, i.e. values specific to a type of object

getattr(plant_growth, 'columns')
plant_growth.columns
dir(plant_growth)
setattr(plant_growth, 'Rick', 'Scavetta')
plant_growth.Rick

getattr(plant_growth, 'shape')
plant_growth.shape

# Dictionaries - Data containers, pt 2
# aka dict

# key/value pairs
# list, use []
# tuples, use ()
# dict, use {}
d = {'int_value': 3,
     'bool_value': False,
     'str_value': 'hello'}

d

# Can only access values using their key
d['bool_value']
# They don't have an order
# d[1] # Computer says no

# values can be more than length one
# i.e. they can contain a list
organizations = {'name': ['Volkswagen', 'Daimler', 'Allianz', 'Charite'],
                 'structure': ['company', 'company', 'company', 'research']}
organizations['name']
# organizations[5]

# Make a dictionary (key/value pair) from lists:
heights = [167, 188, 178, 194, 171, 169]
weights = [65, 70, 67, 79, 80, 64]
persons = ["Mary", "John", "Kevin", "Elena", "Doug", "Galin"]
id = (123, 532, 8672, 2342, 656, 754)

heights_2 = [[167, 65], 
             [188, 70], 
             [178, 67], 
             [194, 79], 
             [171, 80], 
             [169, 64]]

# A dict can only take two inputs: key & value
# dict(zip(persons, heights, weights))
# But a list is more flexible
# list(zip(persons, heights, weights))
hw_list = list(zip(heights, weights))


# key is persons, 
# value is corresponding value in heights
# heights has a list of 6 elements each is 1 int
heights_persons = dict(zip(persons, heights))
heights_persons
heights_persons['Doug']

persons_id = dict(zip(id, persons))
persons_id
persons_id[532]

# heights_2 is a list of 6 elements, each is itself a list of 2 elements
heights_persons_2 = dict(zip(persons, heights_2))
heights_persons_2

# make a dict with two zips lists
heights_weights = dict(zip(persons, zip(heights, weights)))
heights_weights

heights_persons.values()
heights_persons.keys()
persons_id.keys()

# in a list use index position:
heights
heights[3] # 4th position
heights.index(194)
# Use key for dict
heights_persons
heights_persons['Mary']

# NumPy Array - Data containers, pt 3
# n-dimensional (1, 2, ...)
# what we think as a matrix
# They can only have ONE type

xx = [3, 8, 9, 23]
type(xx)

yy = np.array([3, 8, 9, 23])
type(yy)

# A list [] of lists [], [], range()
# Make a range(0)
range(5) # A range object
list(range(5)) # Equates to a list of integers

zz_list = [[5, 7, 8, 9, 3],
           [0, 3, 6, 8, 2],
           range(5)]
zz_list # 1-dimension

zz_array = np.array(zz_list)
zz_array # 2-dimensional

# What is range(5)?
list(range(5))
list(range(3, 5))

# for reference:
import keyword
keyword.kwlist

