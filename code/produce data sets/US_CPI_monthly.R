
## Scraping the CPI data from 

# NOTES: 
  # the bls.gov website limits the number of data requests daily
  # keep this in mind when pulling the data 
  # https://github.com/keberwein/blscrapeR/issues/16 
    # "The BLS documentation specifies "500 requests daily," 
        # but they don't define what they consider a "day." 
        # Looks to me like it's 24-hours."
# HI CPI
  # Querying the HI CPI data imposes some limitations that I haven't quite figured
    # out yet.  Fortunately, I have included some work-arounds. 
    # When querying the HI CPI data, the blscrapeR::bls_api seems to only successfully 
    # query 2019 onward.  To obtain data from earlier years I use the rvest package to 
    # scrape the data table directly from the website.  Because the website naturally only 
    # displays data from 2011 on-ward, the earliest data observation is from 2011.  
    # If you need data from pre-2011 you will need to go to the website directly and download
    # the xcel spreadsheet.  
    # In addition, the CPI is collected (bi)annually up until 2017.  After 2017, its collected 
    # every two months.  


#----------------------------

rm(list = ls())

library(tidyverse)
library(ggplot2)
library(zoo)

#----------------------------
# United States CPI 
  # https://beta.bls.gov/dataViewer/view/timeseries/CUUR0000SA0

library(blscrapeR)
# - More able blscrapeR package: https://www.datascienceriot.com/r/inflation-blscraper/

# The website only allows 9 years of data to be pulled at a time
  # to make sure we do not miss any observations, pull in one year of data
  # at a time and loop over all over the years of interest 


  years <- 2000:2021
  
  month_US_CPI.l <- list()
  for(i in 1:length(years)){
    
    one_year <- years[i]
    
    month_US_CPI_oneyr <- bls_api("CUSR0000SA0", 
                                  startyear = one_year, 
                                  endyear = one_year) %>%
      select(YEAR = year,
             MONTH = periodName,
             CPI = value) %>% 
      mutate(SOURCE = "CPI- National",
             MONTH_NO = 12:1) %>% 
      arrange(MONTH_NO)
    
    month_US_CPI.l[[i]] <- month_US_CPI_oneyr
    
    print(paste0(one_year, " US CPI downloaded"))
  }
  
  month_US_CPI.df <- do.call(rbind, month_US_CPI.l) %>% 
    select(-MONTH_NO) %>%
    mutate(CPI = as.numeric(CPI),
           MONTH_NO = match(MONTH, month.name), 
           YR_MONTH = paste0(YEAR, "-", str_pad(MONTH_NO, "left", width = 2, pad = 0))) %>% 
    select(-MONTH_NO)

  
# -----------------
# Save Final data set 
  
  write_csv(month_US_CPI.df, file.path(".",
                                       "data",
                                       "US_CPI_monthly.csv"))


 