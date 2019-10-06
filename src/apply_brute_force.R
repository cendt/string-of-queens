foreach (i=1:ncol(all_combinations), .combine = c, .multicombine = T) %dopar% {
  check_if_solution(all_combinations[,i]) -> check
  check
  } ->
  result_list

save(result_list, file = "data/result_list.Rdata")

tibble(id = c(1:length(result_list)), result = result_list) %>% 
  filter(result) ->
  result_df

result_df %>% 
  mutate(
    queen1 = all_combinations[1,id],
    queen2 = all_combinations[2,id],
    queen3 = all_combinations[3,id],
    queen4 = all_combinations[4,id],
    queen5 = all_combinations[5,id]
  ) ->
  result_df

save(result_df, file = "data/result_df.Rdata")

# start <- Sys.time()
# foreach (i=1:32000, .combine = c, .multicombine = T) %dopar% {
#   check_if_solution_alternative_approach(all_combinations[,i]) -> check
#   check
# }
# result <- .Last.value
# end <- Sys.time()
# end - start
# tibble(id = c(1:length(result)), result = result) %>% filter(result)