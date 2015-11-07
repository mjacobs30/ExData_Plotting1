plot2 <- function (){
      
      # Set dates and times
      firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
      beginDateTime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
      
      # Calculate which lines to read in
      begin <- beginDateTime - firstDateTime
      beginLine <- as.numeric(begin) * 24 * 60 # first line to read in
      numLines <- 48 * 60 # total number of minutes in 48 hours, total number of rows to read in
      
      #read subset of data
      plot2data <- read.table("./data/household_power_consumption.txt", sep=";",header=TRUE, 
                              skip = beginLine, na.strings = "?",nrows=numLines,
                              colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                              col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                            "Voltage","Global_intensity","sub_metering_1","Sub_metering_2","Sub_metering_3"))
      
      library(lubridate)
      dateTime <- dmy_hms(paste(plot2data$Date, plot2data$Time))
      plot2data <- cbind(dateTime, plot2data)
      
      
      
      #plot graph
      with(plot2data, plot(dateTime,Global_active_power, ylab="Global Active Power (kilowatts)",xlab="", pch=27, type="o"))
      
      
      dev.copy(png, file="Plot2.png", ,width=480,height=480)
      dev.off()
      
      
      
}