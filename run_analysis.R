# I have chosen to read the data and merge the data into a single dataset before extracting specific columns
# and creating a second tidy dataset
# I have used the package reshape 
# I have downloaded the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# and unzipped into the current directory from where the script was run.
#
# --- script starts here --
# read the variable names into a table
features <- read.table("./UCI_HAR_Dataset/features.txt")

# read the experimental data related to subjects chosen for training
trainData <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
# label the variables using the descriptive names loaded into the table features
colnames(trainData) <- features$V2
# read the subjects used for training data set
trainSubjects <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
# label the single column in the table trainSubjects
colnames(trainSubjects) <- "ID"
# read the activity types for training data set
trainActTypes <- read.table("./UCI_HAR_Dataset/train/y_train.txt")
# label the activityTypes with descriptive names using factor
trainLabelledActTypes <- data.frame(factor(trainActTypes$V1, levels=c(1,2,3,4,5,6), labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))
# label the single column in the table trainLabelledActTypes
colnames(trainLabelledActTypes) <- "ActivityType"
# create a single table containing subjects, data, activityTypes for training data.
trainDataWithIdAndActType <- cbind(trainSubjects,trainData,trainLabelledActTypes)

# read the experimental data related to subjects chosen for test
testData <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
# label the variables using the descriptive names loaded into the table features
colnames(testData) <- features$V2
# read the subjects used for test data set
testSubjects <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
# label the single column in the table testSubjects
colnames(testSubjects) <- "ID"
# read the activity types for test data set
testActTypes <- read.table("./UCI_HAR_Dataset/test/y_test.txt")
# label the activityTypes with descriptive names using factor
testLabelledActTypes <- data.frame(factor(testActTypes$V1, levels=c(1,2,3,4,5,6), labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))
# label the single column in the table testLabelledActTypes
colnames(testLabelledActTypes) <- "ActivityType"
# create a single table containing subjects, data, activityTypes for training data.
testDataWithIdAndActType <- cbind(testSubjects,testData,testLabelledActTypes)

# create a dataset that merges training data and test data( both datasets contains subjectID and activityType)
mergedData <- rbind(trainDataWithIdAndActType, testDataWithIdAndActType)

# extract means and std vraibales, get a column subset using a regular expression
extractMeanAndStd <- mergedData[,grep('ID|ActivityType|.*std.*|.*mean.*',names(mergedData))]

# use the library reshape to create the tidy dataset with the average of each variable for each activity and subject
molten <- melt(extractMeanAndStd, id.vars = c("ID","ActivityType"))
groupedResult <- cast(ActivityType +ID ~ variable, data = molten, fun = mean)
# change the column names to indicate the average (mean and std)
colnames(groupedResult) <- paste("avg(",colnames(groupedResult),")")
# write the tidy dataset to a file
write.table(groupedResult,file="./varAvgByIdAndActType.txt")
