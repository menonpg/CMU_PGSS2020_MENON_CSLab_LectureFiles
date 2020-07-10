# Read in the crowdsourced data:
library(readr)
heightWeightSurveyData <- read_csv("heightWeightGenderSurveyData.csv")

heightWeightSurveyData <- na.omit(heightWeightSurveyData)
View(heightWeightSurveyData)

# Convert the datatype of Gender to a factor (rather than a string variable)
heightWeightSurveyData$Gender <- as.factor(heightWeightSurveyData$Gender)

## Generate a fit using logistic regression
fit <- glm(Gender ~ . , data = heightWeightSurveyData, family="binomial")
summary(fit)

# Make a prediction from the fit model
prediction <- predict(object = fit, newdata = heightWeightSurveyData, type="response")
predictionClass <- ifelse(prediction>0.5, "Male", "Female")


# Prediction accuracy table (Confusion matrix)
print(table(heightWeightSurveyData$Gender, predictionClass))
