Getting-and-cleaning-data-assignment
====================================


#uploading the datasets

test <- read.table( paste(getwd(),"/","X_test.txt", sep=""), header= FALSE)

subject_test <- read.table(paste(getwd(),"/","subject_test.txt", sep=""), header= FALSE)

y_test <- read.table(paste(getwd(),"/","y_test.txt", sep=""), header= FALSE)



train <- read.table(paste(getwd(),"/","X_train.txt", sep=""), header= FALSE)

subject_train <- read.table(paste(getwd(),"/","subject_train.txt", sep=""), header= FALSE)

y_train <- read.table(paste(getwd(),"/","y_train.txt", sep=""), header= FALSE)


Features <- read.table(paste(getwd(),"/","features.txt", sep=""), header= FALSE)

activity_lables <- read.table(paste(getwd(),"/","activity_labels.txt", sep=""), header= FALSE)

#merging train and test dataset

Dataset <- rbind(test, train)

Features_transformed <- t(Features)

names(Dataset) <- Features_transformed[2,]

#filtering only mean and std columns

Req_col<- setdiff(grep("mean|std",colnames(Dataset)), grep("meanFreq()",colnames(Dataset)))

#subsetingn the data

Dataset_w_mean_SD <- Dataset[,Req_col]

subject <- rbind(subject_test,subject_train)

activity <- rbind(y_test,y_train)

dataset_w_mean_SD_v1 <- cbind(F_d,subject,activity)

colnames(dataset_w_mean_SD_v1)[67]<- "Subject"

colnames(dataset_w_mean_SD_v1)[68]<- "Activity label"


colnames(activity_lables)[1]<- "Activity label"

colnames(activity_lables)[2]<- "Activity"

# merging activitylabel to the dataset

Final_ds_01 <-  merge(x= dataset_w_mean_SD_v1, y= activity_lables ,by = "Activity label" , all = TRUE)

Final_data_with_req_col <- Final_ds_01[,c(2:69)]

library(reshape)

#Melt and cast functions to summarize the dataset in the required format

Molten <- melt(Final_data_with_req_col, id.vars = c("Activity", "Subject"))
Tidydataset <- cast(data= Molten, fun = mean)

#writing it to a text file

write.table(Tidydataset, file = "Tidy dataset.txt")


#testing on a sample
Test <- subset(Final_ds_02, Activity== "STANDING" & Subject == 1)

mean(Test[,2])




