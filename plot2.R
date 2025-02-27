# Read the data
# with semicolon as separator and missing values as "?"
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Convert Date and Time variables
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- as.character(data$Time)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Subset the data for 2007-02-01 and 2007-02-02
subset_data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

# Open a PNG device
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")

# Create a time series plot with custom x-axis
plot(subset_data$DateTime, subset_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")  # Suppress default x-axis

# Define specific tick positions (midnight of each day)
tick_positions <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"), format = "%Y-%m-%d")

# Add x-axis with specific labels
axis(1, at = tick_positions, labels = c("Thu", "Fri", "Sat"))

# Close the PNG device
dev.off()

