
library(tidyverse)
library(rvest)
library(ggmap)
library(stringr)
library(ggplot2)
library(maps)
library(maptools)
library(rgdal)

setwd("~/Documents/Dissertation/Data/")

# africa_countries <- c("Algeria", "Angola", "Benin","Botswana","Burkina Faso","Burundi","Cape Verde",
# "Cameroon","Central African Republic", "Chad","Comoros", "Democratic Republic of the Congo",
# "Republic of the Congo","Ivory Coast","Djibouti", "Egypt", "Equatorial Guinea","Eritrea","Ethiopia", "Gabon", "Gambia", 
# "Ghana", "Guinea","Guinea-Bissau", "Kenya", "Lesotho", "Liberia","Libya", "Madagascar", "Malawi", "Mali", "Mauritania", 
# "Mauritius","Morocco", "Mozambique", "Namibia","Niger","Nigeria","Rwanda","Sao Tome and Princip","Senegal","Seychelles",
# "Sierra Leone","Somalia","South Africa","South Sudan","Sudan","Swaziland","Tanzania","Togo","Tunisia","Uganda",
# "Zambia","Zimbabwe")
# africa <- subset(map.world, region == africa_countries)

pko <- read_csv("PKO_2016.csv")

map.world <- map_data("world")
map.world_joined <- left_join(map.world, pko, by = c('region' = 'COUNTRY'))

map.world_joined <- map.world_joined %>% mutate(fill_flg = ifelse(is.na(sum),F,T))

# load in GTD data
gtd.events <- read.csv("gtd.csv")

gtd.events <- subset(gtd.events, iyear == "2016")


ggplot() + geom_polygon(data = map.world_joined, aes(x = long, y = lat, group = group, fill = fill_flg), colour="grey90") +
  geom_point(data = gtd.events, aes(x = longitude, y = latitude),size= .2, color = "red") +
  scale_fill_manual(values = c("#CCCCCC","light blue")) +
  labs(x="Longitude", y="Latitude", title="") + 
  theme_bw() + 
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  coord_map(xlim = c(-20, 60),  ylim = c(-40, 40))
