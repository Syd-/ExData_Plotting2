# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group and Aggregate the data
coalSCC <- SCC[grepl('coal', SCC$Short.Name, ignore.case=TRUE), ]
coalNEI <- aggregate(Emissions ~ year, subset = (NEI$SCC %in% coalSCC$SCC), NEI, sum)

# Plot the graph
plot(coalNEI, xlab="Year", ylab="Total PM2.5 Emissions, Tons", main="Total Coal Emissions for US")
lines(coalNEI)

# Copy graph to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()