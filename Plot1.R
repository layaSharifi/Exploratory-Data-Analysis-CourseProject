
# Loading provided datasets from local machine
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")


NEI <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/Source_Classification_Code.rds")

#First aggregating the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

TotalEmissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)    #OR

TotalEmissions <- aggregate(Emissions ~ year,NEI, FUN=sum)

barplot(
  (TotalEmissions$Emissions)/10^6,
  names.arg=TotalEmissions$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)


dev.copy(png, file="C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot1.png", width=480, height=480)
dev.off()

# png(filename = "C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot1.png", width = 480, height = 480, units = "px")
# dev.off()