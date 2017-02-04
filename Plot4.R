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