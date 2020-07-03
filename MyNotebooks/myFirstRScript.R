# Read Chicago COVID19 time series data into R as a data frame
myData <- read.csv("https://raw.githubusercontent.com/menonpg/covid19_Chicago/master/timeSeries_COVID19_Chicago.csv")

# Convert the date column appropriately so R recognizes it as a Date
myData$Date <- as.Date(myData$Date, format="%Y-%m-%d")

# Summarize the columns
print(summary(myData)) 

# Write the file out to the local file system:
write.csv(myData, "timeSeries_COVID19_Chicago.csv")
