# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group and Aggregate the data
baltimore <- NEI[NEI$fips == 24510, ]
motorSCC <- SCC[grepl('motor', SCC$Short.Name, ignore.case=TRUE), ]
baltimoreMotor <- aggregate(Emissions ~ year, subset = (baltimore$SCC %in% motorSCC$SCC), baltimore, sum)

# Plot the graph
plot(baltimoreMotor, xlab="Year", ylab="Total PM2.5 Emissions, Tons", main="Total Vehicular Emissions for Baltimore City")
lines(baltimoreMotor)

# Copy graph to png file
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()