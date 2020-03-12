Felix Ward, "Spotting the Danger Zone: Forecasting Financial Crises
with Classification Tree Ensembles and Many Predictors", Journal of
Applied Econometrics, Vol. 32, No. 2, 2017, pp. 359-378.

For further questions, please contact the author via email:
  s3feward [AT] uni-bonn.de

ORIGINAL DATA

1) text_longrun.txt -- 1870-2011 sample;  2431 observations; 54 variables:

From Jordà, Schularick and Taylor (2013). Sovereigns versus Banks:
Credit, Crises and Consequences

Note: the original long-run data are proprietary and were kindly
provided by Moritz Schularick. Please contact the authors in order to
obtain a copy of the original dataset (version August, 2014). In
agreement with the authors, the prepared data are provided
(“R_class.csv”, “R_class_RR.csv”). On the basis of the prepared data,
the logit- and tree-based models for the 1870-2011 dataset can be
replicated.
	
-> year - Year
-> iso - 2-letter ISO country code
-> ccode - country number code
-> rgdpbarro - real per capita GDP, index
-> rgdpmad - real PPP per capita GDP, international 1990 Geary-Khamis dollar
-> narrowm - narrow money aggregate, local currency
-> money - broad money aggregate, local currency
-> gdp - nominal GDP, local currency
-> iy - investment to GDP ratio
-> cpi - consumer price index
-> pop - population
-> ca - current account, local currency
-> imports - imports, local currency
-> exports - exports, local currency
-> stocks - stock prices, index
-> stir - short-term interest rates
-> ltrate - long-term interest rates
-> debtgdp - public debt to GDP ratio
-> debtgdp_imf - public debt to GDP ratio from IMF
-> revenue - government revenues, local currency
-> taxev - government tax revenues, local currency
-> expenditure - government expenditures, local currency
-> miles - military expenditures, local currency
-> debt_nominal - nominal public debts, local currency
-> xrusd - nominal USD exchange rate, local currency/USD
-> peg - exchange rate regime; 1- peg, 0-float
-> pegIRR - exchange rate regime (according to Ilzetzki, Reinhart, Rogoff);
   1- peg, 0-float
-> pegOT - exchange rate regime (according to Obstfeld and Taylor);
   1- peg, 0-float
-> crisisJST - financial crisis dummy
-> tloans - total bank loans, local currency
-> treal - total real estate loans, local currency
-> thh - total loans to households, local currency
-> hhreal - total mortgage loans to households
-> tbus - total business loans
-> loans1 - total loans to households, old series
-> bassets2 - total bank assets
-> govass - government bonds on banks’ balance sheets
-> newassets - total bank assets, new series
-> tprivfof - total private credit (flow of funds), local currency
-> tmortfof - total mortgage credit (flow of funds), local currency
-> thhfof - Total credit to households (flow of funds), local currency
-> tbusfof - Total credit to business (flow of funds), local currency
-> hhmortfof - Household mortgage credit (flow of funds), local currency
-> busmortfof - Business mortgage credit (flow of funds), local currency

From Reinhart and Rogoff (2010). From Financial Crash to Debt Crisis.
National Bureau of Economic Research. (Crisis dummy).

-> RRcurrencycrises - currency crisis dummy (Reinhart and Rogoff)
-> RRinflationcrises - inflation crisis dummy
-> RRstockmarketcrash - stock market crash dummy
-> RRdomesticsovereigndebtcrises - domestic sovereign debt crisis dummy
-> RRexternalsovereigndebtcrises - external sovereign debt crisis dummy


2) text_post70_y.txt -- annual post-1970 sample; 7081 observations; 24
   variables:

From Leaven and Valencia (2013). Systemic banking crises database. IMF
Econ Rev.:

-> crisisL - Systemic banking crisis dummy
-> country - Country

From Fenestra, R.C., Inklaar, R. and Timmer, M.P. (2013). The Next
Generation of the Penn World Table. Online: www.ggdc.net/pwt:

