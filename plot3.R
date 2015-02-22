# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group and Aggregate the data
baltimore <- NEI[NEI$fips == 24510, ]
baltimore <- ddply(baltimore, .(year,type), summarize, totalEmissions = sum(Emissions))

# Plot the graph
library("ggplot2")
ggplot(baltimore, aes(year, totalEmissions, group=type, color=type)) + geom_point() + geom_line() + labs(x="Year", y="Total PM2.5 Emissions, Tons", title="Total PM2.5 Emissions for Baltimore city")

# Copy graph to png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()