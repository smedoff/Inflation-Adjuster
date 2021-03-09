
# The purpose of this function is to calc the CPI multiplier that turns nominal prices 
  # into real prices relative to a specified year. 

library(readr)
library(dplyr)
library(tidyverse)

adjusting_cpi.f <- function(cpi_df, adj_yr){
  
  cpi_yr.df <- cpi_df %>% 
    group_by(YEAR) %>% 
    summarize(CPI = mean(CPI, na.rm = TRUE))
  
  cpi_adj_yr.df <- cpi_yr.df %>% 
    filter(YEAR == adj_yr)
  
  cpi_adj.df <- cpi_yr.df %>% 
    mutate(CPI_ADJ = cpi_adj_yr.df$CPI/CPI)
}


