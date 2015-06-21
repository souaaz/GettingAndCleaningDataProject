require(plyr)

# Data folder is in UCI HAR Dataset
datafolder <- "UCI HAR Dataset"
# Results folder will contain output file
resultsfolder <- "results"

if(!file.exists(datafolder)){
    print("Please unzip the data file")
    unzip(file, list = FALSE, overwrite = TRUE)
} 

if(!file.exists(resultsfolder)){
    print("Please create results folder")
    dir.create(resultsfolder)
} 


#Get the raw data
inputpath<-file.path(getwd(),"UCI HAR Dataset")

pathfile_test<-file.path(inputpath, "test")
pathfile_train<-file.path(inputpath, "train")

x_test<-read.table(file.path(pathfile_test,"X_test.txt"))
y_test<-read.table(file.path(pathfile_test,"Y_test.txt"))
subject_test<-read.table(file.path(pathfile_test,"subject_test.txt"))

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
sensor_data<-rbind(train_data, test_data)

sensor_labels<-rbind(rbind(feature_labels, c(562, "Subject")), c(563, "Id"))[,2]
names(sensor_data)<-sensor_labels

#2. Extract only the measurements on the mean and standard deviation for each measurement.
sensor_data_mean_std <- sensor_data[,grepl("mean\\(\\)|std\\(\\)|Subject|Id", names(sensor_data))]

#3. Use descriptive activity names to name the activities in the data set
sensor_data_mean_std <- join(sensor_data_mean_std, activity_labels, by = "Id", match = "first")
sensor_data_mean_std <- sensor_data_mean_std[,-1]

#4. Appropriately label the data set with descriptive names.
names(sensor_data_mean_std) <- gsub("([()])","",names(sensor_data_mean_std))
#norm names
names(sensor_data_mean_std) <- make.names(names(sensor_data_mean_std))

#5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject 
finaldata<-ddply(sensor_data_mean_std, c("Subject","Activity"), numcolwise(mean))
#Prepare the fiename
file <- paste(resultsfolder, "/", "tidy_dataset",".txt" ,sep="")
#Create the tidy data set file in results folder
write.table(finaldata, file , row.name=FALSE)
