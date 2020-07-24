library(readr)
DataFrameOfCarData_toProcessinR <- as.data.frame(read_csv("DataFrameOfCarData_toProcessinR.csv")[,-c(1)])
sapply(DataFrameOfCarData_toProcessinR, class)

numericCols <- c(3:12,14:15)
for (i in numericCols) {
  DataFrameOfCarData_toProcessinR[,i] <- as.numeric(DataFrameOfCarData_toProcessinR[,i])
}

library(dplyr)
DataFrameOfCarData_toProcessinR <- DataFrameOfCarData_toProcessinR %>% mutate_if(is.character, as.factor)

write.csv(DataFrameOfCarData_toProcessinR, file="DataFrameOfCarData_toProcessedinR.csv")
