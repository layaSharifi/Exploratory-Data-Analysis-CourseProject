# Loading provided datasets from local machine

NEI <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# vehicle in Baltimore City, Maryland and Los Angeles County, California 

vehiclesBaltimoreNEI<- NEI[NEI$fips == 24510,]
vehiclesBaltimoreNEI$city <- "Baltimore City"
vehiclesLANEI <- NEI[NEI$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles County"
bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)


ggp <- ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

png('C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot6.png') 

print(ggp)
dev.off() 