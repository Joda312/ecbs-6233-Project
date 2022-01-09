* please run this from the code folder of the project so that it can be run properly
* here is a master do-file

* data processing for 2013
do oblast_2013.do
do hhold_comp_2013.do
do hhold_income_2013.do
do remittances_2013.do
do savings_credit_2013.do
do tot_assets_2013.do

* data processing for 2016
do oblast_2016.do
do hhold_comp_2016.do
do hhold_income_2016.do
do remittances_2016.do
do savings_credit_2016.do
do tot_assets_2016.do

* data processing for 2019
do oblast_2019.do
do hhold_comp_2019.do
do hhold_income_2019.do
do remittances_2019.do
do savings_credit_2019.do
do tot_assets_2019.do

* merging the datasets
do merged_2013.do
do merged_2016.do
do merged_2019.do

* constructing the panel and regression analysis
do panel.do
do regression.do