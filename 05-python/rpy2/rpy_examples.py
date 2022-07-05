# %%
# Choose the miniconda base env and
# Run in the terminal
# conda install -y PyHamcrest
# Linux:
# sudo apt-get install -y libreadline6-dev
# macOS:
# conda update -c rdonnellyr -c main --all 
# Install packate
# pip install rpy2

# %%
# Import modules
import pandas as pd
from sklearn.datasets import load_boston

# %%
import rpy2.robjects as robjects

# %%
from rpy2.robjects.packages import importr

# %%
from rpy2.robjects import pandas2ri

# Must be activated
pandas2ri.activate()

# %%
# import R's "base" package
base = importr('base')

# import R's "utils" package
dplyr = importr('dplyr')


#%%
r = robjects.r

#%%
r.data('iris')
#%%
r['iris'].head()
#%%

#%%
boston = load_boston()

# %%
r_dataframe = pandas2ri.py2rpy(pd.DataFrame(boston.data))
r_dataframe.head()

#%%
# FIXME make a better example
from rpy2.robjects.lib.dplyr import (filter,
                                     mutate,
                                     group_by,
                                     summarize)

#%%
 dataf = (DataFrame(mtcars) >>
             filter(rl('gear > 3')) >>
             mutate(powertoweight=rl('hp*36/wt')) >>
             group_by(rl('gear')) >>
             summarize(mean_ptw = rl('mean(powertoweight)')))

    dataf