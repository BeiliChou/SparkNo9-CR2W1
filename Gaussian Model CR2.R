CR2W1_Main <- CR2W1_Main %>% rename(Lead_Rate = `Lead Rate`)
CR2W1_Filtered <- CR2W1_Main[!is.na(CR2W1_Main$Lead_Rate),] %>% filter(Lead_Rate != 0)
CR2W1_Filtered <- CR2W1_Filtered %>% mutate(Emotional = 1)
CR2W1_Filtered$Leads_Per_100_Impressions <- CR2W1_Filtered$Leads / CR2W1_Filtered$Impressions * 100
CR2W1_Filtered[CR2W1_Filtered$Creative == "Made Clear", "Emotional"] <- 0
CR2W1_Filtered[CR2W1_Filtered$Creative == "Are You In?", "Emotional"] <- 0
CR2W1_Filtered[CR2W1_Filtered$Creative == "Stop The Sale", "Emotional"] <- 0
CR2W1_Filtered[CR2W1_Filtered$Creative == "Data Footprint", "Emotional"] <- 0
preds <- CR2W1_Filtered %>% glm(Leads_Per_100_Impressions ~ Brand_Position + Audience + Emotional, family = "gaussian",.)
CR2W1_Filtered$preds <- predict(preds)
View(CR2W1_Filtered)
write.csv(CR2W1_Filtered, file = "CR2W1 Filtered.csv")     

CR2W1_Filtered %>% group_by(Creative) %>% summarise(avg_pred_ldper100 = mean(preds)) %>% arrange(desc(avg_pred_ldper100))
