###########################
##
## run_analysis.R - Peer Assessments/ Getting and Cleaning Data Course Project
##
#########################

#
# 1. Merges the training and the test sets to create one data set
###############################################################

# The analysis of the README and of the data files indicate that
#    file X_test.txt gives the features measured/calculated,  
#    file y_test.txt gives the activity that was practised,
#    and file subject_test.txt gives the subject that did the practice

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
dim(subject_test); head(subject_test)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
dim(X_test); head(X_test)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
dim(y_test); head(y_test)

# The sequence within each file identifies the fixed-width sliding windows 
#        during which the measurement where made
# Therefore I will combine these files on the basis of the sequence number, 
#    to get one dataframe for the test data

testdf<-cbind(X_test,y_test,subject_test)
dim(testdf)
head(testdf)

# Training data has same structure than test data,
# therefore I will do same and create one dataframe for the training data

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
dim(subject_train); head(subject_train)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
dim(X_train); head(X_train)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
dim(y_train); head(y_train)
traindf<-cbind(X_train,y_train,subject_train)
dim(traindf)
head(traindf)

# Each row of testdf and traindf identifies one fixed-width sliding window
#        during which the measurements where made 
# The exercise is about all measurements whether test or training data,
# therefore I will add all the rows into one bigger dataframe
df<-rbind(testdf,traindf)
dim(df)
head(df)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
###############################################

# The analysis of the README and of the data files indicate that X_test.txt and x-train.txt gave 
# the measuremenst of 561 features, and features.txt vives the name (in sequence) of those features

# Get feature names
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)

# I will use dplyr package
library(dplyr)
packageVersion("dplyr")

data1 <- tbl_df(df)
rm("df")
data1

# feature names contain brackets
# I use make.names() to create R syntactically Valid Names
# as I will use the faeture namles as variable names, I ask for unicity
feature_names<-make.names(features$V2, unique=TRUE)
# make.names replaces "()" bu "..", as this is not very nice I remobe ".." using gsub
description <- gsub("\\.\\.", "", feature_names)
# finalmy I apply feature names to variables of data frame
names(data1)<-description
# I also give correct name to 2 last columns for activity and subject, 
# that I added above using cbind()
names(data1)[562]<-"activity"
names(data1)[563]<-"subject"
data1

# I will now use column names to keep only columns that are real mean or standrad deviation
d1<-select(data1, subject, activity, contains("mean"), contains("std"))
# according to feature-info, features names containing meanFreq or angle is not a "mean value"
# therefore I remove the corresponding columns
data2<-select(d1, -contains("meanFreq"), -contains("angle"))
data2

# 3. Uses descriptive activity names to name the activities in the data set
####################################################

# The analysis of the README and of the data files indicate that activity_labels.txt gives 
# the code and label for each activity
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
# variable activity contains the activity code
# I will loop on each row and change the activity code to activity label
# There are 6 different labels
for (i in 1:6) {data2[data2$activity == i, 2] <- activity_labels$V2[[i]] }
data2
tail(data2)

# 4. Appropriately labels the data set with descriptive variable names
#############################################

# At this stage, I already changed labels to descriptive variable names


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
#####################################################

# I first group by subject and activity, 
# and then I apply the function mean to all the variables not beeing part of grouping 
# (i.e. the mean and std features) 
tidydf<-group_by(data2, subject, activity) %>% summarise_each(funs(mean))
tidydf

# and finaly I save the data
write.table(tidydf, "tidydata.txt", row.name=FALSE)

print(tidydf)
