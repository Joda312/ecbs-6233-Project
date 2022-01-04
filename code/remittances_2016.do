clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2016/hh6a", clear
drop if missing(n6a)

gen mig=0
replace mig=1 if n6a>0
tab h605, missing
tab h612, missing
keep hhid mig
duplicates drop hhid, force
save "../data/derived/mig_2016.dta", replace

use "../data/raw/2016/hh6b.dta", clear
keep hhid h617c-h617t h618 h626 h627
generate rems=h617s
replace rems=h617s*12 if h617t==1
replace rems=0 if missing(rems)

gen rems_soms=rems*69.9018 if h617c==2  
replace rems_soms=rems if h617c==1
replace rems_soms=rems*1.0458 if h617c==3
replace rems_soms=0 if missing(rems_soms)
replace h627=0 if missing(h627)

* frequency of transfers
tab h618, missing

*plus remittances in terms of goods (their value)
replace rems=rems+h627
drop if rems==0
keep hhid rems
*save "$Project/data/derived/remittances.dta", replace
*use "$Project/data/derived/mig.dta", clear
merge 1:1 hhid using "../data/derived/mig_2016.dta"
replace rems=0 if rems==.
drop if mig==.
drop _merge
sort hhid

save "../data/derived/remittances_2016.dta", replace
