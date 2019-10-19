plot_combination <- function(combination,id = "x"){
  tibble(
    position = all_positions
  ) %>% 
    mutate(is.solution = position %in% combination) %>% 
    mutate(
      position_x = str_sub(position,1,1),
      position_y = str_sub(position,2,2),
    ) %>% 
    rowwise() %>% 
    mutate(field_color = get_field_color(position)) ->
    plot.data
  
  plot.data %>% 
    ggplot(aes(x = position_x, y = position_y, fill = field_color)) +
    geom_raster() +
    scale_fill_manual(values = c("grey","black"), guide = F) +
    geom_point(data = filter(plot.data, is.solution), color = "red", size = 4) +
    dark_theme_gray() +
    theme(
      aspect.ratio = 1,
      axis.title.x=element_blank(),
      axis.title.y=element_blank()
    )
  ggsave(paste0("img/solutions/",id,".png"), width = 70, height = 60, units = "mm")
}

for (i in c(1:nrow(result_df))){
  result_df %>%
    select(-id,-result) ->
    comb_to_plot
  id_to_plot <- result_df[[i,1]]
  comb_to_plot <- as_vector(comb_to_plot[i,])
  comb_to_plot <- unname(comb_to_plot)
  plot_combination(comb_to_plot,id_to_plot)
}

rm(plot.data,comb_to_plot,field_color,id_to_plot)