#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#   variable, which of these four sources have seen decreases in emissions from 1999–2008
#   for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#   Use the ggplot2 plotting system to make a plot answer this question.

#read data
NEI <- readRDS("summarySCC_PM25.rds")
#str(NEI)

#extract the year and the Emissions
data_year_emissions <- data.frame("year"=NEI$year,"Emissions"=NEI$Emissions,"fips"=NEI$fips,"type"=NEI$type)
data_year_emissions_Baltimore <- subset(data_year_emissions,fips=="24510")

#count the total emissions per year by year and type
data_sumByYearType_Baltimore <- tapply(data_year_emissions_Baltimore$Emissions,list("year"=data_year_emissions_Baltimore$year,"type"=data_year_emissions_Baltimore$type),sum) 

#plot the image
png(file="project2plot3.png")

#covert matrix to data frame because ggplot just plot data frame
df <- as.data.frame(as.table(data_sumByYearType_Baltimore))
colnames(df)[3]="BaltimoreEmissions"
library(ggplot2)
ggplot(data=df,aes(x=year,y=BaltimoreEmissions,group=type,colour=type))+geom_line()+geom_point()

dev.off()

#getwd()
#setwd("/Users/hui/datasciencecourses/ExData_Plotting2")
#getwd()

