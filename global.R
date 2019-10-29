library(shiny)
library(shinydashboard)
library(dplyr)
library(googleVis)
library(DT)
library(leaflet)
library(ggplot2)
library(RColorBrewer)
library(htmltools)

reports = read.csv("SF_reports_new.csv", header = T, stringsAsFactors = F)
reports$Incident.Date=as.Date(reports$Incident.Date)

max_report = reports %>% 
  group_by(., Incident.Category) %>% 
  summarize(., n = n()) %>% 
  arrange(., desc(n))

min_report = reports %>% 
  group_by(., Incident.Category) %>% 
  summarize(., n = n()) %>% 
  arrange(., n)

choices_df = reports %>% select(., Incident.Category) %>% distinct(.,) %>% 
  arrange(., Incident.Category)
choices = c("Total", choices_df$Incident.Category)
choices2 = choices_df$Incident.Category