#1. Have total emissions from PM2.5 decreased in the United States from 1999
#   to 2008? Using the base plotting system, make a plot showing the total 
#   PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


#read data
NEI <- readRDS("summarySCC_PM25.rds")
#str(NEI)

#extract the year and the Emissions
data_year_emissions <- data.frame("year"=NEI$year,"Emissions"=NEI$Emissions)

#count the total emissions per year
data_sumByYear <- tapply(data_year_emissions$Emissions,data_year_emissions$year,sum) 

#plot the image
#mar=c(6, 4, 4, 1)
png(file="project2plot1.png")
x <- names(data_sumByYear)
y <- unname(data_sumByYear)

plot(x,y,type="l",xlab="year",ylab="Emissions",main="National PM25 Emissions")
text(x,y,labels=round(y),pos=c(4,4,4,2))
axis(side=1, at=x,lwd=0)
dev.off()

#getwd()
#setwd("/Users/hui/datasciencecourses/ExData_Plotting2")
#getwd()

