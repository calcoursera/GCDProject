# load add-on libraries for data table and reshaping of data 

packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

#get current working directory

wd <- getwd()

#set path of data files to UCI HAR Dataset

wd <- file.path(wd, "UCI HAR Dataset")

#read the subject test and train files

SubjectTestData  <- fread(file.path(wd, "test" , "subject_test.txt" ))
SubjectTrainData <- fread(file.path(wd, "train", "subject_train.txt"))

#read the label test and train files

LabelTestData  <- fread(file.path(wd, "test" , "Y_test.txt" ))
LabelTrainData <- fread(file.path(wd, "train", "Y_train.txt"))

#read the data files – both test and train

#TestData  <- fread(file.path(wd, "test" , "X_test.txt" ))
#TrainData <- fread(file.path(wd, "train", "X_train.txt"))
#gives errors Expected sep (' ') but new line, EOF (or other non printing char#acter) ends field 655 on line 32 when detecting types


datframetr <- read.table(file.path(wd, "train", "X_train.txt"))
DataTableTrain <- data.table(datframetr)


datframetes <- read.table(file.path(wd, "test", "X_test.txt"))
DataTableTest <- data.table(datframetes)


#join train and test files row-wise for subject and label; add descriptive names to the columns

SubjectTestTrainData <- rbind(SubjectTestData, SubjectTrainData)
setnames(SubjectTestTrainData, "V1", "subject")
LabelTestTrainData <- rbind(LabelTestData, LabelTrainData)
setnames(LabelTestTrainData, "V1", "activityNo")

#rowbind the test and train files for data

DataTestTrain <- rbind(DataTableTest, DataTableTrain)

#merge files and set key columns

SubjectData <- cbind(SubjectTestTrainData,LabelTestTrainData)
SLDataTestTrain<-cbind(SubjectData,DataTestTrain)
setkey(SLDataTestTrain,subject,activityNo)

#find the measurements for mean and std 
#Read the features.txt file and give names to the two columns there


Featuresinfo <- fread(file.path(wd, "features.txt"))
setnames(Featuresinfo, names(Featuresinfo), c("Index", "NameofFeature"))

#search for mean (Mean) and std word patterns to identify the mean and standard deviation of the #feature measurements; and extract such std measurements

Featuresinfo <- Featuresinfo[grepl("mean\\(\\)|std\\(\\)", NameofFeature)]

#Match the columns before extracting subset

Featuresinfo$featureIndex <- Featuresinfo[, paste0("V", Index)]

#head(SLDataTestTrain)
#SLDataTestTrain$featureIndex
#Extract the relevant columns
  
relevant <- c(key(SLDataTestTrain), Featuresinfo$featureIndex)
SLDataTestTrain <- SLDataTestTrain [, relevant, with=FALSE]                                  

#read the activity labels file and add descriptive names to the columns

ActivityNamesdata <- fread(file.path(wd, "activity_labels.txt"))
setnames(ActivityNamesdata, names(ActivityNamesdata), c("activityNo", "activityName"))

#merge the files based on the activityIndex
#and make activityName as key

SLDataTestTrain <- merge(SLDataTestTrain, ActivityNamesdata, by="activityNo", all.x=TRUE)
setkey(SLDataTestTrain, subject, activityNo, activityName)

#Reshape the merged file into a tall format by melting

SLDataTestTrain <- data.table(melt(SLDataTestTrain, key(SLDataTestTrain), variable.name="featureIndex"))

#Next, merge the Name of activities NameofFeature

SLDataTestTrain <- merge(SLDataTestTrain, Featuresinfo[, list(Index, featureIndex, NameofFeature)], by="featureIndex", all.x=TRUE)

#Create new factor variables from activityName and NameofFeature

SLDataTestTrain$activityFactor <- factor(SLDataTestTrain$activityName)
SLDataTestTrain$featureFactor <- factor(SLDataTestTrain$NameofFeature)

#create the tidy data set for each activity and subject with the average setkey(SLDataTestTrain, subject, activityFactor, featDomain, featAcceleration, featInstrument, featJerk, featMagnitude, featVariable, featAxis)

TidyData <- SLDataTestTrain[, list(count = .N, average = mean(value)), by=key(SLDataTestTrain)]

#write the tidy data to a file GCDProjTidyData.txt

write.table(TidyData, file = ".\ GCDProjTidyData.txt ",row.names = FALSE)
 
