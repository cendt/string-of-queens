library(tidyverse)

# install.packages("foreach")
library(foreach)

# install.packages("doParallel")
library(doParallel)

registerDoParallel(detectCores())

x_lookup <-
  read_csv("data/helper/x_lookup.csv")

all_positions <- c()

for(i in c(1:8)){
  position_x <- x_lookup$pos_x[i]
  for (j in c(1:8)){
    position_y <- j
    position <- paste0(position_x,position_y)
    all_positions <- c(all_positions,position)
  }
}

combn(all_positions,5) -> all_combinations