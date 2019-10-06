result_df %>% 
  gather(key = "queen_no", value = "queen_position", 3:ncol(.)) %>% 
  select(-result,-queen_no) %>% 
  group_by(queen_position) %>% 
  mutate(n = n()) %>% 
  select(queen_position,n) %>% 
  unique() %>% 
  arrange(desc(queen_position)) %>% 
  mutate(
    queen_position_x = str_sub(queen_position,1,1),
    queen_position_y = str_sub(queen_position,2,2)
    ) %>% 
  ggplot(aes(x = queen_position_x, y = queen_position_y, fill = n)) +
  geom_raster() +
  scale_fill_gradient(
    high = "red",
    low = "yellow") +
  theme(aspect.ratio = 1) +
  dark_theme_gray()

ggsave("img/heatmap.png", width = 70, height = 60, units = "mm")
