# Load the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Aggregate the data
df <- aggregate(Emissions ~ year, subset=(NEI$fips == 24510), NEI, sum)

# Plot the graph
plot(df, xlab="Year", ylab="Total PM2.5 Emissions, Tons", main="Total Emissions for Baltimore County")
lines(df)

# Copy graph to png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()