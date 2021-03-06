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


#second plot
par(mfrow = c(1,1))
png(filename = "plot2.png", width = 480, height = 480)
plot(DF$DateTime, DF$Global_active_power, typ = "l", col = "black", ann = FALSE)
title( ylab = "Global Active Power (kilowatts)")
dev.off()
