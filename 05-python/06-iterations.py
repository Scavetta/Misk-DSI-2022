
#%%
# If statements in brief:
# Each conditional should return a single True/False
xx = 2
if (xx > 1):
    print("too large")
elif (xx < -5):
    print("too small")
else: 
    print("yesssss!")

#%%
# Iterations
letters = ['A', 'B', 'C'] # list
letters = "Rick" # string
letters = range(6) # range

for names in letters:
    print(names)

# i.e. list, string, range are "iterable"
# They return an "iterator" object in which we can call next()

""" letters = "Hello"
it = iter(letters)
next(it)
next(it)
next(it)
next(it)
next(it)
next(it)

letters = "Hello"
iter(letters)
 """
# We can add a count with the enumerate() function
letters = "Hello" # string
letters = ['A', 'B', 'C'] # list

# we can also specify where to start the counter:
e = enumerate(letters, start = 1)
e

#%%
# view
e_list = list(e)
e_list

#%%
for index, value in e:
    print(f"position {index} has letter {value}")

#%%
for index, value in enumerate(['A', 'B', 'C']):
    print(f"position {index} has letter {value}")

# enumerate makes a list of tuples

# We can use a zip object
heights = [167, 188, 178, 194, 171, 169]
persons = ["Mary", "John", "Kevin", "Elena", "Doug", "Galin"]

for z1, z2, z3 in zip(persons, heights, range(6)):
    print(f"person {z3} is {z1}, who is {z2} cm tall.")

# for z1, z2 in [persons, heights]:
#     print(f"{z1} is {z2} cm tall.")

# Exercise on plant growth DataFrames:
# Recall
plant_growth = pd.read_csv('data/plant_growth.csv')







#%%
# List and dict comprehensions
# Basically very compact for loops

heights # in cm

# heights/100 # in meters, no-go
heights_a = np.array(heights)/100 # yes :)
heights_a


#%%
new_list = []
for num in heights:
    new_list.append(num/100)
new_list

#%%
# list comprehensions 
[[output expression] for [iterator variable] in [iterable object]]

#%%
# for example:
[num/100 for num in heights]

#%%
# Nested loops
pairs_1 = []
for num1 in range(2):
    for num2 in range(6,8):
        pairs_1.append([num1, num2])
pairs_1

#%%
# as comprehension:
[[num1, num2] for num1 in range(2) for num2 in range(6,8)]
# 0,6
# 1,7

#%%
[[num1, num1+6] for num1 in range(2)]

#%%
# A more practical example:
[[j for j in range(5)] for i in range(5)]
# [[col for col in range(2)] for row in range(8)]
# [print("hi") for row in range(8)]
# [col for col in range(2)]
[list(range(5)) for row in range(5)]

# Loops with conditionals
# on input or output

#%%
# No filter
[num ** 2 for num in range(10)]

#%%
# on input
[num ** 2 for num in range(10) if num % 2 == 0]

#%%
# on output
[num ** 2 if num % 2 == 0 else 0 for num in range(10)]
res = [num ** 2 for num in range(10)]
res
#%% Looping exercises
cities = ['Munich', 'Paris', 'Amsterdam', 'Madrid', 'Istanbul']

