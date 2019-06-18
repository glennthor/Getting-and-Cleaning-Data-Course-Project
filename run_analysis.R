#------------------------------------------------------------------------------------
# Pre - Requisites Setup Info:
#
# R Version : R version 3.6.0 (2019-04-26)
#
# Data for the project has been downloaded from:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# Data unzip to "UCI HAR Dataset" folder.
#
# Package "dplyr" version: 0.8.1
#------------------------------------------------------------------------------------
library(dplyr)

#------------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
# 
# Pre-Checks: 
# Before we read the sets, we check that the files does not contain headers.
# Test  files (subject, x, y) have 2947 rows 1 col, except X (561 col).
# Train files (subject, x, y) have 7352 rows 1 col, except X (561 col).
# X_train/test.txt would have 561 columns (same as features), thus each feature = 1 column.
#------------------------------------------------------------------------------------

# Read test sets
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read training sets
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Read Features names (561 rows, 2 columns)
features <- read.table("./UCI HAR Dataset/features.txt")

# Read activity labels (6 rows, 2 columns)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Set column names for Test and Training Tables
colnames(test_x) <- features[,2]
colnames(test_y) <- "activity_id"
colnames(test_subject) <- "subject_id"

colnames(train_x) <- features[,2]
colnames(train_y) <- "activity_id"
colnames(train_subject) <- "subject_id"

# Set column names for feature and Activity tables
colnames(features) <- c("feature_id", "feature")
colnames(activity_labels) <- c("activity_id", "activity")


# After reading the relevant files for each set.. 
# For Test Set - we shall merge them all into 1 file as they have same number of rows
# For Train Set- we shall merge them all into 1 file as they have same number of rows
# Then merge both sets into 1 
# we shall merge in the sequence:  Subject , Activity (y) and Readings (x)

merge_test  <- cbind(test_subject,  test_y,  test_x)
merge_train <- cbind(train_subject, train_y, train_x)
full_data   <- rbind(merge_test, merge_train)

#------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 
# We shall subset subject, activity and any other column-names with mean() or std()
#------------------------------------------------------------------------------------

# read column names..
col_names <- colnames(full_data)

# get a logical vector of column names that matches regular expression.
col_mean_std <- (grepl("^subject_id|^activity_id|[mM]ean|[sT]td", col_names));

# subset measurements ("full_data") based on the column names that we want (mean, std)
ds <- full_data[, col_mean_std == TRUE]


#------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------------------------------

# ds contains only activity_id.. 
# so we shall get the activity labels (created earlier in Section 1) into this data set
dsActivity <- merge(ds, activity_labels, by= 'activity_id')


#------------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names.
#------------------------------------------------------------------------------------

# this refers to the "feature" labels.. which has been done earlier in Section 1 where 
# we set the colnames for test_x and train_x.


#------------------------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#
# Submission Requirements:
# Tiny data set txt file  would be created with write.table() using row.name=FALSE 
#------------------------------------------------------------------------------------

# the objective would be to group by Subject, Activity, then show average of each feature columns
dsTiny <- dsActivity %>% 
          group_by(subject_id, activity_id, activity) %>%
          summarise_if(is.numeric, mean, na.rm = TRUE)

# Write to txt file
write.table(dsTiny, "tiny_data_set.txt", row.names = FALSE)


