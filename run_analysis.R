#step1
#downloading and unzipping the required data

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "dataset.zip")
unzip("dataset.zip")

#step2
#reading the data

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
feature <- read.table("./UCI HAR Dataset/features.txt")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

#step3
#concataning to train and test data

train <- cbind(subjectTrain,ytrain,xtrain)
test <- cbind(subjectTest,ytest,xtest)


#step4
#merging train and test data set

mergingData <- rbind(train,test)


#step5
#assigning each variable descriptive name

x <- data.frame(V1=1,V2=c("subjectNo"))
y <- data.frame(V1=1,V2=c("activity"))
varNames <- rbind(x,y,feature)
names(mergingData)<-varNames$V2


#step6
#Extracting mean and standard deviation for each measurement.

index <- grep("[m][e][a][n][()]|[s][t][d][()]", varNames$V2)
extractedData <- mergingData[,c(1,2,index)]


#step7
#descriptive activity names to the data set

extractedData$activity <- factor(extractedData$activity,
                                 labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") )


#step8
#average of each variable for each activity and each subject

library(dplyr)
dataSummary <- extractedData %>%
  group_by(subjectNo,activity) %>%
  summarise_each(funs(mean))


#creating .txt file 

write.table(dataSummary,file = "tidyDataset.txt",row.name=FALSE)


