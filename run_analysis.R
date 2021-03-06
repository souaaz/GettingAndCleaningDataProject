###############################################################################
# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that can be
# used for later analysis. You will be graded by your peers on a series of 
# yes/no questions related to the project. You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis,
# and 3) a code book that describes the variables, the data, 
# and any transformations or work that you performed to clean up the data 
# called CodeBook.md. You should also include a README.md in the repo with
# your scripts. This repo explains how all of the scripts work and how they 
# are connected.  
#
# One of the most exciting areas in all of data science right now is wearable 
# computing - see for example this article . Companies like Fitbit, Nike, and 
# Jawbone Up are racing to develop the most advanced algorithms to attract new
# users. The data linked to from the course website represent data collected 
# from the accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained: 
#    
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
# Here are the data for the project: 
#    
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
##############################################################################

require(plyr)

# Data folder is in UCI HAR Dataset
datafolder <- "UCI HAR Dataset"
# Results folder will contain output file
resultsfolder <- "results"
fileNameResult <- "tidy_dataset"
fileNameResultExtension <- ".txt"

if(!file.exists(datafolder)){
    stop("No folder for raw data sets.")
} 

if(!file.exists(resultsfolder)){
    print("Creating results folder")
    dir.create(resultsfolder)
} 


#Get the raw data
inputpath<-file.path(getwd(),"UCI HAR Dataset")

pathfile_test<-file.path(inputpath, "test")
x_test<-read.table(file.path(pathfile_test,"X_test.txt"))
y_test<-read.table(file.path(pathfile_test,"Y_test.txt"))
subject_test<-read.table(file.path(pathfile_test,"subject_test.txt"))

pathfile_train<-file.path(inputpath, "train")
x_train<-read.table(file.path(pathfile_train,"X_train.txt"))
y_train<-read.table(file.path(pathfile_train,"Y_train.txt"))
subject_train<-read.table(file.path(pathfile_train,"subject_train.txt"))

#Get activity labels 
activity_labels<-read.table(file.path(inputpath,
                            "activity_labels.txt"),
                           col.names = c("Id", "Activity")
)

#Get features labels
feature_labels<-read.table(file.path(inputpath,
                                    "features.txt"),
                          colClasses = c("character")
)

#1.Merge the training and the test sets to create one data set.
train_data<-cbind(cbind(x_train, subject_train), y_train)
test_data<-cbind(cbind(x_test, subject_test), y_test)
data<-rbind(train_data, test_data)

data_labels<-rbind(rbind(feature_labels, c(562, "Subject")), c(563, "Id"))[,2]
names(data)<-data_labels

#2. Extract only the measurements on the mean and standard deviation for each measurement.
data_mean_std <- data[,grepl("mean\\(\\)|std\\(\\)|Subject|Id", names(data), perl=TRUE, ignore.case=TRUE)]

#3. Use descriptive activity names to name the activities in the data set
data_mean_std <- join(data_mean_std, activity_labels, by = "Id", match = "first")
data_mean_std <- data_mean_std[,-1]

#4. Appropriately label the data set with descriptive names.
names(data_mean_std) <- gsub("([()])","",names(data_mean_std))
names(data_mean_std) <- make.names(names(data_mean_std))

#5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject 
tidydata<-ddply(data_mean_std, c("Subject","Activity"), numcolwise(mean))
#Prepare the filename
file <- paste(resultsfolder, "/", fileNameResult, fileNameResultExtension, sep="")
#Create the tidy data set file in results folder
write.table(tidydata, file , row.name=FALSE)
