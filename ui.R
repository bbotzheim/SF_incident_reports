dashboardPage(
  dashboardHeader(title = "Incidents in SF", 
                  titleWidth = 240),
  dashboardSidebar(
    width = 240,
    sidebarUserPanel("Brenna Botzheim", image = "data:image/jpeg;base64,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"),    sidebarMenu(
      menuItem("Introduction", tabName = "intro", icon = icon("file-alt")),
      menuItem("Location", tabName = "mapwidgets", icon = icon("map-marker")),
      menuItem("Timeline", tabName = "timewidgets", icon = icon("chart-area")),
      menuItem("Compare Incidents", tabName = "compare", icon = icon("balance-scale")),
      menuItem("Data", tabName = "data", icon = icon("database")),
      menuItem(selectizeInput("selected", "Select Type of Incident to Display", choices, selected = "Total"), width = 3, height = 150), 
      menuItem(dateRangeInput("dateRange", "Date Range", 
                              start = "2018-01-01",
                              end = as.character(Sys.Date()),
                              min    = "2018-01-01",
                              max    = "2019-12-31")))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              box(h2("Incident Reports in San Francisco from 2018-2019"),
              "This Shiny app's goal is to provide dynamic visualizations to describe incidents reported in San Francisco since 01/01/2018. The data is 
              provided by SF Open Data and consists of all incident reports filed by the SF police department. As such, the incidents include both illegal 
              incidents and non-criminal incidents that SFPD are obliged to take reports on. This app provides functionality to examine the data by variables
              such as types of incidents, time, and location. Incident reports can be used in a variety of ways and it is the goal of this app to aid the 
              user in finding answers to whatever their questions may be.",
              h3("Location and Time Variables"),
              "The Location tab and Timeline tab offer graphical displays of the selected Incident Type (in the sidebar) within the date range selected. 
              After changing one of the parameters in the sidebar, all charts/graphs within these two tabs will automatically update to filter for the user's 
              selection.",
              h3("Comparing Incidents"),
              "The Comparison tab offers the user the option to look at two different incident types side by side, in order to more easily examine differences
              between incident types. Please note this tab is filtered separately from the other two tabs. Instead of selecting via the sidebar, the 
              parameters are selected within the tab and do not change based on the sidebar selections.")
              ),
      tabItem(tabName = "mapwidgets",
              fluidRow(
                column(width = 6,
                       box(
                         title = textOutput("caption", container = span), width = NULL, status = "success", solidHeader = F,
                         leafletOutput("map"), height = 475)),
                column(width = 3,
                    infoBoxOutput("minBox", width = NULL),
                    valueBoxOutput("totBox", width = NULL),

              ),
                column(width=3,
                     infoBoxOutput("maxBox", width = NULL),
                     valueBoxOutput("max_neigh", width=NULL)
              )),
               fluidRow(
                 box( 
                   title = textOutput("caption2", container = span), height = 400, width = 12, status = "success", solidHeader = F,
                   htmlOutput("location"))
                       )),
      tabItem(tabName = "timewidgets",
              fluidRow(box(
                title = textOutput("caption5", container = span), width = 8, height = 500, status = "success", solidHeader = F,
                htmlOutput("timeline")),
                box(
                  title = textOutput("caption3", container = span), height = 500, width = 4, status = "success", solidHeader = F,
                  htmlOutput("pieday"),
                  br(),
                  "*Morning:5am-11am, Afternoon:11am-5pm, Evening:5pm-11pm, Night:11pm-5am")
                ),
                fluidRow(
                  column(width =4, 
                         valueBoxOutput("avg_by_day", width = NULL),
                         valueBoxOutput("max_time", width = NULL),
                         valueBoxOutput("max_day", width = NULL)
                         ),
                  column(width = 8,
                    box(title=textOutput("caption4", container = span), height = 350, width = NULL, status = "success", solidHeader = F,
                      htmlOutput("weekday"))))
              ),
      tabItem(tabName = "compare", 
              fluidRow(
                box(title = "Select Incidents",width = 3, status = "primary", solidHeader = T,
                    selectizeInput("compare_select1", "First Incident to Display", choices2, selected = "Arson"),
                selectizeInput("compare_select2", "Second Incident to Display", choices2, selected = "Assault"),
                dateRangeInput("compare_dateRange", "Date Range", 
                               start = "2018-01-01",
                               end = as.character(Sys.Date()),
                               min    = "2018-01-01",
                               max    = "2019-12-31")),
                box(title = "Compare Total Incidents by Neighborhood",width = 9, height = 350, status = "success", solidHeader = F,
                    htmlOutput("linecompare"))
              ),
              fluidRow(
                column(width = 3,
                       valueBoxOutput("compare1_value", width = NULL),
                       valueBoxOutput("compare2_value", width = NULL)),
                column(width = 4,
                  box(title = textOutput("caption6", container = span), status = "success",height = 500,width = NULL,
                    htmlOutput("compare_pieday1"))),
                column(width = 4,
                  box(title = textOutput("caption7", container = span), status = "success", height = 500,width = NULL,
                    htmlOutput("compare_pieday2")))
              )),
      tabItem(tabName = "data",
              fluidRow(box(DT::dataTableOutput("table"),
                           width = 12))
              )
      )
    ),
skin = "yellow")