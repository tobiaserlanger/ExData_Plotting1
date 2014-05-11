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

##transform relevant variables into character
dataset[,3] <- as.character(dataset[,3])
dataset[,4] <- as.character(dataset[,4])
dataset[,5] <- as.character(dataset[,5])
dataset[,6] <- as.character(dataset[,6])
dataset[,7] <- as.character(dataset[,7])
dataset[,8] <- as.character(dataset[,8])
dataset[,9] <- as.character(dataset[,9])

##transform into numbers
dataset[,3] <- as.numeric(dataset[,3])
dataset[,4] <- as.numeric(dataset[,4])
dataset[,5] <- as.numeric(dataset[,5])
dataset[,6] <- as.numeric(dataset[,6])
dataset[,7] <- as.numeric(dataset[,7])
dataset[,8] <- as.numeric(dataset[,8])
dataset[,9] <- as.numeric(dataset[,9])

##define image name, type and dimensions
png("plot4.png", width = 480, height = 480) 

##parse graphical output area
par(mfcol = c(2, 2))

##generate top left plot
plot(dataset$DateTime, dataset$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power")

##generate bottom left plot (incl. curve and legend)
plot(dataset$DateTime, dataset$Sub_metering_1, type ="l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(dataset$DateTime, dataset$Sub_metering_2, col = "red")
lines(dataset$DateTime, dataset$Sub_metering_3, col = "blue")
legend("topright", box.col=NA, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black", "red", "blue"))

##generate top right plot
plot(dataset$DateTime, dataset$Voltage, type ="l", xlab = "daytime", ylab = "Voltage")

##generate top right plot
plot(dataset$DateTime, dataset$Global_reactive_power, type ="l", xlab = "daytime", ylab = "Global_reactive_power")

##safe file in working directory
dev.off()