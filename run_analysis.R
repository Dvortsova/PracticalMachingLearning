#know your derictory
getwd()
setwd("./data")
#download zip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="./f_project.zip")
#unzip
unzip("f_project.zip")

train_data<-read.table("./UCI HAR Dataset/train/X_train.txt")
train_label<-read.table("./UCI HAR Dataset/train/Y_train.txt")
test_data<-read.table("./UCI HAR Dataset/test/X_test.txt")
test_label<-read.table("./UCI HAR Dataset/test/Y_test.txt")
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
variables<-read.table("./UCI HAR Dataset/features.txt")
activities<-read.table("./UCI HAR Dataset/activity_labels.txt")

##merging data
full_data0<-rbind(train_data,test_data)
#giving real names to variables
names(full_data0)<-variables[ , 2]
full_label<-rbind(train_label, test_label)
names(full_label)<-"activity"
full_subject<-rbind(train_subject, test_subject)
names(full_subject)<-"subject"
full_data<-cbind(full_subject, full_label, full_data0)

#transforming to string data format
full_data$activity<-as.character(full_data$activity)
activities[,2]<-as.character(activities[,2])

##renaming activities codes with the names
for (j in 1:6) {
  for (i in 1:10299) {
    if(activities[j,1] == full_data[i,2]) {
      full_data[i,2] <-activities[j,2]
    }
  }
}


##using only mean and std variables. I used the corresponding colomn indices
small_data<-full_data[, c(1:8,43:48,83:88)]

##finding mean for subject and activity groups
tidy_data<-aggregate(small_data[, 3:20], list(small_data$subject , small_data$activity), mean)
library(dplyr)
tidy_data<-arrange(tidy_data, Group.1, Group.2)

# saving dataset
write.table(tidy_data, file= "tidy_data.txt", row.name=FALSE)