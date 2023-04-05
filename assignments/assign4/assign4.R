#Leaflet mapping
#
# Hyunsik Son

# A Leaflet page in R with 20 markers. 
Assign4a <- read.csv("assign4a.csv", header = TRUE)
myData <- Assign4a

icon <- makeIcon(iconUrl = "assign4a_book.png", iconWidth = 25, iconHeight = 25)

map <- leaflet(data = myData) %>%
  addTiles(options = providerTileOptions(minZoom = 10, maxZoom = 13)) %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Aerial", options = providerTileOptions(minZoom = 10, maxZoom = 13)) %>%
  addProviderTiles(providers$Esri.WorldTopoMap, group = "TopoMap", options = providerTileOptions(minZoom = 10, maxZoom = 13)) %>%
  addProviderTiles(providers$Esri.WorldStreetMap, group = "OSM", options = providerTileOptions(minZoom = 10, maxZoom = 13)) %>%
  addProviderTiles(providers$Stamen.Terrain, group = "Terrain", options = providerTileOptions(minZoom = 10, maxZoom = 13)) %>%
  addProviderTiles(providers$Stamen.Toner, group = "MainRoad", options = providerTileOptions(minZoom = 10, maxZoom = 13)) %>%
  addMarkers(lng = ~ longitude, lat = ~ latitude, icon = icon, 
             popup = paste("<strong>", "<center>", myData$Name, "</strong><br>", "Type: ", myData$Type),
             clusterOptions = markerClusterOptions()) %>%
  addLayersControl(baseGroups = c("OSM", "Aerial", "TopoMap", "Terrain", "MainRoad"), 
                   options = layersControlOptions(collapsed = TRUE, position = "topleft"))

map


# A Leaflet Chloropleth Map
library(sf)
library(leaflet)
library(htmltools)

studentCount <- st_read("ForAssign4b.shp")
studentCount <- st_transform(studentCount, crs = 4326)

bounds <-studentCount %>%
  st_bbox() %>%
  as.character()
fitBounds(m, -96.63306039630396, 40.37830479583795, -90.14002756307562, 43.50012771146711)

bins <- c(0, 3, 6, 9, 12, 15, 18)
pal <- colorBin("BuGn", domain=studentCount$PercBlack, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g percent",
  studentCount$CountyName, studentCount$PercBlack
) %>% lapply(htmltools::HTML)

m <- leaflet() %>%
  setView(-94.5, 42.2, 6) %>%
  addTiles() %>%
  fitBounds(bounds[1], bounds[2], bounds[3], bounds[4]) %>%
  addPolygons(data = studentCount,
              fillColor = ~pal(PercBlack),
              weight = 0.5,
              opacity = 1,
              color = "grey",
              dashArray = "1",
              fillOpacity = 0.9,
              highlightOptions = highlightOptions(
                weight = 2,
                color = "black",
                dashArray = "4",
                fillOpacity = 0.9,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "12px",
                direction = "auto")) %>%
  addLayersControl(
    overlayGroups = c("Iowa State University"),
    options = layersControlOptions(
      collapsed = FALSE
    ),
    position = "topleft"
  ) %>%
  addMarkers(lng = -93.64640, lat = 42.02684, popup = "Iowa State University", group = "Iowa State University") %>%
  addLegend(pal = pal, values = studentCount$PercBlack, opacity = 1, title = "Black K12 Student %", 
                position = "bottomright")

m

library(htmlwidgets)
saveWidget(map, "assign4a.html", selfcontained = F, libdir="lib")
saveWidget(m, "assign4b.html", selfcontained = F, libdir="lib2")


  