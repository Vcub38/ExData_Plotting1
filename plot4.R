## set working directory to be the folder containing the raw data file, "household_power_consumption.txt"

## read data into R
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))
## subset data to only include data from February 1, 2007 and February 2, 2007
sdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
## Merge the Date and Time columns and convert the combined column to class POSIXct
DateTime <- as.POSIXct(paste(sdata$Date, sdata$Time), format = "%d/%m/%Y %H:%M:%S")
sdata <- sdata[,3:9]
sdata <- cbind(DateTime, sdata)

## re-create plot4 and save it to a PNG file
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

  ## re-create the plot in the top left position
plot(sdata$DateTime, sdata$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(sdata$DateTime, sdata$Global_active_power, type = "l")

  ## re-create the plot in the top right position
plot(sdata$DateTime, sdata$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(sdata$DateTime, sdata$Voltage, type = "l")

 ## re-create the plot in the bottom left position
plot(sdata$DateTime, sdata$Sub_metering_1, type = "n", xlab = "", 
     ylab = "Energy sub metering")
lines(sdata$DateTime, sdata$Sub_metering_1, type = "l", col = "black", lty = 1)
lines(sdata$DateTime, sdata$Sub_metering_2, type = "l", col = "red", lty = 1)
lines(sdata$DateTime, sdata$Sub_metering_3, type = "l", col = "blue", lty = 1)
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), bty = "n", cex = 0.9, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  ## re-create the plot in the bottom right position
plot(sdata$DateTime, sdata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",
     type = "n")
lines(sdata$DateTime, sdata$Global_reactive_power, type = "l")

dev.off()
