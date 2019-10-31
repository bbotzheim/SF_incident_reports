function(input, output, session){
#  conn <-dbConnector(session, dbname = dbname)

  ### Reactive Expressions for use in Location/Timeline Tabs
#  reports_by_type <- reactive(dbGetData(conn = conn,
#                                        tblname=tblname,
#                                        start_date = input$dateRange[1],
#                                        end_date = input$dateRange[2],
#                                        incident = input$selected))
  
  reports_by_type <- reactive({
    if (input$selected == 'Total') {
      reports %>% 
        filter(., Incident.Date >= input$dateRange[1] & Incident.Date <= input$dateRange[2])
    } else {
      reports %>% 
        filter(., Incident.Category==input$selected & Incident.Date >= input$dateRange[1] & Incident.Date <= input$dateRange[2])
    }
  })
  
  ##Pie Chart Disclaimer
  output$disclaimer <- renderText({"*Morning:5am-11am, Midday:11am-5pm, Evening:5pm-11pm, Night:11pm-5am"})
  output$disclaimer2 <- renderText({"*Morning:5am-11am, Midday:11am-5pm, Evening:5pm-11pm, Night:11pm-5am"})
##Dynamic Graph Titles
  output$caption <- renderText({
    paste(input$selected, "Incidents, clustered")
  })
  output$caption2 <- renderText({
    paste(input$selected, "Incidents by District")
  })
  output$caption3 <- renderText({
    paste(input$selected, "Incidents by Time of Day")
  })
  output$caption4 <- renderText({
    paste(input$selected, "Incidents by Day of the Week")
  })
  output$caption5 <- renderText({
    paste(input$selected, "Incidents Over Time")
  })
  output$caption6 <- renderText({
    paste(input$compare_select1, "Incidents by Time of Day")
  })
  output$caption7 <- renderText({
    paste(input$compare_select2, "Incidents by Time of Day")
  })
## Map tab output
  output$map <- renderLeaflet({
    leaflet(data = reports_by_type(), 
            options = leafletOptions(minZoom = 10, maxZoom = 20)) %>%
      setView(-122.4194, 37.7649, zoom = 12) %>% 
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addMarkers(lat = ~Latitude, lng =  ~Longitude,
                 label = ~htmlEscape(Incident.Subcategory),
                 clusterOptions = markerClusterOptions())
  })
  output$location <- renderGvis(
    gvisColumnChart(reports_by_type() %>% 
                      group_by(., Police.District) %>% 
                      summarize(., Total = n()),
                    options=list(
                      hAxis="{title:'District'}",
                      vAxis="{title:'Total Incidents Reported'}",
                      legend = "none",
                      width=1225, height=300,
                      colors = "['#F39C12']")
    ))
  #value/info boxes
  output$totBox <- renderValueBox({
    total_incidents = nrow(reports_by_type())
    if (input$selected=="Total"){
      cap = "Selected: Total Incidents"
      color = "green"
    } else {
      cap = paste("Selected: Total", input$selected, "Incidents")
      color = "green"
    }
    valueBox(icon = icon("angle-double-right"),total_incidents,cap, color = color)
  })
  output$max_neigh <-renderValueBox({
    max_hood = reports_by_type() %>% 
      group_by(., Police.District) %>% 
      summarize(., Total = n()) %>% 
      arrange(., desc(Total))
    cap = paste("Selected:", input$selected, ", Most Common District" )
    color = "green"
    valueBox(max_hood[1,1],cap, icon=icon("home"), color = color)
  })
  output$maxBox <- renderInfoBox({
    max_report = reports %>% 
      group_by(., Incident.Category) %>% 
      summarize(., n = n()) %>% 
      arrange(., desc(n))
    color = "teal"
    cap = paste("Most Common:", max_report[1,1])
    infoBox(cap, max_report[1,2], icon = icon("angle-double-up"), color = color)
  })
  output$minBox <- renderInfoBox({
    min_report = reports %>% 
      group_by(., Incident.Category) %>% 
      summarize(., n = n()) %>% 
      arrange(., n)
    color = "teal"
    cap = paste("Least Common:", min_report[2,1])
    infoBox(cap, min_report[2,2], icon = icon("angle-double-down"), color = color)
  })
## Timeline Tab Output
  output$timeline <- renderGvis(
    gvisAnnotationChart(reports_by_type() %>% 
                   group_by(., Incident.Date) %>% 
                   summarize(., Total = n()),
                  datevar = "Incident.Date",
                  numvar = "Total",
      options = list(height = 400, width = 770,
                     fill=10, displayExactValues=TRUE,
                     hAxis="{title:'Year/Month'}",
                     vAxis="{title:'Total Incidents Reported'}",
                     chartArea="{width:\"100%\",height:\"70%\"}")
    )
  )
  output$pieday <- renderGvis(
    gvisPieChart(reports_by_type() %>% 
                   group_by(., Time_of_Day) %>% 
                   summarize(., Total = n()),
                 options = list(chartArea="{left:20,top:20,width:\"100%\",height:\"100%\"}",
                 width = 350, height = 300,
                 colors="['#27AE60','#5499C7', '#F7DC6F', '#9B59B6']"))
  )
  output$weekday <- renderGvis(
    gvisColumnChart(reports_by_type() %>% 
                      group_by(., Incident.Day.of.Week) %>% 
                      summarize(., Total = n()), 
                    options=list(
                      hAxis="{title:'Day of the Week'}",
                      vAxis="{title:'Total Incidents Reported'}",
                      vAxes="[{viewWindowMode:'explicit', viewWindow:{min:0}}]",
                      legend = "none",
                      width=800, height=290,
                      colors = "['#F39C12']"))
    )
  # value/info boxes
  output$avg_by_day <-renderValueBox({
    avg = reports_by_type() %>% 
      group_by(., Incident.Date) %>% 
      summarize(., Total = n()) %>% 
      summarize(., mean(Total))
    cap = paste("Selected:", input$selected, "Average Incidents per Day")
    color = "green"
    valueBox(round(avg), cap,icon=icon("calculator"), color = color)
  })  
  output$max_time <-renderValueBox({
    maxtime = reports_by_type() %>% 
      group_by(., Time_of_Day) %>% 
      summarize(., Total = n()) %>% 
      arrange(., desc(Total))
    cap = paste("Selected:", input$selected, ", Most Common Time of Day" )
    color = "green"
    valueBox(maxtime[1,1],cap, icon=icon("clock"), color = color)
  })
  output$max_day <-renderValueBox({
    maxday = reports_by_type() %>% 
      group_by(., Incident.Day.of.Week) %>% 
      summarize(., Total = n()) %>% 
      arrange(., desc(Total))
    cap = paste("Selected:", input$selected, ", Most Common Weekday" )
    color = "green"
    valueBox(maxday[1,1],cap, icon=icon("calendar"), color = color)
  })
## Comparison Tab Output
  compare_district1 <- reactive({
    df = reports %>% 
      filter(., Incident.Category==input$compare_select1, 
             Incident.Date >= input$compare_dateRange[1] & Incident.Date <= input$compare_dateRange[2]) %>% 
      group_by(., Police.District) %>% 
      summarize(., "Total1" = n())
    colnames(df)[2] <- input$compare_select1
    df
  })
  compare_district2 <- reactive({
    df = reports %>% 
      filter(., Incident.Category==input$compare_select2,
             Incident.Date >= input$compare_dateRange[1] & Incident.Date <= input$compare_dateRange[2]) %>% 
      group_by(., Police.District) %>% 
      summarize(., "Total2" = n())
    colnames(df)[2] <- input$compare_select2
    df
  })
  compare_reports1 <- reactive({
    reports %>% 
      filter(., Incident.Category==input$compare_select1, 
             Incident.Date >= input$compare_dateRange[1] & Incident.Date <= input$compare_dateRange[2])
  })
  compare_reports2 <- reactive({
    reports %>% 
      filter(., Incident.Category==input$compare_select2,
             Incident.Date >= input$compare_dateRange[1] & Incident.Date <= input$compare_dateRange[2])
  })
    observe({  
    updateSelectizeInput(
      session, "compare_select2",
      choices = choices_df[choices_df$Incident.Category != input$compare_select1, ],
      selected = input$compare_select2)
    })

    output$chartcompare <- renderGvis(
    gvisColumnChart(full_join(compare_district1(), compare_district2(), by = "Police.District"),
      "Police.District", c(input$compare_select1, input$compare_select2), 
      options = list(
        height = 300, width=1200,
        hAxis="{title: 'District'}",
        chartArea="{width:\"80%\",height:\"70%\"}",
        colors = "['#F39C12', 'green']"))
  )
  output$compare_pieday1 <- renderGvis(
    gvisPieChart(compare_reports1() %>% 
                   group_by(., Time_of_Day) %>% 
                   summarize(., Total = n()),
                 options = list(chartArea="{left:20,top:20,width:\"100%\",height:\"100%\"}",
                                width = 370, height = 400,
                                colors="['#27AE60','#5499C7', '#F7DC6F', '#9B59B6']"))
  )
  output$compare_pieday2 <- renderGvis(
    gvisPieChart(compare_reports2() %>% 
                   group_by(., Time_of_Day) %>% 
                   summarize(., Total = n()),
                 options = list(chartArea="{left:20,top:20,width:\"100%\",height:\"100%\"}",
                                width = 370, height = 400,
                                colors="['#27AE60','#5499C7', '#F7DC6F', '#9B59B6']"))
  )
  # value/info boxes
  output$compare1_value <- renderValueBox({
    total_incidents <-nrow(compare_reports1())
    cap = paste("Total", input$compare_select1, "Reports")
    color = "green"
    valueBox(total_incidents, cap,color = color, icon = icon("angle-right"))
  })
  output$compare2_value <- renderValueBox({
    total_incidents <-nrow(compare_reports2())
    cap = paste("Total", input$compare_select2, "Reports")
    color = "green"
    valueBox(total_incidents, cap, color = color, icon = icon("angle-double-right"))
  })
## Data Tab Output
  output$table <- DT::renderDataTable({
    datatable(reports_by_type () %>% 
                select(., 7,1,5,14,15,16,17,21), 
              rownames=FALSE) 
  })
}