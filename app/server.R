## server.R ##

shinyServer(function(input, output) {
  # Map rendering -----------------------------------------------------------------------------
  # Initialization
  output$map <- renderLeaflet({
    leaflet() %>% 
      setView(lng = -73.980, lat = 40.740, zoom =13) %>%
      addProviderTiles("CartoDB.Positron")
  })
  #checkbox for price
  output$value <- renderPrint({ input$checkGroup })
  
})  

  
  
