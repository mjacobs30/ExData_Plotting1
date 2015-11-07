plot3 <- function (){
      
      # Set dates and times
      firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
      beginDateTime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
      
      # Calculate which lines to read in
      begin <- beginDateTime - firstDateTime
      beginLine <- as.numeric(begin) * 24 * 60 # first line to read in
      numLines <- 48 * 60 # total number of minutes in 48 hours, total number of rows to read in
      
      #read subset of data
      plot3data <- read.table("./data/household_power_consumption.txt", sep=";",header=TRUE, 
                              skip = beginLine, na.strings = "?",nrows=numLines,
                              colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                              col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                            "Voltage","Global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))
      
      library(lubridate)
      dateTime <- dmy_hms(paste(plot3data$Date, plot3data$Time))
      plot3data <- cbind(dateTime, plot3data)
      
      
      
      #plot graph
      with(plot3data, plot(dateTime,sub_metering_1,xlab="",ylab="Energy sub metering", 
                           type="l",lty=c(1,1)))
      with(plot3data, lines(dateTime,sub_metering_2,col="red"))
      with(plot3data, lines(dateTime,sub_metering_3,col="blue"))
      legend("topright", legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), lwd=1, 
             col=(c("black","red","blue")))
           
      dev.copy(png, file="Plot3.png",width=480,height=480)
      dev.off()
      
}