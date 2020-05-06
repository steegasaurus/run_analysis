


#Libraries for function
library(dplyr)
library(tidyr)

run_analysis <- function(){
    
    #Call download_data to download relevant data from UCI
    download_data()
    
    #Create merged data frame with complete_data() and return to new variable
    combined <- complete_data()
}

#Function downloading and unzipping the data from UCI smartphone activity
#recognition dataset to the working directory
download_data <- function(){
    #Download the zip file to the working directory
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles
                  %2FUCI%20HAR%20Dataset.zip', 'uci_sp_data.zip')
    #Unzip it
    unzip('uci_sp_data.zip')
}

#Function extracting both test and train data, merging them, then trimming
#columns and renaming variables from the features described in features.txt.
#Extracts the activity descriptions from activity_labels.txt and renames the
#activities appropriately. Returns the resulting data frame
complete_data <- function(){
    #Extract test data from raw and activity file
    test.X <- read.table('UCI HAR Dataset/test/X_test.txt')
    test.y <- read.table('UCI HAR Dataset/test/y_test.txt')
    
    #Extract train data from raw and activity file
    train.X <- read.table('UCI HAR Dataset/train/X_train.txt')
    train.y <- read.table('UCI HAR Dataset/train/y_train.txt')
    
    #Extract features info and record the indices of the mean and standard dev
    features <- read.table('UCI HAR Dataset/features.txt')
    f.index <- grep('[Mm]ean\\(|std\\(', features$V2)
    
    #Extract activity info and make descriptions more readable
    activity <- read.table('UCI HAR Dataset/activity_labels.txt')
    activity$V2 <- activity$V2 %>% tolower() %>% sub('_', ' ', .)
    
    #Merge test and train data from raw
    raw_all <- rbind(test.X, train.X)
    raw_activity <- rbind(test.y, train.y)
    
    #Trim and rename columns in merged
    raw_all <- raw_all[, f.index]
    colnames(raw_all) <- features$V2
    
    #Rename activity factors with descriptor rather than number
    
    #Merge raw and activity file
    combined <- cbind(raw_activity, raw_all)
    
    #Return the combined data frame
    combined
}
