packages.used=c("shinydashboard","leaflet")

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
                       ),
                       multiple = TRUE,
                       options = list(maxItems = 3, placeholder = 'Choose at most 3 attractions')
        ),
        
        #Slider input for cuisines
        selectizeInput('cat', "Cuisine",
                       choices = list(
                         `American` = 'tradamerican', `Chinese` = 'chinese',
                         `Cuban` = 'cuban', `Indian` = 'indpak',
                         `Italian` = 'italian', `Japanese` = 'japanese',
                         `Korean` = 'korean', `Mexican` = 'mexican'
                       ),
                       multiple = TRUE,
<<<<<<< HEAD
                       options = list(maxItems = 3, placeholder = 'Choose up to 3 cuisins')
=======
                       # maxItems = 3
                       options = list(placeholder = 'Choose up to 3 cuisines')
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 0a0b5e1ae5fb2ff09da3c5ecff8df575204f1421
=======
>>>>>>> a91b3372cf64a5772e32dd5abae13ef1afc4e48f
>>>>>>> 0a0b5e1ae5fb2ff09da3c5ecff8df575204f1421
        ),
        
        # Radius slider
        sliderInput("decimal", "Distance (in miles):",
<<<<<<< HEAD
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a91b3372cf64a5772e32dd5abae13ef1afc4e48f
                    min = 0, max = 10,
                    value = 3.0, step = 0.5
        ),
=======
                    min = 0, max = 2.5,
                    value = 1.0, step = 0.5),
>>>>>>> 0a0b5e1ae5fb2ff09da3c5ecff8df575204f1421
<<<<<<< HEAD
=======
=======
                    min = 0, max = 2.5,
                    value = 1.0, step = 0.5),
>>>>>>> 0a0b5e1ae5fb2ff09da3c5ecff8df575204f1421
>>>>>>> a91b3372cf64a5772e32dd5abae13ef1afc4e48f
        
        # checkbox for price
        radioButtons("price_group", "Price", 
                     choices = list(`$` = 1, `$$` = 2, `$$$` = 3, `$$$$` = 4),
                     selected = character(0)
        ),
        
        # checkbox for filter
        radioButtons("filter_setting", "Filter", 
                     choices = list(`Best Match` = "best_match", `Rating` = "rating"
                                    ,`Review Count` = "review_count", `Distance` = "distance"),
                     selected = character(0)
        ),
        
        # search action
        actionButton("search", "Search")
      ) # End of sidebarMenu 
    ), # End of dashboardSidebar
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "mapmenu",
                leafletOutput("map", height = 760)
        )
      ) 
    ) 
  ) 
)          
