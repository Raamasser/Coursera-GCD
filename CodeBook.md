# Code Book

This is the code book for the creation of a tidy data set, as described by the Coursera Getting and Cleaning Data Course project.

## A) Input Data
See README.MD for more info about the the project and the input data

## B) Transformation and Work performed in the run_analalys.R script
See comments in the run_analysis.R script

## C) Output Data 

The script will produce a file named "“tidydata.txt"
It contains the tidy data set (180 * 68 dimensions) with, for each activity and each subject, the average of mean and standard deviation of :
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The 8 "...XYZ" variables are actually each 3 variables, one for X, Y and Z.
So there is a total of 8x3+9=33 variables
As I want the average of mean and standard deviation of these 33 variables, I will have 2x 33 =66 columns
In the data set the name of each feature is the above name combined to either mean or std, depending upon whether it will give the average value of the mean or of the standard deviation 
There are 2 descriptive columns (subject and activity),
There are 6 activities and 30 subjects. 
Therefore the tidy data set contains 180 rows and 68 columns

This data set is tidy. There is one measurement per column and one observation per record (all measurements made during one single time windows)