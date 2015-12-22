##Practical maching learning assignment

#setting seed for reproucability
set.seed(4566)
#downloading data
getwd()
setwd("./data")
#download zip file
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",destfile="./train.csv")
train_data<-read.csv("./train.csv")
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",destfile="./test.csv")
validation_data<-read.csv("./test.csv")

# deleting empty and NA rows, since data has strange half empty variables
train_data[train_data == ""] <- NA                                                   
g=colnames(train_data)[colSums(is.na(train_data)) == 0]
reduced_train<-train_data[,g]
dim(reduced_train)


library(caret)


#building train and test sets
inTrain <- createDataPartition(y=reduced_train$classe,
                               p=0.75, list=FALSE)
training <- reduced_train[inTrain,7:60]
testing <- reduced_train[-inTrain,7:60]
dim(training)
dim(testing)


library(rpart)
library(rattle)
library(rpart.plot)
# fiting decision trees algorithm 
modelFit <- rpart(classe ~ ., data=training, method="class")

#visualisation of the model
fancyRpartPlot(modelFit)

#out-sample testing of the model
test_prediction <- predict(modelFit, testing, type = "class")
confusionMatrix(test_prediction, testing$classe)

# seperate data prediction
validation_pred <- predict(modelFit, validation_data, type = "class")
validation_pred
