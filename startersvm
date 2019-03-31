# Data
library(dplyr)
library(caret)
library(e1071)
library(pROC)
library(mlbench)
library(class)
library(ROSE) 
library(randomForest)
data <- read.csv("LabelData.csv", header = TRUE)
data = data %>% select(-user_id)
str(data)
data$adopter <- as.factor(data$adopter)

# Data Partition
set.seed(123)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.7, 0.3))
train <- data[ind==1,]
test <- data[ind==2,]

# Data for Developing Predictive Model
table(train$adopter)
prop.table(table(train$adopter))
summary(train)

over <- ovun.sample(adopter~., data = train, method = "over", N = 118000)$data
table(over$adopter)


under <- ovun.sample(adopter~., data=train, method = "under", N = 2200)$data
table(under$adopter)

both <- ovun.sample(adopter~., data=train, method = "both",
                    p = 0.5,
                    seed = 222,
                    N = 50000)$data
table(both$adopter)

rose <- ROSE(adopter~., data = train, N = 500, seed=111)$data
table(rose$adopter)

svboth = svm(adopter ~ ., data = both,
              kernel = "linear")
confusionMatrix(predict(svboth, test), test$adopter, mode = "prec_recall", positive = '1')
