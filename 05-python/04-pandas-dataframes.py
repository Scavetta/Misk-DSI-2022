# pandas DataFrames - Data containers, pt 4
import pandas as pd

# Get a DataFrame when importing a file

# Or from a dict:
foo1 = [True, False, False, True, True, False]
foo2 = ["Liver", "Brain", "Testes", "Muscle", "Intestine", "Heart"]
foo3 = [13, 88, 1233, 55, 233, 18]
foo4 = [[167, 65],
        [188, 70],
        [178, 67],
        [194, 79],
        [171, 80],
        [169, 64]]

# Collect list into a dataframe
# Each value in the dict must be the same length
# Error if lengths are not the same
# A value can contain more than 1 item at each element (foo4)
foo_df = pd.DataFrame({'healthy': foo1, 
                       'tissue': foo2, 
                       'quantity': foo3})
foo_df
type(foo_df)
# The above dict is equivalent to :
# dict(zip(list_names, list_cols))
# see below 


# Or from a list of keys and values:
list_names = ['healthy', 'tissue', 'quantity']
list_names
# A list of lists
list_cols = [foo1, foo2, foo3]
list_cols
# zip put the key/value pairs together
pd.DataFrame(dict(zip(list_names, list_cols)))

# Access information by:
# Name (here)
# Position (later, indexing)

# columns
foo_df.columns
# rows
foo_df.index

foo_df['healthy'] # Series
type(foo_df['healthy'])

foo_df[['healthy']] # DataFrame
type(foo_df[['healthy']])

foo_df.healthy # a Series

foo_df[['quantity', 'healthy']] # DataFrame

# each column is a Series
# DataFrames are build upon np.arrays
# i.e. Series can only be ONE type!

foo_df.info()

foo3_2 = foo3
quantity_list = foo3.copy()
quantity_list.mean() # no!

import numpy as np
np.mean(quantity_list) # yes :)
# quantity_list/100 # no!

# These things work with numpy.ndarrays, but not lists
quantity_array
# dir(foo_df)
# press ctrl + <space>
quantity_array = np.array(foo3)
quantity_array.mean()
quantity_array/100
quantity_array.astype("str")
# quantity_array.name # no!

quantity_Series = foo_df['quantity']
type(quantity_Series)
quantity_Series.mean()
quantity_Series/100
quantity_Series.astype("str")
quantity_Series.name

test_Series = pd.Series(quantity_array)
test_Series.name = "hello"
test_Series
# note
# Some exercises
from plotnine.data import mtcars 
mtcars
