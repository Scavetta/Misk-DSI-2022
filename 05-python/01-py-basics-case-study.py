## PlantGrowth data set in Python
#%%
# import an entire library
import math # Functions beyond the basic maths

#%%
# Import an entire library and give it an alias
import pandas as pd # For DataFrame and handling

import numpy as np # Array and numerical processing
import matplotlib.pyplot as plt # Low level plotting
import seaborn as sns # High level Plotting
import statsmodels.api as sm # Modeling, e.g. ANOVA

# Import only specific modules from a library
# we'll use this for the t-test function
from scipy import stats

# Import only specific functions from a library 
# ols is for ordinary least squares
from statsmodels.formula.api import ols


#%%
# Super basic function
n =  math.log(8, 2)
n

#%%
# Import the data set
plant_growth = pd.read_csv('../00-data/plantgrowth.csv')

#%%
# Examine the data
plant_growth.info()
#%%
plant_growth.shape
#%%
plant_growth.columns

#%%
# Summaries
plant_growth.describe()

#%%
plant_growth['group'].value_counts()


#%%
# explore first dataset rows
plant_growth.head(10)


#%%
# Descriptive statistics
# count group members
plant_growth['group'].value_counts()

#%%
# get average weight
np.mean(plant_growth['weight'])

#%%
# plant_growth['weight'].mean()

#%%
# summary statistics
plant_growth.groupby(['group']).describe()

#%%
plant_growth.groupby(['group']).mean()

#%%
# also
df1 = plant_growth.groupby(['group']).mean()
df2 = plant_growth.groupby(['group']).std()
final_df = pd.concat([df1, df2], axis=1)

#%%
# Notice the difference here:
# Produces Pandas Series
plant_growth.groupby('group')['weight'].mean() 

#%%
# Produces Pandas DataFrame
plant_growth.groupby('group')[['weight']].mean()


#%%
sum_dict = {'weight':['mean','std']}

#%%
# Easy and flexible
plant_growth.groupby(['group']).agg({'weight':['min','max']})


#%%
# plot the data:
sns.boxplot(x="group", y="weight", data=plant_growth)
sns.catplot(x="group", y="weight", data=plant_growth)
#%%
sns.pointplot(x="group", y="weight", data=plant_growth, join=False)
#%%
sns.catplot(x="group", y="weight", data=plant_growth, kind="point")

#%%
# base R plotting functions:
""" boxplot()
hist()
plot()
plot(density()) """


# specify the model
""" import statsmodels.api as sm
from statsmodels.formula.api import ols """
model = ols("weight ~ group", data=plant_growth)
results = model.fit()

#%%
# explore model results
# results.summary()
results.params.Intercept
results.params["group[T.trt1]"]
results.params["group[T.trt2]"]
# coefficients == parameters == estimates

#%%
# Explore model results
results.summary()


#%%
# # ANOVA
# compute anova
aov_table = sm.stats.anova_lm(results, typ=2)

#%%
# explore anova results
aov_table
# %%
