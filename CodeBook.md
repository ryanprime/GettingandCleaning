Study Design
Data file was obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Full description of data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


The R script performs the following (ordered) procedure on the data:
-Merges training and test sets.
-Merges training and test labels.
-Merges training and test subject identities.
-Strip training set to only contain required values (mean/std)
-Performs the following parsing of variable (feature) names:
a) changes all ‘-‘ to ‘.’ and removes any parenthesis “()”
b) changes all letters to lowercase.
Example:   tBodyGyroJerk-XYZ-std() becomes tbodygyrojerk.xyz.std

-Replace activity number with name (in lowercase) defined in the file activity_labels.txt.  The ‘_’ also is removed from the original name.
Activity names are:
laying
standing
sitting
walking
walkingdownstairs
walkingupstairs

Clean data is a data frame with dimensions 10,299x68 then outputted to clean_data.txt
The first two columns contain subject and activity, respectively.  The remaining 66 columns contain the variables measured.

The second part of the R script uses the same variable names and activity labels as the previous part.

Data is read from the cleaned table and then averages of each variable for each activity and each subject are calculated and output to a data frame with dimensions 180x68.  The first two columns contain subject and activity, respectively.  The remaining 66 columns contain the averages for each variable.
