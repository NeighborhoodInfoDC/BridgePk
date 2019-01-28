/**************************************************************************
 Program:  BPK Forecasts_2010-45.sas
 Library:  BridgePk
 Project:  Urban--Greater DC
 Author:   S.Diby
 Created:  10/30/18
 Version:  SAS 9.2
 Environment:  Local Windows session
 
 Description:  Using Office of Planning population forecast data, this program calculates percent change in population,
				households, and jobs between base years (2010 and 2015) and all years following (2020, 2025, 2030, 2035, 2040, 2045) 
				for Census tracts within the Bridge Park geography. 

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Planning )
%DCData_lib( Bridgepk )
%DCData_lib( ACS );


data bpk_popforecasts;
	set planning.Pop_forecast_r9_dc_tr10;
	/*Percent change in employment for base year 2010*/
		e10_15pct = ((emp2015 - emp2010)/emp2010)*100;
		e10_20pct = ((emp2020 - emp2010)/emp2010)*100;
		e10_25pct = ((emp2025 - emp2010)/emp2010)*100;
		e10_30pct = ((emp2030 - emp2010)/emp2010)*100;
		e10_35pct = ((emp2035 - emp2010)/emp2010)*100;
		e10_40pct = ((emp2040 - emp2010)/emp2010)*100;
		e10_45pct = ((emp2045 - emp2010)/emp2010)*100;

	/*Percent change in employment for base year 2015*/
		e15_20pct = ((emp2020 - emp2015)/emp2015)*100;
		e15_25pct = ((emp2025 - emp2015)/emp2015)*100;
		e15_30pct = ((emp2030 - emp2015)/emp2015)*100;
		e15_35pct = ((emp2035 - emp2015)/emp2015)*100;
		e15_40pct = ((emp2040 - emp2015)/emp2015)*100;
		e15_45pct = ((emp2045 - emp2015)/emp2015)*100;

	/*Percent change in households for base year 2010*/
		hh10_15pct = ((hh2015 - hh2010)/hh2010)*100;
		hh10_20pct = ((hh2020 - hh2010)/hh2010)*100;
		hh10_25pct = ((hh2025 - hh2010)/hh2010)*100;
		hh10_30pct = ((hh2030 - hh2010)/hh2010)*100;
		hh10_35pct = ((hh2035 - hh2010)/hh2010)*100;
		hh10_40pct = ((hh2040 - hh2010)/hh2010)*100;
		hh10_45pct = ((hh2045 - hh2010)/hh2010)*100;

	/*Percent change in household for base year 2015*/
		hh15_20pct = ((hh2020 - hh2015)/hh2015)*100;
		hh15_25pct = ((hh2025 - hh2015)/hh2015)*100;
		hh15_30pct = ((hh2030 - hh2015)/hh2015)*100;
		hh15_35pct = ((hh2035 - hh2015)/hh2015)*100;
		hh15_40pct = ((hh2040 - hh2015)/hh2015)*100;
		hh15_45pct = ((hh2045 - hh2015)/hh2015)*100;

	/*Percent change in population for base year 2010*/
		tpop10_15pct = ((tpop2015 - tpop2010)/tpop2010)*100;
		tpop10_20pct = ((tpop2020 - tpop2010)/tpop2010)*100;
		tpop10_25pct = ((tpop2025 - tpop2010)/tpop2010)*100;
		tpop10_30pct = ((tpop2030 - tpop2010)/tpop2010)*100;
		tpop10_35pct = ((tpop2035 - tpop2010)/tpop2010)*100;
		tpop10_40pct = ((tpop2040 - tpop2010)/tpop2010)*100;
		tpop10_45pct = ((tpop2045 - tpop2010)/tpop2010)*100;

	/*Percent change in household for base year 2015*/
		tpop15_20pct = ((tpop2020 - tpop2015)/tpop2015)*100;
		tpop15_25pct = ((tpop2025 - tpop2015)/tpop2015)*100;
		tpop15_30pct = ((tpop2030 - tpop2015)/tpop2015)*100;
		tpop15_35pct = ((tpop2035 - tpop2015)/tpop2015)*100;
		tpop15_40pct = ((tpop2040 - tpop2015)/tpop2015)*100;
		tpop15_45pct = ((tpop2045 - tpop2015)/tpop2015)*100;

run;

proc sort data=bpk_popforecasts;
	by Geo2010;
run;

proc sort data=general.geo2010;
	by Geo2010;
run;

data bpk_popforecasts_trmerge;
	merge bpk_popforecasts general.geo2010 (keep=tract tract6 ntract Geo2010);
	by Geo2010;
run;	

data bpk_popforecasts_tr10;
	set bpk_popforecasts_trmerge;
	where geo2010 in ("11001006500", "11001006600", "11001006700", 
						"11001006802", "11001006900", "11001007000", 
						"11001007100", "11001007200", "11001007401", 
						"11001007406", "11001007407",  "11001007503",
						"11001007504", "11001007601", "11001007605" );
run;


proc export data=bpk_popforecasts_tr10
	outfile="&_dcdata_default_path\BridgePk\Data\bpkforecasts_tr10.csv"
	dbms=csv replace;
	run;
