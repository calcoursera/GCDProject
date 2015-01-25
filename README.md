# GCDProject
R script to analyse Samsung data and produce tidy data

Purpose of the project :  

To produce tidy data for later use from a given set of data files pertaining to data collected from the accelerometers of Samsung Galaxy S smartphones to measure the various activities (of subjects) such as walking, climbing stairs (up and down), laying, etc...

Input for the project:

Data files were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Description of the data in these files were obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Output of the project :

GCDProjData.txt (intermediate) - quite large
GCDProjTidyData.txt (final)  - only this is uploaded as required by project

How to run this project:

1. Open the source R script run_analysis.R in the text editor
2. Set working directory to the place where the downloaded and unzipped files are stored
3. Run the file run_analysis.R
4. This will produce the following output files : GCDProjData.txt, GCDProjTidyData.txt, codebook1.md, codebook.md


