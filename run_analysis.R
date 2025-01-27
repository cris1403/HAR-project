rm(list=ls())
setInternet2(use = TRUE) 

# download the zip file for the project
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?accessType=DOWNLOAD"

td = tempdir()                            # create a temporary directory
tf = tempfile(tmpdir=td, fileext=".zip")  # create a tempfile

download.file(fileUrl, destfile=tf, mode="wb")  # download the zip file

fname = unzip(tf, list=TRUE)$Name               # get the name of the files in the zip archive
unzip(tf, files=fname, exdir="../HAR-data", overwrite=TRUE) # unzip the file to a directory

rm(td, tf)                                # remove unnecessary stuff

############################################
# 1. Merge training and test sets 
############################################

dataFolder = "../HAR-data/UCI HAR Dataset"

XTrain = read.table(paste(dataFolder, "/train/X_train.txt", sep=""))
XTest = read.table(paste(dataFolder, "/test/X_test.txt", sep=""))
XData = rbind(XTrain, XTest)

rm(XTrain, XTest)

YTrain = read.table(paste(dataFolder, "/train/y_train.txt", sep=""))
YTest = read.table(paste(dataFolder, "/test/y_test.txt", sep=""))
YData = rbind(YTrain, YTest)

rm(YTrain, YTest)

subjectTrain = read.table(paste(dataFolder, "/train/subject_train.txt", sep=""))
subjectTest = read.table(paste(dataFolder, "/test/subject_test.txt", sep=""))
SubjectData = rbind(subjectTrain, subjectTest)

rm(subjectTrain, subjectTest)

######################################################################################################
# 2. Take into account only the measurements on the mean and standard deviation for each measurement. 
######################################################################################################

# features names
features = read.table(paste(dataFolder, "/features.txt", sep=""))

# search for features which have mean or std in their name
selectedFeatures = grep("-mean\\(\\)|-std\\(\\)", features[, 2])

# extract data only for those features
XData = XData[,selectedFeatures]

# column names: use descriptive feature names
names(XData) = features[selectedFeatures, 2]
names(XData) = gsub("\\(|\\)", "", names(XData))
names(XData) = gsub("\\-", "", names(XData))
names(XData) = tolower(names(XData))

names(XData) = gsub("^t", "time", names(XData))
names(XData) = gsub("^f", "fastfouriertransform", names(XData))
names(XData) = gsub("acc", "acceleration", names(XData))
names(XData) = gsub("gyro", "gyroscope", names(XData))
names(XData) = gsub("mag", "magnitude", names(XData))
names(XData) = gsub("std", "standarddeviation", names(XData))

###########################################################################
# 3. Uses descriptive activity names to name the activities in the data set
###########################################################################

classLabels = read.table(paste(dataFolder, "/activity_labels.txt", sep=""))

###########################################################################
# 4. Appropriately labels the data set with descriptive variable names. 
###########################################################################

classLabels[, 2] = gsub("_", " ", tolower(as.character(classLabels[, 2])))

actlabel = classLabels[YData[,1],2]
YData[,1] = factor(actlabel)
names(YData) = "activity"
names(SubjectData) = "subId"

# merge subject id, class variable and features datasets
merged = cbind(SubjectData, YData, XData)
merged$subId = factor(merged$subId)
write.table(merged, "tidy_data.txt", row.name=FALSE)

##############################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
##############################################################################

# library(plyr)
# excludedColumns = which(names(merged) %in% c("subId", "activity"))
# result = ddply(merged, .(subId, activity), .fun=function(x){colMeans(x[,-excludedColumns])})

library(dplyr)
result = merged %>%
          group_by(subId, activity) %>%
          summarise_each(funs(mean))

write.table(result, "avg_data.txt", row.name=FALSE)

