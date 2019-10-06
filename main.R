start <- Sys.time()

# load packages and create some datasets we will need
source("src/config.R")

# functions to check if a string of queens is a valid solution
source("src/functions.R")

# loop through all possible combinations to find valid solutions
# BE CAREFUL: this takes many hours and uses ALL the cores in your CPU
source("src/apply_brute_force.R")

# number of valid solutions
nrow(result_df)

end <- Sys.time()
# total computation time:
end - start

# now, some analysis on the data
source("src/plot_heatmap.R")
source("src/check_on_pairs.R")

# my_solution <- c("B4","C7","D5","E3","F6")