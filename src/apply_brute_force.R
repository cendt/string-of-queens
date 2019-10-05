foreach (i=1:100, .combine = c, .multicombine = T) %dopar% {
  check_if_solution(all_combinations[,i]) -> check
  if (i %% 100000 == 0){print(paste0("Progress: ",i," out of 7.6 million done"))}
  check
  } ->
  result_list

save(result_list, file = "data/result_list.Rdata")

tibble(id = c(1:length(result_list)), result = result_list) %>% 
  filter(result) ->
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