CR2W1_Filtered <- CR2W1_Main[!is.na(CR2W1_Main$`Lead Rate`),] %>% filter(`Lead Rate` != 0)
CR2W1_Filtered$Leads_Per_100_Impressions <- CR2W1_Filtered$Leads / CR2W1_Filtered$Impressions * 100
preds <- CR2W1_Filtered %>% glm(Leads_Per_100_Impressions ~ Brand_Position + Audience, family = "gaussian",.)
CR2W1_Filtered$preds <- predict(preds)
View(CR2W1_Filtered)
write.csv(CR2W1_Filtered, file = "CR2W1 Filtered.csv")     
