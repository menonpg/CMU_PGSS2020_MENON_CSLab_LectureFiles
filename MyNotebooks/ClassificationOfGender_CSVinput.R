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




## ROC analysis:  is 0.5 the optimal threshold?   
library(ROCR)
pred <- prediction(as.vector(prediction), relevel(as.factor(heightWeightSurveyData$Gender), ref = "F"))
roc.perf = performance(pred, measure = "tpr", x.measure = "fpr")
plot(roc.perf)
abline(a=0, b= 1)

opt.cut = function(perf, pred){
  cut.ind = mapply(FUN=function(x, y, p){
    d = (x - 0)^2 + (y-1)^2
    ind = which(d == min(d))
    c(sensitivity = y[[ind]], specificity = 1-x[[ind]], 
      cutoff = p[[ind]])
  }, perf@x.values, perf@y.values, pred@cutoffs)
}
print(opt.cut(roc.perf, pred))

print(1-opt.cut(roc.perf, pred)[3]) 



# Do we have a bi-modal probability output?
plot(density(prediction))


# Prediction accuracy table (Confusion matrix) using the optimal prediction probability cutoff
print(table(heightWeightSurveyData$Gender, ifelse(prediction > 1-opt.cut(roc.perf, pred)[3], "Male", "Female")))



