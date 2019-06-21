# Code Book

The `run_analysis.R` performs the data preparation on database available on `UCI HAR Dataset/`. The steps below describes what was done on that script:

  1.  **Download the dataset**
  * The dataset available on this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "link") was used on this assessment. The dataset was downloaded and extracted under the fold UCI HAR Dataset.
  
  2.  **Extract the data into variables**
  * `features` <- `features.txt`, List of all features. 561 rows, 2 columns
  * `activity_labels` <- `activity_labels.txt`, Links the class labels with their activity name. 6 rows, 2 columns.
  * `subject_train`, `subject_test` <- `train/subject_train.txt`, `test/subject_test.txt`, Each row identifies the subject who performed the activity for each window sample. 7352 rows, 1 column (Train), 2947 rows, 1 column (Test)
  * `x_train`, `x_test` <- `train/x_train.txt`, `test/x_test.txt`, Training (Test) set. 7352 rows, 561 columns (Train), 2947 rows, 561 columns (Test)
  * `y_train`, `y_test` <- `train/y_train.txt`, `test/y_test.txt`, Training (Test) labels. 7352 rows, 1 columns (Train), 2947 rows, 1 columns (Test)
  
  3.  **Merge train and test dataset into one**
  * `X` (10299 rows, 561 columns) was created by merging `x_train` and `x_test` using **rbind()** function
  * `Y` (10299 rows, 1 column) was created by merging `y_train` and `y_test` using **rbind()** function
  * `Subjects` (10299 rows, 1 column) was created by merging `subject_train` and `subject_test` using **rbind()** function
  * `dataset` (10299 rows, 563 column) was created by merging `Subjects`, `Y` and `X` using **cbind()** function

  4.  **Extracts only the measurements on the mean and standard deviation for each measurement**
  * `data_tidy` (10299 rows, 88 columns) was created by seting `dataset`, selecting only columns: `subject`, `id` and the measurements on the mean and standard deviation (std) for each measurement.
  
  5.  **Uses descriptive activity names to name the activities in the data set**
  * Entire numbers in id column of the `data_tidy` replaced with corresponding activity taken from second column of the  `activity_labels` variable.
  
  6. ** Appropriately labels the data set with descriptive variable names**
  * `id` column in `data_tidy` renamed into **activities**
  * All `Acc` in column’s name replaced by **Accelerometer**
  * All `Gyro` in column’s name replaced by **Gyroscope**
  * All `BodyBody` in column’s name replaced by **Body**
  * All `Mag` in column’s name replaced by **Magnitude**
  * All start with character `f` in column’s name replaced by **Frequency**
  * All start with character `t` in column’s name replaced by **Time**

  7.  **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
  * `data_final_mean` (180 rows, 88 columns) was created by sumarizing `data_tidy` taking the means of each variable for each activity and each subject, after groupped by subject and activity.
  * Export `data_final_mean` into *Data_final.txt* file.
    


