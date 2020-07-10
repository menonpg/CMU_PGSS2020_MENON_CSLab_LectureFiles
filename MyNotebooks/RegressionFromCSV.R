library(readr)
heightWeightSurveyData <- read_csv("heightWeightGenderSurveyData.csv")

heightWeightSurveyData <- na.omit(heightWeightSurveyData)
View(heightWeightSurveyData)


fit <- lm(Weight ~ . , data = heightWeightSurveyData)
summary(fit)

plot(heightWeightSurveyData$Height, heightWeightSurveyData$Weight, xlab="Height", ylab="Weight", main="Regression of Weight on Height")
abline(fit, col="red")

boxplot( Weight ~ Gender, main="Weight by Gender", data=heightWeightSurveyData)
boxplot( Height ~ Gender, main="Height by Gender", data=heightWeightSurveyData)


