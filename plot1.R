# Read the data
# with semicolon as separator and missing values as "?"
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Convert Date and Time variables
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- as.character(data$Time)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Subset the data for 2007-02-01 and 2007-02-02
subset_data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

# Create a histogram of Global_active_power
hist(subset_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Close the PNG device - this finalizes the PNG file
dev.off()