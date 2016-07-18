
##extract column names
d1<-read.delim("UCI HAR Dataset/features.txt",header = FALSE,sep = "")

##extract activity names
dta<-read.delim("UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = "")
colnames(dta)<-c("Activity Number","Activity")

##read the tables for the train dataset
dt1x<-read.delim("UCI HAR Dataset/train/X_train.txt",header = FALSE,sep = "")
dt1y<-read.delim("UCI HAR Dataset/train/y_train.txt",header = FALSE,sep = "")
dt1s<-read.delim("UCI HAR Dataset/train/subject_train.txt",header = FALSE,sep = "")
##join the columns for activity and subject in train 
dt1t<-cbind(dt1y,dt1s,dt1x)
##change column names so they arent repeated
colnames(dt1t)[1:2]<-c("ac","sub")

##read the tables for the test dataset
dt2x<-read.delim("UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "")
dt2y<-read.delim("UCI HAR Dataset/test/y_test.txt",header = FALSE,sep = "")
dt2s<-read.delim("UCI HAR Dataset/test/subject_test.txt",header = FALSE,sep = "")
##join the columns for activity and subject in test
dt2t<-cbind(dt2y,dt2s,dt2x)
##change column names so they arent repeated
colnames(dt2t)[1:2]<-c("ac","sub")

## join the test and train dataset 
dtt<-rbind(dt1t,dt2t)

##Merge dataset and get activity name
dtta<-merge(dtt,dta,by.x = "ac",by.y = "Activity Number",all.x = TRUE)
dtta[,1] <- NULL ##remove first column (the activity number)
dtta<-cbind(dtta[,"Activity"],dtta[,names(dtta) != "Activity"]) ##Put the Activity column first

##Select all the columns ending with mean() or std() from the column names db
to_extract<-grep("([Mm]ean\\(\\))|([Ss]td\\(\\))",d1[,2])

##add the two first columns (that were added at first) and move the column number to account for it
to_extract2c<-c(1,2,sapply(to_extract,function(x){x+2}))

##Selected Data
ds<-dtta[,to_extract2c]

##Generate column names
dscn<-c("Activity","Subject",as.character(d1[,2][to_extract]))

##assign column names to table, ds is our Tidy Dataset for point 4!!
colnames(ds)<-dscn

library(dplyr)

##here we create the dataset that takes the mean of each column, grouping by activity and subject
finalds<-ds %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))

##remove intermediate dataset to clean up
rm(d1,dta,dt1x,dt1y,dt1s,dt1t,dt2x,dt2y,dt2s,dt2t,dtt,to_extract,to_extract2c,dscn,dtta)

##generates output in TXT
write.table(finalds, "FinalDS.txt",row.names = FALSE)