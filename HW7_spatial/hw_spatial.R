library(leaflet)

df <- read.csv("database.csv") #dataset of Earthquakes with magnitudes 5.5+ 
df2 <- df[22944:23412,] #subset data for observations only in the year 2016

getColor <- function(d2) {
  sapply(df2$Magnitude, function(Magnitude) {
    if(Magnitude <= 5.9) { #green marker if magnitude 5-5.9
      "green"
    } else if(Magnitude <= 6.9) { #orange marker if magnitude 5.9-6.9
      "orange"
    } else if(Magnitude <= 7.9){ #red marker if magnitude 6.9-7.9
      "red"
    } else #dark red marker if magnitude greater than 7.9
      "darkred"})
}
icons <- awesomeIcons(
  icon = 'glyphicon-warning-sign', #chooses icon type
  iconColor = 'white', #colour of icon
  library = 'glyphicon', #icon library 
  markerColor = getColor(df2) #colours given by function above
)

map <- leaflet(data=df2) %>%
  addTiles() %>%
  addAwesomeMarkers(lng = ~Longitude, lat = ~Latitude, 
             popup = paste("Date", df2$Date, "<br>", #display date, time, depth, and magnitude after click
                           "Time:", df2$Time, "<br>",
                           "Depth:", df2$Depth, "<br>",
                           "Magnitude:",df2$Magnitude), 
             label = ~as.character(Magnitude),
             icon = icons) #show magnitude after hovering over marker


map2 <- fitBounds(map,-150,70, -60,30) #create map boundary to display around North America
map2

#The graphic was created to illustrate the location and magnitudes of significant earthquakes (5.5+).
#I chose specific colours based on the classes of earthquakes defined by the range their magnitude resides:
#https://en.wikipedia.org/wiki/Richter_magnitude_scale
#It was immediately noticeble that in 2016, no detectable earthquake was present on the east coast of Canada.
