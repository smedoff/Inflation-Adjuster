
# Hawaii GDP
  # https://fred.stlouisfed.org/series/HINGSP

  rm(list=ls())

  quart_HI_GDP.df <- read.csv(paste0("https://fred.stlouisfed.org/graph/fredgraph.csv?", 
                                     "bgcolor=%23e1e9f0&chart_type=line&drp=0&fo=open%20", 
                                     "sans&graph_bgcolor=%23ffffff&height=450&mode=fred", 
                                     "&recession_bars=on&txtcolor=%23444444&ts=12&tts=12", 
                                     "&width=1168&nt=0&thu=0&trc=0&show_legend=yes&show_", 
                                     "axis_titles=yes&show_tooltip=yes&id=HINGSP&scale=", 
                                     "left&cosd=1997-01-01&coed=2019-01-01&line_color=", 
                                     "%234572a7&link_values=false&line_style=solid&mark_", 
                                     "type=none&mw=3&lw=2&ost=-99999&oet=99999&mma=0&fml=", 
                                     "a&fq=Annual&fam=avg&fgst=lin&fgsnd=2019-01-01&line_", 
                                     "index=1&transformation=lin&vintage_date=2021-03-07&", 
                                     "revision_date=2021-03-07&nd=1997-01-01")) 
  
  quart_HI_GDP_FINAL.df <- quart_HI_GDP.df %>% 
    mutate(SOURCE = "GDP- Hawaii") %>% 
    rename(GDP = HINGSP) %>% 
    mutate(YEAR = substr(DATE, 1, 4),
           MONTH = substr(DATE, 6, 7),
           YR_MONTH = paste0(YEAR, "-", MONTH)) %>% 
    select(YEAR, MONTH, YR_MONTH, GDP, SOURCE)
  
                          
                          
# -----------------
# Save Final data set 
  
  write_csv(quart_HI_GDP_FINAL.df, file.path(".",
                                             "data",
                                             "HI_GDP_annual.csv"))
