library(dplyr)

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) {
  
  filename <- "Dataset_project_3.zip"
  filezip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(filezip, filename, method="curl")
  
  unzip(filename) 
}
#Defines
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

#Train dataset
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

#Test dataset
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")

#To merge those datasets we need to bind them
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)

#Subject + Labels + Features
dataset <- cbind(Subjects, Y, X)

#1. Extracts only the measurements on the mean and standard deviation for each measurement.
data_tidy <- select(dataset, subject, id, contains("mean"), contains("std"))

#2. Uses descriptive activity names to name the activities in the data set
data_tidy$id <- activity_labels[data_tidy$id, 2]

#3. Appropriately labels the data set with descriptive variable names.
names(data_tidy)[2] = "activity"
names(data_tidy) <- gsub("Acc", "Accelerometer", names(data_tidy))
names(data_tidy) <- gsub("Gyro", "Gyroscope", names(data_tidy))
names(data_tidy) <- gsub("BodyBody", "Body", names(data_tidy))
names(data_tidy) <- gsub("Mag", "Magnitude", names(data_tidy))
names(data_tidy) <- gsub("^t", "Time", names(data_tidy))
names(data_tidy) <- gsub("tBody", "TimeBody", names(data_tidy))
names(data_tidy) <- gsub("fBody", "FrequencyBody", names(data_tidy))
names(data_tidy) <- gsub("-mean", "Mean", names(data_tidy))
names(data_tidy) <- gsub("-std", "Std", names(data_tidy))
names(data_tidy) <- gsub("-freq()", "Frequency", names(data_tidy))
names(data_tidy) <- gsub("angle", "Angle", names(data_tidy))
names(data_tidy) <- gsub("gravity", "Gravity", names(data_tidy))

#4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_final_mean <- data_tidy %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(data_final_mean, "Data_final.txt", row.name=FALSE)
