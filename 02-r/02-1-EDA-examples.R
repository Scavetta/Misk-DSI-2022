# Intro to making EDA easier

# Initialize packages
library(ggplot2)
library(DataExplorer)
library(GGally)

# Decide on an easy dataset 
PlantGrowth
glimpse(diamonds)
# glimpse(starwars)

# Make an EDA report:
create_report(diamonds, 
              output_file = "diamonds_EDA.html", 
              output_dir = "02-r/EDA_reports/")

# GGally pairs plot
g <- ggpairs(diamonds)
ggsave(g, filename = "02-r/EDA_reports/diamonds_pairs.png", width = 10, height = 10, units = "in")
ggsave(g, filename = "02-r/EDA_reports/diamonds_pairs_largeview.png", width = 20, height = 20, units = "in")
