#Read and combine training set and test set.
train <- read.table("UCI HAR Dataset//train//X_train.txt")
test <- read.table("UCI HAR Dataset//test//X_test.txt")
xtt <- rbind(train,test)

#Read and combine training labels and test labels.
train <- read.table("UCI HAR Dataset//train//Y_train.txt")
test <- read.table("UCI HAR Dataset//test//Y_test.txt")
ytt <- rbind(train,test)
names(ytt) <- "activity"

#Read and combine training subject and test subject identities.
train <- read.table("UCI HAR Dataset//train/subject_train.txt")
test <- read.table("UCI HAR Dataset//test/subject_test.txt")
stt <- rbind(train,test)
names(stt) <- "subject"

#Load feature table and determine valid entries (mean/std).
features <- read.table("UCI HAR Dataset/features.txt")
indices_std <- grep("-std\\(\\)",features[,2])
indices_mean <- grep("-mean\\(\\)",features[,2])
indices_mean_std <- rbind(indices_mean,indices_std)

#Modify training and test set to only contain valid entries (mean/std).
xtt <- xtt[,indices_mean_std]

#Use parsed 'features' strings to define and assign meaningful names.
names(xtt) <- features[indices_mean_std,2]
names(xtt) <- gsub("\\(|\\)","",names(xtt))
names(xtt) <- gsub("\\-",".",names(xtt))
names(xtt) <- tolower(names(xtt))

#Replace activity number with activity name (label).
alabels <- read.table("UCI HAR Dataset/activity_labels.txt")
alabels[,2] <- gsub("\\_","",alabels[,2])
alabels[,2] <- tolower(alabels[,2])
ytt[,1] <- alabels[ytt[,1],2]

#Bind subject, activity, and cleaned data columns, then output to file.
clean <- cbind(stt,ytt,xtt)
write.table(clean,"clean_data.txt",row.name = FALSE)

usub <- unique(clean$subject)
nousub <- length(usub)
uact <- unique(clean$activity)
nouact <- length(uact)
mean_clean <- clean[1:(nousub*nouact),]

r <- 1

for (subject in usub) {
     for (activity in uact) {
          temp <- clean[clean$subject==subject & clean$activity==activity,]          
          temp <- colMeans(temp[3:length(temp)])
          mean_clean$subject[r] <- subject
          mean_clean$activity[r] <- activity
          mean_clean[r,3:length(mean_clean)] <- temp
          r <- r + 1
     }    
}

write.table(mean_clean,"mean_clean.txt",row.name = FALSE)
rm(list = ls())
