# Diamonds analysis

# libraries
import numpy as np
import pandas as pd
import seaborn as sns

#%%
# import the data
jems = pd.read_csv("data/diamonds.csv")

#%%
# Explore the DataFrame

# type(jems)
jems.columns # names
jems.describe()
jems.info()
jems.head()
jems.tail()
jems.sample(n = 10)
# %%
# How many diamonds with a clarity of category “IF” are present in the data-set?
len(jems[jems.clarity == "IF"])
(jems['clarity'] == 'IF').value_counts()[True]
jems.clarity.value_counts()

# What fraction of the total do they represent?
len(jems[jems.clarity == 'IF'])/len(jems)
# %%
# What is the cheapest diamond price overall?
#min(jems.price)
jems['price'].min()
#%%
# What is the range of diamond prices?
# print('Range for prices (', jems['price'].min(), '-', jems['price'].max(), ')')
def getRange (x):
    low = min(x)
    high = max(x)
    return low, high

price_range = getRange(jems.price)

low, high = getRange(jems.price)

""" def priceRange(x):
    min_range = jems[x].min()
    max_range = jems[x].max()
    return min_range, max_range
    
priceRange("price") """

#%%

#low
#high
price_range

#%%
# What is the average diamond price in each category of cut and color?
jems.groupby(['cut','color'])['price'].mean()
# %%
