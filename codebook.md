===========================================================================================================================

   TidyData.featureIndex

----------------------------------------------------------------------------------------------------------------------------

   Storage mode: character
   Measurement: nominal

   Values and labels     N     Percent  
                                        
        (unlab.vld.)    66   100.0 100.0

============================================================================================================================

   TidyData.count

----------------------------------------------------------------------------------------------------------------------------

   Storage mode: integer
   Measurement: interval

            Min:  10299.000
            Max:  10299.000
           Mean:  10299.000
       Std.Dev.:      0.000
       Skewness:        NaN
       Kurtosis:        NaN

============================================================================================================================

   TidyData.average

----------------------------------------------------------------------------------------------------------------------------

   Storage mode: double
   Measurement: interval

            Min:  -0.965
            Max:   0.669
           Mean:  -0.511
       Std.Dev.:   0.330
       Skewness:   1.387
       Kurtosis:   1.315


The raw data for the project which needs to be tidied up was obtained from

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

An R script called run_analysis.R was then coded to do the following. 
1.	The test and training data sets were merged to create one data set.
2.	The measurements on the mean and standard deviation were then identified from the merged data set.
3.  These mean and std measurements were then extracted for the various activities in the merged data set, taking care to include both mean and Mean.
4.	The activities were then named with descriptive labels and activity names (GCDProjData.txt)
5.  The format of the data was changed from a wide to a narrow one by melting/reshaping.
6.	An independent tidy data set with the average of each variable for each activity and each subject (GCDProjTidyData.txt) was also created. 
