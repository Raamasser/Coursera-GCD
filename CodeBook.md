CODE BOOK

A) INPUT DATA 
(This is the content of Feature_info.txt, attached to the input data)


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'







B) Transformation and Work performed in the R script

1. Merges the training and the test sets to create one data set

The analysis of the README and of the data files indicate that
    file X_test.txt gives the features measured/calculated,  
    file y_test.txt gives the activity that was practised,
    and file subject_test.txt gives the subject that did the practice
-> I read those files

The sequence within each file identifies one sliding window during which the measurements where made
 -> I combine these files on the basis of the sequence number, to get one dataframe for the test data, using cbind()

Training data has same structure than test data
-> I do same and create one dataframe for the training data

Both data frames identify one fixed-width sliding window during which the measurements where made. The exercise is about all measurements : test and training data
 -> I add all the rows into one bigger dataframe, using rbind()

2. Extracts only the measurements on the mean and standard deviation for each measurement

The analysis of the README and of the data files indicate that X_test.txt and x-train.txt give the measuremenst of 561 features, and features.txt gives the name (in sequence) of those features
-> I read file features.txt

later, I will use dplyr package
-> I install package and convert dataframe, using tbl_df()

Feature names contain brackets. I want to use  them as variable names
-> I use make.names() to create R syntactically valid and unique names 
-> I use gsub to eliminate the ".." created by gsub in place of "()"
-> I apply feature names to variables of data frame

-> I also give correct name to 2 last variable (activity and subject) that I added above using cbind()

-> I use column names to keep only columns that are real mean or standard deviation, using
select(..., subject, activity, contains("mean"), contains("std"))

According to feature-info, the features names that contain meanFreq or angle are not "mean" values
-> I remove the corresponding columns, using
select(..., -contains("meanFreq"), -contains("angle"))

3. Uses descriptive activity names to name the activities in the data set

The analysis of the README and of the data files indicate that activity_labels.txt gives the code and label for each activity
-> I read file activity_labels.txt, with option stringsAsFactors = FALSE, because I do not want factors

The variable activity contains the activity code. There are 6 different codes.
-> I loop on each row and change the activity code to activity label. 

4. Appropriately labels the data set with descriptive variable names
-> At this stage, I already changed labels to descriptive variable names


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

-> I group by subject and activity, using group_by
-> I calculate average of all the variables not being part of grouping (i.e. the mean and std features), 
using summarize_each with function mean 









C) OUTPUT DATA 

The script will produce the “tidydata.txt”. It is a txt file that contains the tidy data set (180 * 68 dimensions) with, for each activity and each subject, the average of mean and standard deviation of :
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

the 8 "...XYZ" variables are actually 3 variables
So there is a total of 8x3+9=33 variables
As we want the average of mean and standrda deviation of these 33 variables, we will have 2x 33 =66 columns
There are 2 descriptive columns (subject and activity
There are 6 activities and 30 subjects. 
Therefore the data contains 180 rows and 68 columns