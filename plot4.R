fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
library(data.table)
library(sqldf)
library(lubridate)
download.file(fileURL, temp)

# selecting subset of data by using SQL request (only values with 1/2/07 and 2/2/07 Date)
DF <- read.csv.sql("household_power_consumption.txt", 
                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep = ";")
#transforming string Date and Time to one Date row with POSIXlt date type
DF$DateTime <- strptime(paste(DF$Date,DF$Time), "%d/%m/%Y %H:%M:%S" )

#fourth chart
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
#1
plot(DF$DateTime, DF$Global_active_power, typ = "l", 
     col = "black", ylab = "Global Active Power", xlab = "datetime")
#2
plot(DF$DateTime, DF$Voltage, typ = "l", col = "black", ylab = "Voltage", xlab = "datetime")
#3
plot(DF$DateTime, DF$Sub_metering_1, typ = "l", col = "black", ann = FALSE)
lines(DF$DateTime, DF$Sub_metering_2, typ = "l", col = "red")
lines(DF$DateTime, DF$Sub_metering_3, typ = "l", col = "blue")
title( ylab = "Energy sub metering")
legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col=c("black","red","blue"), lwd=1, lty=c(1,1,1) , bty = "n" )
#4
plot(DF$DateTime, DF$Global_reactive_power, typ = "l", 
     col = "black", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
unlink("household_power_consumption.txt")
unlink(temp)
