# Loading provided datasets from local machine

NEI <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008')) 


# Baltimore City, Maryland == fips 
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

ggp <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(ggp)


png('C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot5.png') 

dev.off() 