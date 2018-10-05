setwd("..")
att_loc <- read.csv("./data/NYC_attractions.csv")
setwd("./app")

m = match(c('SL','CP'),att_loc$Code)
att_lng = att_loc$Latitude[m]
att_lat = att_loc$Longitude[m]
att_nm = att_loc$Attraction[m]
df_app = data.frame(att_nm, att_lng, att_lat)
df_app
