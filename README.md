HAR-project
===========
Getting and Cleaning Data Course Project
----------------------------------------

In this repository, you find a "run_analysis.R" script which will perform the analysis.
Here are the main steps:

1. Download and unzip the zip file for the project, which includes compressed raw data regarding the Human Activity Recognition data.
2. Merge training set and test set data.
3. Take into account only the features regarding the mean and standard deviation for each measurement (ie. seach for features which have mean or std in thei name).
4. Use descriptive feature names: all lower case, descriptive, don't have underscores or dots or white spaces.
5. Use descriptive activity names to name the activities in the data set and appropriately labels the data set with descriptive variable names (variables with character values should usually be made into factor variables).
6. Merge subject id, class variable and features datasets in a dataset named "tidy_data.txt".
7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject, named "avg_data.txt".


Two output files are generated in the current working directory:
* "tidy_data.txt" (8.1 Mb): it contains a data frame called "merged" with 10299 rows and 68 variables.
* "avg_data.txt" (221 Kb): it contains a data frame called "result" with 180 rows and 68 variables.