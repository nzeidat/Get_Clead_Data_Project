---
title: "README"
author: "Nidal Zeidat"
date: "Saturday, August 22, 2015"
output: html_document
---

## Assumptions:##
> - the files X_test.txt, y_test.txt, subject_test.txt, X_train.txt, y_train.txt, subject_train.txt, and the script run_analysis.R are all assumed to be in the "current working  directory" for the script to work correctly.

##================================================================
## Task # 1:##
## Merges the training and the test sets to create one data set.
##================================================================
>**Solution steps:**

> - Will Appending testing data after training data
> - For training data:

    > - Read file X_train.txt into data frame (train_data)
    > - Read the data lables from the file features.txt into character vector
    > - Use character vector created in (b) as names() for training data DF
    > - Add the data in subject_train.txt as New column "Subject" train_data
    > - Add the data in y_train.txt as new column "Activity" in train_data
    > - Write training data into a file named final_data.csv
> - For Testing data

    > - Read file X_test.txt into data frame (test_data)
    > - Read the data lables from the file features.txt into character vector
    > - Use character vector created in (b) as names() for testing data DF
    > - Add the data in subject_test.txt as New column "Subject" test_data
    > - Add the data in y_test.txt as new column "Activity" in test_data
    > - Append test data at end of the file final_data.csv
    
> - Read data from final_data.csv into a data frame "final_data_set"

##================================================================
## Task # 2:##
## Extracts only the measurements on the mean and standard deviation for each measurement. 
##================================================================
>For this question, **I assume that the question is asking us to choose the columns that contain the text "mean" or "std"**. To accomplish that I used grep() on the column names and selected to inlclude the resulting column names. I also retained the columns "Subject" and "Activity".

>As a result of using "write.table()" for merging the training and testing data sets 
as explaind above, Column titles were automatically transferme where all characters:

> - "("
> - ")"
> - "-"
> - ","

>were each replaced with a dot (.). Following transoformations were carried to make the column names more readable

> - Replace "..." with "_"
> - Delete ".." text patterns
> - Replace "." with "_"

##
##================================================================
## Task # 3:##
## Uses descriptive activity names to name the activities in the data set 
##================================================================
I underood this task as replacing the Activity numeric values in the column
"Activity" with the corresponding "text" name of that activity; i.e.

> - 1 --> WALKING
> - 2 --> WALKING_UPSTAIRS
> - 3 --> WALKING_DOWNSTAIRS
> - 4 --> SITTING
> - 5 --> STANDING
> - 6 --> LAYING

##================================================================
## Task # 4:##
## Appropriately labels the data set with descriptive variable names. 
##================================================================
In this task I will replace the abbreviated words in the column names with
there actual full words. For example **fBodyBodyGyroJerkMag_mean** will be 
replaced by **f_Body_gyroscope_Jerking_Magnitude_mean**. Transformations carried include

> - BodyBody --> Body
> - Gyro --> Gyroscope
> - Acc --> Acceleration
> - Mag --> Magnitude
> - std --> StdDev
> - plus insertion of "_" between words to make column names more readable

##================================================================
## Task # 5:##
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##================================================================
>To do that we first group the data according to "Subject" column then "Activity" column
using the dplyr function "group_by()". This will create one (1) group of rows per subject (person) per Activity type. for a Total of 30X6 = 180 group of rows. Each group contains all the measures (Columns) measured for same Subject same Activy type.

>Then we use the dplyr function "summarise_each()" to summarize all "Measurements" columns for each group. We provide the function "meam" as the summary function to the function summarise_each() to produce the final Tiday data set.

> Final Tidy data set will be written into a .txt file named **"tidy_data_set.txt"** created with write.table() using row.name=FALSE.

##================================================================
## Codebook 
##================================================================
>Creating the codebook.md Markdown document is accomblished at the end of the script **run_analysis.R**. It has the for of

> - *  Old Code 1
> -   New code 1 used in the Tide data set
> - *  Old Code 2
> -   New code 2 used in the Tide data set
> - ....