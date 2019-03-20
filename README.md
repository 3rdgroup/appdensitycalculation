# appdensitycalculation

### Data Science Toolboox
## Discussion Exercise (3/20/2019)
## Alejandro, Dizon, Kuo, Matias, Peña


## Barangay Density
1. Load dplyr and read the data csv files
library(dplyr)
library(data.table)
populationData = read.csv(file="population.csv", head=TRUE)
regionAreaData = read.csv(file="regionarea.csv", head=TRUE)
DT<-data.table(populationData)

2. Group by City Province, Region, and Barangay
populationDataGroupedByBarangay = group_by(populationData, Region,CityProvince,Barangay)

3. Summarize results


4. Merge City Province by Region and Region Area by Region
5. Get the count of City per Region
6. Merge count of City per Region with the previous one
7. Add another column that contains the computations of land area of city (area/n)
8. Add another column that contains the computation of population denstiy (population/land area of city)
9. Arrange the list in descending order
10. Get only the top 5 of the list. 
11. The list is as follows;
      City Province                  Population Density
      Quezon City                    80566
      City of Manila                 48847
      Caloocan City                  43464
      Taguig City                    22087
      City of Pasig                  20725

12. Make an output in csv file


## City Density 
1. Load dplyr and read the data csv files
library(dplyr)
populationData = read.csv(file="population.csv", head=TRUE)
regionAreaData = read.csv(file="regionarea.csv", head=TRUE)

2. Group by City Province and Region
populationDataGroupedByCityProvince = group_by(populationData, Region, CityProvince)

3. Summarize results
populationDataGroupedByCityProvinceWithCount = summarize(populationDataGroupedByCityProvince, population = sum(Population))

4. Merge City Province by Region and Region Area by Region
mergedPopulationDataAndRegionDataAndTallyWithCityArea = mutate(mergedPopulationDataAndRegionDataAndTally, landAreaOfCity = Area/n)

5. Get the count of City per Region
tallyOfCityPerRegion = count(populationDataGroupedByCityProvinceWithCount)

6. Merge count of City per Region with the previous one
mergedPopulationDataAndRegionDataAndTally = merge(mergedPopulationDataAndRegionData, tallyOfCityPerRegion, by = "Region")       

7. Add another column that contains the computations of land area of city (area/n)
mergedPopulationDataAndRegionDataAndTallyWithCityArea = mutate(mergedPopulationDataAndRegionDataAndTally, landAreaOfCity = Area/n)

8. Add another column that contains the computation of population denstiy (population/land area of city)
finalDataSet = mutate(mergedPopulationDataAndRegionDataAndTallyWithCityArea, populationDensity = population/landAreaOfCity)

9. Arrange the list in descending order.
output = arrange(finalDataSet, desc(populationDensity))

10. Get only the top 5 of the list. 
topFiveCityWithHighestDensity = head(output, n=5)

11. The list is as follows;
      City Province                  Population Density
      Quezon City                    80566
      City of Manila                 48847
      Caloocan City                  43464
      Taguig City                    22087
      City of Pasig                  20725
      
12. Make an output in csv file
write.csv(topFiveCityWithHighestDensity, file = "TopFiveCityWithHighestDensity.csv",row.names=TRUE)

