#instructions:
## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

if (!require("plyr")) {
        install.packages("plyr")
}

require("plyr")

## descargamos fichero
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
## descomprimimos
unzip(zipfile="./data/Dataset.zip",exdir="./data")
## guardamos el path
ruta <- file.path("./data" , "UCI HAR Dataset")
## cargamos la informacion de actividades
testActivity  <- read.table(file.path(ruta, "test" , "Y_test.txt" ),header = FALSE)
trainActivity <- read.table(file.path(ruta, "train", "Y_train.txt"),header = FALSE)
## cargamos la informacion de los sujetos
testSubject  <- read.table(file.path(ruta, "test" , "subject_test.txt"),header = FALSE)
trainSubject <- read.table(file.path(ruta, "train", "subject_train.txt"),header = FALSE)
## cargamos las mediciones
testData  <- read.table(file.path(ruta, "test" , "X_test.txt" ),header = FALSE)
trainData <- read.table(file.path(ruta, "train", "X_train.txt"),header = FALSE)
## juntamos la informacion de test y train
subject <- rbind(trainSubject, testSubject)
activity<- rbind(trainSubject, testSubject)
feature<- rbind(trainData, testData)
## añadimos los nombres a todos los datasets
names(subject)<-c("subject")
names(activity)<- c("activity")
dataFeaturesNames <- read.table(file.path(ruta, "features.txt"),head=FALSE)
names(feature)<- dataFeaturesNames$V2
#juntamos toda la información en un solo data frame
combina <- cbind(subject, activity)
datos <- cbind(feature, combina)

# obtenemos los nombres de las columnas que nos interesan
subdataFeatures<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#obtenemos solo la información de las medias y las desviaciones
selectedNames<-c(as.character(subdataFeatures), "subject", "activity" )
datos<-subset(datos,select=selectedNames)
# arreglamos un poco los nombres:
names(datos)<-gsub("^t", "time", names(datos))
names(datos)<-gsub("^f", "frequency", names(datos))
names(datos)<-gsub("Acc", "Accelerometer", names(datos))
names(datos)<-gsub("Gyro", "Gyroscope", names(datos))
names(datos)<-gsub("Mag", "Magnitude", names(datos))
names(datos)<-gsub("BodyBody", "Body", names(datos))
# escribimos un segundo dataSet
library(plyr);
Data2<-aggregate(. ~subject + activity, datos, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)