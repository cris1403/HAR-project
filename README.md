HAR-project
===========
Getting and Cleaning Data Course Project
----------------------------------------

### Session October 2014

The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Data are collected from the Samsung Galaxy S smartphone's accelerometers and gyroscopes. 

The original dataset comes from an experiment carried out with a group of 30 subjects. Each person performed six activities (laying, sitting, standing, walk, walk down, walk up) wearing a smartphone on the waist. The experiments have been video-recorded to label the data manually.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

As stated in the UCI Machine Learning Repository web page, for each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The script "run_analysis.R" does the following:

1. Download and unzip the the original dataset, which includes - among the others - the following files:
a) 'activity_labels.txt': Links the class labels with their activity name.
b) 'train/X_train.txt': Training set.
c) 'train/y_train.txt': Training labels.
d) 'test/X_test.txt': Test set.
e) 'test/y_test.txt': Test labels.
f) 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  
g) 'test/subject_test.txt': The same as above.
h) 'features.txt': List of all features.

2. Merge training set and test set data regarding features (b+d), class variable (c+e) and subjects (f+g).
3. The dataset has 561 features, but we want to take into account only features regarding mean standard deviation for each measurement: so from file "h)" we extract features names which have mean or std in their name. We obtain a dataset with only 66 features.
4. Then we build descriptive column names: all lower case, descriptive, don't have underscores or dots or white spaces.
5. Use descriptive activity names, using file "a)" to name the activities in the data set and appropriately labels the data set with descriptive variable names (variables with character values should usually be made into factor variables).
6. Eventually we bind subject id, class variable and features datasets from previous steps in a dataset named "tidy_data.txt".
7. From the dataset in step 6, we create a second, independent tidy data set with the average of each variable for each activity and each subject, named "avg_data.txt".


Two output files are generated in the current working directory:
* "tidy_data.txt" (8.1 Mb): it contains a data frame called "merged" with 10299 rows and 68 variables.
* "avg_data.txt" (221 Kb): it contains a data frame called "result" with 180 rows and 68 variables.