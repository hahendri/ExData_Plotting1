##Set your Working Directory
##setwd("enter path here")
##Install dplyr, ggplot2, chron, and lubridate libraries.  If you don't have these packages intalled, use install.packages to install them.
library(dplyr)
library(ggplot2)
library(chron)
library(lubridate)
##Create data directory and download the data
fileurl = "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
if (!file.exists("data")) {
        dir.create("data")
}
download.file(fileurl, destfile = "./data/UCI Power Dataset.zip", 
              mode = "wb")
unzip("./data/UCI Power Dataset.zip", exdir = "./data")
#Read the data into table
hpc <- read.table("./data/household_power_consumption.txt", 
                  sep = ";", na.strings = "?", 
                  header = TRUE, colClasses = 
                          c("character", "character", "numeric", "numeric", "numeric", 
                            "numeric", "numeric", "numeric", "numeric"))
#Tidy data
hpc <- filter(hpc, Date %in% c("1/2/2007", "2/2/2007"))
hpc[,1] <- as.Date(hpc[,1], format = "%d/%m/%Y") 
hpc[,2] <- times(hpc[,2], format = "h:m:s")
hpc$DateTime <- ymd(hpc$Date) + hms(hpc$Time)
#Create plot1 and generate png file
png(file = "plot2.png", width = 480, height = 480)
with(hpc, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = 
                        "Global Active Power (kilowatts)"))
dev.off()