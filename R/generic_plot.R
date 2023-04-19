# Jessica

#Do we need to call this library outside of the function?
library(ggprism)

#QUESTIONS 
# 1. Are we still converting the timestamp to hours?
# 2. Do I need to differentiate between the two cases that were suggested 
# in the example.rmd?
# 3. What are the arguments?

#' Generic Plot Function
#' 
#' This function plots two different scenarios. One of the scenarios is a 
#' cumulative one. Essentially, the cumulative case takes the result of 
#' calculations created by the extract, mpc, and var_def functions; it then 
#' plots them. The second scenario has this function plotting specific session
#' wide variables.
#' 
#' @param timestamp A measure of time that will be converted to hours
#' 
#' @param x A data frame
#' 
#' @examples PUT SOMETHING HERE
#' 
#' @returns The function returns a visual of plotted data
#' 
#' @export 
generic_plot <- function(data = x, mapping = aes(), ..., environment = parent.frame()) {
  
  # Putting our data into "long form" in order to prepare it for graphing
  # Essentially eliminating columns in favor of more rows
  x = x %>% 
    tidyverse::pivot_longer(cols = c(3:6),
                 names_to = "measure",
                 values_to = "value" ) 
  
  final_d_df %>% 
    filter(measure == "active_total_cum") %>% 
    ggplot()+
    geom_step(aes(x = time_stamp, y = value),size = .25)+
    labs(x = "Time", y = "Cummulative Responses")+
    theme_prism(base_size = 11,base_line_size = 0.30)+
    scale_x_continuous(expand = c(0, 0))+ 
    scale_y_continuous(expand = c(0, 0))
}
