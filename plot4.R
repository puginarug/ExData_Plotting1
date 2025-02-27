# Read the data
data <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Convert Date and Time variables
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Subset the data for 2007-02-01 and 2007-02-02, extending to 2007-02-03 for correct labeling
subset_data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

# Open a PNG device
png(filename = "plot4.png", 
    width = 480, height = 480, units = "px", 
    bg = "white")

# Set up 2x2 grid layout
par(mfcol = c(2, 2))

# ---- PLOT 1: Global Active Power ----
plot(subset_data$DateTime, subset_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), 
     labels = c("Thu", "Fri", "Sat"))

# ---- PLOT 2: Energy Sub Metering ----
plot(subset_data$DateTime, subset_data$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy Sub Metering",
     xaxt = "n")
lines(subset_data$DateTime, subset_data$Sub_metering_1, col = "black")
lines(subset_data$DateTime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col = "blue")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), 
     labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub 1", "Sub 2", "Sub 3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# ---- PLOT 3: Voltage ----
plot(subset_data$DateTime, subset_data$Voltage, 
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n",
     col = "black")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), 
     labels = c("Thu", "Fri", "Sat"))

# ---- PLOT 4: Global Reactive Power ----
plot(subset_data$DateTime, subset_data$Global_reactive_power, 
     type = "l",
     xlab = "datetime",
     ylab = "Global Reactive Power",
     xaxt = "n",
     col = "black")
axis(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")), 
     labels = c("Thu", "Fri", "Sat"))

# Close the PNG device
dev.off()

# Print confirmation message
cat("Plot saved as 'four_panel_plot.png'\n")


