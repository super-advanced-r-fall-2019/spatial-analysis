# Make lat/long non-spatial data

library("tidyverse")
library("sf")
library("here")

boats <- read_sf(here("data", "BoatLaunchSites"))

coords <- st_transform(boats, 4326) %>%
  st_coordinates(boats) %>%
  as_tibble() %>%
  rename(lon = X, lat = Y)

newdat <- as.data.frame(boats) %>%
  select(-geometry) %>%
  cbind(coords)

write_csv(newdat, here("data", "boat-launch-sites.csv"))
