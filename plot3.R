r# Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Convert Date and Time variables
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Subset the data for 2007-02-01 and 2007-02-02, extending to 2007-02-03 for correct labeling
subset_data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

# Open a PNG device
png(filename = "plot3.png", 
    width = 480, height = 480, units = "px", 
    bg = "white")

# Create an empty plot for Energy Sub Metering with correct axes
plot(subset_data$DateTime, subset_data$Sub_metering_1, 
     type = "n",  # Set up plot without plotting points yet
     xlab = "",
     ylab = "Energy Sub Metering",
     xaxt = "n")  # Suppress default x-axis

# Add lines for each sub-metering in different colors
lines(subset_data$DateTime, subset_data$Sub_metering_1, col = "black")
lines(subset_data$DateTime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col = "blue")

# Define specific tick positions for Thu, Fri, and Sat
tick_positions <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"), format = "%Y-%m-%d")

# Add x-axis with day labels
axis(1, at = tick_positions, labels = c("Thu", "Fri", "Sat"))

# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# Close the PNG device
dev.off()

