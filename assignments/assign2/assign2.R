# Assignment #2
# Hyunsik Son

library(tidyverse)

Assign2_Son <- read_xlsx('LA558_Assign2.xlsx', sheet ="for R")



# Which County in Iowa has the highest percentage of K12 students?

PercentAsian <-Assign2_Son %>%
  group_by(COUNTYNAME) %>%
  summarize(TotalK12= sum(TotalK12), AsianTotal= sum(AsianTotal)) %>%
  mutate(PercAsian = round(AsianTotal / TotalK12, 3)*100) %>%
  as.data.frame()

#Bar Plot
v1 <-ggplot(data=PercentAsian, aes(x=COUNTYNAME, y=PercAsian))+
  geom_bar(stat="identity", width=0.4, color="black", fill="black")+
  theme(plot.title = element_text(hjust = 0.5))+
  geom_text(aes(label=PercAsian), size=2, hjust= -1.0, color="black")+
  theme(axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 5))+
  xlab("County")+
  ylab("Percentage")+
  ggtitle("Percentage of Asian K-12 students \n by County in Iowa")+
  coord_fixed(ratio=0.5)+
  coord_flip()+
  theme(aspect.ratio = 2)
v1

ggsave("Plot_Assign2.png", dpi = 500)


write.csv(PercentAsian, file="Assign2_ForGIS.csv")

  


              
            


            

            