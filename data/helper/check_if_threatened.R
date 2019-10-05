get_x_coordinate <-
  function(position){
    position_x <- str_sub(position,1,1)
    x_lookup %>% 
      filter(pos_x == position_x) ->
      x_df
    x <- x_df[[1,2]]
    return(x)
  }

get_y_coordinate <-
  function(position)
  {
    position_y = str_sub(position,2,2)
    position_y = as.numeric(position_y)
    y <- position_y - 4.5
    return(y)
  }

check_if_threatened <-
  function(queen,enemy){
    q_x <- get_x_coordinate(queen)
    q_y <- get_y_coordinate(queen)
    e_x <- get_x_coordinate(enemy)
    e_y <- get_y_coordinate(enemy)
    if_else(
      q_x == e_x,
      T,
      ifelse(
        q_y == e_y,
        T,
        ifelse(
          abs((q_y - e_y) / (q_x - e_x)) == 1,
          T,
          F
        )
      )
    ) ->
      threatened
    return(threatened)
  }

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