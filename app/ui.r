packages.used=c("shinydashboard","leaflet","yelpr")

# check packages that need to be installed.
packages.needed=setdiff(packages.used,
                        intersect(installed.packages()[,1],
                                  packages.used))
# install additional packages
if(length(packages.needed) > 0){
  install.packages(packages.needed, dependencies = TRUE)
}

## ui.R ##
library(shinydashboard)
library(leaflet)
library(yelpr)

shinyUI(
  dashboardPage(
    skin = 'blue',
    dashboardHeader(title = "NYC Trip Guide", titleWidth = 240
    ),# End of Header
  
    dashboardSidebar(
      sidebarMenu(
        menuItem("NYC Map", tabName = "mapmenu", icon = icon("bank")),
  
        # Attractions selection
        selectizeInput('att', "Attractions",
                       choices = list(
                         `Statue of Liberty` = 'SL', `Central Park` = 'CP',
                         `Rockefeller Center` = 'RC', `Metropolitan Museum of Art` = 'MA',
                         `Broadway and Theater District` = 'BT', `Empire State Building` = 'ES',
                         `9/11 Memorial and Museum` = 'MM', `The High Line` = 'HL',
                         `Times Square` = 'TS', `Brooklyn Bridge` = 'BB',
                         `Grand Central Terminal` = 'GS', `One World Observatory` = 'OW',
                         `New York Public Library` = 'PL', `Charging Bull` = 'CB',
                         `Radio City Music Hall` = 'RCM', `St. Patrick's Cathedral` = 'SP',
                         `Carnegie Hall` = 'CH', `Bryant Park` = 'BP',
                         `Lincoln Center` = 'LC', `The Oculus` = 'O',
                         `Macy's Herald Square` = 'MH'
                       ), selected = 'RC',
                       multiple = TRUE,
                       # maxItems = 3
                       options = list(placeholder = 'Choose at most 3 attractions')
        ),
        
        #Slider input for cuisines
        selectizeInput('cat', "Cuisine",
                       choices = list(
                         `American` = 'tradamerican', `Chinese` = 'chinese',
                         `Cuban` = 'cuban', `Indian` = 'indpak',
                         `Italian` = 'italian', `Japanese` = 'japanese',
                         `Korean` = 'korean', `Mexican` = 'mexican'
                       ), selected = 'chinese',
                       multiple = TRUE,
                       # maxItems = 3
                       options = list(placeholder = 'Choose up to 3 cuisines')
        ),
        
        # Radius slider
        sliderInput("decimal", "Distance (in miles):",
                    min = 0, max = 2,
                    value = 1.0, step = 0.5),
        
        # checkbox for price
        checkboxGroupInput("price_group", "Price", 
                           choices = list("$" = "$", "$$" = "$$", "$$$" = '$$$'),
                           selected = '$'),
        
        # search action
        actionButton("search", "Search")
        ) 
    ), 
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "mapmenu",
                leafletOutput("map", height = 760)
        )
      ) 
    ) 
  ) 
)          
