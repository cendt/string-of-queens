# a little helper that will # translate an alphabetic coordinate ABCDEFGH to a cartesian one,
# using a lookup table I created by hand.
get_x_coordinate <-
  function(position){
    position_x <- str_sub(position,1,1)
    x_lookup %>% 
      filter(pos_x == position_x) ->
      x_df
    x <- x_df[[1,2]]
    return(x)
  }

# a little helper for transforming the Y coordinate as well
get_y_coordinate <-
  function(position)
  {
    position_y = str_sub(position,2,2)
    position_y = as.numeric(position_y)
    y <- position_y - 4.5
    return(y)
  }

# check if two positions are on the same diagonal.
# this is done by calculating the slope of the line that connects them
# if the slope is -1 or +1, it's a diagonal
check_if_diagonal <-
  function(queen,enemy){
    q_x <- get_x_coordinate(queen)
    q_y <- get_y_coordinate(queen)
    e_x <- get_x_coordinate(enemy)
    e_y <- get_y_coordinate(enemy)
    ifelse(
          abs((q_y - e_y) / (q_x - e_x)) == 1,
          T,
          F
    ) ->
      diagonal
    return(diagonal)
  }

# this function takes a string of five queens
# and checks if it works
# via checking for all 64 fields wether they are threatened
# first, everything that shares a row or column with a queen is cleared
# the rest ist checked for diagonal connections, using the function from above
# the function stops as soon as it finds an unthreatened position
check_if_solution <-
  function(queens){
    queen_cols <- unique(str_sub(queens,1,1))
    queen_rows <- unique(str_sub(queens,2,2))
    tibble(
      position = all_positions
    ) %>%
      filter(
        !(str_sub(position,1,1) %in% queen_cols),
        !(str_sub(position,2,2) %in% queen_rows)
      ) ->
      positions_to_check
    p <- 1
    threatened <- T
    while (p <= nrow(positions_to_check) & threatened == T) {
      position <- positions_to_check[[p,1]]
      queen_one = check_if_diagonal(queens[1],position)
      queen_two = check_if_diagonal(queens[2],position)
      queen_three = check_if_diagonal(queens[3],position)
      queen_four = check_if_diagonal(queens[4],position)
      queen_five = check_if_diagonal(queens[5],position)
      threatened = queen_one | queen_two | queen_three | queen_four | queen_five
      p <- p + 1
    }
    is_solution <- threatened
    return(is_solution)
  }

# this function is not in use anymore, because it uses to much computation time
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

### this was an alternative approach which turned out to take almost 2x computation time
# find_diagonals <-
#   function(pos){
#     xc <- get_x_coordinate(pos)
#     yc <- get_y_coordinate(pos)
#     d1 <- c()
#     d2 <- c()
#     d3 <- c()
#     d4 <- c()
#     while (abs(xc) < 4 & abs(yc) < 4) {
#       pos_x <- filter(x_lookup, x == xc)[[1,1]]
#       pos_y <- yc + 4.5
#       d1 <- c(d1,paste0(pos_x,pos_y))
#       xc <- xc + 1
#       yc <- yc - 1
#     }
#     xc <- get_x_coordinate(pos)
#     yc <- get_y_coordinate(pos)
#     while (abs(xc) < 4 & abs(yc) < 4) {
#       pos_x <- filter(x_lookup, x == xc)[[1,1]]
#       pos_y <- yc + 4.5
#       d2 <- c(d2,paste0(pos_x,pos_y))
#       xc <- xc - 1
#       yc <- yc + 1
#     }
#     xc <- get_x_coordinate(pos)
#     yc <- get_y_coordinate(pos)
#     while (abs(xc) < 4 & abs(yc) < 4) {
#       pos_x <- filter(x_lookup, x == xc)[[1,1]]
#       pos_y <- yc + 4.5
#       d3 <- c(d3,paste0(pos_x,pos_y))
#       xc <- xc + 1
#       yc <- yc + 1
#     }
#     xc <- get_x_coordinate(pos)
#     yc <- get_y_coordinate(pos)
#     while (abs(xc) < 4 & abs(yc) < 4) {
#       pos_x <- filter(x_lookup, x == xc)[[1,1]]
#       pos_y <- yc + 4.5
#       d4 <- c(d4,paste0(pos_x,pos_y))
#       xc <- xc - 1
#       yc <- yc - 1
#     }
#     return(unique(c(d1,d2,d3,d4)))
#   }
# 
# check_if_solution_alternative_approach <-
#   function(queens){
#     queen_cols <- unique(str_sub(queens,1,1))
#     queen_rows <- unique(str_sub(queens,2,2))
#     tibble(
#       position = all_positions
#     ) %>%
#       filter(
#         !(str_sub(position,1,1) %in% queen_cols),
#         !(str_sub(position,2,2) %in% queen_rows),
#         !(position %in% find_diagonals(queens[1])),
#         !(position %in% find_diagonals(queens[2])),
#         !(position %in% find_diagonals(queens[3])),
#         !(position %in% find_diagonals(queens[4])),
#         !(position %in% find_diagonals(queens[5]))
#       )  %>% 
#       nrow() ->
#       check
#     is_solution <- if_else(check == 0,T,F)
#     return(is_solution)
#   }

get_field_color <-
  function(position){
    position_x <- str_sub(position,1,1)
    position_y <- str_sub(position,2,2)
    position_y <- as.numeric(position_y)
    field_color <- "bright"
    if (
      position_y %% 2 == 1 & position_x %in% c("A","C","E","G")) {
      field_color <- "dark"
    }
    if (position_y %% 2 == 0 & !(position_x %in% c("A","C","E","G"))) {
      field_color <- "dark"
    }
    return(field_color)
  }
