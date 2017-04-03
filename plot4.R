#
# Make plot4.png for Course 4 Week 1 Assignment
#

# Download file into current working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
download.file(url, destfile)

# Read the 02/01/2007 and 02/02/2007 data in the .txt (csv format) inside the zip file
unzip(destfile)
dataset <- read.csv(file = "household_power_consumption.txt",skip=66637,nrows=2880, sep=";",header = FALSE,
                    col.names = c(
                        "Date",
                        "Time",
                        "Global_active_power",
                        "Global_reactive_power",
                        "Voltage",
                        "Global_intensity",
                        "Sub_metering_1",
                        "Sub_metering_2",
                        "Sub_metering_3")
                   )

dataset$Date <- as.character(dataset$Date)
dataset$Time <- as.character(dataset$Time)

# Clean memory and files
file.remove(destfile,"household_power_consumption.txt")

# Convert the Date and Time variables to Date/Time classes
dataset$Time <- strptime(paste(dataset$Date,dataset$Time),format = "%d/%m/%Y %H:%M:%S", tz = "")
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y" )

# Make panel plots
png(filename = "plot4.png",width = 480, height = 480)

par(mfrow=c(2,2))

plot(dataset$Time, dataset$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")

plot(dataset$Time, dataset$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

plot(dataset$Time, dataset$Sub_metering_1,type="l", col="black",xlab = "",ylab="")
lines(dataset$Time, dataset$Sub_metering_2,type="l", col="red")
lines(dataset$Time, dataset$Sub_metering_3,type="l", col="blue")
title(xlab = "", ylab = "Energy sub metering")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

plot(dataset$Time, dataset$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()





