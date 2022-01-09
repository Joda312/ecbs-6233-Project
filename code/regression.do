clear all
capture log close
set more off

* I used the relative paths:
use "../data/derived/panel.dta", clear

regress savings i.mig h_size num_work_age numChildren i.hhead_sex numFemale i.urban i.south, robust
outreg2 using "../exhibits/Regression_1.xls", replace

regress loan i.mig h_size num_work_age numChildren i.hhead_sex numFemale i.urban i.south, robust
outreg2 using "../exhibits/Regression_2.xls", replace
