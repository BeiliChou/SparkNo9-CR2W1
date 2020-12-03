library(readxl);library(dplyr)
CR2W1_Main <- read_excel("CR2W1 Main.xlsx")
CR2W1_Main <- CR2W1_Main %>% rename(Brand_Position = `Brand Position`)
CR2W1_Main <- CR2W1_Main[-33,]
CR2W1_Analysis <- CR2W1_Main %>% group_by(Brand_Position, Audience) %>% filter(Impressions>=1000) %>% summarise(Spent_Total = sum(Spent), Impressions_Total = sum(Impressions), 
                                                                Leads_Total = sum(Leads), Leads_Per_1k_Impressions = (Leads_Total/Impressions_Total)*1000,
                                                                Cost_Per_1k_Impressions = (Spent_Total/Impressions_Total)*1000) %>% arrange(desc(Impressions_Total))
write.csv(CR2W1_Analysis, file = "CR2W1 Analysis.csv")    
CR2W1_Analysis %>% summarise(cor(Leads_Per_100_Impressions, Impressions_Total))
View(CR2W1_Analysis)
