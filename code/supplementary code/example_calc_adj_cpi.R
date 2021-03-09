
# This code shows the use of the adjusting_CPI helper function 

rm(list = ls())

source(file.path(".", 
                 "code",
                 "hlprfnc_adjusting_CPI.R"))

#--------------
# loading in CPI data 
  CPI.df <- read_csv(file = file.path(".",
                                      "data",
                                      "CPI_final.csv")) %>% 
    filter(SOURCE == "US CPI")

# Take a look at what the CPI df looks like 
  head(CPI.df)

# Run the function 
  CPI_adjr.df <- adjusting_cpi.f(cpi_df = CPI.df, 
                                adj_yr = 2014)

# Take a look at resulting data frame 
  head(CPI_adjr.df)

