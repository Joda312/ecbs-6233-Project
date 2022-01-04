clear all
set more off
capture log close

* I used the relative paths:
use "../data/derived/hhold_comp_2013.dta", clear
sort hhid, stable

merge 1:1 hhid using "../data/derived/hhold_income_2013.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid using "../data/derived/oblast_2013.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid using "../data/derived/savings_credit_2013.dta"
keep if _merge==3
drop _merge

merge 1:1 hhid using "../data/derived/remittances_2013.dta"
drop if _merge==2
replace rems=0 if missing(rems)
replace mig=0 if missing(mig)
drop _merge

generate year=2013
order hhid year savings-loan_amount income mig rems tot_assets 

replace savings=2 if missing(savings)
replace loan=2 if missing(loan)
replace savings=0 if savings==2
replace loan=0 if loan==2

generate recip = 1 if rems>0
replace recip = 0 if missing(recip)

misstable sum

save "../data/derived/merged_2013.dta", replace