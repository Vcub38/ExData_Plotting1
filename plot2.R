## set working directory to be the folder containing the raw data file, "household_power_consumption.txt"

## read data into R
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))
## subset data to only include data from February 1, 2007 and February 2, 2007
sdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
## Merge the Date and Time columns and convert the combined column to class POSIXct
DateTime <- as.POSIXct(paste(sdata$Date, sdata$Time), format = "%d/%m/%Y %H:%M:%S")
sdata <- sdata[,3:9]
sdata <- cbind(DateTime, sdata)

## re-create plot2 and save it to a PNG file
png(filename = "plot2.png", width = 480, height = 480)
plot(sdata$DateTime, sdata$Global_active_power, type = "n", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
lines(sdata$DateTime, sdata$Global_active_power, type = "l")
dev.off() 
