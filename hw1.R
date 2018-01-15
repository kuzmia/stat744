library(tidyverse)
library(DAAG) #contains data set of Australian Atheletes of various sports

sub_ais <- select(ais,sport,sex) #create subset for demographic plot

ggplot(data=mutate(sub_ais,value=1))+
  geom_bar(mapping = aes(x=sport, fill = sport))+
  coord_flip()+ #flips coordinates to form horizontal bar graph
  facet_wrap(~sex) #facets by gender

#creating box plot to compare hemoglobin concentrations by sport
ggplot(data=ais, aes(x = sport,y = hg))+
  geom_boxplot()+
  facet_wrap(~sex)

#create scatterplot that illustrates correlation between red blood cell count and hemoglobin concentration
ggplot(data=ais)+
  geom_point(mapping = aes(x=rcc, y=hg, colour=sport))+
  geom_smooth(method = "lm", aes(x=rcc, y=hg))+
  facet_wrap(~sex)
