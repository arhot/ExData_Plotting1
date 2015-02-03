## Download data file, unzip and use the sqldf package the handily read the needed rows.
## Couldn't get read.csv.sql to work with reading the zip file directly (works with read.table)?

library(sqldf)
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, temp)
unzip(temp, "household_power_consumption.txt")
powerdata <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"', header=TRUE, sep=";")

## Convert to date and time
powerdata$Datetime <- as.POSIXct(paste(powerdata$Date,powerdata$Time),
                                 format="%d/%m/%Y %H:%M:%S")

## Set location so names of days are English

Sys.setlocale("LC_TIME", "English")
## Do the first time plot as a line plot 
png("plot2.png", width=480, height = 480)
plot(powerdata$Datetime, powerdata$Global_active_power, 
     type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()