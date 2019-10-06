result_df %>% 
  mutate(
    queens = paste0(queen1," ",queen2," ",queen3," ",queen4," ",queen5)
  ) %>% select(id,queens) ->
  result_df_compact

combn(all_positions,2) -> all_pairs

impossible_pairs <- c()

for (i in c(1:ncol(all_pairs))){
  result_df_compact %>% 
    filter(str_detect(queens,all_pairs[1,i]) & str_detect(queens,all_pairs[2,i])) %>% 
    nrow() ->
    check
  if (check == 0){impossible_pairs <- c(impossible_pairs,i)}
}

# There are 40 pairs not connected to a solution.
# So for almost any given pair of positions, you can find a solution.