-> ifs - IFS 3 digit country code
-> year - Year
-> v_c - household consumption, local currency
-> v_i - investment, local currency
-> v_g - government consumption, local currency
-> v_x - exports, local currency
-> v_m - imports, local currency
-> v_gdp - GDP, local currency
-> q_gdp - GDP, constant national 2005 prices
-> pop - population
-> xr2 - nominal exchange rate, national currency/USD
-> pl_gdpe - GDP deflator

From International Monetary Fund. International Financial Statistic.
CD-ROM. (Version February, 2014):

-> loans - deposit money banks’ claims on private sector, local currency
-> loans_std - depository corporations’ claims on private sector (standardised
   report form), local currency
-> fliab - deposit money banks’ foreign liabilities, local currency
-> ltbondrate - long-term government bond rates
-> mmrate - money market rate
-> mortrate - interest rate on mortgages
-> stocks - share price index
-> tbillrate - interest rate on short-term treasury bills
-> pdebt - public government debt


3) text_post70_q.txt -- quarterly post-1970 sample; 31145
   observations; 20 variables:

-> ifs - IFS 3 digit country code
-> year - Year
-> quarter - Quarter
-> date - Year, quarter

From Leaven and Valencia (2013). Systemic banking crises database. IMF
Econ Rev.:

-> crisisL - Systemic banking crisis dummy
-> country - Country

From International Monetary Fund. International Financial Statistic.
CD-ROM. (Version February, 2014):

-> tloans - deposit money banks’ claims on private sector, local currency
-> cpi - consumer price index
-> gdp - nominal GDP, local currency
-> hopr - nominal house prices, index
-> ltrate - long-term government bond rate
-> stir - short-term interest rate
-> stocks - share price index
-> er - nominal exchange rate, local currency/USD
-> res - foreign exchange reserves
-> fliab - deposit money banks’ foreign liabilities, local currency
-> mrate - mortgage rate
-> tbill - interest rate on short-term treasury bills

Bank of International Settlements:

-> loans_bis - Total credit to the non-financial sector (BIS), local currency


4) text_post70_y_DE.txt -- annual post-1970 sample (including dummies
   on developmental status and data quality); 7081 observations; 29
   variables:

  AE - advanced economy dummy
  DE - developing economy dummy
  ME - middle income economy
  QU - good data quality dummy
 big - size dummy = 1 for population > 5 million

otherwise identical to "text_post70_y.txt"; see iii).

PREPARED DATA

On the basis of the above described original data several prepared
data-files are obtained. For convenience these prepared data-files are
provided as comma-separated value (.csv) files. All logit- and
classification tree-based applications discussed in the paper can be
directly replicated on the basis of these files with the respective
R-code.


CODE

1) preparation

  i) "prepare" - prepare long-run annual samples
 ii) "prepare_post70_y.do" - prepare annual post-1970 sample
iii) "prepare_post70_q.do" - prepare quarterly post-1970 samples
 iv) "prepare_post70_y_DE.do" - prepare annual post-1970 emerging market
     and quality data subsamples

(preparation make use of "detrend_mt_q.do" and "detrend_mt.do" files
for detrending)


2) summaries

  i) "summaries" - prepares .csv file for long-run annual crisis map
		 - makes indicator table A1
 ii) "summaries_post70_y" - prepares .csv file for post-1970 annual crisis map
		 - makes indicator table A2
iii) "summaries_post70_y" - makes indicator table A3


3) crisis maps

  i) "CrisisMap" - makes annual long-run crisis map (figure A1)
 ii) "CrisisMap_post70" - makes annual post-1970 crisis map (figure A2)

4) analysis

   i) "t_MCCV" - makes table 2
  ii) "CT_longrun" - makes table 3, figure 2, figure A3 and figure A4
 iii) "CT_robustness" - makes table 4
  iv) "CT_post1970_y" - makes table A4
   v) "CT_post1970_q" - makes table A5 and A6
  vi) "CT_longrun_ACCS_BS" - makes table A7
 vii) "CT_horizons" - makes table A8
viii) "CT_boost" - makes table A9
  ix) "Case" - makes figure 3
   x) "CT_longrun_AC" -- for Lahiri & Yang confidence bands reported in
      appendix
 
