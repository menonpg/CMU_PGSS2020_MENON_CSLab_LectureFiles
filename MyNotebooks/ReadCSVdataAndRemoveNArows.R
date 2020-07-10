library(readr)
heightWeightSurveyData <- read_csv("heightWeightSurveyData.csv")

heightWeightSurveyData <- na.omit(heightWeightSurveyData)
View(heightWeightSurveyData)
