
# West Coast regional CPI 

# CPI for All Urban Consumers in the West Coast Region
  # https://data.bls.gov/timeseries/CUUR0400SA0,CUUS0400SA0

rm(list=ls())

library(rvest)

  url <- read_html("https://data.bls.gov/timeseries/CUUR0400SA0,CUUS0400SA0")

  xpath_node <- '//*[(@id = "table0")]//td | //*[(@id = "table0")]//th'
  
  month_Regional_CPI.df <- url %>%
    html_nodes(xpath = xpath_node) %>% 
    html_text() %>% 
    matrix(nrow = 16) %>%
    t() %>% 
    data.frame() 

  colnames(month_Regional_CPI.df) <- trimws(month_Regional_CPI.df[1, ])
  
  month_Regional_CPI_FINAL.df <- month_Regional_CPI.df %>% 
    slice(-1) %>% 
    select(-c(Annual, HALF1, HALF2)) %>% 
    gather(MONTH, 
           CPI, 
           Jan, 
           Feb, 
           Mar,
           Apr, 
           May,
           Jun,
           Jul, 
           Aug, 
           Sep,
           Oct,
           Nov, 
           Dec) %>% 
    rename(YEAR = Year) %>% 
    mutate(SOURCE = "CPI- Regional",
           MONTH = str_pad(match(MONTH,month.abb), width = 2, side = "left", pad = 0)) %>%
    mutate(YR_MONTH = paste0(YEAR, "-", MONTH))

# -----------------
# Save Final data set 
  
  write_csv(month_Regional_CPI_FINAL.df, file.path(".",
                                       "data",
                                       "Regional_CPI_monthly.csv"))
  


