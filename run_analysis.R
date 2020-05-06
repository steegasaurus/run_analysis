


#Libraries for function

library(dplyr)
library(tidyr)
library(utils)

run_analysis <- function(){
    
    #Call download_data to download relevant data from UCI
    
    download_data()
    
    #Create merged data frame with complete_data()
    
    combined <- complete_data()
    
    #Create new condensed table with just averages for activities and subjects
    
    condensed <- condense_data(combined)
    
    #Save tables as .txt files
    write.table(combined, 'UCI HAR Dataset/all_data.txt')
    write.table(condensed, 'UCI HAR Dataset/condensed.txt')
    
    #Print what was done to the console
    print('Relevant files downloaded, new files all_data.txt and condensed.txt
          created in folder UCI HAR Dataset. all_data.txt is a cleaned up
          file of all observations and condensed.txt is a table of the averages
          of each variable for each activity and each subject.')
}

#Function downloading and unzipping the data from UCI smartphone activity
#recognition dataset to the working directory

download_data <- function(){
    
    #Download the zip file to the working directory
    
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'uci_sp_data.zip')
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
    test.s <- read.table('UCI HAR Dataset/test/subject_test.txt')
    
    #Extract train data from raw and activity file
    
    train.X <- read.table('UCI HAR Dataset/train/X_train.txt')
    train.y <- read.table('UCI HAR Dataset/train/y_train.txt')
    train.s <- read.table('UCI HAR Dataset/train/subject_train.txt')
    
    #Extract features info and record the indices of the mean and standard dev
    
    features <- read.table('UCI HAR Dataset/features.txt')
    f.index <- grep('[Mm]ean\\(|std\\(', features$V2)
    
    #Extract activity info and make descriptions more readable
    
    activity <- read.table('UCI HAR Dataset/activity_labels.txt')
    activity$V2 <- activity$V2 %>% tolower %>% sub('_', ' ', .)
    
    #Merge test and train data from raw
    
    raw_all <- rbind(test.X, train.X)
    raw_activity <- rbind(test.y, train.y)
    raw_subjects <- rbind(test.s, train.s)
    
    #Trim and rename columns in merged, then make column names readable
    
    raw_all <- raw_all[, f.index]
    colnames(raw_all) <- features$V2[f.index]
    colnames(raw_all) <- raw_all %>% names %>% descriptive_variables
    
    #Clean subjects
    
    colnames(raw_subjects) <- 'subject'
    raw_subjects$subject <- as.factor(raw_subjects$subject)
    
    #Rename activity factors with descriptor rather than number
    
    raw_activity$V1 <- as.factor(raw_activity$V1)
    levels(raw_activity$V1) <- activity$V2
    colnames(raw_activity) <- 'activity'
    
    #Merge raw, activity, subject files
    
    combined <- cbind(raw_subjects, raw_activity, raw_all)
    
    #Return the combined data frame
    
    combined
}

#Makes column names more readable with a series of character variable subs

descriptive_variables <- function(n){
    vars <- n %>% gsub('^t', 'raw ', .) %>%
        gsub('^f', 'ffs ', .) %>%
        gsub('-mean\\(\\)', 'mean ', .) %>%
        gsub('-std\\(\\)', 'standard dev ', .) %>%
        gsub('-X', 'x dir', .) %>%
        gsub('-Y', 'y dir', .) %>%
        gsub('-Z', 'z dir', .) %>%
        gsub('Body', 'body ', .) %>%
        gsub('Gravity', 'gravity ', .) %>%
        gsub('Acc', 'acceleration ', .) %>%
        gsub('Gyro', 'gyro ', .) %>%
        gsub('Jerk', 'jerk ', .) %>%
        gsub('Mag', 'magnitude ', .)
    vars
}

#Create a condensed table from the raw data
condense_data <- function(data){
    
    #Group the data
    g <- group_by(data, subject, activity)
    
    #Create summary table and return it
    summarize_all(g, mean)
}
