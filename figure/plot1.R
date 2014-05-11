##install and select lubridate packages
install.packages("lubridate")
library(lubridate)

##import csv-file
fullDataset <- read.csv("household_power_consumption.txt", sep=";") 

##paste Date and Time columns 
fullDataset$DateTime <- paste(fullDataset$Date, fullDataset$Time) 
##convert date and time
fullDataset$DateTime <- strptime(fullDataset$DateTime, "%d/%m/%Y %H:%M:%S") 

##generate time intervall
start <- as.POSIXct("2007-02-01 00:00:00") 
end <- as.POSIXct("2007-02-02 23:59:59")
int <- new_interval(start, end)

##subset time interval
dataset <- fullDataset[fullDataset$DateTime %within% int, ]

##transform into character
dataset[,3] <- as.character(dataset[,3])
##transform into numbers
dataset[,3] <- as.numeric(dataset[,3]) 

##define image name, type and dimensions
png("plot1.png", width = 480, height = 480) 
##generate plot
hist(dataset$Global_active_power, col = "red", main ="Global Active Power",
     xlab = "Global Active Power (kilowatts)")

##safe file in working directory
dev.off()