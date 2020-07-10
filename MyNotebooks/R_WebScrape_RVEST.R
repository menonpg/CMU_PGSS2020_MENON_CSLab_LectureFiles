## Web-scrape direct using the tags identified by Chrome's DataMiner Plugin
library("rvest")
url <-   "https://www.chicago.gov/city/en/sites/covid-19/home/latest-data.html"
population <- url %>%
  read_html() %>%
  html_nodes(xpath='//div[2]/div/div/div[1]/div[1]/div/div/div/table') %>%
html_table()
population <- population[[1]]

population <- population[-NROW(population), ]


library(stringr)
# Cast the data types of the columns to numeric by removing special characters that may have been scraped in 
population$CASES1 <- as.numeric(str_replace_all(population$CASES1,",", ""))
population$DEATHS <- as.numeric(str_replace_all(population$DEATHS,",", ""))
population$CASES1  <- as.numeric(population$CASES1 )
population$DEATHS  <- as.numeric(population$DEATHS )


# Visualize
par(mfrow=c(1,2))
par(mar=c(5,15,4,4))
barplot(height = population$CASES1, names.arg = population$GEOGRAPHY, horiz = T, las=2, main="Cases")
barplot(height = population$DEATHS, names.arg = population$GEOGRAPHY, horiz = T, las=2, main="Deaths")
