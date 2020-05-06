## Final project for Getting and Cleaning Data

This repository contains three files: this README, a Codebook detailing given
variables, and the run_analysis file itself which contains functions used for
running an analysis of the data from the UCI dataset.

### run_analysis.R

The run_analysis file downloads the data from the internet, then loads the
different .txt files into data frames that are then manipulated and combined
into a more readable format. The combined raw observational data is arranged by
subject and activity and then trimmed to only mean and standard deviation of
each observation. The remaining data is used to create a new summary table with
only the mean of each variable for each subject and activity included. Both the
summary table and trimmed raw data are saved into new files in the folder that
was downloaded from the internet. The file names are 'condensed.txt' for the
summary data and 'all_data.txt' for the trimmed raw data. All of this is only
done when the run_analysis() function is called from the sourced run_analysis.R
file. The actions taken when the function is called are overviewed in text
printed to the console.