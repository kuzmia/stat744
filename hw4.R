library(tidyverse)
library(readr)
library(directlabels)

## BMB: where are your data files? they don't seem to be pushed to
##  your repo?
df <- read.csv("POCIS_Raw_McCallum.csv")
drugnames <- read_csv("drugnames.csv")

df2 <- df %>% 
  gather(key = chemical, value = Concentration, colnames(df[,5:28])) #gather chemical variables and have them under one variable called 'chemical'
df2 <- mutate(df2,type="") #add a 'type' variable

## BMB: best not to use column numbers in workflows (fragile)

for(i in 1:24){
  df2$type[df2$chemical == drugnames$abbr[i]] <- drugnames$drugcat[i]
} #fills up type variable with appropriate drug type

## BMB: could do this with full_join() (or base::merge())

df3 <- group_by(df2,Site,chemical,type) #grou_by Site, chemical and type
df4 <- summarise(df3, meanConc = mean(Concentration)) #summarise by providing the mean of concnetrations of samples of each chemical at each site
## BMB: would be easier if you named this as above

gg1<-ggplot(data=df2, mapping=aes(x=Site, y=Concentration, colour=chemical))+
  geom_point()+
  facet_wrap(~type, scale="free")+ #facet by chemical type and free the scale to better see individual change in concentration
  scale_x_discrete(limits=c("WWTP", "Outfall", "Downstream", "Control"))+ #specify order of x-axis
  scale_color_discrete(h=c(0,360), direction = 3) #made colour between points from the same type more distinguishable
direct.label(gg1) #apply direct labelling to remove need for legend
## BMB: nice!

#This plot illustrates the concentrations of the 3 samples taken for each chemical at sequentially different sites.
#The need for a legend was removed by applying a direct label for each chemical to the plot because there were too many colours --
#would make points too difficult to distinguish. I thought it would be a good idea to have relevant portions of a legend
#positioned inside each facet, but I did not know how to do this.

## BMB: seems hard

## Overall, I think this plot illustrates the change in concentration of particular
#chemicals at different sites quite well. A geom_line would likely improve the perception of change.

#Improvements: add a geom_line which plots at the average of the 3 samples. This plot was created below
#but when I tried to include it in gg1 and separate the lines at each facet, the mean(concentration) would plot inaccurately.

## BMB: something like this?
df2 %>% group_by(chemical,Site,type) %>%
    summarise(Concentration=mean(Concentration)) -> df2_sum
gg1 + geom_line(data=df2_sum,aes(group=chemical)) +
    geom_dl(method="top.bumpup",aes(label=chemical))
## I chose "top.bumpup", not sure what the default is for points, but
## I think it's better than what I chose ...
## in principle stat_summary() can do this too, but my head hurt
##  trying to average by chemical+site but then draw lines connecting
##   chemicals across sites ...

gg2<-ggplot(data=df4, mapping = aes(x=Site, y=meanConc, group=chemical))+
  geom_line(aes(colour=chemical))+
  scale_x_discrete(limits=c("WWTP", "Outfall", "Downstream", "Control"))+
  ylab("mean Concentration")
gg2


## BMB: what about order of chemicals?
## any way to adjust the scale so it's not dominated by
## sucralose? would a log scale help if you
## could do something sensible with the zeros?
## lines + points might be nice here.
## other colour choices?
## order of sites? (good to have control first?)
