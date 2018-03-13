library(tidyverse)
library(ggvis)
library(highcharter)
library(shiny)

##Plot 1: Sepal Length vs. Sepal Width from iris dataset
iris$id <- 1:nrow(iris)
all_values <- function(x) {
  if(is.null(x)) return(NULL)
  row <- iris[iris$id == x$id, -c(5,6)] #excluded 'id' and 'species' from hovering
  paste0(names(row), ": ", format(row), collapse = "<br />")
}

iris %>% ggvis(x = ~Sepal.Length, y = ~Sepal.Width, fill =~Species, key := ~id) %>% 
  layer_points() %>% 
  add_tooltip(all_values,"hover")

##Plot 2: Highchart time series from Nile dataset
highchart() %>% 
  hc_series(list(data=datasets::Nile, name="Flow")) %>% 
  hc_title(text = "Annual Flow of the Nile") %>%
  hc_xAxis(title = list(text = "Years since 1871")) %>% #x axis label
  hc_yAxis(title = list(text = "Annual Flow (10^8 cubic metres)")) #y axis label
  
