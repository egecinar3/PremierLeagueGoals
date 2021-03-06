library(tidyverse)
library(ggplot2)
library(ggthemes)
library(worldfootballR)
library(ggrepel)
prem_2021_shooting <- get_season_team_stats(country = "ENG", 
                                            gender = "M", 
                                            season_end_year = "2021",
                                            tier = "1st",
                                            stat_type = "shooting")

data <- prem_2021_shooting %>%
  filter(Team_or_Opponent == "team") %>%
  select(Squad, Gls_Standard, xG_Expected) %>%
  mutate(Color = ifelse(Gls_Standard>xG_Expected, "Green", "Red")) %>%
  ggplot(aes(x = Gls_Standard, y = xG_Expected,color = Color))+
  xlab("Goals Scored") +
  ylab("Goal Expectancy") +
  labs(caption = "Chart: @egecinar3") +
  xlim(15, 90) +
  geom_point(aes(size = 14))+ 
  theme_fivethirtyeight() +
  geom_text_repel(
    color = "Black",
    force = 20,            
    aes(label = Squad),
    nudge_y = -1,
    fontface = "bold"
  ) +
  scale_color_identity()+

  theme(legend.position = "none",
    axis.text.x = element_text(face = "bold", size=12),
    axis.text.y = element_text(face = "bold", size=12),
    axis.title = element_text(face = "bold", size=16))
data
