# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group and Aggregate the data
library("plyr")
citiesSubset <- NEI[(NEI$fips == "24510" | NEI$fips == "06037"), ]
# In the EI.Sector, "Vehicle" is a road vehicle.
# "mobile" refers to non-road vehicles, apparently.
motorSCC <- SCC[grepl('vehicle', SCC$EI.Sector, ignore.case=TRUE), ]
# Subset
citiesMotorSubset <- subset(citiesSubset, subset = (citiesSubset$SCC %in% motorSCC$SCC))
citiesMotorSubset <- ddply(citiesMotorSubset, .(year, fips), summarize, totalEmissions = sum(Emissions))
# Rename
citiesMotorSubset[citiesMotorSubset$fips == "24510", ]$fips = "Baltimore City"
citiesMotorSubset[citiesMotorSubset$fips == "06037", ]$fips = "Los Angeles County"

# Plot the graph
library("ggplot2")
ggplot(citiesMotorSubset, aes(year, totalEmissions, group=fips, color=fips)) + geom_point() + geom_line() + labs(x="Year", y="Total PM2.5 Emissions, Tons", title="Total PM2.5 Emissions for 24510 and 06037") + theme(legend.title=element_blank())

# Copy graph to png file
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()