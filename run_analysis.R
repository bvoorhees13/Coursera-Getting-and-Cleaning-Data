
#Read in Data
#Files should be unzipped in your working directory
activity_labels<- read.table("UCI HAR Dataset/activity_labels.txt")
features<- read.table("UCI HAR Dataset/features.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<- read.table("UCI HAR Dataset/train/X_train.txt")  
Y_train<- read.table("UCI HAR Dataset/train/Y_train.txt")       
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<- read.table("UCI HAR Dataset/test/X_test.txt")  
Y_test<- read.table("UCI HAR Dataset/test/Y_test.txt")         

#Code the activity labels
Y_train[,1]<-replace(Y_train[,1], Y_train[,1]==1, "WALKING")
Y_train[,1]<-replace(Y_train[,1], Y_train[,1]==2, "WALKING_UPSTAIRS")
Y_train[,1]<-replace(Y_train[,1], Y_train[,1]==3, "WALKING_DOWNSTAIRS")
Y_train[,1]<-replace(Y_train[,1], Y_train[,1]==4, "SITTING")
Y_train[,1]<-replace(Y_train[,1], Y_train[,1]==5, "STANDING")
Y_train[,1]<-replace(Y_train[,1], Y_train[,1]==6, "LAYING")
Y_test[,1]<-replace(Y_test[,1], Y_test[,1]==1, "WALKING")
Y_test[,1]<-replace(Y_test[,1], Y_test[,1]==2, "WALKING_UPSTAIRS")
Y_test[,1]<-replace(Y_test[,1], Y_test[,1]==3, "WALKING_DOWNSTAIRS")
Y_test[,1]<-replace(Y_test[,1], Y_test[,1]==4, "SITTING")
Y_test[,1]<-replace(Y_test[,1], Y_test[,1]==5, "STANDING")
Y_test[,1]<-replace(Y_test[,1], Y_test[,1]==6, "LAYING")

#Merge the training and the test sets to create one data set.
features1<-t(features[,2])
d1<-rbind(subject_train, subject_test)
d2<-rbind(Y_train, Y_test)
d3<-rbind(X_train, X_test)
colnames(d3)<-features1
colnames(d1)<-("subject")
colnames(d2)<-("activity")
d4<-cbind(d1, d2, d3)

#Create indexes to include only columns for mean and standard deviation
keep.index.mean<- grep("mean()", colnames(d4), value=FALSE) 
keep.index.std<- grep("std()", colnames(d4), value=FALSE)
drop.index<-grep("meanFreq", colnames(d4), value=FALSE)
keep.index<- sort(setdiff(union(keep.index.mean, keep.index.std),drop.index))        
tidy_data<-d4[,c(1,2,keep.index)]
attach(tidy_data)

#Fix variable names by removing "()", making all names lowercase, removing duplicated string "body"
#and removing "-" string
subject<-as.factor(subject)
activity<-as.factor(activity)
colnames(tidy_data) <- gsub("mean..", "mean", colnames(tidy_data))
colnames(tidy_data) <- gsub("std..", "std", colnames(tidy_data))
colnames(tidy_data) <- tolower(colnames(tidy_data))
colnames(tidy_data) <- gsub("bodybody", "body", colnames(tidy_data))
colnames(tidy_data) <- gsub("-", "", colnames(tidy_data))

#Create an independent tidy data set with the average of each variable for each activity and subject.
tidy_data2<-aggregate(tidy_data[,-(1:2)], list(subject=subject, activity=activity), mean)

#output tidy_data to a text file
write.table(tidy_data2, "tidy_data.txt", append=FALSE, row.name=FALSE)

#Please use this script for viewing the outputted file 
#view_tidy<- read.table("tidy_data.txt", header=TRUE) 
#view(view_tidy)
