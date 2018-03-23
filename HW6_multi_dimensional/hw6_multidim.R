library(aplpack)
library(rattle.data)

df <- wine

df %>%
  group_by(Type) %>% #group the wine data dataset by the type of wine (Type: 1,2,3)
  summarise_all(funs(mean)) -> df2 #collapse the dataset by summarizing with taking means of each variable


faces(df2[,2:14]) #generate 3 faces (on for each type of wine) illustrating the differences of each variable
