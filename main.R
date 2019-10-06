start <- Sys.time()

source("src/config.R")
source("src/functions.R")
source("src/apply_brute_force.R")

nrow(result_df)

end <- Sys.time()
end - start

# my_solution <- c("B4","C7","D5","E3","F6")