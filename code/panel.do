clear all
set more off
capture log close

* I used the relative paths:
use "../data/derived/merged_2013.dta", clear
append using "../data/derived/merged_2016.dta"
append using "../data/derived/merged_2019.dta"
count if year==2013
count if year==2016 
count if year==2019 

* Uncomment and run the following command in case xtbalance is not installed:
* ssc install xtbalance
xtset hhid year 
xtdescribe
* xtbalance, range(2013 2016 2019)
* xtdescribe
drop where purpose 

save "../data/derived/panel.dta", replace