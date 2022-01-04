clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2016/hh5a.dta", clear

collapse (sum) income=h502, by(hhid)
replace income=12*income
merge 1:1 hhid using "../data/derived/tot_assets_2016.dta"
keep if _merge==3
drop _merge
*replace income=tot_assets+income
*drop tot_assets _merge
save "../data/derived/hhold_income_2016.dta", replace

use "../data/raw/2016/hh5b", clear
collapse (sum) social_transfers=h504, by(hhid)
replace social_transfers=12*social_transfers
merge 1:1 hhid using "../data/derived/hhold_income_2016.dta"
replace income=0 if missing(income)
replace tot_assets=0 if missing(tot_assets)
replace social_transfers=0 if missing(social_transfers)
replace income=income+social_transfers
drop social_transfers _merge

save "../data/derived/hhold_income_2016.dta", replace
