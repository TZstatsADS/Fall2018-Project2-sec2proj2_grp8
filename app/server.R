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
  
  observeEvent(input$search,{
    # ------------------- attraction part ------------
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
    
    # ------------------- restaurant part ------------
    # concatenating all inputs for cuisine
    cuz = paste0(input$cat,collapse=" ")
    
    # grab data based on cuz
    key = 'zLZesNlW8YSPyNP9poXD-_FDOhvNFACzrq-xAul5H3b6isbviX3o2EuCeifPRAsTvfz_c0lPzJUPNtzUIeowGHmhheCAxRMWz_lc5cqQAY-7X94pAvYkC3pXNjG2W3Yx'
    business_ny = business_search(api_key = key, location = 'New York', term = cuz, limit = 50)
    dat = business_ny$businesses #dataframe
    
    # get filter
    price_group = input$price_group
    
    # clean the data
    dat = dat[!is.na(dat$price), ]
    dat[!is.na(dat$coordinates$longitude), ]
    dat[!is.na(dat$coordinates$latitude), ]
    dat$price = iconv(dat$price, to = "utf-8")
    
    # filter the data based on mark
    dat = dat[dat$price %in% price_group, ]
    
    # get miles parameter from input
    miles = input$decimal

    convter_mile_to_meter = function(){
      return(miles*1609.34)
    }
    
    check_dist = function(lng, lat){
      meter = convter_mile_to_meter()
      len = length(att_lat)
      for( i in 1:len){
        if(distm(c(lng, lat), c(att_lng[i], att_lat[i]), fun = distHaversine) <= meter){
          return(TRUE)
        }
      }
      return(FALSE)
    }
    
    # filter the data based on distance
    dat = dat[mapply(check_dist, dat$coordinates$longitude, dat$coordinates$latitude), ]
    
    # render map
    leafletProxy("map", data = dat) %>%
      clearMarkers() %>% # hard refresh each page
      addMarkers(lng = dat$coordinates$longitude,
                 lat = dat$coordinates$latitude,
                 popup = ~name,
                 icon=makeIcon("chef.png", 22, 22)) %>% #Change this icon to something pretty if you like!
      
      addMarkers(lng = att_lng,
                 lat = att_lat,
                 popup = att_nm,
                 icon = attIcons[att_cd])

  })
})
