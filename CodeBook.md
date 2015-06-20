# Code Book

This is the code book for the creation of a tidy data set, as described by the Coursera Getting and Cleaning Data Course project.
See README.MD for more info about the the project and the input data

## A) Transformation and Work performed in the run_analalys.R script

### 1. Merges the training and the test sets to create one data set

The analysis of the README and of the data files indicate that
    file X_test.txt gives the features measured/calculated,  
    file y_test.txt gives the activity that was practised,
    and file subject_test.txt gives the subject that did the practice
-> I read those files

The sequence within each file identifies one sliding window during which the measurements where made
 -> I combine these files on the basis of the sequence number to get one dataframe for the test data, using cbind()

Training data has same structure than test data
-> I do same and create one dataframe for the training data

The project asks for results taking into account all measurement :test and training data 
 -> I add all the rows into one bigger dataframe, using rbind()

### 2. Extracts only the measurements on the mean and standard deviation for each measurement

I will eliminate columns of my dataframe based on the names of the features
I need first to give all coiumns their right fetaure name

The analysis of the README and of the data files indicate that X_test.txt and x-train.txt give the measuremenst of 561 features, and features.txt gives the name (in sequence) of those features
-> I read file features.txt

later, I will use dplyr package
-> I install package and convert dataframe, using tbl_df()

Feature names contain brackets. I want to use them as colupmn names
-> I use make.names() to create R syntactically valid and unique names 
-> I use gsub to eliminate the ".." created by gsub in place of "()"
-> I apply feature names to variables of data frame

-> I also give correct name to the 2 last columns (activity and subject) that I added above using cbind()

-> I use column names to keep only columns that are real mean or standard deviation, using
select(..., subject, activity, contains("mean"), contains("std"))

According to feature-info, the features names that contain meanFreq or angle are not "mean" values
-> I remove the corresponding columns, using
select(..., -contains("meanFreq"), -contains("angle"))

### 3. Uses descriptive activity names to name the activities in the data set

The analysis of the README and of the data files indicate that activity_labels.txt gives the code and label for each activity
-> I read file activity_labels.txt, with option stringsAsFactors = FALSE, because I do not want factors

The variable activity contains the activity code. There are 6 different codes.
-> I loop over each row and change the activity code to activity label. 

### 4. Appropriately labels the data set with descriptive variable names
-> At this stage, I already changed labels to descriptive variable names

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-> I group by subject and activity, using group_by()
-> I calculate average of all the variables not being part of grouping (i.e. the mean and std features), using summarize_each() with function mean 


## B) Output Data 

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
There are 2 descriptive columns (subject and activity)
There are 6 activities and 30 subjects. 
Therefore the data contains 180 rows and 68 columns

This data set is tidy. There is one measurement per column and one observation per record (all measurements made during one single time windows)