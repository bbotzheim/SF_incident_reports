reports = read.csv("incident_reports_SF.csv", header = T, stringsAsFactors = F)
reports$Incident.Time = gsub(":", "", reports$Incident.Time)
reports$Incident.Time = as.numeric(reports$Incident.Time)
reports$Incident.Date=as.Date(reports$Incident.Date)
reports = reports %>% 
  mutate(., month = format(Incident.Date, "%m"), Time_of_Day = ifelse(Incident.Time >= 2300 | Incident.Time < 0500, "Night", 
                                                                      ifelse(Incident.Time >= 0500 & Incident.Time < 1100 ,"Morning", 
                                                                             ifelse(Incident.Time>=1100 & Incident.Time <1700, "Afternoon" ,
                                                                                    ifelse(Incident.Time>=1700 & Incident.Time <2300, "Evening", 0)))))
reports = reports %>% 
  mutate(., season = ifelse(month=="03" | month=="04" | month=="05", "Spring", 
                            ifelse(month=="06" | month=="07" | month=="08", "Summer", 
                                   ifelse(month=="09" | month=="10" | month=="11", "Autumn",
                                          ifelse(month=="12" | month=="01" | month=="02", "Winter", 0)))))


reports[reports$Incident.Category %in% c("Weapons Offence", "Weapons Carrying Etc"), "Incident.Category"] = "Weapons Offense"
reports[reports$Incident.Category =="Suspicious Occ", "Incident.Category"] = "Suspicious"
reports[reports$Incident.Category == "Motor Vehicle Theft?", "Incident.Category"] = "Motor Vehicle Theft"
reports[reports$Incident.Category %in% c("Other Miscellaneous", "Other Offenses", "Miscellaneous Investigation"), "Incident.Category"] = "Other"
reports[reports$Incident.Category == "Human Trafficking (A), Commercial Sex Acts", "Incident.Category"] = "Human Trafficking, Commercial Sex Acts"
reports[reports$Incident.Category == "Drug Violation", "Incident.Category"] = "Drug Offense"



write.csv(reports, file='SF_reports_new.csv', row.names=F)

