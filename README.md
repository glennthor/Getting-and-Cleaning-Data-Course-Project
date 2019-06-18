# Getting-and-Cleaning-Data-Course-Project

This repo contains submissions files for Coursea "Getting and Cleaning Data" Week 4 Assignment.

## Original Data Files
getdata_projectfiles_UCI HAR Dataset.zip is downloaded, and unzip into folder "**UCI HAR Dataset**".

## Code
`CodeBook.md` describes the variables, data and transformations / work that has been performed to clean up the data.

`run_analysis.R` contains R script to do the following tasks:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`tiny_data_set.txt` contains the tiny data set output from run_analysis.R, as a text file.

