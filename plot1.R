## set working directory to be the folder containing the raw data file, "household_power_consumption.txt"

## read data into R
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = c("?"))
## subset data to only include data from February 1, 2007 and February 2, 2007
sdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
## Merge the Date and Time columns and convert the combined column to class POSIXct
DateTime <- as.POSIXct(paste(sdata$Date, sdata$Time), format = "%d/%m/%Y %H:%M:%S")
sdata <- sdata[,3:9]
sdata <- cbind(DateTime, sdata)

## re-create plot1 and save it to a PNG file
png(filename = "plot1.png", width = 480, height = 480)
hist(sdata$Global_active_power, freq = TRUE, col = "red", main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)", breaks = 11, xaxt = "n", yaxt = "n")
axis(side = 1, at = c(0, 2, 4, 6))
axis(side = 2, at = c(0, 200, 400, 600, 800, 1000, 1200))
dev.off()
