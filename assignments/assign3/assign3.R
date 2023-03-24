library(tidycensus)
library(tidyverse)

install.packages("idbr", dependencies = TRUE)
install.packages("hrbrthemes")
install.packages(c("usmap", "usmapdata", "ggplot2"))
library(idbr)
library(ggplot2)
library(dplyr)
library(hrbrthemes)
library(sf)
library(s2)

# A MAP USING VARIABLES OF CHOICE FROM TidyCensus

vars1 <- load_variables(2021, "acs5")

#B08101_001: Estimate!!Total: MEANS OF TRANSPORTATION TO WORK (16 TO ALL)
#B08101_025: Estimate!!Total:!!Public transportation (excluding TAXICAB) (16 TO ALL)

PublicTrans <- get_acs(
  geography = "state",
  state = c("Alabama", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"),
  variables = "B08101_025",
  year=2021,
  summary_var = "B08101_001",
  geometry = TRUE
)

PublicTrans <- PublicTrans %>%
  mutate(PercPT = round(estimate/summary_est, 3)*100)

plot(PublicTrans["PercPT"])

ggplot(PublicTrans) +
  geom_sf(aes(fill = PercPT)) +
  scale_fill_gradient(low = "white", high = "#54278f") +
  labs(title = "Percentage of Workers Using Public Transportation to Work (2021)",
              fill = "Percentage",
       caption = "Source: ACS 2021") +
  theme_void() +
  theme(plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
        plot.subtitle = element_text(size = 14, hjust = 0.5),
        plot.caption = element_text(size = 12),
        panel.grid.major = element_line(color = "white"),
        panel.grid.minor = element_line(color = "white"),
        legend.position = "bottom",
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12),
        legend.background = element_rect(fill = "white", size = 0.5, linetype = "solid",
                                         color = "grey50", inherit = FALSE),
        legend.key.width = unit(2, "cm"))
  





# A PLOT USING THE WORLD DATA AND THE IDBR PACKAGE

vars = idb_variables()
view(vars)

KFERTIL <- get_idb(
  country = "KR",
  variables = "TFR",
  year = 1990:2022
)

JFERTIL <- get_idb(
  country = "JP",
  variables = "TFR",
  year = 1990:2022
)

ggplot() +
  geom_line(data = KFERTIL, aes(x=year, y=tfr, color = "blue"), group = 1) +
  geom_point(data = KFERTIL, aes(x=year, y=tfr, color = "South Korea"), shape=21, color="blue", fill="blue", size=2) +
  geom_line(data = JFERTIL, aes(x=year, y=tfr, color = "red"), group = 2) +
  geom_point(data = JFERTIL, aes(x=year, y=tfr, color = "Japan"), shape=21, color="red", fill="red",size=2) +
  ggtitle("Total Fertility Rate of South Korea and Japan (1990-2022)") +
  ylab("Total Fertility Rate") +
  xlab("Year") +
  scale_x_continuous(breaks = seq(1990, 2022, by = 4)) +
  scale_color_manual(name = "Country", values = c("blue", "red"), labels = c("South Korea", "Japan")) +
  theme_ipsum() +
  geom_text(data = KFERTIL, aes(x = year, y = tfr, label = round(tfr, 2), color = "blue"), size = 2, vjust = -1) +
  geom_text(data = JFERTIL, aes(x = year, y = tfr, label = round(tfr, 2), color = "red"), size = 2, vjust = -1)

  
# A PLOT USING .csv file 

##Employment by Industry in Clarke County and USA (2017)

library(readxl)
install.packages("fmsb")
library(fmsb)
library(ggplot2)
library(tidyr)

data <-read_excel("assign3.xlsx")

data_long <- data %>%
  pivot_longer(cols =c(Clarke_County, USA), names_to="Category", values_to="Value")

ggplot(data_long, aes(x = Employment, y = Value, fill = Category)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  ggtitle("Percentage of Employment by Industry (2017)") +
  xlab("Industry") + 
  ylab("Percentage") +
  coord_flip()
  









