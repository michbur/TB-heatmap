library(tidyverse)
library(visdat)
library(naniar)
library(WHO)  

who_tuberculosis <- who %>% 
  select(country, year, new_sp_m3544) %>% 
  complete(country, year, fill = list(new_sp_m3544 = NA)) %>% 
  mutate(is_na_nice = ifelse(is.na(new_sp_m3544), "Missing", "Present")) %>% 
  select(-new_sp_m3544) 

p <- ggplot(who_tuberculosis, aes(x = year, y = country, fill = is_na_nice)) +
  geom_tile(color = "white") +
  scale_fill_manual("", values = c("black", "grey")) +
  theme_bw() +
  theme(legend.position = "bottom")
  
png("heatmap.png", height = 1024*8, width = 486*4, res = 300)
p
dev.off()


