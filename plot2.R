# plot2.R
#
# Read household power consumption data and plot a time series of global
# active power consumption in kilowatts sampled each minute.
#
# Note that the data file, "household_power_consumption.txt" is not included
# in the repository, but can be obtained from the link in README.md.

# read in the data; we only want data for Feb 1-2, 2007, which comprise 2880
# rows starting at row 66638
powerDat <- read.table("household_power_consumption.txt", header=FALSE, 
                       sep=";", na.strings="?", skip=66637, nrows=2880)
# read.table doesn't let us get a header that is not contiguous with the range
# of rows we read, so we'll grab it from the file and name the columns manually
headerString <- readLines("household_power_consumption.txt", 1)
names(powerDat) <- unlist(strsplit(headerString, ";"))
# now let's convert the Date column into the Date class
powerDat$Date <- as.Date(powerDat$Date, "%d/%m/%Y")
# add a "datetime" column that combines Date and Time in POSIXct format
powerDat$datetime <- as.POSIXct(paste(powerDat$Date, powerDat$Time), 
                                "%Y-%m-%d %H:%M:%S", tz="UTC")

# open a png device and make the plot
png("plot2.png", width=480, height=480, bg="transparent")
plot(Global_active_power ~ datetime, data=powerDat, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()