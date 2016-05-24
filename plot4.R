library(plyr)
library(dplyr)
library(tidyr)
library(data.table)
library(lubridate) 

data <- read.table(unzip('data.zip'), header=T, na.strings='?', sep=';') 
df <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')

dates <- as.character(df$Date)
times <- as.character(df$Time)
names <- make.names(colnames(df))

df <- mutate(df, Timestamp = paste(dates, times)) %>% select(-Date, -Time)
df$Timestamp <- strptime(df$Timestamp, format="%d/%m/%Y %H:%M:%S")

#PLOT 4
png(filename="Plot 4.png")
par(mfrow=c(2,2))
#left top
with(df, plot(Timestamp, Global_active_power, type='l', main="", ylab="Global Active Power", xlab=""))
#right top
with(df, plot(Timestamp, Voltage, type='l', main="", ylab="Voltage", xlab="datetime"))
#left bottom
with(df, plot(Timestamp, Sub_metering_1, type='l', main="", ylab="Energy sub metering", xlab=""))
with(df, lines(Timestamp, Sub_metering_2, col='red'))
with(df, lines(Timestamp, Sub_metering_3, col='blue'))
legend('topright', bty='n', col=c('black','red','blue'), seg.len=1, lwd='0.5', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
#right bottom
with(df, plot(Timestamp, Global_reactive_power, type='l', main="", ylab="Global_reactive_power", xlab="datetime"))
dev.off()