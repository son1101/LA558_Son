install.packages(c("usmap", "usmapdata", "ggplot2"))

install.packages("sf")
library(s2)
vars <- load_variables(2021, "acs5")

ACS_California_Total <- get_acs (
  geography = "county",
  state="CA",
  variables = "C16001_001",
  year = 2021,
  geometry = TRUE
)

ACS_California_KorOnly <- get_acs(
  geography ="county",
  state = "CA",
  variables = "C16001_018",
  year = 2021,
  geometry = TRUE
)

ACS_California_Lang <- st_join(ACS_California_Total, ACS_California_KorOnly, join=st_equals)

ACS_California_Lang <- ACS_California_Lang %>%
  mutate(PerKorean = round(estimate.y/estimate.x,3)*100)

library(ggplot2)

myMap <- ggplot(ACS_California_Lang, aes(fill = PerKorean)) +
  geom_sf() +
  scale_fill_continuous(limits = c(0, 3), low = "white", high ="red") +
  labs(title = "Percentage of Korean-Only Speakers in California Counties (2021)", fill = "Percentage(%)") +
  theme(plot.title=element_text(hjust=0.5)) +
  theme_void()
  

myMap


