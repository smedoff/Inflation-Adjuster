
# This script pulls int he national GDP data from the FRED website
# https://fred.stlouisfed.org/series/GDPDEF 

rm(list=ls())

library(readr)
library(tidyverse)
library(dplyr)

  quart_US_GDP.df <- read.csv(paste0("https://fred.stlouisfed.org/graph/fredgraph.csv?bgcolor=", 
  "%23e1e9f0&chart_type=line&drp=0&fo=open%20sans&graph_bgcolor", 
  "=%23ffffff&height=450&mode=fred&recession_bars=on&txtcolor=%23", 
  "444444&ts=12&tts=12&width=1168&nt=0&thu=0&trc=0&show_legend=yes&", 
  "show_axis_titles=yes&show_tooltip=yes&id=GDPDEF&scale=left&cosd=19", 
  "47-01-01&coed=2020-10-01&line_color=%234572a7&link_values=false&", 
  "line_style=solid&mark_type=none&mw=3&lw=2&ost=-99999&oet=99999&mma", 
  "=0&fml=a&fq=Quarterly&fam=avg&fgst=lin&fgsnd=2020-02-01&line_index=1", 
  "&transformation=lin&vintage_date=2021-03-09&revision_date=2021-03-09&nd=1947-01-01")) 
  
  quart_US_GDP_FINAL.df <- quart_US_GDP.df %>% 
    mutate(SOURCE = "GDP- National") %>% 
    rename(GDP = GDPDEF) %>% 
    mutate(YEAR = substr(DATE, 1, 4),
           MONTH = substr(DATE, 6, 7),
           YR_MONTH = paste0(YEAR, "-", MONTH)) %>% 
    select(YEAR, MONTH, YR_MONTH, GDP, SOURCE)
                          
                          
# -----------------
# Save Final data set 
  
  write_csv(quart_US_GDP_FINAL.df, file.path(".",
                                             "data",
                                             "US_GDP_quarterly.csv"))
