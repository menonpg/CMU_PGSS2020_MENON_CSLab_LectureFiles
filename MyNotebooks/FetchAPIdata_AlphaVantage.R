# install.packages("AlphaVantageClient")
rm(list=ls())
library(AlphaVantageClient)
library(TTR)

setAPIKey("YOUR_API_KEY")

sym = "MSFT"
myData <- fetchSeries(function_nm = "time_series_daily", 
                      symbol = sym, outputsize = "compact", datatype = "json")

myData_XTS <- myData$xts_object

plot(myData_XTS[,-c(5)])  # eliminate the volume column from the XTS plot
