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
        sliderInput("decimal", "Distance (in miles):",
                    min = 0, max = 2.5,
                    value = 1.0, step=0.5),
        #checkbox for price
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