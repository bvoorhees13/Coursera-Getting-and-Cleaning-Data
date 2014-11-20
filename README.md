====================================================================================================================================
#Title: Transformation of Human Activity Recognition Using Smartphones Dataset into Tidy Data

##Coursera: Getting and Cleaning Data, Course Project
##Student: William Voorhees
====================================================================================================================================

##Script
- The script 'run_analysis.R' was written for R, version 3.1.2.
- Before running the script, the zip folder from the original data needs to be unzipped in your working directory
- The script will merge the training and test data to create a tidy dataset, an R dataframe- 'tidy_data' 
- The first column of tidy_data is "subject" - this is the subject number for each record stored as a factor variable (levels: 1-30)
- The second column of tidy_data is "activity" - this is the descriptive activity name for each record (levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS
, SITTING,
 STANDING,
 LAYING)

- The remaining columns are the measures of the variables in the original dataset.  Only the measurements on the mean and standard deviation for each measurement are included.) 
- The script will create a second independent tidy data set (R dataframe tidy_data2) with the average of each variable for each activity and subject.  Again, the columns will be "subject" and "activity" followed by the mean and standard deviation for each measurement in the remaining 66 columns.  Each record (row) in the dataset will represent the data for a unique subject/activity pair.  With 30 subjects and 6 activities there are 180 such records (rows).
- The script outputs tidy_data2 to a text file 'tidy_data.txt' in the working directory.
- The output file can be read in with the following script:
view_tidy<- read.table("tidy_data.txt", header=TRUE) 
view(view_tidy)

##Notes
The data, variables, and specific transformations performed are described in more detail in CodeBook.MD.

##References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[2] R, version 3.1.2
