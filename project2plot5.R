#5. How have emissions from motor vehicle sources changed 
#   from 1999–2008 in Baltimore City? 

#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
str(SCC)
colnames(SCC)

#get SCC in which row motor vehicle is included
SCC.motor <- SCC[grep("Onroad",SCC$Data.Category), ][1]

#extract the year and the Emissions
data_year_emissions <- data.frame("year"=NEI$year,"Emissions"=NEI$Emissions,"SCC"=NEI$SCC,"fips"=NEI$fips)

#extract data for Baltimore motor emissions
motor_baltimore_emissions <- data_year_emissions[(data_year_emissions$SCC%in%SCC.motor$SCC)&(data_year_emissions$fips=="24510"), ]

#str(motor_baltimore_emissions)

#count the emissions per year
motorEmiBal_sumByYear <- tapply(motor_baltimore_emissions$Emissions,motor_baltimore_emissions$year,sum) 

#plot the image
png(file="project2plot5.png")

x <- names(motorEmiBal_sumByYear)
y <- unname(motorEmiBal_sumByYear)

p <- plot(x,y,xlab="year",ylab="Emissions",main="Baltimore motor vehicle Emissions",type="n")
axis(side=1, at=x,lwd=0)
points(x,y,col="red")
axis(side=1, at=x,lwd=0)
text(x,y,round(y),offset=0.5,pos=c(4,1,1,2))
lines(x,y,col="blue")

dev.off()

#getwd()
#setwd("/Users/hui/datasciencecourses/ExData_Plotting2")
#getwd()

