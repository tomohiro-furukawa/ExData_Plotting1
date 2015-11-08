plot3 <- function() {
  # sets the locale to 'English' so that the plot will not contain local characters
  Sys.setlocale( "LC_ALL", "English" )
  
  # read data frame from the file
  data <- read.table(
    file="household_power_consumption.txt",
    sep=";",
    header=TRUE,
    stringsAsFactors=FALSE
  )
  # choose data of Feb 1, 2007 and Feb 2, 2007 only
  data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
  # convert data type from Factor to numeric
  data$Global_active_power <- as.numeric( data$Global_active_power )
  data$Global_reactive_power <- as.numeric( data$Global_reactive_power )
  data$Voltage <- as.numeric( data$Voltage )
  data$Global_intensity <- as.numeric( data$Global_intensity )
  data$Sub_metering_1 <- as.numeric( data$Sub_metering_1 )
  data$Sub_metering_2 <- as.numeric( data$Sub_metering_2 )
  data$Sub_metering_3 <- as.numeric( data$Sub_metering_3 )
  # add a new column 'datetime'
  data$datetime <- strptime(
    paste(data$Date, data$Time ),
    "%d/%m/%Y %H:%M:%S",
    tz="UTC"
  )
  
  # set up the device
  png( filename="plot3.png", width=480, height=480, units="px" )
  
  # plot
  plot(
    data$datetime,
    data$Sub_metering_1,
    type="n",
    xlab="",
    ylab="Energy sub metering"
  )
  lines( data$datetime, data$Sub_metering_1, col="black" )
  lines( data$datetime, data$Sub_metering_2, col="red" )
  lines( data$datetime, data$Sub_metering_3, col="blue" )
  legend(
    "topright",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col=c("black", "red", "blue"),
    lty=1
  )
  
  # clear the device
  invisible( dev.off() )
}
