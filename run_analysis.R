dataDirectory <- "datacleaningcoursera/data/"

library("dplyr")
library("matrixStats")


# ==========================================================================================================
# This function will merge the subject, label, and activity files given as parameters into one consolidated 
# data frame
#
# subjectFile   - name of the .txt file with subject data
# labelFile     - name of the .txt file with the label data
# activityFile  - name of the .txt file with the activity result data
mergeSet <- function(subjectFile, labelFile, activityFile){
    
    #Load datafile with subject information and rename the column to something more helpful
    subjectData <- read.table(subjectFile);
    subjectData <- rename(subjectData, subject_id = V1)
    
    #Load the activity datafile and rename the column to something more helpful
    labelData <- read.table(labelFile);
    labelData <- rename(labelData, activity_id = V1)
    
    #Load the results datafile
    activityData <- read.table(activityFile);
    
    #add columns for the mean and std dev of the activity data, and add them into the dataframe to return
    activity_mean    <- rowMeans(activityData, na.rm = TRUE)
    activity_stdev    <- rowSds(as.matrix(activityData), na.rm=TRUE)
    
    #Read the names of the different activity types into a table
    activityLabels <- read.table(paste(dataDirectory, "activity_labels.txt", sep=""))
    activityLabels <- rename(activityLabels, activity_name = V2)
    
    
    #Assemble the data fram to return
    returnData <- cbind(subjectData, labelData, activity_mean, activity_stdev)
    
    #Join the data frame with the data frame that contains the text names of the activities
    returnData <- merge(returnData, activityLabels, by.x = "activity_id", by.y = "V1")
    
    returnData
    
}


#Merge the test data
testSet <- mergeSet(paste(dataDirectory, "test/", "subject_test.txt", sep=""), paste(dataDirectory, "test/", "y_test.txt", sep=""), paste(dataDirectory, "test/", "X_test.txt", sep="") )

#Merge the training data
trainSet <- mergeSet(paste(dataDirectory, "train/", "subject_train.txt", sep=""), paste(dataDirectory, "train/", "y_train.txt", sep=""), paste(dataDirectory, "train/", "X_train.txt", sep="") )

#Concatenate the two sets together
totalSet <- rbind(testSet, trainSet)


#create a summary data frame to satisfy Q5
summarySet <- summarise(group_by(totalSet, subject = subject_id, activity = activity_name), mean = mean(activity_mean), stdev = mean(activity_stdev))


write.table(summarySet, "datacleaningcoursera/tidydata.txt", row.names = FALSE)






