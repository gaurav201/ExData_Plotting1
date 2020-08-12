#install.packages("dplyr")
#install.packages("tidyverse")
#install.packages("lubridate")

library(tidyverse)
library(lubridate)
library(dplyr)

filename <- "household_power_consumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileURL, filename)
unzip(filename)

data <- read_delim("household_power_consumption.txt",delim = ";",na = c("?"),col_types = list(col_date(format = "%d/%m/%Y"),col_time(format = ""),col_number(),col_number(),col_number(),col_number(),col_number(),col_number(),col_number())) %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

data <- mutate(data, datetime = ymd_hms(paste(Date, Time)))

plot(Global_active_power ~ datetime, data, type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA)

dev.copy(png, "plot2.png", width  = 480, height = 480)

dev.off()

rm(list = ls())

