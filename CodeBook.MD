====================================================================================================================================
#Title: Transformation of Human Activity Recognition Using Smartphones Dataset into Tidy Data

##Cousera: Getting and Cleaning Data, Course Project
##Student: William Voorhees
====================================================================================================================================

##Data

A full description of the raw data including background information is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The zip folder that contains the data and the README file for the original dataset are located in the following zip folder[1]:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Please read the README file for the original dataset before proceeding.  It contains critical information on the background of the data and how the data was collected.

The following files from the zip folder were directly used to create the tidy dataset:
======================================================================================
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject in the training group who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/subject_test.txt': Each row identifies the subject in the test group who performed the activity for each window sample. Its range is from 1 to 30. 

For each record the following data is provided:
===============================================
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Notes: 
======
- Features are normalized and bounded within [-1,1]. In other words, the data is unitless.
- Each feature vector is a row on the text file.

##Variables

An overview of the feature selection process for the **original** data set is included in 'features_info.txt' located in the original zip folder.  It is important to review that file before proceeding.  The complete list of variables of each feature vector of the **original** data set is available in 'features.txt' located in the original zip folder.  These will not be reproduced here.

The following adjustments were made to the original variable list:
- Only measurements on the mean and standard deviation for each measurement are included.  All other data including meanfreq data were ommitted.
- Parentheses "()" were ommitted from variable names as they do not add anything to the readability of the data
- Where the original data set erroneously duplicated the term "body" within the variable name, that was corrected


##Transformations

- All data manipuation was conducted using R version 3.1.2.  
- The training data and test data were combined in the following manner:
	1. The numerical activity identifiers in 'Y_train.txt' and 'Y_test.txt' were transformed into a factor, Activity (levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS
, SITTING,
 STANDING,
 LAYING)

	2. The subject identifiers for the training ('subject_train.txt') and test data ('subject_test.txt') sets were combined using rbind
	3. The Activity labels (from step 1) for the training ('Y_train.txt') and test data ('Y_test.txt') sets were combined using rbind
	4. The training data ('X_train.txt') and test data ('X_test.txt') were combined using rbind
	5. The dataframes from steps 2,3, and 4 were combined in that order using cbind
	6. Variables (columns) that were not mean or standard deviation measurements were dropped.   
	7. Whenever the character string "()" appeared within a variable name, that string was dropped (e.g. mean()-X was changed to mean-X)
	8. All alpha characters were made lowercase
	9. Whenever the character string "body" is duplicated within a variable name, the duplication is dropped (e.g. fbodybody was changed to fbody)
	10. All dashes ("-" strings) were removed
- An independent tidy data set was created with the average of each variable for each activity and each subject (a dataframe with dimensions 180x68). Each record (row) in the dataset includes the averages of each of the 66 variables for a unique subject/activity pair.  With 30 subjects and 6 activities there are 180 such records (rows). This data set was output to a text file 'tidy_data.txt'.

##References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
