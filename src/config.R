library(tidyverse)

# install.packages("foreach")
library(foreach)

# install.packages("doParallel")
library(doParallel)

# this checks how many cores the machine has, and assignes all of them to the task
registerDoParallel(detectCores())

# translate alphabet coordinates ABCDEFGH to cartesian
x_lookup <-
  read_csv("data/helper/x_lookup.csv")

# create a vector of all 64 positions on the field
all_positions <- c()
for(i in c(1:8)){
  position_x <- x_lookup$pos_x[i]
  for (j in c(1:8)){
    position_y <- j
    position <- paste0(position_x,position_y)
    all_positions <- c(all_positions,position)
  }
}

# create a matrix with all possible combinations of 5 out of 64 positions
combn(all_positions,5) -> all_combinations

### this is only for Instagram
# install.packages("ggdark")
library(ggdark)
