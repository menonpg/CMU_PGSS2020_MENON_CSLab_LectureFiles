library(readr)
AccidentalOD_Allegheny_County<- read_csv("1c59b26a-1684-4bfb-92f7-205b947530cf.csv")
View(AccidentalOD_Allegheny_County)


# Delete constant columns or NA columsn:
AccidentalOD_Allegheny_County <- AccidentalOD_Allegheny_County[, -c(6,18)]

library(dplyr)
AccidentalOD_Allegheny_County <- AccidentalOD_Allegheny_County %>% mutate_if(is.character, as.factor)
sapply(AccidentalOD_Allegheny_County,  class)

AccidentalOD_Allegheny_County$case_year <- as.factor(AccidentalOD_Allegheny_County$case_year)  
AccidentalOD_Allegheny_County <- AccidentalOD_Allegheny_County %>% as.data.frame()
AccidentalOD_Allegheny_County <- AccidentalOD_Allegheny_County[, -c(2)]

#  Convert Age into "AGE GROUP BuCKETS"  
AccidentalOD_Allegheny_County <- AccidentalOD_Allegheny_County %>% mutate(AgeGrp = cut(age, breaks = c(0, 18, 21, 30, 40, 50, 60, 100)))
AgeFreqTable <- as.data.frame(table(AccidentalOD_Allegheny_County$AgeGrp))
barplot(AgeFreqTable$Freq, names.arg = AgeFreqTable$Var1, main="Age-Grouping of Accidental ODs", horiz = T, las=2)
barplot(AgeFreqTable$Freq[order(AgeFreqTable$Freq)], names.arg = AgeFreqTable$Var1[order(AgeFreqTable$Freq)], main="Age-Grouping of Accidental ODs", horiz = T, las=2)


#GOALS:
#Gender specificity of accidental ODs
GenderFreqTable <- as.data.frame(table(AccidentalOD_Allegheny_County$sex))
barplot(GenderFreqTable$Freq[order(GenderFreqTable$Freq)], names.arg = GenderFreqTable$Var1[order(GenderFreqTable$Freq)], main="Age-Grouping of Accidental ODs", horiz = T, las=2)


#Race specificity of accidental ODs
RaceFreqTable <- as.data.frame(table(AccidentalOD_Allegheny_County$race))
barplot(RaceFreqTable$Freq[order(RaceFreqTable$Freq)], names.arg = RaceFreqTable$Var1[order(RaceFreqTable$Freq)], main="Race-Grouping of Accidental ODs", horiz = T, las=2)


#Most common primary drug involved with OD's  
DrugFreqTable <- as.data.frame(table(AccidentalOD_Allegheny_County$combined_od1)) ##print table and order by freq
par(mar=c(0,5,5,1))
barplot(tail(DrugFreqTable$Freq[order(DrugFreqTable$Freq)]), names.arg = tail(DrugFreqTable$Var1[order(DrugFreqTable$Freq)]), main="Drug-Grouping of Accidental ODs", horiz = T, las=2)


#Is the accidental OD rate improving Year on Year       
Acc_OD_countsByYear <- AccidentalOD_Allegheny_County %>% group_by(case_year) %>% summarize(count=n())
barplot(Acc_OD_countsByYear$count[order(Acc_OD_countsByYear$count)], 
        names.arg = Acc_OD_countsByYear$case_year[order(Acc_OD_countsByYear$case_year)], 
        main="Case-Year-Grouping of Accidental ODs", horiz = T, las=2)

plot(as.numeric(as.character(unlist(Acc_OD_countsByYear$case_year))), Acc_OD_countsByYear$count, xlab = "Year", ylab="Case Counts")
abline(lm ( Acc_OD_countsByYear$count ~ as.numeric(as.character(unlist(Acc_OD_countsByYear$case_year)))), col="red")
