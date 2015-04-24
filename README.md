# GettingandCleaningData
# Coursera Getting and Cleaning Data course

## First, the script reads the separate test files and loads them into memory:
## 1. read the data from file "X_test.txt" into X_test
## 2. read the data from file "subject_test.txt" into subject_test
## 3. read the data from file "y_test.txt" into y_test

## Second, # the script merges (column bind) the three datasets X_test, subject_test, y_test (in that order) into one dataset called merged_test

## Third, the script reads the separate train files and loads them into memory:
## 1. read the data from file "X_train.txt" into X_train
## 2. read the data from file "subject_train.txt" into subject_train
## 3. read the data from file "y_test.txt" into y_test
## merge (column bind) the three datasets X_train, subject_train, y_train (in that order) into one dataset called merged_train


## Fourth, the script merges (row bind) the two data sets merged_test and merged_train into one data set called merged_data
merged_data <- rbind(merged_test, merged_train)

## Then, it assigns variable labels (column names) to dataset merged_data 
## the first two columns get the names "Subject" and "Activity"
## the columns 3 through 563 will get the respective names from the "features.txt" file, which is loaded into features

## Then, the script converts column/variable names to valid unique names to avoid the "duplicate names" problem
## and uses the select function from the dplyr package to display columns that include "mean" or "std", and the first two columns 

## After that, it reads the data from file "activity_labels.txt" into activities
## and replaces the numerical values in the "Activity" column based on their textual equivalent from the "activity_labels" file

## Next, it uses melt and dcast functions from reshape2 package
## the melt function reshapes the dataset into a tall skinny dataset by defining "Subject" and "Activity" as id vars, and the rest as measure vars
## while the dcast function summarizes the data by calculating the means of all observations for each Subject for each Activity 
library(reshape2)

## finally, it prints the final tidy data table
