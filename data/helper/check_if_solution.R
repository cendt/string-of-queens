check_if_solution <-
  function(queens){
    tibble(
      position = all_positions
    ) %>% 
      rowwise() %>% 
      mutate(
        queen_one = check_if_threatened(queens[1],position),
        queen_two = check_if_threatened(queens[2],position),
        queen_three = check_if_threatened(queens[3],position),
        queen_four = check_if_threatened(queens[4],position),
        queen_five = check_if_threatened(queens[5],position),
        threatened = queen_one | queen_two | queen_three | queen_four | queen_five
      ) %>% 
      filter(threatened == F) ->
      unthreatened
    if_else(nrow(unthreatened) == 0,T,F) ->
      is_solution
    return(is_solution)
  }