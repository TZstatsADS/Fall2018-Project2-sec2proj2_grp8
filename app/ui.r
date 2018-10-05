## ui.R ##
library(shinydashboard)
library(leaflet)

shinyUI(
  dashboardPage(
    skin = 'blue',
    dashboardHeader(title = "NYC Trip Guide", titleWidth = 240
    ),# End of Header
  
    dashboardSidebar(
      sidebarMenu(
        menuItem("NYC Map", tabName = "mapmenu", icon = icon("bank")),
        
        # Attractions selection
        selectizeInput('foo', label = h3("Attractions"),
                       choices = list(
                         `Statue of Liberty` = 'SL', `Central Park` = 'CP',
                         `Rockefeller Center` = 'RC', `Metropolitan Museum of Art` = 'MA',
                         `Broadway and Theater District` = 'BT', `Empire State Building` = 'ES',
                         `9/11 Memorial and Museum` = '911', `The High Line` = 'HL',
                         `Times Square` = 'TS', `Brooklyn Bridge` = 'BB',
                         `Grand Central Terminal` = 'GS', `One World Observatory` = 'OW',
                         `New York Public Library` = 'PL', `Charging Bull` = 'CB',
                         `Radio City Music Hall` = 'RC', `St. Patrick's Cathedral` = 'SP',
                         `Carnegie Hall` = 'CH', `Bryant Park` = 'BP',
                         `Lincoln Center` = 'LC', `The Oculus` = 'O',
                         `Macy's Herald Square` = 'MH'
                       ),
                       multiple = TRUE,
                       options = list(maxItems = 3, placeholder = 'Choose at most 3 attractions')
        ),
        
        # Radius slider
        sliderInput("decimal", "Distance (in miles):",
                    min = 0, max = 2.5,
                    value = 1.0, step=0.5),
        
        # checkbox for price
        checkboxGroupInput("checkGroup", label = h3("Price"), 
                           choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                           selected = 1)
        
        ) # End of sidebarMenu
    ), # End of Sidebar
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "mapmenu",
                leafletOutput("map", height = 760)
  
        )
      ) # End of tabItems
    ) # End of dashboardBody
  ) # End
)          