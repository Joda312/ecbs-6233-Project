clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2013/hh2b", clear

* assigning 0 to missing observations
replace h223=0 if missing(h223)

* summing the value of total assets by hhid 
collapse (sum) tot_assets=h223, by(hhid)

save "../data/derived/tot_assets_2013.dta", replace
