# Change file name to powerData.txt
file <- "./data/powerData.txt"

# Search the first line for "2/1/2007" 
grep("1/2/2007", readLines(file))[1]
#[1] 66638

# The target is on line 66638.
# Calculate the number of rows for two days by one minute
# 60 minutes * 48 hours = 2880

# Read the data for the portion of 1/2/2007 ~ 2/2/2007, based on the above data
powerData <- read.csv("./data/powerData.txt", sep = ";",  header = FALSE, skip= 66637, nrows = 2880, na.strings ="?")

# Add column names
colnames(powerData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage",
	                         "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Adjust system local time in English
Sys.setlocale("LC_TIME", "C")

# Convert Date column value to as.Date( ) format 
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")

# Combine Date and Time columns into DateTime column
DateTime <- paste(powerData$Date, powerData$Time, sep=" ")
powerData$DateTime <- as.POSIXct(DateTime)

# Plot line chart and save it as plot3.png.
png(filename = "plot3.png", width = 480, height = 480, bg ="white")
par(mar = c(6,6,2,2))

   with(powerData, {
   plot(Sub_metering_1 ~ DateTime, type ="l", ylab = "Energy sub metering", xlab="")
   lines(Sub_metering_2 ~ DateTime, col ="red")
   lines(Sub_metering_3 ~ DateTime, col="blue")})
   legend("topright", col=c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),  lty = 1, lwd =1)

# Close the graphic device
dev.off()
# End(Not run)
