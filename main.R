start <- Sys.time()

source("src/config.R")
source("src/functions.R")
source("src/apply_brute_force.R")

nrow(result_df)

end <- Sys.time()

# total computation time:
end - start

# now, some analysis on the data
source("src/plot_heatmap.R")

# my_solution <- c("B4","C7","D5","E3","F6")