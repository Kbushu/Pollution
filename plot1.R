# __Plot1__ Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Read the data
setwd("~/40 L&G/Coursera/ExDataAnalysis/Project2")
if (!exists("NEI")) {
        NEI <- readRDS(paste0(getwd() ,"/Data/summarySCC_PM25.rds"))        
}

# Start the png driver
png(filename= paste0("plot1.png"), height=295, width=600, bg="white")
        
# Prepare Data for plot
library(dplyr)
df <- NEI %>% select(Emissions, year) %>% 
        # mutate(Year = factor(year)) %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions))

# Compile the plot 
with(df, plot.default(x = year, y = Total,
              type = "b",
              xlab="Year", 
              ylab = "Tons of PM2.5", 
              main = "Total Annual Emissions"))
   
# Export the plot 
dev.off()
