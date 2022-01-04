clear all 
set more off
capture log close

* I used the relative paths:
use "../data/raw/2016/hh1a.dta", clear

keep hhid-h105 h108 
rename h105 ethn
rename h103a age
rename h102 gender

* finding the age, gender, and marital status of the household head
gen hhead_age=age if h104==1
sort hhid, stable
by hhid: egen temp=mean(hhead_age)
drop hhead_age
rename temp hhead_age
gen hhead_sex=gender if h104==1
by hhid: egen temp=mean(hhead_sex)
drop hhead_sex
rename temp hhead_sex 
replace hhead_sex=0 if hhead_sex==2
gen h_mstat=h108 if h104==1
by hhid: egen temp=mean(h_mstat)
drop h_mstat
rename temp h_mstat

* finding the number of working age individuals by hh, average age of hh-members
gen fem_work_age=(age>18 & age<58) if gender==2
by hhid: egen num_fem_work_age=total(fem_work_age)
gen male_work_age=(age>18 & age<63) if gender==1
by hhid: egen num_male_work_age=total(male_work_age)
by hhid: gen num_work_age=num_male_work_age+num_fem_work_age
drop fem_work_age num_fem_work_age male_work_age num_male_work_age  
by hhid: egen age_aver=mean(age)

* finding the number of elderly by household (elderly is defined as males aged over 63 and females aged over 58 because of official "pension" age)
gen elderly_fem=(age>=58) if gender==2
by hhid: egen num_elderly_fem=total(elderly_fem)
gen elderly_male=(age>=63) if gender==1
by hhid: egen num_elderly_male=total(elderly_male)
by hhid: gen numElderly=num_elderly_fem+num_elderly_male
drop elderly_fem num_elderly_fem elderly_male num_elderly_male

* finding the number children and share of females by household
gen child=(age<=18)
by hhid: egen numChildren=total(child)
drop child
gen female=(gender==2)
by hhid: egen numFemale=total(female)
by hhid: gen h_size=_N
gen share_female=numFemale/h_size
duplicates report hhid
duplicates tag hhid, gen(dup)
egen tag=tag(hhid)
egen sum=sum(tag)
di sum
misstable sum

drop pid-h108 female dup tag sum
duplicates drop hhid, force
drop if missing(h_mstat)

save "../data/derived/hhold_comp_2016.dta", replace