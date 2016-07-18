==================================================================
Coursera Assignment
==================================================================

The assignment includes the following files:
===========================================

- 'README.md'

- 'codebook.md': A description of the variables

- 'run_analysis.R': The script.


Using the Script:
================

The working directory should be set up where the "UCI HAR Dataset" directory is located, to run the script.
The output file is FinalDS.txt and is can be read using the following lines:

data <- read.table("FinalDS.txt", header = TRUE)
View(data)

Script description:
==================

Inside the script there is a line which describes what it´s being done step by step


-First the column names of the variables are extracted
-Then activity names are extracted
-The train dataset is read, and attached to their corresponding activity and subject
-The test dataset is read, and attached to their corresponding activity and subject
-Join the test and train dataset
-Select the relevant columns (the ones ending in "mean()" and "std()". The variables containing "meanFreq()" were not considered on purpose.
-The column names are assigned
-The ds variable is generated contains the tidy dataset for point 4
-The table for point 5 is generated. It can be found in the working directory as "FinalDS.txt"