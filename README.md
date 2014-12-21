gettingcleaningdataproject
==========================

project work related to Coursera course "Getting and Cleaning data"


Description of Source Datasets:

A detailed explanation is available in  file "README.txt" of the dataset
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

An R script (at the same link as this file) called run_analysis.R is created to do the following tasks


1.    Merges the training and the test sets to create one data set.
2.    Extracts only the measurements on the mean and standard deviation for each measurement. 
3.    Uses descriptive activity names to name the activities in the data set
4.    Appropriately labels the data set with descriptive variable names. 
5.    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The outfile generated is called varAvgByIdAndActType.txt

The CodeBook.md explains the variables of the output file

Notes:

The run_analysis.R may not have executed the steps in the same order they are listed above
