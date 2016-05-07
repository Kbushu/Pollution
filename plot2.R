# __Plot 2__ Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Read the data
setwd("~/40 L&G/Coursera/ExDataAnalysis/Project2")
if (!exists("NEI")) {
        NEI <- readRDS(paste0(getwd() ,"/Data/summarySCC_PM25.rds"))        
}

# Start the png driver
png(filename= paste0("plot2.png"), height=295, width=600, bg="white")

# Prepare Data for plot
library(dplyr)
df <- NEI %>% select(Emissions, year, fips) %>% 
        # mutate(Year = factor(year)) %>%
        filter(fips == "24510") %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions))

# Compile the plot 
with(df, plot.default(x = year, y = Total,
                      type = "b",
                      xlab="Year", 
                      ylab = "Tons of PM2.5", 
                      main = "Total Annual Emissions",
                      sub = "Baltimore City, Maryland (fips 24510)"))

# Export the plot 
dev.off()