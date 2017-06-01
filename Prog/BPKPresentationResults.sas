/**************************************************************************
 Program:  BPKPresentationResults.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   J.Dev
 Created:  3/20/17
 Version:  SAS 9.2
 Environment:  Local Windows session
 
 Description:  Prepare data for initial 11th Street Bridge Park Data Room
			   Presentation on 3/27/2017, from ACS, Realprop, and Police

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( ACS )
%DCData_lib( Realprop )
%DCData_lib( Police )
%DCData_lib( NCDB )

libname Bridgepk "L:\Libraries\Bridgepk\Data\";


** Define time periods  **;
%let year = 2011_15;
%let year_lbl = 2011-15;

** Pull ACS Estimates for city **;
data ACS_city (keep= city ShrLaborForce_&year ShrEmpRate_&year ShrUnEmpRate_&year
ShrPov_&year ShrHS_&year ShrCol_&year ShrWht_&year ShrBlk_&year ShrHisp_&year 
ShrAsn_&year ShrOth_&year);
set ACS.acs_2011_15_dc_sum_tr_city (keep= popincivlaborforce_&year
pop16andoveryears_&year popcivilianemployed_&year popunemployed_&year 
poppoorpersons_&year personspovertydefined_&year popwithrace_&year 
popwhitenonhispbridge_&year popblacknonhispbridge_&year pophisp_&year 
popasianpinonhispbridge_&year popotherracenonhispbridg_&year 
pop25andoveryears_&year pop25andoverwhs_&year pop25andoverwcollege_&year 
city);

ShrLaborForce_&year = popincivlaborforce_&year / pop16andoveryears_&year;
ShrEmpRate_&year = popcivilianemployed_&year / popincivlaborforce_&year;
ShrUnEmpRate_&year = popunemployed_&year / popincivlaborforce_&year;
ShrPov_&year = poppoorpersons_&year / personspovertydefined_&year;

ShrHS_&year = pop25andoverwhs_&year / pop25andoveryears_&year;
ShrCol_&year = pop25andoverwcollege_&year / pop25andoveryears_&year;

ShrWht_&year = popwhitenonhispbridge_&year / popwithrace_&year;
ShrBlk_&year = popblacknonhispbridge_&year / popwithrace_&year;
ShrHisp_&year = pophisp_&year / popwithrace_&year;
ShrAsn_&year = popasianpinonhispbridge_&year / popwithrace_&year;
ShrOth_&year = popotherracenonhispbridg_&year / popwithrace_&year;

run;

proc export data = ACS_city outfile = "L:\Libraries\Bridgepk\Data\ACS_city_pct.csv" dbms = csv replace;
run;

data ACS_city_n (keep= city pop16andoveryears_&year popincivlaborforce_&year
personspovertydefined_&year pop25andoveryears_&year popwithrace_&year
numrenterhsgunits_&year);
set ACS.acs_2011_15_dc_sum_tr_city (keep= pop16andoveryears_&year 
popincivlaborforce_&year personspovertydefined_&year 
pop25andoveryears_&year popwithrace_&year numrenterhsgunits_&year city);

run;

proc export data = ACS_city_n outfile = "L:\Libraries\Bridgepk\Data\ACS_city_n.csv" dbms = csv replace;
run;

** Pull ACS Estimates for wards **;
data ACS_ward (keep= ward2012 ShrLaborForce_&year ShrEmpRate_&year ShrUnEmpRate_&year 
ShrPov_&year ShrHS_&year ShrCol_&year ShrWht_&year ShrBlk_&year ShrHisp_&year 
ShrAsn_&year ShrOth_&year);
set ACS.acs_2011_15_dc_sum_tr_wd12  (keep= popincivlaborforce_&year
pop16andoveryears_&year popcivilianemployed_&year popunemployed_&year 
poppoorpersons_&year personspovertydefined_&year popwithrace_&year 
popwhitenonhispbridge_&year popblacknonhispbridge_&year pophisp_&year 
popasianpinonhispbridge_&year popotherracenonhispbridg_&year 
pop25andoveryears_&year pop25andoverwhs_&year pop25andoverwcollege_&year 
ward2012);

ShrLaborForce_&year = popincivlaborforce_&year / pop16andoveryears_&year;
ShrEmpRate_&year = popcivilianemployed_&year / popincivlaborforce_&year;
ShrUnEmpRate_&year = popunemployed_&year / popincivlaborforce_&year;
ShrPov_&year = poppoorpersons_&year / personspovertydefined_&year;

ShrHS_&year = pop25andoverwhs_&year / pop25andoveryears_&year;
ShrCol_&year = pop25andoverwcollege_&year / pop25andoveryears_&year;

ShrWht_&year = popwhitenonhispbridge_&year / popwithrace_&year;
ShrBlk_&year = popblacknonhispbridge_&year / popwithrace_&year;
ShrHisp_&year = pophisp_&year / popwithrace_&year;
ShrAsn_&year = popasianpinonhispbridge_&year / popwithrace_&year;
ShrOth_&year = popotherracenonhispbridg_&year / popwithrace_&year;

run;

proc export data = ACS_ward outfile = "L:\Libraries\Bridgepk\Data\ACS_ward_pct.csv" dbms = csv replace;
run;

data ACS_ward_n (keep= ward2012 pop16andoveryears_&year popincivlaborforce_&year
personspovertydefined_&year pop25andoveryears_&year popwithrace_&year
numrenterhsgunits_&year);
set ACS.acs_2011_15_dc_sum_tr_wd12 (keep= pop16andoveryears_&year 
popincivlaborforce_&year personspovertydefined_&year 
pop25andoveryears_&year popwithrace_&year numrenterhsgunits_&year ward2012);

run;

proc export data = ACS_ward_n outfile = "L:\Libraries\Bridgepk\Data\ACS_ward_n.csv" dbms = csv replace;
run;

** Pull ACS Estimates for BP Areas **;
data ACS_bpk (keep= bridgepk ShrLaborForce_&year ShrEmpRate_&year ShrUnEmpRate_&year
ShrPov_&year ShrHS_&year ShrCol_&year ShrWht_&year ShrBlk_&year ShrHisp_&year 
ShrAsn_&year ShrOth_&year);
set ACS.acs_2011_15_dc_sum_tr_bpk (keep= popincivlaborforce_&year
pop16andoveryears_&year popcivilianemployed_&year popunemployed_&year 
poppoorpersons_&year personspovertydefined_&year popwithrace_&year 
popwhitenonhispbridge_&year popblacknonhispbridge_&year pophisp_&year 
popasianpinonhispbridge_&year popotherracenonhispbridg_&year 
pop25andoveryears_&year pop25andoverwhs_&year pop25andoverwcollege_&year 
bridgepk);

ShrLaborForce_&year = popincivlaborforce_&year / pop16andoveryears_&year;
ShrEmpRate_&year = popcivilianemployed_&year / popincivlaborforce_&year;
ShrUnEmpRate_&year = popunemployed_&year / popincivlaborforce_&year;
ShrPov_&year = poppoorpersons_&year / personspovertydefined_&year;

ShrHS_&year = pop25andoverwhs_&year / pop25andoveryears_&year;
ShrCol_&year = pop25andoverwcollege_&year / pop25andoveryears_&year;

ShrWht_&year = popwhitenonhispbridge_&year / popwithrace_&year;
ShrBlk_&year = popblacknonhispbridge_&year / popwithrace_&year;
ShrHisp_&year = pophisp_&year / popwithrace_&year;
ShrAsn_&year = popasianpinonhispbridge_&year / popwithrace_&year;
ShrOth_&year = popotherracenonhispbridg_&year / popwithrace_&year;

run;

proc export data = ACS_bpk outfile = "L:\Libraries\Bridgepk\Data\ACS_bpk_pct.csv" dbms = csv replace;
run;

data ACS_bpk_n (keep= bridgepk pop16andoveryears_&year popincivlaborforce_&year
personspovertydefined_&year pop25andoveryears_&year popwithrace_&year
numrenterhsgunits_&year);
set ACS.acs_2011_15_dc_sum_tr_bpk (keep= pop16andoveryears_&year 
popincivlaborforce_&year personspovertydefined_&year 
pop25andoveryears_&year popwithrace_&year numrenterhsgunits_&year bridgepk);

run;

proc export data = ACS_bpk_n outfile = "L:\Libraries\Bridgepk\Data\ACS_bpk_n.csv" dbms = csv replace;
run;

** Pull Real Prop Units for City**;
data RealProp_sf_units_city;
set RealProp.num_units_city (keep= units_sf_2000 units_sf_2001 units_sf_2002 
units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007 
units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012 
units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016 city);
run;

proc export data = RealProp_sf_units_city outfile = "L:\Libraries\Bridgepk\Data\RealProp_sf_units_city.csv" dbms = csv replace;
run;

data RealProp_condo_units_city;
set RealProp.num_units_city (keep= units_condo_2000 units_condo_2001 units_condo_2002
units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016 city);
run;

proc export data = RealProp_condo_units_city outfile = "L:\Libraries\Bridgepk\Data\RealProp_condo_units_city.csv" dbms = csv replace;
run;

** Pull Real Prop Single Family Sales for City**;
data RealProp_sf_nsales_city;
set RealProp.sales_sum_city (keep= sales_sf_2000 sales_sf_2001
sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
sales_sf_2014 sales_sf_2015 sales_sf_2016 city); 

proc export data = RealProp_sf_nsales_city outfile = "L:\Libraries\Bridgepk\Data\RealProp_sf_nsales_city.csv" dbms = csv replace;
run;

data RealProp_sf_price_city;
set RealProp.sales_sum_city (keep= r_mprice_sf_2000
r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016
city);
run;

proc export data = RealProp_sf_price_city outfile = "L:\Libraries\Bridgepk\Data\RealProp_sf_price_city.csv" dbms = csv replace;
run;

** Pull Real Prop Condo Sales for City**;
data RealProp_condo_sales_city;
set RealProp.sales_sum_city (keep= sales_condo_2000 sales_condo_2001
sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
sales_condo_2014 sales_condo_2015 sales_condo_2016 city); 

proc export data = RealProp_condo_sales_city outfile = "L:\Libraries\Bridgepk\Data\RealProp_condo_nsales_city.csv" dbms = csv replace;
run;

data RealProp_condo_price_city;
set RealProp.sales_sum_city (keep= r_mprice_condo_2000
r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016
city);
run;

proc export data = RealProp_condo_price_city outfile = "L:\Libraries\Bridgepk\Data\RealProp_condo_price_city.csv" dbms = csv replace;
run;

** Pull Real Prop Units for BP Area**;
data RealProp_sf_units_bpk;
set RealProp.num_units_bpk (keep= units_sf_2000 units_sf_2001 units_sf_2002
units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007
units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012
units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016 bridgepk);
run;

proc export data = RealProp_sf_units_bpk outfile = "L:\Libraries\Bridgepk\Data\RealProp_sf_units_bpk.csv" dbms = csv replace;
run;

data RealProp_condo_units_bpk;
set RealProp.num_units_bpk (keep= units_condo_2000 units_condo_2001 units_condo_2002 
units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016 bridgepk);
run;

proc export data = RealProp_condo_units_bpk outfile = "L:\Libraries\Bridgepk\Data\RealProp_condo_units_bpk.csv" dbms = csv replace;
run;

** Pull Real Prop Single Family Sales for BP Area**;
data RealProp_sf_nsales_bpk;
set RealProp.sales_sum_bpk (keep= sales_sf_2000 sales_sf_2001
sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
sales_sf_2014 sales_sf_2015 sales_sf_2016 bridgepk); 

proc export data = RealProp_sf_nsales_bpk outfile = "L:\Libraries\Bridgepk\Data\RealProp_sf_nsales_bpk.csv" dbms = csv replace;
run;

data RealProp_sf_price_bpk;
set RealProp.sales_sum_bpk (keep= r_mprice_sf_2000
r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016
bridgepk);
run;

proc export data = RealProp_sf_price_bpk outfile = "L:\Libraries\Bridgepk\Data\RealProp_sf_price_bpk.csv" dbms = csv replace;
run;

** Pull Real Prop Condo Sales for BP Area**;
data RealProp_condo_sales_bpk;
set RealProp.sales_sum_bpk (keep= sales_condo_2000 sales_condo_2001
sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
sales_condo_2014 sales_condo_2015 sales_condo_2016 bridgepk); 

proc export data = RealProp_condo_sales_bpk outfile = "L:\Libraries\Bridgepk\Data\RealProp_condo_nsales_bpk.csv" dbms = csv replace;
run;

data RealProp_condo_price_bpk;
set RealProp.sales_sum_bpk (keep= r_mprice_condo_2000
r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016
bridgepk);
run;

proc export data = RealProp_condo_price_bpk outfile = "L:\Libraries\Bridgepk\Data\RealProp_condo_price_bpk.csv" dbms = csv replace;
run;


** Pull Property and Violent Crime Stats for City **;
data Crime_prop_stats_city (keep= city property_crime_rate_2000 property_crime_rate_2001
property_crime_rate_2002 property_crime_rate_2003 property_crime_rate_2004 
property_crime_rate_2005 property_crime_rate_2006 property_crime_rate_2007 
property_crime_rate_2008 property_crime_rate_2009 property_crime_rate_2010
property_crime_rate_2011 property_crime_rate_2012 property_crime_rate_2013
property_crime_rate_2014 property_crime_rate_2015);
set Police.Crimes_sum_city (keep= crimes_pt1_property_2000 crimes_pt1_property_2001 
crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
crimes_pt1_property_2014 crimes_pt1_property_2015 crime_rate_pop_2000
crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 crime_rate_pop_2004 
crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 crime_rate_pop_2008
crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 crime_rate_pop_2012 
crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 city);

property_crime_rate_2000 = crimes_pt1_property_2000 / crime_rate_pop_2000;
property_crime_rate_2001 = crimes_pt1_property_2001 / crime_rate_pop_2001;
property_crime_rate_2002 = crimes_pt1_property_2002 / crime_rate_pop_2002;
property_crime_rate_2003 = crimes_pt1_property_2003 / crime_rate_pop_2003;
property_crime_rate_2004 = crimes_pt1_property_2004 / crime_rate_pop_2004;
property_crime_rate_2005 = crimes_pt1_property_2005 / crime_rate_pop_2005;
property_crime_rate_2006 = crimes_pt1_property_2006 / crime_rate_pop_2006;
property_crime_rate_2007 = crimes_pt1_property_2007 / crime_rate_pop_2007;
property_crime_rate_2008 = crimes_pt1_property_2008 / crime_rate_pop_2008;
property_crime_rate_2009 = crimes_pt1_property_2009 / crime_rate_pop_2009;
property_crime_rate_2010 = crimes_pt1_property_2010 / crime_rate_pop_2010;
property_crime_rate_2011 = crimes_pt1_property_2011 / crime_rate_pop_2011;
property_crime_rate_2012 = crimes_pt1_property_2012 / crime_rate_pop_2012;
property_crime_rate_2013 = crimes_pt1_property_2013 / crime_rate_pop_2013;
property_crime_rate_2014 = crimes_pt1_property_2014 / crime_rate_pop_2014;
property_crime_rate_2015 = crimes_pt1_property_2015 / crime_rate_pop_2015;

run;

proc export data = Crime_prop_stats_city outfile = "L:\Libraries\Bridgepk\Data\Crime_prop_stats_city.csv" dbms = csv replace;
run;

data Crime_viol_stats_city (keep= city violent_crime_rate_2000 violent_crime_rate_2001 
violent_crime_rate_2002 violent_crime_rate_2003 violent_crime_rate_2004 
violent_crime_rate_2005 violent_crime_rate_2006 violent_crime_rate_2007 
violent_crime_rate_2008 violent_crime_rate_2009 violent_crime_rate_2010 
violent_crime_rate_2011 violent_crime_rate_2012 violent_crime_rate_2013 
violent_crime_rate_2014 violent_crime_rate_2015);
set Police.Crimes_sum_city (keep= crimes_pt1_violent_2000 crimes_pt1_violent_2001 
crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
crimes_pt1_violent_2014 crimes_pt1_violent_2015 crime_rate_pop_2000
crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 crime_rate_pop_2004 
crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 crime_rate_pop_2008
crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 crime_rate_pop_2012 
crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 city);

violent_crime_rate_2000 = crimes_pt1_violent_2000 / crime_rate_pop_2000;
violent_crime_rate_2001 = crimes_pt1_violent_2001 / crime_rate_pop_2001;
violent_crime_rate_2002 = crimes_pt1_violent_2002 / crime_rate_pop_2002;
violent_crime_rate_2003 = crimes_pt1_violent_2003 / crime_rate_pop_2003;
violent_crime_rate_2004 = crimes_pt1_violent_2004 / crime_rate_pop_2004;
violent_crime_rate_2005 = crimes_pt1_violent_2005 / crime_rate_pop_2005;
violent_crime_rate_2006 = crimes_pt1_violent_2006 / crime_rate_pop_2006;
violent_crime_rate_2007 = crimes_pt1_violent_2007 / crime_rate_pop_2007;
violent_crime_rate_2008 = crimes_pt1_violent_2008 / crime_rate_pop_2008;
violent_crime_rate_2009 = crimes_pt1_violent_2009 / crime_rate_pop_2009;
violent_crime_rate_2010 = crimes_pt1_violent_2010 / crime_rate_pop_2010;
violent_crime_rate_2011 = crimes_pt1_violent_2011 / crime_rate_pop_2011;
violent_crime_rate_2012 = crimes_pt1_violent_2012 / crime_rate_pop_2012;
violent_crime_rate_2013 = crimes_pt1_violent_2013 / crime_rate_pop_2013;
violent_crime_rate_2014 = crimes_pt1_violent_2014 / crime_rate_pop_2014;
violent_crime_rate_2015 = crimes_pt1_violent_2015 / crime_rate_pop_2015;

run;

proc export data = Crime_viol_stats_city outfile = "L:\Libraries\Bridgepk\Data\Crime_viol_stats_city.csv" dbms = csv replace;
run;

** Pull Crime Stats for BP Area **;
data Crime_prop_stats_bpk (keep= bridgepk property_crime_rate_2000 property_crime_rate_2001
property_crime_rate_2002 property_crime_rate_2003 property_crime_rate_2004 
property_crime_rate_2005 property_crime_rate_2006 property_crime_rate_2007 
property_crime_rate_2008 property_crime_rate_2009 property_crime_rate_2010
property_crime_rate_2011 property_crime_rate_2012 property_crime_rate_2013
property_crime_rate_2014 property_crime_rate_2015);
set Police.Crimes_sum_bpk (keep= crimes_pt1_property_2000 crimes_pt1_property_2001 
crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
crimes_pt1_property_2014 crimes_pt1_property_2015 crime_rate_pop_2000
crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 crime_rate_pop_2004 
crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 crime_rate_pop_2008
crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 crime_rate_pop_2012 
crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 bridgepk);

property_crime_rate_2000 = crimes_pt1_property_2000 / crime_rate_pop_2000;
property_crime_rate_2001 = crimes_pt1_property_2001 / crime_rate_pop_2001;
property_crime_rate_2002 = crimes_pt1_property_2002 / crime_rate_pop_2002;
property_crime_rate_2003 = crimes_pt1_property_2003 / crime_rate_pop_2003;
property_crime_rate_2004 = crimes_pt1_property_2004 / crime_rate_pop_2004;
property_crime_rate_2005 = crimes_pt1_property_2005 / crime_rate_pop_2005;
property_crime_rate_2006 = crimes_pt1_property_2006 / crime_rate_pop_2006;
property_crime_rate_2007 = crimes_pt1_property_2007 / crime_rate_pop_2007;
property_crime_rate_2008 = crimes_pt1_property_2008 / crime_rate_pop_2008;
property_crime_rate_2009 = crimes_pt1_property_2009 / crime_rate_pop_2009;
property_crime_rate_2010 = crimes_pt1_property_2010 / crime_rate_pop_2010;
property_crime_rate_2011 = crimes_pt1_property_2011 / crime_rate_pop_2011;
property_crime_rate_2012 = crimes_pt1_property_2012 / crime_rate_pop_2012;
property_crime_rate_2013 = crimes_pt1_property_2013 / crime_rate_pop_2013;
property_crime_rate_2014 = crimes_pt1_property_2014 / crime_rate_pop_2014;
property_crime_rate_2015 = crimes_pt1_property_2015 / crime_rate_pop_2015;

run;

proc export data = Crime_prop_stats_bpk outfile = "L:\Libraries\Bridgepk\Data\Crime_prop_stats_bpk.csv" dbms = csv replace;
run;

data Crime_viol_stats_bpk (keep= bridgepk violent_crime_rate_2000 violent_crime_rate_2001 
violent_crime_rate_2002 violent_crime_rate_2003 violent_crime_rate_2004 
violent_crime_rate_2005 violent_crime_rate_2006 violent_crime_rate_2007 
violent_crime_rate_2008 violent_crime_rate_2009 violent_crime_rate_2010 
violent_crime_rate_2011 violent_crime_rate_2012 violent_crime_rate_2013 
violent_crime_rate_2014 violent_crime_rate_2015);
set Police.Crimes_sum_bpk (keep= crimes_pt1_violent_2000 crimes_pt1_violent_2001 
crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
crimes_pt1_violent_2014 crimes_pt1_violent_2015 crime_rate_pop_2000
crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 crime_rate_pop_2004 
crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 crime_rate_pop_2008
crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 crime_rate_pop_2012 
crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 bridgepk);

violent_crime_rate_2000 = crimes_pt1_violent_2000 / crime_rate_pop_2000;
violent_crime_rate_2001 = crimes_pt1_violent_2001 / crime_rate_pop_2001;
violent_crime_rate_2002 = crimes_pt1_violent_2002 / crime_rate_pop_2002;
violent_crime_rate_2003 = crimes_pt1_violent_2003 / crime_rate_pop_2003;
violent_crime_rate_2004 = crimes_pt1_violent_2004 / crime_rate_pop_2004;
violent_crime_rate_2005 = crimes_pt1_violent_2005 / crime_rate_pop_2005;
violent_crime_rate_2006 = crimes_pt1_violent_2006 / crime_rate_pop_2006;
violent_crime_rate_2007 = crimes_pt1_violent_2007 / crime_rate_pop_2007;
violent_crime_rate_2008 = crimes_pt1_violent_2008 / crime_rate_pop_2008;
violent_crime_rate_2009 = crimes_pt1_violent_2009 / crime_rate_pop_2009;
violent_crime_rate_2010 = crimes_pt1_violent_2010 / crime_rate_pop_2010;
violent_crime_rate_2011 = crimes_pt1_violent_2011 / crime_rate_pop_2011;
violent_crime_rate_2012 = crimes_pt1_violent_2012 / crime_rate_pop_2012;
violent_crime_rate_2013 = crimes_pt1_violent_2013 / crime_rate_pop_2013;
violent_crime_rate_2014 = crimes_pt1_violent_2014 / crime_rate_pop_2014;
violent_crime_rate_2015 = crimes_pt1_violent_2015 / crime_rate_pop_2015;

run;

proc export data = Crime_viol_stats_bpk outfile = "L:\Libraries\Bridgepk\Data\Crime_viol_stats_bpk.csv" dbms = csv replace;
run;



** Pull Population and Household Counts for city**;
data NCDB_counts90_00_city;
set NCDB.Ncdb_sum_city  (keep= totpop_1990 totpop_2000
numoccupiedhsgunits_1990 numoccupiedhsgunits_2000 city); 

proc export data = NCDB_counts90_00_city outfile = "L:\Libraries\Bridgepk\Data\NCDB_counts90_00_city.csv" dbms = csv replace;
run;

data NCDB_counts10_city;
set NCDB.Ncdb_sum_2010_city  (keep= totpop_2010 numoccupiedhsgunits_2010 city); 

proc export data = NCDB_counts10_city outfile = "L:\Libraries\Bridgepk\Data\NCDB_counts10_city.csv" dbms = csv replace;
run;

** Pull Population and Household Counts for Ward**;
data NCDB_counts90_00_wd12;
set NCDB.Ncdb_sum_wd12  (keep= totpop_1990 totpop_2000
numoccupiedhsgunits_1990 numoccupiedhsgunits_2000 ward2012); 

proc export data = NCDB_counts90_00_wd12 outfile = "L:\Libraries\Bridgepk\Data\NCDB_counts90_00_wd12.csv" dbms = csv replace;
run;

data NCDB_counts10_wd12;
set NCDB.Ncdb_sum_2010_wd12  (keep= totpop_2010 numoccupiedhsgunits_2010 ward2012); 

proc export data = NCDB_counts10_wd12 outfile = "L:\Libraries\Bridgepk\Data\NCDB_counts10_wd12.csv" dbms = csv replace;
run;

** Pull Population and Household Counts for BP Area**;
data NCDB_counts90_00_bpk;
set NCDB.Ncdb_sum_bpk  (keep= totpop_1990 totpop_2000
numoccupiedhsgunits_1990 numoccupiedhsgunits_2000 bridgepk); 

proc export data = NCDB_counts90_00_bpk outfile = "L:\Libraries\Bridgepk\Data\NCDB_counts90_00_bpk.csv" dbms = csv replace;
run;

data NCDB_counts10_bpk;
set NCDB.Ncdb_sum_2010_bpk  (keep= totpop_2010 numoccupiedhsgunits_2010 bridgepk); 

proc export data = NCDB_counts10_bpk outfile = "L:\Libraries\Bridgepk\Data\NCDB_counts10_bpk.csv" dbms = csv replace;
run;
