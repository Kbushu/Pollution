# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City?

# Read the data
setwd("~/40 L&G/Coursera/ExDataAnalysis/Project2")
if (!exists("NEI")) {
        NEI <- readRDS(paste0(getwd() ,"/Data/summarySCC_PM25.rds"))        
}

# Start the png driver
png(filename= paste0("plot3.png"), height=295, width=600, bg="white")

# Prepare Data for plot
library(dplyr)
df <- NEI %>% select(Emissions, year, Source = type, fips) %>% 
        filter(fips == "24510", year %in% c(1999, 2008), !Source == "POINT") %>%
        group_by(year, Source) %>%
        summarise(Total = sum(Emissions))

# Compile the plot 
library(ggplot2)
qplot(x = year, y = Total,
        data = df,
        geom = c("point", "line"),
        group = Source,
        col = Source,
        xlab="Year",
        ylab = "Tons of PM2.5",
        main = "Decreased Total Annual Emission Sources \n Baltimore City, Maryland")

# Export the plot 
dev.off()
