

# Hawaii CPI
  # https://data.bls.gov/timeseries/CUURS49FSA0 

rm(list=ls())

library(rvest)
library(dplyr)
library(tidyverse)
library(blscrapeR)

  url <- read_html("https://data.bls.gov/timeseries/CUURS49FSA0")
  
  xpath_node <- '//*[(@id = "table0")]//td | //*[(@id = "table0")]//th'
  
  yr_CPI.df <- url %>%
    html_nodes(xpath = xpath_node) %>%
    html_text() %>% 
    matrix(nrow = 16) %>%
    t() %>% 
    data.frame() 
  
  colnames(yr_CPI.df) <- trimws(yr_CPI.df[1, ])
  
  yr_CPI.df <- yr_CPI.df %>% 
    rename(YEAR = Year,
           YR_AVG_CPI = Annual) 

# Formatting the pre-2017 data.  This data is at the annual level  
  yr_CPI_pre2017.df <- yr_CPI.df %>% 
    slice(-1) %>% 
    filter(YEAR <= 2017) %>% 
    select(YEAR, YR_AVG_CPI)

# Assign the yearly average to all months in the pre-2018 data to match
# data levels.   
  month_HI_CPI_pre2017.df <- expand_grid(YEAR = yr_CPI_pre2017.df$YEAR, 
                                         MONTH = format(ISOdatetime(2000,1:12,1,0,0,0),"%B")) %>% 
    left_join(yr_CPI_pre2017.df, by = "YEAR") %>% 
    select(YEAR, MONTH, CPI = YR_AVG_CPI) %>% 
    mutate(SOURCE = "CPI- Hawaii")

# Querying the data using bls_api only pulls in data from 2019 onward, obtain the 2018 data 
# using the rvest-produced data set. 
  month_HI_CPI_2018.df <- yr_CPI.df %>% 
    filter(YEAR == 2018) %>%
    gather(MONTH, CPI, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec) %>% 
    select(YEAR, MONTH, CPI) %>% 
    mutate(SOURCE = "CPI- Hawaii")
  
  month_HI_CPI_pre2018.df <- rbind(month_HI_CPI_pre2017.df, month_HI_CPI_2018.df)


#----
# Obtain post 2018 data for HI CPI

  month_HI_CPI_post2018.df <- bls_api("CUURS49FSA0") %>% 
    select(YEAR = year, 
           MONTH = periodName,
           CPI = value) %>% 
    mutate(SOURCE = "CPI- Hawaii")

# Make sure all months are in the data set (since the data is measured every two months)
  month_HI_CPI_post2018.df <- expand_grid(YEAR = month_HI_CPI_post2018.df$YEAR, 
                                          MONTH = format(ISOdatetime(2000,1:12,1,0,0,0),"%B")) %>% 
    left_join(month_HI_CPI_post2018.df) %>% 
    mutate(SOURCE = "CPI- Hawaii")

# Binding pre 2018 and post 2018 data sets
  month_HI_CPI.df <- rbind(month_HI_CPI_pre2018.df, month_HI_CPI_post2018.df) %>% 
    mutate(CPI = as.numeric(CPI),
           MONTH_NO = match(MONTH, month.name), 
           YR_MONTH = paste0(YEAR, "-", str_pad(MONTH_NO, "left", width = 2, pad = 0))) %>% 
    select(-MONTH_NO)
  
# -----------------
# Save Final data set 
  
  write_csv(month_HI_CPI.df, file.path(".",
                                    "data",
                                    "HI_CPI_monthly.csv"))

#--------------
# sm edits:  As Jon suggested, do not impute values. If anything transfer this to 
  # a helper function and add it to the supplementary code folder 
  
# Impute missing months with mean values within the same year  
# Make sure you do not impute current year 
#  HI_CPI_currentyr.df <- month_HI_CPI.df %>% 
#    filter(YR_MONTH == substr(Sys.Date(), 1, 7))

# Impute past years 
#  HI_CPI_impute.df <- month_HI_CPI.df %>% 
#    anti_join(HI_CPI_currentyr.df) %>% 
#    group_by(YEAR) %>% 
#    mutate(CPI = ifelse(is.na(CPI), mean(CPI, na.rm = TRUE), CPI))

# Combine current year df and imputed df 
#  month_HI_CPI.df <- rbind(HI_CPI_impute.df, HI_CPI_currentyr.df)
  
#  rm(month_HI_CPI_pre2018.df, month_HI_CPI_post2018.df)
  
