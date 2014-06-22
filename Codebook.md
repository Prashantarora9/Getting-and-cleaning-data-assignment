The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean



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



