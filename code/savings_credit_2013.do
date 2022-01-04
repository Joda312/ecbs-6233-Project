clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2013/hh2d", clear
keep hhid-h250
rename h247 savings
rename h248 where
rename h249 loan
rename h250 loan_amount
replace loan_amount=0 if missing(loan_amount)
save "../data/derived/savings_credit_2013", replace
