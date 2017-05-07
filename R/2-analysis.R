library(tidyverse)
library(tigris)
library(ggmap)
library(plotly)

data(fips_codes)

coords <- map("county")
df <- readRDS("./data/sample_with_counties.rds")

# get the top race population by state for every month of every year
df_race <- df %>%
  select(YEAR, MONTH, RACE, State, WTFINL) %>%
  group_by(YEAR, MONTH, State, RACE) %>%
  summarise(pop = round(sum(WTFINL), 0)) %>%
  arrange(YEAR, MONTH, State, desc(pop)) %>%
  group_by(YEAR, MONTH, State) %>%
  do(head(., 2)[2, ])

df_race$region = tolower(df_race$State)

for(i in 1:12){
  month_df <- df_race[df_race$YEAR == 2007 & df_race$MONTH == i, ]
  
  map_df <- map_data("state") %>%
    left_join(month_df)
  
  g <- ggplot(map_df) +
    geom_polygon(aes(long, lat, group=group, fill=RACE)) +
    guides(fill=FALSE) +
    ggtitle(i)
  print(ggplotly(g))
  
}


df %>% group_by(RACE) %>% summarise(pop = sum(WTFINL))



# Test count per state per month and per county per month
temp <- df %>%
  select(YEAR, MONTH, RACE, State, County) %>%
  group_by(YEAR, MONTH, State) %>%
  summarise(n=n())

temp <- temp[temp$YEAR == 2016 & temp$MONTH == 12, ]

# Not all states used
unique(df$State)

temp <- df %>%
  select(YEAR, MONTH, RACE, State, County) %>%
  group_by(YEAR, MONTH, State, County) %>%
  summarise(n=n())
temp <- temp[temp$YEAR == 2016 & temp$MONTH == 12, ]
