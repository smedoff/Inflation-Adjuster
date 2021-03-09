# Inflation_Adjuster
The purpose of this repo is to scrape or download the following GDP and CPI data into R.  

Data Sets Produced 
  - US GDP
  - HI GDP
  - US CPI
  - HI CPI

GDP data is provided by 
  - https://fred.stlouisfed.org

CPI data is provided by 
  - https://beta.bls.gov/dataQuery/find?fq=survey:%5Bcu%5D&s=popularity:D
    - "All Items US City Average, All Urban Consumers, Not Seasonally Adjusted" 
    - 2000 to present.


------------------
## CPI and Diesel Fuel Prices

*Proceedures and Background*  
  - The scripts provided in this repo scrape the following variables (refer to data sources given below)
    - CPI US 
    - CPI HI
    - Diesel fuel US
    - Diesel fuel HI  
  - Each script will download the data, clean the data, and produce a final time series plot of each variable of interest and a csv. 
  - CPI US and both diesel fuel data downloads are self-sufficient, meaning the code will download the data directly from the url within R.  No other procedures are needed to obtain data.  
  - CPI HI is a little interesting 
    - CPI HI was taken at the (bi)annual level from 2017 and before.  In 2018 monthly CPI was measured but it was measured every two months.  
    - I scrape the data table from the bls website for years 2017 and before.  The data scraping tool only will scrape till 2011.  If you need data from 2010 and before, use the file `consumerpriceindex_honolulu_table_2018.xlsx` in the `data` folder. 
    - In addition, for years where CPI was measured every other month, I impute the missing months using the yearly mean values.  


*NOTE* 
  - bls.gov limits the number of data requests to 500 a day (https://github.com/keberwein/blscrapeR/issues/16) be sure to keep this in mind when querying the data through R.  

------------------
## Data Sources 

The data sets used are (Given by Jon S.) 
  - CPI:
  https://beta.bls.gov/dataQuery/find?fq=survey:%5Bcu%5D&s=popularity:D
    - We'll want the "all items us city average, all urban consumers, not seasonally adjusted" for 2000 to present.

  - fuel price:
  https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=pet&s=emd_epd2d_pte_nus_dpg&f=m
    - Again 2000-present is fine, and we'll want the monthly averages of US no2 diesel prices.
    
The data sets used are (Given by Michel) 

  - CPI: (HI CPI - pre 2018, see Minling's reference for updated data set) 
  https://www.bls.gov/regions/west/data/consumerpriceindex_honolulu_table.pdf

  - fuel price, I used the diesel price from DBEDT (source:  American Automobile Association)
  https://dbedt.hawaii.gov/economic/energy-trends-2/
    - Go to website and use the link `Monthly Energy Data: Historical data from January 2006 to January 2021`
    - This will lead to an xlsx spread sheet.  Navigate to the first tab "State" and use row 18 titled `Diesel, State`


The data sets used are (Given my Minling) 
  - CPI: (HI CPI - post 2018) 
  https://data.bls.gov/pdq/SurveyOutputServlet







