# Coursera - Getting-and-Cleaning-Data - Course Project

This repository contains the course project of the "Getting and Cleaning Data" class in coursrea's Data Science Track by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD from John Hopkins Unversity.

The purpose of the project is to demonstrate the ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.

The data used for this project were collected from the accelerometer and gyroscope  from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script, �run_analysis.R� will complete the following five tasks:

 1. Merges the training and the test sets to create one data set. 
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set 
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Please follow this instruction to execute the �run_analysis.R� in RStudio in windows 8 64 bit:

* Download the getdata_projectfiles_UCI HAR Dataset.zip file. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Unzip the file into a folder FOLDER. 
* Download the run_analysis.R script into FOLDER. 
* In RStudio, change the work directory to FOLDER, and source(�run_analysis.R�) 
* The script will produce the �tidydata.txt� in FOLDER. It is a txt file that contains the tidy data set (180 * 68 dimensions) with the average of each variable for each activity and each subject. There are 6 activities and 30 subjects. Therefore the data contains 180 rows and 68 columns (2 descriptive column, subject and activity, and 66 columns for measures).
* Use data <- read.table("tidydata.txt") command in RStudio to read the file. 
* The CodeBook.md in this Repo describes all of the variables.