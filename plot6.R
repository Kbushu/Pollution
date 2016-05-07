# How have emissions from 
# motor vehicle sources changed from 1999–2008 in Baltimore City?

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

# Select the SCC codes for coal combustion related sources
library(dplyr)
vehicles <- SCC %>% 
        filter(grepl("Mobile", x = SCC.Level.One ,ignore.case = TRUE)) %>%
        filter(grepl("vehicle", x = Short.Name, ignore.case = TRUE)) %>%
        select(SCC,Short.Name)

#Convert to a vector to use in the filter
vehicles <- vehicles %>% .$SCC

# Start the png driver
png(filename= paste0("plot5.png"), height=295, width=600, bg="white")

# Prepare Data for plot
df <- NEI %>% select(Emissions, year, Source = type, SCC) %>% 
        filter(SCC %in% vehicles) %>%
        filter(fips == "24510") %>%        
        group_by(year, Source) %>%
        summarise(Total = sum(Emissions))

# Compile the plot >>>Change from point and check filters!!!!!!!!!!!!!
library(ggplot2)
qplot(x = year, y = Total,
      data = df,
      geom = c("point", "line"),
      group = Source,
      col = Source,
      xlab="Year",
      ylab = "Tons of PM2.5",
      main = "Total Annual Vehicles Related Sources \n Baltimore City, Maryland")

# Export the plot 
dev.off()
