## server.R ##
library(shiny)
library(dplyr)
library(yelpr)
library(geosphere)

shinyServer(function(input, output) {
  # init map
  output$map = renderLeaflet({
    leaflet() %>% 
      setView(lng = -73.980, lat = 40.738, zoom = 13) %>%
      addProviderTiles("CartoDB.Positron")
  })
  
  # ------------------- attraction part --------------------
  # Make a list of icons
  attIcons <- iconList(
    SL = makeIcon("SL.png", 50, 50),
    ES = makeIcon("ES.png", 40, 40),
    BB = makeIcon("BB.png", 40, 40),
    TS = makeIcon("TS.png", 35, 35),
    MA = makeIcon("MA.png", 35, 35),
    GS = makeIcon("GS.png", 35, 35),
    CP = makeIcon("CP.png", 40, 40),
    BP = makeIcon("BP.png", 40, 40),
    BT = makeIcon("BT.png", 35, 35),
    RC = makeIcon("RC.png", 40, 40),
    OW = makeIcon("OW.png", 40, 40),
    PL = makeIcon("PL.png", 35, 35),
    LC = makeIcon("LC.png", 35, 35),
    RCM = makeIcon("RCM.png", 35, 35),
    CB = makeIcon("CB.png", 40, 40),
    MH = makeIcon("MH.png", 35, 35),
    MM = makeIcon("MM.png", 40, 40),
    CH = makeIcon("CH.png", 40, 40),
    SP = makeIcon("SP.png", 40, 40),
    HL = makeIcon("HL.png", 30, 30),
    O = makeIcon("O.png", 35, 35)
  )
  
  observeEvent(input$att,{
    m = match(input$att,att_loc$Code)
    att_lng = att_loc$Longitude[m]
    att_lat = att_loc$Latitude[m]
    att_nm = att_loc$Attraction[m]
    att_cd = att_loc$Code[m]
    df_app = data.frame(att_nm, att_lng, att_lat, att_cd)
    
    # render map
    leafletProxy("map", data = df_app) %>%
      addMarkers(lng = att_lng,
                 lat = att_lat,
                 popup = att_nm,
                 icon = attIcons[att_cd])
    
    }) # End of attraction part
    
    # ------------------- filter part --------------------
    observeEvent(input$search,{
      m = match(input$att,att_loc$Code)
      att_lng = att_loc$Longitude[m]
      att_lat = att_loc$Latitude[m]
      att_nm = att_loc$Attraction[m]
      att_cd = att_loc$Code[m]
      df_app = data.frame(att_nm, att_lng, att_lat, att_cd)
      
      if (length(input$att) != 0) {
      
        # get cuisine parameter from input and concatenat
        if (length(input$cat) == 0) {
          cuz = NULL
        } else {
          cuz = paste0(input$cat,collapse=",")
        }
        
        # get miles parameter from input and turn to meters
        radius = as.integer(input$decimal*1609.34 + 0.5)

        # get price parameter from input
        if (length(input$price_group) == 0){
          price_group = NULL
        } else {
          price_group = input$price_group
        }
        
        # get filter parameter from input
        if (length(input$filter_setting) == 0){
          set_filter = NULL
        } else {
          set_filter = input$filter_setting         
        }
 
        # Get data from yelp for each attraction
        key = 'zLZesNlW8YSPyNP9poXD-_FDOhvNFACzrq-xAul5H3b6isbviX3o2EuCeifPRAsTvfz_c0lPzJUPNtzUIeowGHmhheCAxRMWz_lc5cqQAY-7X94pAvYkC3pXNjG2W3Yx'
        
        # Clean the map
        leafletProxy("map") %>% 
          clearMarkers() %>%
          addMarkers(lng = att_lng,
                     lat = att_lat,
                     popup = att_nm,
                     icon = attIcons[att_cd])
        
        # Loop through the attraction lists
        n = length(input$att)
        for (i in 1:n) {
          # Access yelp API
          dat = get_yelp_data(latitude = att_lat[i],
                              longitude = att_lng[i],
                              radius = radius,
                              categories = cuz,
                              price = price_group,
                              sort = set_filter)
          
          'business_ny = business_search(api_key = key,
                                        location = ,
                                        latitude = att_lat[i],
                                        longitude = att_lng[i],
                                        radius = radius,
                                        price = price_group,
                                        sort_by = set_filter,
                                        limit = 50)'
          
          # render map
          leafletProxy("map", data = dat) %>%
            addMarkers(lng = dat$longitude,
                       lat = dat$latitude,
                       popup = ~dat$name,
                       icon=makeIcon("food.png", 25, 25))
        } # End for loop
      } # End if
    })
})
