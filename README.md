# READ-ME: Analysis Project
This is a readme to explain the code in run_analysis.R

The datasets are retrieved from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

First, we read the activity file, separating them into corresponding "Activity.ID" that maps to each individual "Activity". We then do the same with features file, corresponding "Function.ID" to "Functions".

Then, we start reading the training files. The training data (X_train) can be split into different columns using the "Functions" subset. The training label (Y_train) represents the type of activity. The training subject (subject_train) represents the subjects.

We do the same for test files.

Then, we can add all the files read using rbind() and cbind(). Be careful to add them in correct order, so that the column rows correspond correctly to each other. This table is saved as table.

We merge the table with activity by "Activity.ID". We also change the Subject.ID to numeric

table_2 contains the table with columns having only means and std, using contains() function

table contains only mean, std, Subject.ID and activity, to allow us to proceed to the next steps.

Using names() we can return the col names. We then use gsub() to change the column names to appropriate names so that it makes it easier to understand. 

table is now grouped by subject.ID and Activity, wheere we summarise all the mean and std columns, removing any na values if any. This is saved to table_3

Finally, we use write.table() to save the table into a txt which is the output of this analysis.
