
rm(list=ls())

library(dplyr)
library(tidyverse)
library(readr)
library(purrr)

# List the data to pull in
  data_sets_names.v <- list.files(file.path(".",
                                            "data"), pattern="*.csv")

# Pull all data in and create a list
  inf.l <- lapply(1:length(data_sets_names.v), FUN = function(file){
    read.csv(file.path(".",
                       "data",
                       data_sets_names.v[file]))
  })

# For the graph we need each data set to have the same names
  inf_clean.l <- map(inf.l, ~ .x %>% 
                           rename_at(vars(any_of(c("CPI", "GDP"))), ~ "TYPE"))

# Combine list elements to a data frame 
  inf.df <- do.call(rbind, inf_clean.l)
  
# Data sets measure different values.  Plotting raw data will not be informative because the 
  # scales will be off.  If we are only interested in comparing trends, we will plot the standardized
  # data as a means to unify the scale of axis 
  inf_standardized.df <- inf.df %>% 
    group_by(SOURCE) %>% 
    summarize(avg = mean(TYPE, na.rm = TRUE),
              standdev = sd(TYPE, na.rm = TRUE)) %>% 
    right_join(inf.df) %>% 
    mutate(standardized_TYPE = (TYPE - avg)/standdev) %>% 
    select(YEAR, SOURCE, standardized_TYPE)
  
# Data sets are at the monthly, quarterly, and annual level.  Unify levels to yearly for plot
  inf_yr.df <- inf_standardized.df %>% 
    group_by(YEAR, SOURCE) %>% 
    summarize(STD_VALUE = mean(standardized_TYPE, na.rm = TRUE))
  


# Produce a time series plot
  ggplot(inf_yr.df, aes(YEAR, STD_VALUE)) + 
    geom_line(aes(color = SOURCE, group = SOURCE)) +
    labs(title = "Time Series of Yrly Inflation Adjusters",
         subtitle = paste0("All data sets are standardized by subtracting the mean and dividing by the standard deviation"))  + 
    theme(plot.caption=element_text(hjust = 0)) 
  ggsave(file.path(".",
                   "figures",
                   "Inflation_Adj_TS.png"), 
         device = "png")
  












