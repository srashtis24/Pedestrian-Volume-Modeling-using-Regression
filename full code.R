###QUESTION 1####

setwd("C:/Users/Hp/Downloads/CE687_Assignment_1_ped_data_variables_code_c8ceed0a-9566-4969-b8cc-50a05fcfa32c/Assignment_1_ped_data_variables_code")#(i) Model Selection & Justification
getwd()
library(tidyverse)
install.packages("corrplot")
library(corrplot)

#Import data
pedvars <- read.csv("ped_exposure_data_sample.csv")
colnames(pedvars)

# split data into training and test data (80-20 split)
n<-nrow(pedvars)
set.seed(12345) ##changing the seed will change the training/test data sets
index <- sample(n, round(n*0.8))
train <- pedvars[index,] #80% of data
test <- pedvars[-index,] #20% of data

##Comparing Model 1 (Linear) and Model 2 (Log-Linear).
#Model 1: Linear Regression (AnnualEst ~ PopT)
model_1 <- lm(AnnualEst~PopT,data=train)
summary(model_1)

###Model 2: Log-Linear Regression (logAnnualEst ~ PopT)
model_2 <- lm(logAnnualEst~PopT,data=train)
summary(model_2)

##To compare the models, we check:
####model 1 goodness-of-Fit
logLik(model_1)
AIC(model_1)
BIC(model_1)

#model 1: Prediction on test data
AnnualEst_pred_model_1<-predict(model_1,test)

#model 1: training RMSE calculation
model_1_rmse_train<-(sum(model_1$residuals^2)/nrow(train))^0.5

#model 1: test RMSE calculation
model_1_rmse_test<-(sum((test$AnnualEst-AnnualEst_pred_model_1)^2)/nrow(test))^0.5


####model 2 Goodness-of-Fit
logLik(model_2)
AIC(model_2)
BIC(model_2)

#model 2: Prediction on train and test data and converting back from log
AnnualEst_pred_model_2_train<-exp(predict(model_2,train))
AnnualEst_pred_model_2_test<-exp(predict(model_2,test))

#model 2: training RMSE of not log, but back-transformed estimates
model_2_rmse_train<-(sum((train$AnnualEst-AnnualEst_pred_model_2_train)^2)/nrow(train))^0.5

#model 2: test RMSE
model_2_rmse_test<-(sum((test$AnnualEst-AnnualEst_pred_model_2_test)^2)/nrow(test))^0.5

## Display results
result<-data.frame(Metric = c("R²", "Adjusted R²", "AIC", "BIC", "RMSE (Train)", "RMSE (Test)"),
           Model_1 = c(summary(model_1)$r.squared, summary(model_1)$adj.r.squared, 
                       AIC(model_1), BIC(model_1), model_1_rmse_train, model_1_rmse_test),
           Model_2 = c(summary(model_2)$r.squared, summary(model_2)$adj.r.squared, 
                       AIC(model_2), BIC(model_2), model_2_rmse_train, model_2_rmse_test))
result

###QUESTION 2 & 3####
district_summary <- train %>%
  group_by(District) %>%
  summarize(
    Mean = mean(AnnualEst, na.rm = TRUE),
    SD = sd(AnnualEst, na.rm = TRUE),
    Lower_CI = Mean - 1.96 * (SD / sqrt(n())),
    Upper_CI = Mean + 1.96 * (SD / sqrt(n()))
  )

print(district_summary)

###QUESTION 4#####
d4 <- train %>% filter(District == 4) %>% pull(AnnualEst)
d7 <- train %>% filter(District == 7) %>% pull(AnnualEst)

t_test_result <- t.test(d4, d7, var.equal = TRUE)
print(t_test_result)


###QUESTION 5####
colnames(train)
vars<-train[,6:21]
corrmat<-cor(vars)
corrplot(corrmat) # default is circle

###QUESTION 6###
# Revised Model 1 (Linear)
revised_model1 <- lm(AnnualEst ~ PopT + HseHldT + EmpT + StSegT, data = train)
summary(revised_model1)

# Revised Model 2 (Log-Linear)
revised_model2 <- lm(logAnnualEst ~ PopT + HseHldT + EmpT + StSegT, data = train)
summary(revised_model2)
