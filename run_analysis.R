##manually unzip the contents of ZIP file to working directory

##Read files from ZIP:

subjecttest <- read.table("./test/subject_test.txt")
subjecttrain <- read.table("./train/subject_train.txt")
Xtest <- read.table("./test/X_test.txt")
Xtrain <- read.table("./train/X_train.txt")
ytest <- read.table("./test/y_test.txt")
ytrain <- read.table("./train/y_train.txt")
activitylabels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")  

##Merge the training and the test sets to create one data set.
dataset <- rbind(Xtrain,Xtest)

##Extracts only the measurements on the mean and standard deviation for each measurement.
#create vector with only mean and sd
vector <-grep("mean|std", features[, 2]) 
#subset
dataset <- dataset[,vector]

## Appropriately labels the data set with descriptive activity names.
#create vector of feature names without brackets
vector2 <- sapply(features[,2], function(x) {gsub("[()]","",x)})
names(dataset)<-vector2[vector]

#rbind subjecttrain with subjecttest, and ytrain with ytest
subject <- rbind(subjecttrain, subjecttest)
names(subject) <- "subject"
activity <- rbind(ytrain, ytest)
names(activity) <- "activity"

#cbind subject, activity, and dataset
dataset <- cbind(subject,activity, dataset)

## Uses descriptive activity names to name the activities in the data set
#take numbers and replace them with activity labels.
actnum <- factor(dataset$activity)
levels(actnum) <- activitylabels[,2]
dataset$activity <- actnum

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#install reshape2 if not installed and load lib
if (!"reshape2" %in% installed.packages()) {
    install.packages("reshape2")
}
library("reshape2")

basedata <- melt(dataset,(id.vars=c("subject","activity")))
secondds <- dcast(basedata, subject + activity ~ variable, mean)
names(secondds)[-c(1:2)] <- paste("[mean of]" , names(secondds)[-c(1:2)] )
write.table(secondds, "tidydata.txt", sep = ",")