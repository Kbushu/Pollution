# Across the United States, 
# how have emissions from coal combustion-related sources changed 
# from 1999–2008?

# Which have seen increases in emissions from 1999–2008? 
# Use the _ggplot2_ plotting system to make a plot answer this question.

# Read the data
setwd("~/40 L&G/Coursera/ExDataAnalysis/Project2")
if (!exists("NEI")) {
        NEI <- readRDS(paste0(getwd() ,"/Data/summarySCC_PM25.rds"))        
}

# Start the png driver
png(filename= paste0("plot4.png"), height=295, width=600, bg="white")

# Prepare Data for plot
library(dplyr)
df <- NEI %>% select(Emissions, year, Source = type, fips) %>% 
        # change to coal
        # filter(, year %in% c(1999, 2008), Source == "POINT") %>%
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
      main = "Increased Total Annual Emission Sources \n Baltimore City, Maryland")

# Export the plot 
dev.off()
