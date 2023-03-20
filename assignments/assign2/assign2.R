# Assignment #2
# Hyunsik Son

library(tidyverse)

Assign2_Son <- read_xlsx('LA558_Assign2.xlsx', sheet ="for R")



# Which County in Iowa has the highest percentage of Asian K12 students?

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



# Which County in Iowa has the highest percentage of Black K12 students?

Assign2_Son <- read_xlsx('LA558_Assign2.xlsx', sheet ="for R")


PercentBlack <-Assign2_Son %>%
  group_by(COUNTYNAME) %>%
  summarize(TotalK12= sum(TotalK12), BlackTotal= sum(BlackTotal)) %>%
  mutate(PercBlack = round(BlackTotal / TotalK12, 3)*100) %>%
  as.data.frame()


write.csv(PercentBlack, file="Assign2_ForGIS.csv")



# Which County in Iowa has the highest percentage of Black K12 students?

Assign2_Son_2 <- read_xlsx('LA558_Assign2.xlsx', sheet ="for R")


PercentBlack_2 <-Assign2_Son_2 %>%
  group_by(COUNTYNAME) %>%
  summarize(TotalK12= sum(TotalK12), BlackTotal= sum(BlackTotal)) %>%
  mutate(PercBlack = round(BlackTotal / TotalK12, 3)*100) %>%
  as.data.frame()

iowaCounties_sf <- st_read("Counties.shp")

ggplot()+
  geom_sf(data = iowaCounties_sf, size = 3, color = "black", fill = "red")+
  ggtitle("LA 558")+
  coord_sf()

iowaCounties_sf <-iowaCounties_sf %>%
  rename("COUNTYNAME" ="COUNTY")

myMap <- left_join(iowaCounties_sf, PercentBlack_2, by="COUNTYNAME")

ggplot(myMap) +
  geom_sf(aes(fill = PercBlack))+
  ggtitle("Percentage of Black K-12 students by County in Iowa")+
  theme_void()+
  theme(plot.title=element_text(hjust=0.5))
  
            


            

            