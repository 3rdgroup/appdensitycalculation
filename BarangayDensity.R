# GROUP 3 (Alejandro, Dizon, Kuo, Matias, Pena)

#Use Library dplyr

library(dplyr)
library(data.table)

# Load the datasets
populationData = read.csv(file="population.csv", head=TRUE)
regionAreaData = read.csv(file="regionarea.csv", head=TRUE)
DT<-data.table(populationData)

populationDataGroupedByBarangay = group_by(populationData,Region,CityProvince,Barangay)

populationDataGroupedByBarangayWithCount = summarize(populationDataGroupedByBarangay, population = sum(Population))

mergedPopulationDataAndRegionData = merge(populationDataGroupedByBarangayWithCount, regionAreaData, by = "Region")       

tallyOfBarangayPerRegion=DT[,.(n=length(Barangay)),by=Region]

mergedPopulationDataAndRegionDataAndTally = merge(mergedPopulationDataAndRegionData, tallyOfBarangayPerRegion, by = "Region")       

mergedPopulationDataAndRegionDataAndTallyWithBarangayArea = mutate(mergedPopulationDataAndRegionDataAndTally, landAreaOfBarangay = Area/n)

finalDataSet = mutate(mergedPopulationDataAndRegionDataAndTallyWithBarangayArea, populationDensity = population/landAreaOfBarangay)

output = arrange(finalDataSet, desc(populationDensity))

topFiveBarangayWithHighestDensity = head(output, n=5)

write.csv(topFiveBarangayWithHighestDensity, file = "TopFiveBarangayWithHighestDensity.csv",row.names=TRUE)
