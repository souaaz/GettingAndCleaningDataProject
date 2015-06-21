---
title: "Getting and Cleaning Data - Course Project"
author: "Samira Ouaaz"
date: "Sunday, June 21, 2015"
output: html_document
---
## Requirements
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The data for the project
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Repository Contents
* CodeBook.md : details about raw data set and tidy data set
* README.md : this file
* run_analysis.R : R script to transform raw data into tidy data

## How To
* Clone this repository
* Download compressed raw data
* Unzip raw data and copy the directory 'UCI HAR Dataset' to the cloned repository root directory
* Open an R console and set the working directory to the repository root
* Run run_analysis.R script : the tidy data set will be created in the results folder.