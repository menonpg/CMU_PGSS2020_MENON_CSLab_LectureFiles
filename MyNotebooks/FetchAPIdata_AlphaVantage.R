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
finalDF1 <- c()

for (sym in syms) {
  myData <- fetchSeries(function_nm = "time_series_daily", 
                        symbol = sym, outputsize = "compact", datatype = "json")
  
  myData_XTS <- myData$xts_object
  
  plot(myData_XTS[,-c(5)], main=sym)
  
  
  colnames(myData_XTS) <- c("Open", "High", "Low", "Close", "Volume")
  
  finalDF <- data.frame(TICKER=sym, DATE = rownames(as.data.frame(tail(myData_XTS,1))),
                        as.data.frame(tail(myData_XTS,1)))
    
  # Bollinger Bands
  bbands <- BBands( myData_XTS[,c("High","Low","Close")] )
  finalDF <- cbind(finalDF, bbands = as.data.frame(tail(bbands, 1)))

  # Directional Movement Index
  adx <- ADX(myData_XTS[,c("High","Low","Close")])
  finalDF <- cbind(finalDF, adx = as.data.frame(tail(adx, 1)))
  
  # Moving Averages
  ema <- EMA(myData_XTS[,"Close"], n=50)
  finalDF <- cbind(finalDF, ema = as.data.frame(tail(ema, 1)))
  
  sma <- SMA(myData_XTS[,"Close"], n=20)
  finalDF <- cbind(finalDF, sma = as.data.frame(tail(sma, 1)))
  
  # MACD
  macd <- MACD( myData_XTS[,"Close"] )
  finalDF <- cbind(finalDF, macd = as.data.frame(tail(macd, 1)))
  
  # RSI
  rsi <- RSI(myData_XTS[,"Close"])
  finalDF <- cbind(finalDF, rsi = as.data.frame(tail(rsi, 1)))
  
  # Stochastics
  stochOsc <- stoch(myData_XTS[,c("High","Low","Close")])
  finalDF <- cbind(finalDF, stochOsc = as.data.frame(tail(stochOsc, 1)))
  
  
  finalDF1 <- rbind(finalDF1, finalDF) 
  
}

rownames(finalDF1) <- seq(1, NROW(finalDF1), 1)
print(finalDF1)


# Create a trading rule based on Bollinger bands
finalDF1$Buy <- finalDF1$Close < finalDF1$bbands.dn
finalDF1$Sell <- finalDF1$Close > finalDF1$bbands.up




## Lets try to repeat this exerise for the entire S&P500 stock list:

# Scraping all the indices / tickers that constitute the S&P500 list
## Web-scrape direct using the tags identified by Chrome's DataMiner Plugin
library("rvest")
url <-   "https://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
Sp500List <- url %>%
  read_html() %>%
  html_nodes(xpath='//table[1]') %>%
  html_table()
Sp500List <- Sp500List[[1]]
Sp500List <- Sp500List$Symbol

syms = Sp500List

finalDF1_allSp500 <- c()

for (sym in syms) {
  myData <- fetchSeries(function_nm = "time_series_daily", 
                        symbol = sym, outputsize = "compact", datatype = "json")
  
  myData_XTS <- myData$xts_object
  
  plot(myData_XTS[,-c(5)], main=sym)
  
  
  colnames(myData_XTS) <- c("Open", "High", "Low", "Close", "Volume")
  
  finalDF <- data.frame(TICKER=sym, DATE = rownames(as.data.frame(tail(myData_XTS,1))),
                        as.data.frame(tail(myData_XTS,1)))
  
  # Bollinger Bands
  bbands <- BBands( myData_XTS[,c("High","Low","Close")] )
  finalDF <- cbind(finalDF, bbands = as.data.frame(tail(bbands, 1)))
  
  # Directional Movement Index
  adx <- ADX(myData_XTS[,c("High","Low","Close")])
  finalDF <- cbind(finalDF, adx = as.data.frame(tail(adx, 1)))
  
  # Moving Averages
  ema <- EMA(myData_XTS[,"Close"], n=50)
  finalDF <- cbind(finalDF, ema = as.data.frame(tail(ema, 1)))
  
  sma <- SMA(myData_XTS[,"Close"], n=20)
  finalDF <- cbind(finalDF, sma = as.data.frame(tail(sma, 1)))
  
  # MACD
  macd <- MACD( myData_XTS[,"Close"] )
  finalDF <- cbind(finalDF, macd = as.data.frame(tail(macd, 1)))
  
  # RSI
  rsi <- RSI(myData_XTS[,"Close"])
  finalDF <- cbind(finalDF, rsi = as.data.frame(tail(rsi, 1)))
  
  # Stochastics
  stochOsc <- stoch(myData_XTS[,c("High","Low","Close")])
  finalDF <- cbind(finalDF, stochOsc = as.data.frame(tail(stochOsc, 1)))
  
  
  finalDF1_allSp500 <- rbind(finalDF1_allSp500, finalDF) 
  
}

rownames(finalDF1_allSp500) <- seq(1, NROW(finalDF1_allSp500), 1)
print(finalDF1_allSp500)


# Create a trading rule based on Bollinger bands
finalDF1_allSp500$Buy <- finalDF1_allSp500$Close < finalDF1_allSp500$bbands.dn
finalDF1_allSp500$Sell <- finalDF1_allSp500$Close > finalDF1_allSp500$bbands.up

