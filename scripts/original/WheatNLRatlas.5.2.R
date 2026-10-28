library(data.table)
library(parallel)
main_dir <- "21.out_bedtools_coverage_equal"
sub_dirs <- list.dirs(path = main_dir, recursive = FALSE)
files <- unlist(lapply(sub_dirs, list.files, full.names = TRUE))
files <- files[file.info(files)$size > 0]
#----------------------All_readscounts--------------
read_data_5 <- function(file) {
  data <- fread(file, select = 5)
  return(data[[1]])
}
num_cores <- min(20, detectCores()) 
all_values <- unlist(mclapply(files, read_data_5, mc.cores = num_cores))
library(ggplot2)
library(pracma)
if (length(all_values) > 0) {
  df <- data.frame(Value = all_values)
  density_data <- density(log10(df$Value), n = 1024)  
  x_values <- density_data$x
  y_values <- density_data$y    
  peaks <- findpeaks(y_values, nups = 2, ndowns = 2, sortstr = TRUE)
  troughs <- findpeaks(-y_values, nups = 2, ndowns = 2, sortstr = TRUE)
  peak_points <- data.frame(x = 10^x_values[peaks[,2]], y = peaks[,1])
  trough_points <- data.frame(x = 10^x_values[troughs[,2]], y = -troughs[,1])
  p <- ggplot(df, aes(x = log10(Value))) +
    geom_density(color = "blue", fill = NA) +
    geom_point(data = peak_points, aes(x = log10(x), y = y), color = "green", size = 3) + 
    geom_point(data = trough_points, aes(x = log10(x), y = y), color = "red", size = 3) + 
    theme_classic() +
    labs(title = "Distribution of Read Count on NLR (parallel)",
         x = "NLR-Mapped Reads Count (log10)",
         y = "Density") +
    theme(
      axis.title = element_text(size = 14),
      axis.text = element_text(size = 14),
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5)
    )
  print("Peak positions (log10 scale):")
  print(peak_points)
  print("Trough positions (log10 scale):")
  print(trough_points)
} else {
  print("No valid data found in column 5 of the files.")
}
ggsave("21.Rplot_density_readscount_all_equal.pdf",plot = p,width = 6,height = 4)

#--------------All NLRcoverage-------------
read_data_8 <- function(file) {
  data <- fread(file, select = 8)  
  return(data[[1]])  
}
num_cores <- min(20, detectCores())  
all_values_cov <- unlist(mclapply(files, read_data_8, mc.cores = num_cores))
library(ggplot2)
library(pracma)  
if (length(all_values_cov) > 0) {
  df <- data.frame(Value = all_values_cov)
  density_data <- density(df$Value, n = 1024) 
  x_values <- density_data$x 
  y_values <- density_data$y  
  peaks <- findpeaks(y_values, nups = 2, ndowns = 2, sortstr = TRUE)
  troughs <- findpeaks(-y_values, nups = 2, ndowns = 2, sortstr = TRUE)
  peak_points <- data.frame(x = x_values[peaks[,2]], y = peaks[,1])
  trough_points <- data.frame(x = x_values[troughs[,2]], y = -troughs[,1])
  p <- ggplot(df, aes(x = Value)) +
    geom_density(color = "#00BCD4", fill = NA) +
    geom_point(data = peak_points, aes(x = x, y = y), color = "#CDDC39", size = 3) + 
    geom_point(data = trough_points, aes(x = x, y = y), color = "#FF9800", size = 3) + 
    theme_classic() +
    labs(title = "Distribution of Read Coverage on NLR (parallel)",
         x = "Read Coverage on NLR",
         y = "Density") +
    theme(
      axis.title = element_text(size = 14),
      axis.text = element_text(size = 14),
      plot.title = element_text(size = 16, face = "bold", hjust = 0.5)
    )
  print(p)
  print("Peak positions:")
  print(peak_points)
  print("Trough positions:")
  print(trough_points)
} else {
  print("No valid data found in column 5 of the files.")
}
ggsave("21.Rplot_density_readscoverage_all_equal.pdf",plot = p,width = 6,height = 4)
