library(shiny)
library(shinydashboard)
library(rsconnect)
library(dplyr)
library(googleVis)
library(DT)
library(leaflet)
library(ggplot2)
library(RColorBrewer)
library(htmltools)

#source("./helpers.R")
#dbname = "./reports.sqlite"
#tblname = "reports"

reports = read.csv("SF_reports_new.csv", header = T, stringsAsFactors = F)
reports$Incident.Date=as.Date(reports$Incident.Date)


choices_df = reports %>% select(., Incident.Category) %>% distinct(.,) %>% 
  arrange(., Incident.Category)
choices = c("Total", choices_df$Incident.Category)
choices2 = choices_df$Incident.Category