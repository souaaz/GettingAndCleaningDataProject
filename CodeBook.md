---
title: "Code Book - Course Project"
---

This is a code book that describes the variables, data, and transformations performed to clean up the data.


##Raw Data Transformation

The raw data sets are processed with the **run_analysis.R** script to create a tidy data set.

**Merge training and test sets**
Test and training data, subject ids and activity ids are merged to obtain a single data set. 
Variables are labelled with the names assigned by original collectors.

**Extract mean and standard deviation variables** 
Keep only the values of estimated mean and standard deviation .

**Get descriptive activity names** 
A new column is added to intermediate data set with the activity description.

**Get label variables** 
Labels were changed to get more descriptive R names

**Create a tidy data set**
A final tidy data set where numeric variables are averaged for each activity and each subject.

## Tidy Data Set

**Variables**

The tidy data set contains :

1. A **Subject** identifier of the subject who carried the experiment (Subject). Range is from 1 to 30.
2. An **Activity** label: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
3. **mean and standard deviation** of all other variables are measurements for the accelerometer and gyroscope 3-axial raw signal (numeric value)

**.mean/std**: mean or standard deviation of the measurement

**.X/Y/Z**: one direction of a 3-axial signal
**.mean**: global mean value

The data set is written to the file **tidy_dataset.txt**.
