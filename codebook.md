# Code Book

This file details the relevant variables not already covered in the .txt files
included in the downloaded .zip file from the final project. Files are merged,
so test and train data are no longer partitioned. 

## Included .txt files

A few files to read to gather information on what variables are calculated:

### features_info.txt

Provides an overview of the calculated variables. Variables included in the
final dataset are means and standard deviations from each observation. Other
data are discarded. Remaining features are renamed in the following format:

t is translated to raw
f is translated to ffc (short for Fast Fourier Transform)
Acc is translated to accelerometer
Mag is translated to magnitude
Gyro is translated to gyroscope

### activity_labels.txt

These activity labels are changed from numbers to descriptive variables. They
are as follows:

walking
walking upstairs
walking downstairs
sitting
standing
laying

## Subjects

Subjects are only denoted by integers from 1 to 30.

## all_data.txt

This is a data frame sorted by subject and activity that includes each
observation of the 66 mean and standard deviation variables mentioned in the
features section.

## condensed.txt

This is a summarized data frame sorted by subject and activity that includes
the mean of the observations taken for each activity on each subject for the
66 mean and standard deviation variables mentioned in the features section.