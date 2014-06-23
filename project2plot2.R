#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use 
#   the base plotting system to make a plot answering this question.

#read data
NEI <- readRDS("summarySCC_PM25.rds")
#str(NEI)

#extract the year and the Emissions of Baltimore
data_year_emissions <- data.frame("year"=NEI$year,"Emissions"=NEI$Emissions,"fips"=NEI$fips)
data_year_emissions_Baltimore <- subset(data_year_emissions,fips=="24510")

#count the total emissions per year for Baltimore
data_sumByYear_Baltimore <- tapply(data_year_emissions_Baltimore$Emissions,data_year_emissions_Baltimore$year,sum) 

#plot the image
png(file="project2plot2.png")
x <- names(data_sumByYear_Baltimore)
y <- unname(data_sumByYear_Baltimore)
plot(x,y,xlab="year",ylab="Baltimore Emissions",main="Baltimore PM25 Emissions",type="n")
axis(side=1, at=x,lwd=0)
lines(x,y,type="l")
text(x,y,labels=round(y))
dev.off()

#getwd()
#setwd("/Users/hui/datasciencecourses/ExData_Plotting2")
#getwd()


