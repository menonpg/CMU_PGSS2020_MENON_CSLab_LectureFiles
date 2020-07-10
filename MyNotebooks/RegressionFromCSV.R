library(readr)
heightWeightSurveyData <- read_csv("heightWeightSurveyData.csv")

heightWeightSurveyData <- na.omit(heightWeightSurveyData)
View(heightWeightSurveyData)


fit <- lm(Weight ~ . , data = heightWeightSurveyData)
summary(fit)

plot(heightWeightSurveyData$Height, heightWeightSurveyData$Weight, xlab="Height", ylab="Weight", main="Regression of Weight on Height")
abline(fit, col="red")


