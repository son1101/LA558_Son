install.packages("leaflet")

leaflet(options = leafletOptions(minZoom = 0, maxZoom = 2))

map <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng= 127.01948, lat=37.54609, popup="My Aprtment in South Korea")
map

map %>% setView(lng= 127.01948, lat=37.54609, zoom = 14)
