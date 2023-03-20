## Assignment 2

### Description

Using data sourced from the [Iowa Department of Education](https://educateiowa.gov/data-reporting/education-statistics-pk-12), I downloaded student Enrollment data. I cleaned up the file in Excel before bringing it into R, isolating Total K-12 and Asian Total. Using the pipe function, I calculated the percentage of Asian K-12 Students by County in Iowa. I plotted the resulting data on a bar chart using the ggplot. And then, I exported the resulting data to .csv file and use it make a map using ArcGIS Pro. All

![Plot1](assginments/assign2/BarPlot_Assign2.png)


### Mapping Data in R

This map was created using the same initial data set as the plot above. Here, I grouped the data by county and summarized various fields using a pipe. I then joined the data table to a shapefile of Iowa counties after renaming the fields to match. I chose to map the average salary of full time teachers by county, which was calculated in the pipe by taking the sum of the average salary per district divided by the number of districts in each county.

![Map1](assginments/assign2/Map_Assign2.jpg)
