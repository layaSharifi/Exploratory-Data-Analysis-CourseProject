
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

--------------------------------------------------------Q2--------------------------------------------------------------
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

------------------------------------------------------Q3------------------------------------------------------------
  # Loading provided datasets from local machine  
NEI <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/Source_Classification_Code.rds")
install.packages("ggplot2")

library(ggplot2)

MD <- subset(NEI, fips == 24510) 
MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008')) 


ggp <- ggplot(MD,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.copy(png, file="/C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot4.png", width=480, height=480)
dev.off

------------------------------------------------------Q4-----------------------------------------------------------
  # Loading provided datasets from local machine 
  NEI <- readRDS("~/Exploratory_Data_Analysis/Assignment_2/summarySCC_PM25.rds") 
SCC <- readRDS("~/Exploratory_Data_Analysis/Assignment_2/Source_Classification_Code.rds") 

# Coal combustion related sources 
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),] 


# Merge two data sets 
merge <- merge(x=NEI, y=SCC.coal, by='SCC') 

merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum) 
colnames(merge.sum) <- c('Year', 'Emissions') 
colnames(merge.sum)

# Generate the graph in the same directory as the source code 
png(filename='png, file="/C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot5.png') 

ggp <- ggplot(merge,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(ggp)

dev.off() 
---------------------------------------------------Q5--------------------------------------------------------------------
  
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

------------------------------------------------------------Q6-----------------------------------------------------------------
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

png('C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot5.png') 

dev.off() 





