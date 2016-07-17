
##extract column names
d1<-read.delim("Ds/features.txt",header = FALSE,sep = "")

##extract activity names
dta<-read.delim("Ds/activity_labels.txt",header = FALSE,sep = "")

##read the tables for the train dataset
dt1x<-read.delim("Ds/train/X_train.txt",header = FALSE,sep = "")
dt1y<-read.delim("Ds/train/y_train.txt",header = FALSE,sep = "")
dt1s<-read.delim("Ds/train/subject_train.txt",header = FALSE,sep = "")
##Merge dataset and get activity name
dt1ya<-merge(dt1y,dta,by.x = 1,by.y = 1,all.x = TRUE)
dt1ya[,1] <- NULL ##remove first column

##join the columns for activity and subject in train 
dt1t<-cbind(dt1ya,dt1s,dt1x)

##read the tables for the test dataset
dt2x<-read.delim("Ds/test/X_test.txt",header = FALSE,sep = "")
dt2y<-read.delim("Ds/test/y_test.txt",header = FALSE,sep = "")
dt2s<-read.delim("Ds/test/subject_test.txt",header = FALSE,sep = "")
##Merge dataset and get activity name
dt2ya<-merge(dt2y,dta,by.x = 1,by.y = 1,all.x = TRUE)
dt2ya[,1] <- NULL ##remove first column

##join the columns for activity and subject in test
dt2t<-cbind(dt2ya,dt2s,dt2x)

## join the test and train dataset 
dtt<-rbind(dt1t,dt2t)

##Select all the columns ending with mean() or std() from the column names db
to_extract<-grep("([Mm]ean\\(\\))|([Ss]td\\(\\))",d1[,2])

##add the two first columns (that were added at first) and move the column number to account for it
to_extract2c<-c(1,2,sapply(to_extract,function(x){x+2}))

##Selected Data
ds<-dtt[,to_extract2c]

##Generate column names
dscn<-c("Activity","Subject",as.character(d1[,2][to_extract]))

##assign column names to table, ds is our Tidy Dataset for point 4!!
colnames(ds)<-dscn

library(dplyr)

##here we create the dataset that takes the mean of each column, grouping by activity and subject
finalds<-ds %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))