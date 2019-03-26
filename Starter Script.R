# This is a starter script for the group project

# import necessary packages
library(dplyr)
library(caret)
library(e1071)

# import labeled data
data_label = read.csv("LabelData.csv")
# convert outcome "adopter" to be a factor for classification
data_label$adopter = factor(data_label$adopter)
# user_id not useful as a feature
data_label = data_label %>% select(-user_id)

# Training-Validation split or Cross-Validation is skipped here

# Build a naive bayes model
model = naiveBayes(adopter ~ ., data = data_label)

# import unlabeled data and make predictions
data_unlabel = read.csv("UnlabelData.csv")
pred = predict(model, data_unlabel)

# prepare submission
submission = data.frame(user_id = data_unlabel$user_id,
                        prediction = pred)
write.csv(submission, "Group-X-Submission.csv", row.names = FALSE)