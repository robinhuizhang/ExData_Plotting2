#6. Compare emissions from motor vehicle sources in Baltimore
#   City with emissions from motor vehicle sources in Los Angeles
#   County, California (fips == "06037"). Which city has seen greater
#   changes over time in motor vehicle emissions?

#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
str(SCC)
colnames(SCC)

#get SCC in which row motor vehicle is included
SCC.motor <- SCC[grep("Onroad",SCC$Data.Category), ][1]

#extract the year and the Emissions of two regions
data_year_emissions <- data.frame("year"=NEI$year,"Emissions"=NEI$Emissions,"SCC"=NEI$SCC,"fips"=NEI$fips)

motor_baltimore_emissions <- data_year_emissions[(data_year_emissions$SCC%in%SCC.motor$SCC)&(data_year_emissions$fips=="24510"), ]

motor_LA_emissions <- data_year_emissions[(data_year_emissions$SCC%in%SCC.motor$SCC)&(data_year_emissions$fips=="06037"), ]

#str(motor_baltimore_emissions)

#count the motor emissions per year for each region
motorEmiBal_sumByYear <- tapply(motor_baltimore_emissions$Emissions,motor_baltimore_emissions$year,sum) 
motorEmiLA_sumByYear <- tapply(motor_LA_emissions$Emissions,motor_LA_emissions$year,sum) 

#plot the image
png(file="project2plot6.png")

x1 <- names(motorEmiBal_sumByYear)
y1 <- unname(motorEmiBal_sumByYear)

x2 <- names(motorEmiLA_sumByYear)
y2 <- unname(motorEmiLA_sumByYear)

par(mfrow=c(2,1))

p <- plot(x1,y1,xlab="year",ylab="Emissions",main="Baltimore motor vehicle Emissions",type="n")
axis(side=1, at=x,lwd=0)
points(x1,y1,col="red")
lines(x,y,col="blue")
text(x1,y1,round(y1),pos=c(1,3,3,3))


plot(x2,y2,xlab="year",ylab="Emissions",main="LA motor vehicle Emissions",type="n")
axis(side=1, at=x2,lwd=0)
points(x2,y2,col="red")
lines(x2,y2,col="blue")
text(x2,y2,round(y2),pos=c(3,1,1,3))


dev.off()

#getwd()
#setwd("/Users/hui/datasciencecourses/ExData_Plotting2")
#getwd()

