library(tidyverse)

df<-readr::read_csv("https://bbolker.github.io/stat744/data/vaccine_data_online.csv")
#The original graphic is trying to illustrate how vaccines have decreased the
#prevalence of a number of diseases. This is done by having the area of the circles proportional to the
#number of individuals with the disease. It includes a dynamic-graphics component so that the user
#can see specifics pertaining to the disease at a given year.


#1. geom_line graph with geom_point indicator of vaccine intervention
ggplot(data=df, mapping=aes(x=year, y=cases/1000, group=disease, colour=disease))+
  geom_line()+
  geom_point(data=df[df$vaccine!=FALSE,], mapping=aes(x=year, y=cases/1000))+ #add points for special events
  facet_wrap(~disease, scales="free")+ #make scale with respect to each disease -- not just one
  theme(legend.position = "none")+ #remove legend due to redundancy
  labs(y="Cases (Thousand)")

#I felt that the better way to illustrate the change in prevalence was to use a line graph.
#The perceived changes were more apparent than the change in area of the circles. I freed the scale for
#the facets because, if I hadn't, the scales would be stretched to fit the change of the Measles,
#Which would make the changes significantly less noticeable for other diseases.

#2. Point plot with sizes proportional to the number of cases
ggplot(data=df, mapping=aes(x=year, y=disease))+
  geom_point(aes(size=cases, alpha=cases))+#point size and transparency depended on number of cases
  geom_point(data=df[df$vaccine!=FALSE,], colour="red")+ #red point indicates intervention of vaccination
  scale_size(range=c(1,8))+ #increase variation between sizes
  scale_x_continuous(breaks=seq(1945,2015, by=10)) #scale x-axis for every 10 years

#I couldn't think of an alternative to the original design, but I found mine easier to visually navigate.
#I found that, just as reading, it was easier to notice change if I scanned horizontally as opposed to vertically.
#There was trial-and-error with the scale_size() function to find a variance in size and spacing
#between the circles. Also, I didn't have to scroll down to see the whole picture, which was nice.