clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2019/hh6a", clear
drop if missing(h601)

gen mig=0
replace mig=1 if h601>0
tab h605, missing
tab h613, missing
*keep hhid mig
duplicates drop hhid, force
save "../data/derived/mig_2019.dta", replace

use "../data/raw/2019/hh6b.dta", clear
keep hhid h622-h624 h631 h632
generate rems=h622
replace rems=h622*69.7895 if h623==2
replace rems=0 if missing(rems)
replace h632=0 if missing(h632)

* frequency of transfers
tab h624 

*plus remittances in terms of goods (their value)
replace rems=rems+h632
keep hhid rems
*save "$Project/data/derived/remittances.dta", replace
*use "$Project/data/derived/mig.dta", clear
merge 1:1 hhid using "../data/derived/mig_2019.dta"
keep if _merge==3
drop _merge
sort hhid

save "../data/derived/remittances_2019.dta", replace
