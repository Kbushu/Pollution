##Plot 7
# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Read the data
setwd("~/40 L&G/Coursera/ExDataAnalysis/Project2")
if (!exists("NEI")) {
        # Emissions Data
        NEI <- readRDS(paste0(getwd() ,"/Data/summarySCC_PM25.rds"))
}
if (!exists("SCC")) {
        # Source Classification Code Table
        SCC <- readRDS(paste0(getwd() ,"/Data/Source_Classification_Code.rds"))
}

# Select the SCC codes for vehicle sources
library(dplyr)
vehicles <- SCC %>% 
        filter(grepl("Mobile", x = SCC.Level.One ,ignore.case = TRUE)) %>%
        filter(grepl("vehicle", x = Short.Name, ignore.case = TRUE)) %>%
        select(SCC,Short.Name)

#Convert to a vector to use in the filter
vehicles <- vehicles %>% .$SCC

# Start the png driver
png(filename= paste0("plot7.png"), height=295, width=600, bg="white")

# Prepare Data for plot
df <- NEI %>% select(Emissions, year, fips, SCC) %>%
        filter(SCC %in% vehicles) %>%
        filter(fips == "24510" | fips == "06037") %>%
        mutate(fips, City = as.character(ifelse(fips == "24510", "Baltimore City (24510)","Los Angeles (06037)"))) %>%
        group_by(year, City) %>%
        summarise(Total = sum(Emissions))

library(ggplot2)
p <- qplot(x = year, y = Total,
      data = df,
      geom = c("point", "line"),
      group = City,
      col = City,
      xlab="Year",
      ylab = "Tons of PM2.5",
      main = "Total Annual Vehicle Related Emissions \n Baltimore City, Maryland and Los Angeles")
# Add linear models to observe the change
p+geom_smooth(method = "lm")

# Export the plot 
dev.off()
