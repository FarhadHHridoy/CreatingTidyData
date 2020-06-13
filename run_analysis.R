#step1
#downloading and unzipping the required data

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "dataset.zip")
unzip("dataset.zip")

#step2
#reading the data

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "subjectID")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "subjectID")
feature <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featureID", "featureName"))
activity <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activityID", "activityName"))

#step3
#concataning to train and test data

train <- cbind(subjectTrain,ytrain,xtrain)
test <- cbind(subjectTest,ytest,xtest)


#step4
#merging train and test data set

mergingData <- rbind(train,test)


#step5
#assigning each variable descriptive name
library(dplyr)


feature <- feature %>%
  mutate(featureName = gsub("\\(\\)", "", featureName),          # remove ()
         featureName = gsub("-", "", featureName),               # remove -
         featureName = sub("mean", "Mean", featureName),         # change "mean" to "Mean"
         featureName = sub("std", "StDev", featureName),         # change "std" to "StDev"
         featureName = sub("^t", "Time", featureName),           # change leading "t" to "Time"
         featureName = sub("^f", "Freq", featureName),           # change leading "f" to "Freq"
         featureName = sub("BodyBody", "Body", featureName),     # change "Acc" to "Body"
         featureName = sub("Acc", "Accelerometer", featureName), # change "BodyBody" to "Accelerometer"
         featureName = sub("Gyro", "Gyroscope", featureName),    # change "Gyro" to "Gyroscope"
         featureName = sub("Grav", "Gravity", featureName),      # change "Grav" to "Gravity"
         featureName = sub("Mag", "Magnitude", featureName))     # change "Mag" to "Magnitude"



varNames <- c(names(subjectTest),names(activity)[2],feature$featureName)
names(mergingData)<-varNames


#step6
#Extracting mean and standard deviation for each measurement.

index <- grep("([M][e][a][n][XYZ])|([S][t][D][e][v][XxYyZz])|(([M][e][a][n])|([S][t][D][e][v]))$", varNames)
extractedData <- mergingData[,c(1,2,index)]


#step7
#descriptive activity names to the data set

extractedData$activityName <- factor(extractedData$activityName,
                                     labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") )


#step8
#average of each variable for each activity and each subject


dataSummary <- extractedData %>%
  group_by(subjectID,activityName) %>%
  summarise_each(funs(mean))


#creating .txt file 

write.table(dataSummary,file = "tidyDataset.txt",row.name=FALSE)


#reading the tidy dataset
data <- read.table("tidyDataset.txt")
