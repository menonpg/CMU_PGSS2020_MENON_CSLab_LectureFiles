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

# Perform a visual comparison of two categories of DriveTrain, in term sof MSRP, using a boxplot 
boxplot(DataFrameOfCarData_toProcessinR$MSRP[which(DataFrameOfCarData_toProcessinR$Drivetrain %in% "AWD")], 
        DataFrameOfCarData_toProcessinR$MSRP[which(DataFrameOfCarData_toProcessinR$Drivetrain %in% "FWD")],
        names = c("AWD", "RWD"))
plot(density(na.omit(DataFrameOfCarData_toProcessinR$MSRP[which(DataFrameOfCarData_toProcessinR$Drivetrain %in% "AWD")])))
lines(density(na.omit(DataFrameOfCarData_toProcessinR$MSRP[which(DataFrameOfCarData_toProcessinR$Drivetrain %in% "FWD")])), col= "red")


# Statistical testing of difference of means for two categories of DriveTrain, in term sof MSRP, using an unpaired two-samples t-test
t.test(x = na.omit(DataFrameOfCarData_toProcessinR$MSRP[which(DataFrameOfCarData_toProcessinR$Drivetrain %in% "AWD")]), y = na.omit(DataFrameOfCarData_toProcessinR$MSRP[which(DataFrameOfCarData_toProcessinR$Drivetrain %in% "FWD")]), paired = F, var.equal =  F)

