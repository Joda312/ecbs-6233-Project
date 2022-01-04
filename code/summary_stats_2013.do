clear all
set more off
capture log close

* I used the relative paths:
use "../data/derived/merged_2013.dta", replace
 
misstable sum
sum mig

* test of means by migration status
sum savings
ttest savings, by(mig)

sum loan
ttest loan, by(mig)

sum loan_amount
ttest loan_amount, by(mig)
 
sum income
ttest income, by(mig)
*sum rems
*ttest rems, by(mig)
sum tot_assets
ttest tot_assets, by(mig)

sum hhead_age
ttest hhead_age, by(mig)

sum hhead_sex
ttest hhead_sex, by(mig)

sum h_mstat
ttest h_mstat, by(mig)

sum num_work_age
ttest num_work_age, by(mig)

sum age_aver
ttest age_aver, by(mig)

sum numElderly
ttest numElderly, by(mig)

sum numChildren
ttest numChildren, by(mig)

sum numFemale
ttest numFemale, by(mig)

sum h_size
ttest h_size, by(mig)

sum share_female
ttest share_female, by(mig)

sum oblast
ttest oblast, by(mig)

sum urban 
ttest urban, by(mig)

sum south
ttest south, by(mig)

tab savings mig
tab loan mig