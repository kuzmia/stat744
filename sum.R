library(tidyverse)
library(ggplot2)
cdat <- read_csv("Carbohydrate_diet.csv")
gg0 <- (ggplot(cdat,
                aes(x=weight, y=carbohydrate))
         + geom_point()
)
print(gg0)
print(gg0 + geom_smooth(method="loess")
      + geom_smooth(method="lm", col="red"))

cdat <- mutate(cdat, f_age=cut_number(age,3))

gg1 <- (ggplot(cdat,aes(weight,carbohydrate,colour=f_age))
        + geom_point(aes(shape=f_age),size=4)
)

print(gg1+geom_smooth(method="lm",aes(group=1)))

print(gg1+geom_smooth(method="lm")+
        facet_wrap(~f_age))

gg2 <- (ggplot(cdat,
              aes(f_age,carbohydrate))+
  geom_boxplot()
)

print(gg2+
        geom_point(alpha=0.3))
