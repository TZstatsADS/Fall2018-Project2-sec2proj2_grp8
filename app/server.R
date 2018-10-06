## server.R ##
library(shiny)
library(dplyr)
library(yelpr)

shinyServer(function(input, output) {
  # Map rendering -----------------------------------------------------------------------------
  # Initialization
  output$map <- renderLeaflet({
    leaflet() %>% 
      setView(lng = -73.980, lat = 40.738, zoom =13) %>%
      addProviderTiles("CartoDB.Positron")
  })
  
 
  # Check attractions inputs
  observeEvent(input$att, {
    m = match(input$att,att_loc$Code)
    att_lng = att_loc$Longitude[m]
    att_lat = att_loc$Latitude[m]
    att_nm = att_loc$Attraction[m]
    att_cd = att_loc$Code[m]
    df_app = data.frame(att_nm, att_lng, att_lat, att_cd)
    
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
    
    # Output to map
  leafletProxy("map", data = df_app) %>%
      clearMarkers() %>% 
      addMarkers(lng = ~att_lng,
                 lat = ~att_lat,
                 popup = ~att_nm,
                 icon = ~attIcons[att_cd])
    })# end of attractions observe event
  
  #Cuisines output:
  
  observeEvent(input$search,{
    # checkbox for price
    output$value <- renderPrint({ input$checkGroup })
    # concatenating all inputs for cuisine
    cuz=NULL
    cuz=paste0(input$cat,collapse=" ")
       
  
  #Final pull request from yelp with all filters
    key<-'zLZesNlW8YSPyNP9poXD-_FDOhvNFACzrq-xAul5H3b6isbviX3o2EuCeifPRAsTvfz_c0lPzJUPNtzUIeowGHmhheCAxRMWz_lc5cqQAY-7X94pAvYkC3pXNjG2W3Yx'
    business_ny <- business_search(api_key = key,location = 'New York',term = cuz,limit = 50)
    bny=business_ny$businesses #dataframe
    bny
    
  #Output to map
  leafletProxy("map", data = bny) %>%
    #clearMarkers() %>%
    addMarkers(lng = bny$coordinates$longitude,
               lat = bny$coordinates$latitude,
               popup = ~name,
               icon=makeIcon("chef.png",22, 22)) #Change this icon to something pretty if you like!
    
    
# Output on map -------------------------------------------------------------
})
   })  

  
  
