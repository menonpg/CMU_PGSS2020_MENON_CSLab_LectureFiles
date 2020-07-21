# install.packages("AlphaVantageClient")
rm(list=ls())
library(AlphaVantageClient)
library(TTR)

setAPIKey("YOUR_API_KEY")

# Lets download one symbol's time series data
sym = "MSFT"
myData <- fetchSeries(function_nm = "time_series_daily", 
                      symbol = sym, outputsize = "compact", datatype = "json")

myData_XTS <- myData$xts_object

plot(myData_XTS[,-c(5)])  # eliminate the volume column from the XTS plot



# Lets download a series of time series data for a list of stock tickers
syms = c("MSFT", "AMZN", "TSLA", "X")

finalDF <- c()

for (sym in syms) {
  myData <- fetchSeries(function_nm = "time_series_daily", 
                        symbol = sym, outputsize = "compact", datatype = "json")
  
  myData_XTS <- myData$xts_object
  
  plot(myData_XTS[,-c(5)], main=sym)
  
  
  colnames(myData_XTS) <- c("Open", "High", "Low", "Close", "Volume")
  
  finalDF <- rbind(finalDF, data.frame(TICKER=sym, DATE = rownames(as.data.frame(tail(myData_XTS,1))),
                                       as.data.frame(tail(myData_XTS,1))))
  
  # print(finalDF)

}

rownames(finalDF) <- seq(1, NROW(finalDF), 1)
print(finalDF)
