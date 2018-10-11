library(yelpr)
library(dplyr)
library(httr)
library(geosphere)
library(tidyr)
source("function.R")
a <- get_yelp_data()
a$name[which.max(a$distance)]
max(a$distance)

setwd("..")
att_loc <- read.csv("./data/NYC_attractions.csv")
setwd("./app")

m = match(c('SL'),att_loc$Code)
att_lng = att_loc$Latitude[m]
att_lat = att_loc$Longitude[m]
att_nm = att_loc$Attraction[m]

key = 'zLZesNlW8YSPyNP9poXD-_FDOhvNFACzrq-xAul5H3b6isbviX3o2EuCeifPRAsTvfz_c0lPzJUPNtzUIeowGHmhheCAxRMWz_lc5cqQAY-7X94pAvYkC3pXNjG2W3Yx'
# Access yelp API
business_ny = business_search(api_key = key,
                              latitude = -74.01697,
                              longitude = 40.70334,
                              radius = 8000,
                              limit = 50)









