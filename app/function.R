library(dplyr)
library(httr)

# It's a function retrieving data from Yelp using API
# The default location is Empire State Building
# Set latitude, longitude, categories, radius, price as inputs to filter results
# Latitude, longitude should be decimal numbers
# Radius should be an integer in meters
# Categories should be a string in the list of Yelp restaurant types
# Price should be of type $, $$, $$$ for price range
# Left it blank if you don't wanna change that parameters
get_yelp_data <- function(latitude = 40.748817,
                          longitude = -73.985428,
                          categories = NULL,
                          radius = 5000,
                          price = NULL,
                          sort = "best_match"){

  # Type inspection ---------------------------------------------------------
  if(!is.double(latitude)) {
    stop("latitude must be a decimal number")
  } else {
    lat <- latitude
  }
  
  if(!is.double(longitude)) {
    stop("longitude must be a decimal number")
  } else {
    lng <- longitude
  }
  
  if(!is.numeric(radius)) {
    stop("radius must be an integer number")
  } else {
    rad <- as.integer(radius + 0.5)
  }
  
  # Initialization ---------------------------------------------------------
  yelp <- "https://api.yelp.com"
  term <- "restaurants"
  location <- "NYC"
  p <- price
  limit <- 10

  # Add filter to search engine
  url <- modify_url(yelp, path = c("v3", "businesses", "search"),
                    query = list(term = term,
                                 location = location,
                                 limit = limit,
                                 longitude = lng,
                                 latitude = lat,
                                 price = p,
                                 categories = categories,
                                 radius = rad,
                                 sort_by = sort
                                 )
                    )
  
  # Send request to API and get results
  res <- GET(url, add_headers('Authorization' = paste("bearer", "zLZesNlW8YSPyNP9poXD-_FDOhvNFACzrq-xAul5H3b6isbviX3o2EuCeifPRAsTvfz_c0lPzJUPNtzUIeowGHmhheCAxRMWz_lc5cqQAY-7X94pAvYkC3pXNjG2W3Yx")))
  results <- content(res)
  
  # Define a function to parse search results with only the columns needed -----
  yelp_httr_parse <- function(x) {
    
    # Set a list of wanted columns
    parse_list <- list(id = x$id, 
                       name = x$name, 
                       rating = x$rating,
                       price = x$price,
                       review_count = x$review_count, 
                       latitude = x$coordinates$latitude, 
                       longitude = x$coordinates$longitude, 
                       address1 = x$location$address1, 
                       city = x$location$city, 
                       state = x$location$state, 
                       distance = x$distance
                       )
    # Read results into the parse_list without useless columns
    parse_list <- lapply(parse_list, FUN = function(x) ifelse(is.null(x), "", x))
    
    # Change parse_list to data frame type
    df <- data_frame(id=parse_list$id,
                     name=parse_list$name, 
                     rating = parse_list$rating,
                     price = parse_list$price,
                     review_count = parse_list$review_count, 
                     latitude=parse_list$latitude, 
                     longitude = parse_list$longitude, 
                     address1 = parse_list$address1, 
                     city = parse_list$city, 
                     state = parse_list$state, 
                     distance= parse_list$distance)
    df
  }

  # Call yelp_httr_parse() to get parse results and save in results_list -----------
  results_list <- lapply(results$businesses, FUN = yelp_httr_parse)
  payload <- do.call("rbind", results_list)
  
  # Return
  payload
}
