# Working with simple feature to draw maps.
# Rick Scavetta

# 0. Setting up ----

# Load packages
library(tidyverse)
library(sf)

# Get files from GADM:
# Select country here: https://gadm.org/download_country.html
# Download the geopackage fileformat (gpkg)

# This example:
# https://geodata.ucdavis.edu/gadm/gadm4.1/gpkg/gadm41_SAU.gpkg
geo_data <- "99-extras/KSA_maps/data/gadm41_SAU.gpkg"

# 1. Basics ----

# Read in a simple feature:
# Takes the first level (country-level)
ksa <- st_read(geo_data)

# This is an unnecessarily highly-detail map and
g <- ksa %>% 
  ggplot() +
  geom_sf()

# ** takes a long time to plot **
# g

# 2. Working with layers ----
# Get the names of the available layers
layers <- st_layers(geo_data)$name
layers
# [1] "ADM_ADM_0" "ADM_ADM_1" "ADM_ADM_2"

# 3. Simplify objects ----
# Import each layer as a separate image and 
# immediately simplify to reduce plotting time
st_read(geo_data, layer = layers[1]) %>% 
  st_simplify(dTolerance = 500) -> ksa_1

st_read(geo_data, layer = layers[2]) %>% 
  st_simplify(dTolerance = 500) -> ksa_2

st_read(geo_data, layer = layers[3]) %>% 
  st_simplify(dTolerance = 500) -> ksa_3

# Much faster (notice the lack of detail, e.g. the missing islands?)
# Use theme_void to remove all non-data ink.

# outline:
ksa_1 %>% 
  ggplot() +
  geom_sf(color = "black", fill = NA) +
  theme_void()

ksa_2 %>% 
  ggplot() +
  geom_sf(color = "black", fill = NA) +
  theme_void()

ksa_3 %>% 
  ggplot() +
  geom_sf(color = "black", fill = NA) +
  theme_void()

# fill:
ksa_2 %>% 
  ggplot() +
  geom_sf(color = "white", fill = "grey75") +
  theme_void()


# 4. Multiple layers ----
# Plot all layers together
ksa_3 %>% 
  ggplot() +
  geom_sf(color = "grey85", fill = NA) +
  geom_sf(data = ksa_2, color = "grey60", fill = NA) +
  geom_sf(data = ksa_1, color = "black", fill = NA) +
  theme_void()

# 5. Projections ----
# Find the prefered projection of the country or region from
# https://epsg.org/
# Set it with st_transform
ksa_1 %>% 
  st_transform(4979) %>% # Based on WGS 84, a common standard
  ggplot() +
  geom_sf(color = "black", fill = NA)

# 6. Add details ----
# e.g. cities and their sizes.
# import data and immediatly sort according to city size
# This will plot small cities first and then the large ones on top of them.
# ** NOTE: There are some duplicates in this table! **
ksa_popln <- read_csv("99-extras/KSA_maps/data/KSA_cities_popln.csv") %>% 
  arrange(-popln)

## 6.1 color = popln ----
g1 <- ksa %>%    # Detailed input, replace with ksa_1 for simplified input,
  ggplot() +
  geom_sf(fill = "grey75", color = NA) +
  geom_point(aes(x = lon, y = lat, color = popln), 
             ksa_popln, 
             shape = 16, 
             size = 2,
             alpha = 0.75) +
  scale_color_viridis_b() +
  theme_void()

ggsave("99-extras/KSA_maps/output/popln_color_detailed.png", plot = g1, height = 6, width = 8, units = "in")

## 6.2 size = popln ----
g2 <- ksa %>% 
  ggplot() +
  geom_sf(fill = "grey75", color = NA) +
  geom_point(aes(x = lon, y = lat, size = popln), 
             ksa_popln, 
             color = "red",
             shape = 16, 
             alpha = 0.25) +
  theme_void()

ggsave("99-extras/KSA_maps/output/popln_size_detailed.png", plot = g2, height = 6, width = 8, units = "in")

# 7. EXTRA - Get lat + long cities ----
# Use:
library(ggmap)

# Get your own Google Maps API key
# see this help page
?register_google
# And go here:
# https://cloud.google.com/maps-platform/.
has_google_key() # This needs to be TRUE

# Sets your google map for *this* session only
register_google(key = "YOUR KEY HERE")
# Don't push this to github!
# Store it in a secure location and import it, or,
# or you .Rprofile file 
google_key() # confirm this shows your key

# e.g.
geocode("Berlin, Germany")
# A tibble: 1 × 2
# lon   lat
# <dbl> <dbl>
#   1  13.4  52.5

# Get city names and population sizes:
# Retreived from https://worldpopulationreview.com/countries/cities/saudi-arabia
# 21 July 2022
ksa_cities <- read_csv("99-extras/KSA_maps/data/KSA_cities.csv")

# for pasting strings together
library(glue)

ksa_cities$name %>%                       # Take the city names and 
  map_df(                                 # map them onto 
    ~ geocode(                            # the geocode() function
      glue("{.}, Saudi Arabia"))) %>%     # Paste on the country name 
  mutate(name = ksa_cities$name) %>%      # Then put the names in the name variable
  full_join(ksa_cities) %>%               # Join it up with the population sizes
  rename(popln = "2022") %>%              # Rename the column with populations
  write_csv("data/KSA_cities_popln.csv")  # Save as a new file (what we imported above)
