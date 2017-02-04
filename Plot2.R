# Loading provided datasets from local machine

NEI <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/Source_Classification_Code.rds")

baltimore <- NEI[NEI$fips=="24510",]
TotalPMBaltimore <- aggregate(Emissions ~ year, baltimore,FUN=sum)

barplot(
  TotalPMBaltimore$Emissions,
  names.arg=TotalPMBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (Tons)",
  main="Total PM2.5 Emissions From All Baltimore City Sources"
)

png(file="C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot2.png", width=480, height=480)

dev.off()

# dev.copy(png, file="plot3.png", width=480, height=480)
# dev.off()