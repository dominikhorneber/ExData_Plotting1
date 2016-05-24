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

#PLOT 2
png(filename="Plot 2.png")
with(df, plot(Timestamp, Global_active_power, type='l', main="", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()

