# Across the United States, 
# how have emissions from coal combustion-related sources changed 
# from 1999–2008?

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
coalcomb <- SCC %>% 
        filter(grepl("comb", x = Short.Name, ignore.case = TRUE)) %>%
        filter(grepl("coal", x = Short.Name, ignore.case = TRUE)) %>%
        select(SCC,Short.Name)

#Convert to a vector to use in the filter
coalcomb <- coalcomb %>% .$SCC

# Start the png driver
png(filename= paste0("plot5.png"), height=295, width=600, bg="white")

# Prepare Data for plot
df <- NEI %>% select(Emissions, year, Source = type, SCC) %>% 
        filter(SCC %in% coalcomb) %>%
        group_by(year) %>%
        summarise(Total = sum(Emissions))

# Compile the plot 
library(ggplot2)
qplot(x = year, y = Total,
      data = df,
      geom = c("point", "line"),
      xlab="Year",
      ylab = "Tons of PM2.5",
      main = "Total Annual Coal Combustion Related Emissions \n U.S.A.")

# Export the plot 
dev.off()
