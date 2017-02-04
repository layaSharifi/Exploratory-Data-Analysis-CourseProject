# Loading provided datasets from local machine  
NEI <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/summarySCC_PM25.rds") 
SCC <- readRDS("C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/Source_Classification_Code.rds")
install.packages("ggplot2")

library(ggplot2)

baltimore <- NEI[NEI$fips=="24510",]
TotalPMBaltimore <- aggregate(Emissions ~ year, baltimore,FUN=sum)

ggp <- ggplot(baltimore,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(ggp)

dev.copy(png, file="/C:/Users/lsharifi/Desktop/Rot2/coursera/A4-courseProject/plot4.png", width=480, height=480)
dev.off