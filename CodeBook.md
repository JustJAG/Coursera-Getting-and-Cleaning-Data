Here is the list of all variables:

subjecttest : subject IDs for test
subjecttrain : subject IDs for train
Xtest : values of variables in test
Xtrain : values of variables in train
ytest : activity ID in test
ytrain : activity ID in train
activitylabels : Description of activity IDs in ytest and ytrain
features : description(label) of each variables in Xtest and Xtrain
dataset : rbind of Xtrain and Xtest

vector : a vector with only mean and std labels extracted from 2nd column of features
dataset : at this point, dataset will only contain mean and std variables

vector2 : a vector of feature names without brackets

subject : rbind of subjecttrain and subjecttest
activity : rbind of ytrain and ytest

actnum : factored activity column of dataset

basedata : melted tall and skinny dataset
secondds : casete basedata which has means of each variables