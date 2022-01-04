clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2016/hh2d", clear
keep hhid h247-h250b
rename h247 savings
replace savings=2 if missing(savings)
rename h248 where
rename h249 purpose
rename h250a loan
replace loan=2 if missing(loan)
rename h250b loan_amount
replace loan_amount=0 if missing(loan_amount)
save "../data/derived/savings_credit_2016", replace
