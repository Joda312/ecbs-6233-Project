clear all
set more off
capture log close

* I used the relative paths:
use "../data/raw/2019/hh2c", clear
keep hhid h231-h235
rename h231 savings
rename h232_1 where_1
rename h232_2 where_2
rename h232_3 where_3
rename h233 purpose
rename h234 loan
rename h235 loan_amount
replace loan_amount=0 if missing(loan_amount)
save "../data/derived/savings_credit_2019", replace
