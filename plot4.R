#read the required data using sqldf package
#assign path to the dataset to a variable called power and assign power to file.
#Note the dataset "household_power_consumption.txt" must be in a subdirectory called data
#in the working directory.

power <-"./data/household_power_consumption.txt"

file <- file(power)

#select only the data for the two dates. As there are no missing values did not
#indicate how to read the missing value


library(sqldf)

powerdata <- sqldf("select * from file where Date in ('1/2/2007','2/2/2007')",
                   file.format = list(header = TRUE, sep = ";"))

# close the connection
close(file)


#create a new vairable  called DateTime by pasting Date and Time 
# and then using strptime

powerdata$DateTime<-paste(powerdata$Date, powerdata$Time)
powerdata$DateTime<-strptime(powerdata$DateTime, format='%d/%m/%Y %H:%M:%S')
powerdata$dayofweek<-weekdays(powerdata$DateTime)

png("plot4.png")


#divide page up two columns and two row sections
par(mfrow=c(2,2))

#DateTime vs Global_active_power
plot( powerdata$DateTime, powerdata$Global_active_power, type='l', xlab="",
      ylab="Global Active Power(Kilowatts)")

#DateTime vs. Voltage
plot( powerdata$DateTime, powerdata$Voltage, type='l', xlab="DateTime",
      ylab="Voltage")

#DateTime vs submetering

plot(powerdata$DateTime, powerdata$Sub_metering_1,  type="l", col="black",  ylab="Energy Sub Metering",
     xlab="")
lines( powerdata$DateTime,powerdata$Sub_metering_2, type="l", col="red")

lines(powerdata$DateTime,powerdata$Sub_metering_3, type="l", col="blue")

legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=0.5,
       col=c("black", "red", "blue"),cex=0.75, bty="n")

#Datetime vs Global_reactive_power
plot( powerdata$DateTime, powerdata$Global_reactive_power, type='l', xlab="DateTime",
      ylab="Global_reactive_power")


dev.off()