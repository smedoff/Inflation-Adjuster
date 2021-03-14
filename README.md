# Inflation_Adjuster

The purpose of this repo is to scrape or download the following GDP and CPI data into R.  

Data Sets Produced 
  - GDP National
  - GDP Hawaii
  - CPI National
  - CPI Regional (West) 
  - CPI Hawaii

![GitHub Logo](/figures/Inflation_Adj_TS.png?raw=true)

## Directory Structure

  - Run all code by opening to the `Inflation_Adj.Rproj`.  This will help preserve the folder structure when saving and sourcing data and figures. 
  - There are 3 folders in the working directory 
    1. code
      - produce data sets- This folder holds all scripts needed to extract, clean, and save the GDP and CPI data 
      - supplementary code- The files in the folder
        - compiling_ts_graph.R - Create the final time series graph 
        - hlprfnc_adjusting_CPI.R - Function to calculate the CPI adjuster 
        - example_calc_adj_cpi.R - An example of how to use the CPI adjuster
    2. data - House all final data sets
    3. figures - House the final time series graph


## About the Data

GDP National 
  - https://fred.stlouisfed.org/series/GDPDEF  
  - Data Range: 1947 to present 
  - Measured quarterly 

GDP Hawaii 
  - https://fred.stlouisfed.org/series/HINGSP
  - Data Range: 1997 to present 
  - Measured quarterly 

CPI National 
  - https://beta.bls.gov/dataViewer/view/timeseries/CUUR0000SA0
  - Data Range: 2000 to present
  - Measured annual (pre 2018), bimonthly (2018 and current) 

CPI Regional 
  - https://data.bls.gov/timeseries/CUUR0400SA0,CUUS0400SA0
  - Data Range: 2011 to present 
  - Measured monthly 

CPI Hawaii 
  - https://data.bls.gov/timeseries/CUURS49FSA0 
  - Data Range: 2011 to present (See *Notes* for obtaining data pre-2011) 
  - Measured annual (pre 2018), bimonthly (2018 and current) 


------------------
*NOTES* 

  - bls.gov limits the number of data requests (https://github.com/keberwein/blscrapeR/issues/16) be sure to keep this in mind when querying the data through R.  
  - CPI HI 
     - From 2017 and prior, CPI was measured (bi)annually.  
     - 2018 to present, bi-monthly CPI is recorded.  
     - Data from pre-2011 is saved as a pdf file `data/ HI_CPI_pre2011/ consumerpriceindex_honolulu_table_2018.xlsx`. 
  - Imputting values to obtain a data set at the monthly level can be done upon request.    







