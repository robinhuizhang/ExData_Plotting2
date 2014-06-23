#4.Across the United States, how have emissions from coal combustion-related
#  sources changed from 1999–2008?

#read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#str(NEI)
str(SCC)
colnames(SCC)

#get SCC in which row "coal" is included
SCC.coal <- SCC[grep("\\- Coal",SCC$EI.Sector), ][1]

#extract the year and the Emissions
data_year_emissions <- data.frame("year"=NEI$year,"Emissions"=NEI$Emissions,"SCC"=NEI$SCC)

#extract the coal Emissions
coal_year_emissions <- data_year_emissions[data_year_emissions$SCC%in%SCC.coal$SCC, ]

#str(coal_year_emissions)

#count the coal emissions per year
coalEmi_sumByYear <- tapply(coal_year_emissions$Emissions,coal_year_emissions$year,sum) 

#plot the image
png(file="project2plot4.png")

x <- names(coalEmi_sumByYear)
y <- unname(coalEmi_sumByYear)

p <- plot(x,y,xlab="year",ylab="Emissions",main="national coal combustion-related Emissions",type="l")
axis(side=1, at=x,lwd=0)
lines(x,y,type="l")
text(x,y,labels=round(y),pos=c(4,1,4,2))
dev.off()

#getwd()
#setwd("/Users/hui/datasciencecourses/ExData_Plotting2")
#getwd()