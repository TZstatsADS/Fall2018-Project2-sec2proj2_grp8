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
        menuItem("NYC Map", tabName = "mapmenu", icon = icon("bank"))
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