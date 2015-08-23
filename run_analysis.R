##================================================================
## Task # 1:##
## Merges the training and the test sets to create one data set.
##================================================================
##  Steps to Make one data set out of the training  and testing data sets
## Appending testing data after training data
## --------------
## training data set
## --------------
## Read file X_test.txt
train_data <- read.table("X_train.txt")
## Read the data lables from the file features.txt
lables <- read.table("features.txt")
names(train_data) <- lables[,2]
## Add the data in subject_test.txt as a New column in test_data.txt called "Subject"
train_subjects <- read.table("subject_train.txt", col.names=c("Subject"))
train_data <-cbind(train_data, train_subjects)
## Add the data in y_test.txt as a new column in test_data.txt called "Activity"
train_activities <- read.table("y_train.txt", col.names=c("Activity"))
train_data <-cbind(train_data, train_activities)
write.table(train_data, file="./final_data.csv", row.names=FALSE, sep=",")

## --------------
## test data set
## --------------
## Read file X_test.txt
test_data <- read.table("X_test.txt")
## Reda the data lables from the file features.txt
lables <- read.table("features.txt")
names(test_data) <- lables[,2]
## Add the data in subject_test.txt as a New column in test_data.txt called "Subject"
test_subjects <- read.table("subject_test.txt", col.names=c("Subject"))
test_data <-cbind(test_data, test_subjects)
## Add the data in y_test.txt as a new column in test_data.txt called "Activity"
test_activities <- read.table("y_test.txt", col.names=c("Activity"))
test_data <-cbind(test_data, test_activities)
write.table(test_data, file="./final_data.csv", sep=",", row.names=FALSE, append=TRUE, col.names=FALSE)

## Now reading in the final combined data set
final_data_set <- read.csv("./final_data.csv")
##
##================================================================
## Task # 2:
## Extracts only the measurements on the mean and standard deviation for each measurement. 
##================================================================
mean_std_df <- final_data_set[, c(colnames(final_data_set)[grep("mean|std", 
    colnames(final_data_set))], "Subject", "Activity")]

## As a result of using "write.table()" for merging the training and testing data sets 
## as explaind above, Column titles were automatically transferme where all characters:
## "("
## ")"
## "-"
## ","
## were replaced with (.). Following transoformations were carried to make the column names
## more readable
mean_std_df_cols <- colnames(mean_std_df)
mean_std_df_cols <- gsub(x=mean_std_df_cols, pattern="...", replacement="_", fixed=TRUE) 
mean_std_df_cols <- gsub(x=mean_std_df_cols, pattern="..",  replacement="", fixed=TRUE) 
mean_std_df_cols <- gsub(x=mean_std_df_cols, pattern=".",   replacement="_", fixed=TRUE) 
names(mean_std_df) <- mean_std_df_cols
##
##
##================================================================
## Task # 3:
## Uses descriptive activity names to name the activities in the data set 
##================================================================
## First pull the column "Activity" and transform its values
Activity_col_c <- as.character(mean_std_df[,"Activity"])
Activity_col_c <- gsub(x=Activity_col_c, pattern="1", replacement="WALKING", fixed=TRUE) 
Activity_col_c <- gsub(x=Activity_col_c, pattern="2", replacement="WALKING_UPSTAIRS", fixed=TRUE) 
Activity_col_c <- gsub(x=Activity_col_c, pattern="3", replacement="WALKING_DOWNSTAIRS", fixed=TRUE) 
Activity_col_c <- gsub(x=Activity_col_c, pattern="4", replacement="SITTING", fixed=TRUE) 
Activity_col_c <- gsub(x=Activity_col_c, pattern="5", replacement="STANDING", fixed=TRUE) 
Activity_col_c <- gsub(x=Activity_col_c, pattern="6", replacement="LAYING", fixed=TRUE) 
## Now put the colun bac into the data frame replacing the exiting "Activity" column
New_data_frame <- select(mean_std_df, -(Subject:Activity))
New_data_frame <-cbind(New_data_frame, Activity=Activity_col_c)
New_data_frame <-cbind(New_data_frame, Subject=mean_std_df[,"Subject"])
##
##
##================================================================
## Task # 4:
## Appropriately labels the data set with descriptive variable names.  
##================================================================
col_names <- names(New_data_frame)
col_names <- gsub(x=col_names, pattern="BodyBody", replacement="Body_", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="Body", replacement="_Body_", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="Gyro", replacement="Gyroscope", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="Acc", replacement="_Acceleration_", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="Mag", replacement="Magnitude", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="Jerk", replacement="_Jerk_", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="std", replacement="StdDev", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="mean", replacement="Mean", fixed=TRUE)
col_names <- gsub(x=col_names, pattern="__", replacement="_", fixed=TRUE)

##Now we need to put the column names back into the data set
names(New_data_frame) <- col_names
#
#
##================================================================
## Task # 5:
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject..  
##================================================================
#
## group the data according to "Subject" column then "Activity" column
New_data_frame_grp <- group_by(New_data_frame, Subject, Activity)
## Now summarize the data. Use the Mean() function on all columns
New_data_frame_grp_sum <- summarise_each(New_data_frame_grp, 
        funs(mean), 
        vars=-c(Activity, Subject))
## Write the Final Tidy data set into a .txt file named "tidy_data_set.txt"
write.table(New_data_frame_grp_sum, file="./tidy_data_set.txt", row.names=FALSE)
#
#
##================================================================
## Creating the Code Book
##================================================================
orig_col_names <- c("Subject", "Activity", 
    colnames(test_data)[grep("mean|std", colnames(test_data))])
Modified_col_names <- names(New_data_frame_grp_sum)
codebook <- paste("* ",orig_col_names,"\n",Modified_col_names,"\n")
write.table(codebook, "codebook.md", quote = FALSE, row.names = FALSE, col.names = FALSE)