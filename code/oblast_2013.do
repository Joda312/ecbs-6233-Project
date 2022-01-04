clear all
capture log close
set more off

* I used the relative paths:
use "../data/raw/2013/hh0.dta", clear

keep hhid oblast residence
rename residence urban
replace urban=0 if urban==2
label define for_urban 1 "city" 0 "village"
label values urban for_urban

* creating a dummy for south: Jalal-Abad, Batken, and Osh oblasts, including Osh city
gen south=0
replace south=1 if oblast==3
replace south=1 if oblast==5
replace south=1 if oblast==6
replace south=1 if oblast==21
misstable sum

save "../data/derived/oblast_2013.dta", replace

