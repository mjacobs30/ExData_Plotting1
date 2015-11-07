plot4 <- function (){
      
      # Set dates and times
      firstDateTime <- strptime("2006-12-16 17:24:00", "%Y-%m-%d %H:%M:%S")
      beginDateTime <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
      
      # Calculate which lines to read in
      begin <- beginDateTime - firstDateTime
      beginLine <- as.numeric(begin) * 24 * 60 # first line to read in
      numLines <- 48 * 60 # total number of minutes in 48 hours, total number of rows to read in
      
      #read subset of data
      plot4data <- read.table("./data/household_power_consumption.txt", sep=";",header=TRUE, 
                              skip = beginLine, na.strings = "?",nrows=numLines,
                              colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                              col.names = c("Date","Time","Global_active_power","Global_reactive_power",
                                            "Voltage","Global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))
      
      library(lubridate)
      dateTime <- dmy_hms(paste(plot4data$Date, plot4data$Time))
      plot4data <- cbind(dateTime, plot4data)
      
      #set par functions
      par(mfrow=c(2,2), mar=c(4,4,1,1), oma=c(0,0,2,0))
      
      #plots
      with(plot4data,plot(dateTime,Global_active_power, ylab="Global Active Power",xlab="", type="l"))
      with(plot4data,plot(dateTime, Voltage, type="l"))
      with(plot4data, plot(dateTime,sub_metering_1,xlab="",ylab="Energy sub metering", 
                           type="l",lty=c(1,1)))
      with(plot4data, lines(dateTime,sub_metering_2,col="red"))
      with(plot4data, lines(dateTime,sub_metering_3,col="blue"))
      legend("topright", legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), lwd=1, 
             col=(c("black","red","blue")), bty="n", cex=.7)
      with(plot4data,plot(dateTime, Global_reactive_power, type="l"))
      
      #create png
      dev.copy(png, file="Plot4.png",width=480,height=480)
      dev.off()
      
}