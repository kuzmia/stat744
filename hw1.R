library(tidyverse)
library(DAAG) #contains data set of Australian Atheletes of various sports (ais)

sub_ais <- select(ais,sport,sex) #create subset for demographic plot

ggplot(data=mutate(sub_ais,value=1))+ #adding a value variable to count athletes in their respective sports
  geom_bar(mapping = aes(x=sport, fill = sport))+
  coord_flip()+ #flips coordinates to form horizontal bar graph
  facet_wrap(~sex) #compare by gender

## BMB: IMO (and Cleveland's), better to align along common axis. Colors are redundant with axis
##  position anyway
## https://stackoverflow.com/questions/10326729/dont-drop-zero-count-dodged-barplot
ggplot(data=mutate(sub_ais,value=1))+ #adding a value variable to count athletes in their respective sports
  geom_bar(mapping = aes(x=sport, fill = sex),
           position=position_dodge(preserve="single")) +
  coord_flip() #flips coordinates to form horizontal bar graph

## BMB: please use actual R comments (#)

## "Alligning the bars horizontally allows for easier comparison between the number of individuals per sport.
## Immediately, you can tell that there was no woman's waterpolo team, and no men's Netball and Gymnastics team."



#2.Creates a box plot comparing hemoglobin concentrations by sport
ggplot(data=ais, aes(x = sport,y = hg))+
  geom_boxplot()+
  facet_wrap(~sex)


## BMB: why did you leave 'sport' alphabetically ordered? why not reorder
## by mean/median hg?
## coord_flip() would make it easier to read sport tick-mark labels

## "The authors analyzing the dataset were interested in seeing if endurance-intensive sports consisted of athletes
## that had higher hemoglobin concentrations than those in power-intensive sports. For instance, the median hemoglobin concentration is higher in female track and field
## athletes when compared to the gymnastics team. Using facet_wrap(), it appears that men tend to
## have higher hemoglobin concentrations than women for their respective sports.

## BMB: if your primary goal is the M/F comparison you shouldn't split by
## facets: instead, colour the boxplots (or fill them) and let ggplot
## dodge them for you

#3.Creates a scatterplot that illustrates correlation between red blood cell count and hemoglobin concentration
ggplot(data=ais)+
  geom_point(mapping = aes(x=rcc, y=hg, colour=sport))+
  geom_smooth(method = "lm", aes(x=rcc, y=hg))+
  facet_wrap(~sex)

##"A strong positive correlation is not surprising since hemoglobin is a protein found in red blood cells.
## I decided to add colour to determine any sports that potential outliers may come from."

## BMB: OK.
##  Why did you choose method="lm" rather than standard loess?
##  If you specify x=rcc, y=hg mappings in the original ggplot call,
##   you don't need to specify them for each geom -- they will be
##   inherited
