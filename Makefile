STATA = StataMP-64 -b 
exhibits/Regression_1.xls: code/regression.do data/derived/panel.dta 
	$(Stata) do code/regression.do
exhibits/Regression_2.xls: code/regression.do data/derived/panel.dta 
	$(Stata) do code/regression.do