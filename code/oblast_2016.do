clear all
capture log close
set more off

* I used the relative paths:"
use "../data/raw/2016/cc_hh.dta", clear

keep hhid oblast residence
rename residence urban
replace urban=0 if urban==2
label define for_urban 1 "city" 0 "village"
label values urban for_urban

* creating a dummy for south: Jalal-Abad, Batken, and Osh oblasts, including Osh city
gen south=0
replace south=1 if oblast==41703
replace south=1 if oblast==41705
replace south=1 if oblast==41706
replace south=1 if oblast==41721
misstable sum

save "../data/derived/oblast_2016.dta", replace


/*41702 issyk-kul
       41703 jalal-abad
       41704 naryn
       41705 batken
       41706 osh
       41707 talas
       41708 chui
       41711 t.bishkek
       41721 t.osh