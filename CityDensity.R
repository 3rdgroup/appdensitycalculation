# GROUP 3 (Alejandro, Dizon, Kuo, Matias, Pena)

#Use Library dplyr

library(dplyr)

# Load the datasets
populationData = read.csv(file="population.csv", head=TRUE)
regionAreaData = read.csv(file="regionarea.csv", head=TRUE)



populationDataGroupedByCityProvince = group_by(populationData, Region, CityProvince)
populationDataGroupedByCityProvinceWithCount = summarize(populationDataGroupedByCityProvince, population = sum(Population))


mergedPopulationDataAndRegionData = merge(populationDataGroupedByCityProvinceWithCount, regionAreaData, by = "Region")       

tallyOfCityPerRegion = count(populationDataGroupedByCityProvinceWithCount)

mergedPopulationDataAndRegionDataAndTally = merge(mergedPopulationDataAndRegionData, tallyOfCityPerRegion, by = "Region")       


mergedPopulationDataAndRegionDataAndTallyWithCityArea = mutate(mergedPopulationDataAndRegionDataAndTally, landAreaOfCity = Area/n)
finalDataSet = mutate(mergedPopulationDataAndRegionDataAndTallyWithCityArea, populationDensity = population/landAreaOfCity)


output = arrange(finalDataSet, desc(populationDensity))

topFiveCityWithHighestDensity = head(output, n=5)

write.csv(topFiveCityWithHighestDensity, file = "TopFiveCityWithHighestDensity.csv",row.names=TRUE)


