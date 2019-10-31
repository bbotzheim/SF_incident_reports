dashboardPage(
  dashboardHeader(title = "Incidents in SF", 
                  titleWidth = 240),
  dashboardSidebar(
    width = 240,
    sidebarMenu(
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
              "This app provides dynamic visualizations to describe incidents reported in San Francisco. The data is provided by SF Open Data and consists 
              of all incident reports filed by the SF police department since 01/01/2018. As such, the incidents include both criminal activity and 
              non-criminal reports that SFPD take reports for. This app provides functionality to examine the data by variables such as type 
              of incidents, time, and location. SF incident reports can be used in a variety of ways and it is the goal of this app to aid the user in 
              finding answers to whatever their questions may be.",
              h3("Location and Time Variables"),
              "The Location tab and Timeline tab offer graphical displays of the selected Incident Type (in the sidebar) within the selected date range. 
              After changing one of the parameters in the sidebar, all graphics within these two tabs will automatically update to filter for the user's 
              selection.",
              h3("Comparing Incidents"),
              "The Comparison tab offers the user the option to look at two different incident types side by side, in order to more easily examine differences
              between incident types. Please note this tab is filtered separately from the other two tabs. Instead of selecting via the sidebar, the 
              parameters are selected within the tab and do not change based on the sidebar selections.",
              h3("Data"),
              "The data tab allows the user to directly view the underlying data, filtered by their selections. It includes incident subcategories and incident 
              descriptions of the filtered data."),
              box(
                img(src="https://hoodline.imgix.net/uploads/story/image/10247/sfpdfinal.png?auto=format", width = "100%")
              )),
      tabItem(tabName = "mapwidgets",
              fluidRow(
                column(width = 6,
                       box(
                         title = textOutput("caption", container = span), width = NULL, status = "success", solidHeader = F,
                         leafletOutput("map"), height = 475)),
                column(width = 3,
                    infoBoxOutput("minBox", width = NULL),
                    valueBoxOutput("totBox", width = NULL)

              ),
                column(width=3,
                     infoBoxOutput("maxBox", width = NULL),
                     valueBoxOutput("max_neigh", width=NULL)
              )),
               fluidRow(
                 box( 
                   title = textOutput("caption2", container = span), height = 370, width = 12, status = "success", solidHeader = F,
                   htmlOutput("location"))
                       )),
      tabItem(tabName = "timewidgets",
              fluidRow(box(
                title = textOutput("caption5", container = span), width = 8, height = 500, status = "success", solidHeader = F,
                htmlOutput("timeline")),
                box(
                  title = textOutput("caption3", container = span), width = 4, height = 500, status = "success", solidHeader = F,
                  htmlOutput("pieday"),
                  br(),
                  span(textOutput("disclaimer"), style = "font-size:70%"))
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
                column(width =3,
                       box(title = "Select Incidents",width = NULL, status = "primary", solidHeader = T,
                                    selectizeInput("compare_select1", "First Incident to Display", choices2, selected = "Arson"),
                                    selectizeInput("compare_select2", "Second Incident to Display", choices2, selected = "Assault"),
                                    dateRangeInput("compare_dateRange", "Date Range", 
                                                   start = "2018-01-01",
                                                   end = as.character(Sys.Date()),
                                                   min    = "2018-01-01",
                                                   max    = "2019-12-31")),
                           valueBoxOutput("compare1_value", width = NULL),
                           valueBoxOutput("compare2_value", width = NULL)),
                column(width = 4,
                       box(title = textOutput("caption6", container = span), status = "success",height = 550,width = NULL,
                           htmlOutput("compare_pieday1"),
                           br(),
                           span(textOutput("disclaimer2"), style = "font-size:70%"))),
                column(width = 4,
                       box(title = textOutput("caption7", container = span), status = "success", height = 550,width = NULL,
                           htmlOutput("compare_pieday2")))
              ),
              fluidRow(
                box(title = "Compare Total Incidents by District",width = 12, height =370, status = "success", solidHeader = F, 
                    htmlOutput("chartcompare"))
              )),
      tabItem(tabName = "data",
              fluidRow(box(DT::dataTableOutput("table"),
                           width = 12))
              )
      )
    ),
skin = "yellow")