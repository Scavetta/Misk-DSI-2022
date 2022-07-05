# Intro to OOP

# %%
# An example from class:
from fizzbuzz import FizzBuzz
# import fizzbuzz

# %%
bar = FizzBuzz.FizzBuzz()
# %% 
bar.fizzBuzz(123)    

# %%
foo = FizzBuzz.FizzBuzz()
foo.fizzBuzz(15)
# %%

#%%
# # So far...
myList = list(range(6))
for item in myList:
    print(f"item is {item}")

#%%
myList

# instead, we can use Object-oriented programming
# which is based on classes
# Use the class keyword, like def
# Use capital letters

#%%
class PrintList:

    def __init__(self, numberlist):
        self.myNumbers = numberlist
    
    def print_list(self):
        for item in self.myNumbers:
            print(f"item is {item}")

#%%
# __init__ is the initialization of the class
# it's not necessary, but anything here
# Gets called when ever you "initialize" an instance.

# e.g. Instantiate it (i.e. create an instance)
A = PrintList(myList)
A.

# %%
# Call a method of the instance
A.print_list()

#%%
B = PrintList(list(range(6,46)))
B.print_list()

#%%
B.myNumbers

#%%
# Attribute (class variables) == Variable in imperative
# Method (class functions) == Function in imperative

# We don't need an __init__ method:
class PrintList_2:
    
    def print_list(self, numberlist):
        for item in numberlist:
            print(f"item is {item}")

#%%
C = PrintList_2()
C.print_list([1,3,5])

#%%
# S0 far... we've seen instance methods
# They can modify an object state and the class state

# Another type of method is: Class method
# They can't modify an object state but they can modify an class state
# Define them using the @classmethod "decorator"

# cls is a standard name for class
# like self is a standard name for the instance

#%%
class ManiNumbs:
    """class description"""

    @classmethod
    def multi(cls, x):
        """multiply some numbers"""
        return x * 100

    @classmethod
    def addup(cls, x):
        return x + 20

    @classmethod
    def doBoth(cls, x):
        x = cls.multi(x)
        x = cls.addup(x)
        return (x)

#%%
ManiNumbs.addup(40) 

#%%
ManiNumbs.multi(40)

#%%
ManiNumbs.doBoth(40)

#%%
D = ManiNumbs()

#%%
D.addup(40)

#%%
D.multi(40)

#%%
D.doBoth(40)

#%%
ManiNumbs.__doc__

#%%
ManiNumbs.multi.__doc__