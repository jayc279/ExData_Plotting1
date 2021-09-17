## Install and Load the following libraries
## "ggplot2", "jpeg", "tidyverse", "data.table", "dyplr"

## Read Household Power Consumption File
df <- read.csv2("household_power_consumption.txt", sep=";", dec=".")

## Dimensions of dataset
dim(df)
### 2075259 	9

## Get Names of columns
names(df)
###
## "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"               
## "Global_intensity"     "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"

## Verify dataset 'df'
head(df, n=10)
head(select(df, Date:Time), n=10)

## Check if there are any "?" values and filter them out
df %>% filter(Sub_metering_2 != "?")

## Testing ## df %>% filter(Date == "16/12/2006")
## Remove rows with question marks and copy/overwrite same dataset
df <- df %>% filter(Global_active_power != "?")

## Check class of df$Date
class(df$Date)   ## Character

print("Cleaning up Data for Graph Analysis")

## Step 1 -- Combine Columns Date and Time and create a new column 'datetime'
df <- mutate(df, datetime = paste(Date,Time))

## Step 2 -- Convert Date to as.Date
df$Date <- as.Date(df$Date, "%d/%m/%Y")
## Check dataset ## head(df, n=10)

## Step 3 -- Subset data to Dates 2/1/2007 and 2/2/2007
df<- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02",]
## Check NUM of Rows ## nrow(df) ## 2880

## Step 4 -- Make a copy of dataset to be safe
df1 <- df

## Convert 'datetime' from CLASS 'character' to 'Date' CLASS
## class(df$datetime) ## "character"
## Step 5 -- Convert "datetime" column to Data format - YYYY-mm-dd HH:MM::SS
df$datetime <- strptime(df$datetime, "%d/%m/%Y %H:%M:%S")

## Check output 
head(df, n=10)
tail(df, n=10)

## Check CLASS
class(df$datetime)
## [1] "POSIXlt" "POSIXt"

## Get Day of datetime
weekdays(df$datetime)  ### Thursday Friday

class(df$Date)  ## Date

### Get ROWs for Dates 2007-02-01 and 2007-02-02
df<- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02",]
## nrow(df)    ## 2880 	10
## names(df)

## Convert columns other than Date, Time, and 'datetime' to Numeric
## Global_active_power Global_reactive_power Global_intensity
## Voltage Sub_metering_1 Sub_metering_2 Sub_metering_3

class(df$Global_active_power)

## After conversion check CLASS of converted columns
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

class(df$Global_active_power)

####################### PLOTTING & SAVING to PNG ####################################
## Switch off any active device
if (!is.null(dev.list()) ) { dev.off()}

## Plot 1
hist(df$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.copy(png, file="plot1.png")

## After Copying Close the PNG handle
if (!is.null(dev.list()) ) { dev.off()}

## Closes Window 2
if (!is.null(dev.list()) ) { dev.off()}

print("Execution completed -- plot1.R")

###########################################################################
