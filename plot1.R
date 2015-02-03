## Download data file, unzip and use the sqldf package the handily read the needed rows.
## Couldn't get read.csv.sql to work with reading the zip file directly (works with read.table)?

library(sqldf)
temp <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, temp)
unzip(temp, "household_power_consumption.txt")
powerdata <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"', header=TRUE, sep=";")

## Plot a histogram as required to file.

png("plot1.png", width=480, height = 480)
hist(powerdata$Global_active_power, col="RED", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", 
     main="Global Active Power")
dev.off()
