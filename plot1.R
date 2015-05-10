#read the required data using sqldf package
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

png("plot1.png")

#plot 1: Histogram of Global active power


hist(powerdata$Global_active_power, col="orange", main="Global Active Power", 
     xlab="Global Active Power(Kilowatts)")

dev.off()