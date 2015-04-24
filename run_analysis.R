## read the data from file "X_test.txt" into X_test
## read the data from file "subject_test.txt" into subject_test
## read the data from file "y_test.txt" into y_test
## merge (column bind) the three datasets X_test, subject_test, y_test (in that order) into one dataset called merged_test
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
merged_test <- cbind(subject_test, y_test, X_test)

## read the data from file "X_train.txt" into X_train
## read the data from file "subject_train.txt" into subject_train
## read the data from file "y_test.txt" into y_test
## merge (column bind) the three datasets X_train, subject_train, y_train (in that order) into one dataset called merged_train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
merged_train <- cbind(subject_train, y_train, X_train)

## merge (row bind) the two data sets merged_test and merged_train into one data set called merged_data
merged_data <- rbind(merged_test, merged_train)

## assign variable labels (column names) to dataset merged_data 
## the first two columns will get the names "Subject" and "Activity"
## the columns 3 through 563 will get the respective names from the "features.txt" file, which is loaded into features
colnames(merged_data)[1] <- "Subject"
colnames(merged_data)[2] <- "Activity"
features <- read.table("./UCI HAR Dataset/features.txt") 
colnames(merged_data)[3:563] <- as.character(features[1:561,2])

## convert column/variable names to valid unique names to avoid the "duplicate names" problem
names(merged_data) <- make.names(names(merged_data), unique=TRUE)

## use the select function from the dplyr package to display columns that include "mean" or "std", and the first two columns 
library(dplyr)
filtered_data <- select(merged_data, Subject, Activity, contains("mean"), contains("std"))

## read the data from file "activity_labels.txt" into activities
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## replaces the numerica values in the "Activity" column based on their textual equivalent from the "activity_labels" file
filtered_data <- mutate(filtered_data, Activity = activity_labels[Activity,2])


## used melt and dcast functions from reshape2 package
## melt reshaped the dataset into a tall skinny dataset by defining "Subject" and "Activity" as id vars, and the rest as measure vars
## dcast summarizes the data by calculating the means of all observations for each Subject for each Activity 
library(reshape2)
melted_data <- melt(filtered_data, id=c("Subject", "Activity"), measure.vars=c(names(filtered_data[,3:length(filtered_data)])))
tidy_data <- dcast(melted_data, Subject ~ Activity, mean)

## gives the final table
tidy_data

##write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)
