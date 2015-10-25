# datacleaningcoursera
Data cleaning project for Coursera Course on Data Science

## Overview / How the code works

The script depends heavily on the mergeSet() function, which takes as inputs the locations of the subject, activity and measurements/results files that need to be merged together. The function returns a single data frame with the columns *activity_id, subject_id, activyt_mean, activity_stdev, activity_name*, populated with information from the different datafiles supplied.

The overall script works by running mergeSet on the training data, then on the test data, and then finally adding the one set to the other to produce the final data frame, using rbind().



**NOTE:**
Instead of returning all of the individual results from the X_...txt file, this function calculates the mean and std deviation of the observations in the file, and instead adds these to the dataframe that is returned. This is done in
order to gretly simplify later operations on the dataframe.

## Variable descriptions
In the file that is produced when the script finishes running (tidydata.txt), the following fields are specified:

* *subject* The unique ID reference of a participant in the test
* *activity* The text name of the activity that the subject performed
* *mean* The mean of all observations of the subject performing that activity
* *stdev* The standard deviation of the observations of the subject performing that activity

## To run the script
This script can simply be run in place. The script assumes that it is run from a subdirectory of the home/working directory, named *datacleaningcoursera*, and that the working data is stored in *datacleaningcoursera/data*, in the same hierarchy as it emerges from its original ZIP file.
