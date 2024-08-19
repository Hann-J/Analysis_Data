library(datasets)
library(dplyr)

activity_data <- read.delim("./activity_labels.txt", header=FALSE, sep = "",
                            col.names = c("Activity.ID", "Activity"))

features <- read.table("./features.txt", col.names = c("Function.ID", "Functions"))

training_data <- read.table("./train/X_train.txt", col.names = features$Functions)
training_label <- read.table("./train/Y_train.txt", col.names = "Activity.ID")
training_subject <- read.table("./train/subject_train.txt", col.names = "Subject.ID")

test_data <- read.table("./test/X_test.txt", col.names = features$Functions)
test_label <- read.table("./test/Y_test.txt", col.names = "Activity.ID")
test_subject <- read.table("./test/subject_test.txt", col.names = "Subject.ID")

table_data <- rbind(training_data, test_data)
table_label <- rbind(training_label, test_label)
table_subject <- rbind(training_subject, test_subject)

table <- cbind(table_data, table_label, table_subject)

table <- merge(table, activity_data, by = "Activity.ID")
table$Subject.ID <- as.numeric(table$Subject.ID)

table_2 <- table %>%
  select(contains("mean"), contains("std"))

table_2

table <- table %>%
  select(contains("mean"), contains("std"), Subject.ID, Activity)

names(table) <- gsub("^t", "Time", names(table))
names(table) <- gsub("Acc", "Accelerometer", names(table))
names(table) <- gsub("Gyro", "Gyroscope", names(table))
names(table) <- gsub("^f", "Frequency", names(table))
names(table) <- gsub("tBody", "TimeBody", names(table))
names(table) <- gsub("BodyBody", "Body", names(table))
names(table) <- gsub("Mag", "Magnitude", names(table))

table_3 <- table %>%
  group_by(Subject.ID, Activity) %>%
  summarise_all(list(mean = mean), na.rm = TRUE)

write.table(table_3, "final_table.txt", row.name = FALSE)

