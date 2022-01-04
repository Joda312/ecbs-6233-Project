clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2013/hh6a", clear
drop if missing(n6a)

gen mig=0
replace mig=1 if n6a>0
tab h605, missing
tab h612, missing
keep hhid mig
duplicates drop hhid, force
save "../data/derived/mig_2013.dta", replace

use "../data/raw/2013/hh6b.dta", clear
keep hhid h617_s-h617_t h618 h624 h625_s h625_c

*frequency of transfers
tab h618, missing

generate rems=h617_s
replace rems=h617_s*12 if h617_t==1
replace rems=0 if missing(rems)
gen rems_soms=rems*48.4386 if h617_c==2  
replace rems_soms=rems if h617_c==1
replace rems_soms=rems*1.5253 if h617_c==3
replace rems_soms=rems*64.3536 if h617_c==4
replace rems_soms=0 if missing(rems_soms)

*plus remittances in terms of goods (their value)
gen inkind=h625_s if h625_c==1
  replace inkind=h625_s*1.5223 if h625_c==3
  replace inkind=0 if missing(inkind)    
replace rems=rems+inkind
drop if rems==0
keep hhid rems
*save "$Project/data/derived/remittances.dta", replace
*use "$Project/data/derived/mig.dta", clear
merge 1:1 hhid using "../data/derived/mig_2013.dta"
replace rems=0 if rems==.
drop _merge
sort hhid

save "../data/derived/remittances_2013.dta", replace