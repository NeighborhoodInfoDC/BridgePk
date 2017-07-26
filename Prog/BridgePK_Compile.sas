/**************************************************************************
 Program:  BridgePk_Compile.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   S. Diby
 Created:  7/26/17
 Version:  SAS 9.2
 Environment:  Local Windows session
 
 Description:  Prepare data for initial 11th Street Bridge Park Data Room
			   Presentation on 3/27/2017, from ACS, Realprop, and Police.
			   Adapted from L:\Libraries\Bridgepk\Prog\BPKPresentationResults.sas and
		 	   L:\Libraries\Equity\Prog\Equity_Compile_ACS_for_profile.sas

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( ACS )
%DCData_lib( Realprop )
%DCData_lib( Police )
%DCData_lib( NCDB )
%DCData_lib( Bridgepk )

** Define geographies  **;
%let geography=city Ward2012 BridgePk;

** Define time periods  **;
%let year = 2011_15;
%let year_lbl = 2011-15;


%macro add_percents;

%do i = 1 %to 3; 
  %let geo=%scan(&geography., &i., " "); 


    %local geosuf geoafmt j; 

  %let geosuf = %sysfunc( putc( %upcase( &geo ), $geosuf. ) );
  %let geoafmt = %sysfunc( putc( %upcase( &geo ), $geoafmt. ) );

  data bridgepk&geosuf._A (compress=no);  
  	merge  
      acs.Acs_2011_15_dc_sum_tr&geosuf
        (keep=&geo TotPop: mTotPop: 
		   Pop25andOverYears: mPop25andOverYears: 
		   PopWithRace: mPopWithRace:
		   PopBlackNonHispBridge: mPopBlackNonHispBridge:
           PopWhiteNonHispBridge: mPopWhiteNonHispBridge:
		   PopHisp: mPopHisp:
		   PopAsianPINonHispBridge: mPopAsianPINonHispBridge:
		   PopOtherRaceNonHispBridg: mPopOtherRaceNonHispBr:
		   PopMultiracialNonHisp: mPopMultiracialNonHisp:
		   Pop25andOverWHS: mPop25andOverWHS:
		   Pop25andOverWCollege: mPop25andOverWCollege:
		   NumOccupiedHsgUnits: mNumOccupiedHsgUnits:
		   NumOwnerOccupiedHU: mNumOwnerOccupiedHU:
           NumRenterHsgUnits: mNumRenterHsgUnits:
		   NumRenterOccupiedHU: mNumRenterOccupiedHU:
           NumOwnerOccupiedHU: mNumOwnerOccupiedHU:
		   GrossRent: mGrossRent:
		   NumRenterCostBurden: mNumRenterCostBurden:
		   NumRentSevereCostBurden: mNumRentSevereCostBurden:
		   NumOwnerCostBurden:	mNumOwnerCostBurden:
		   NumOwnSevereCostBurden:mNumOwnSevereCostBurden:
           PersonsPovertyDef: mPersonsPovertyDef:
           PopPoorPersons: mPopPoorPersons: 
           PopInCivLaborForce: mPopInCivLaborForce: 
		   PopCivilianEmployed: mPopCivilianEmployed:
           PopUnemployed: mPopUnemployed:
		   PopEmployedByInd: mPopEmployedByInd:
		   PopEmployedAgric: mPopEmployedAgric:
		   PopEmployedConstr: mPopEmployedConstr:
		   PopEmployedManuf: mPopEmployedManuf:
		   PopEmployedWhlsale: mPopEmployedWhlsale:
		   PopEmployedRetail: mPopEmployedRetail:
		   PopEmployedTransprt: mPopEmployedTransprt:
		   PopEmployedInfo: mPopEmployedInfo:
		   PopEmployedFinance: mPopEmployedFinance:
		   PopEmployedProfServ: mPopEmployedProfServ:
		   PopEmployedEduction: mPopEmployedEduction:
		   PopEmployedArts: mPopEmployedArts:
		   PopEmployedOther: mPopEmployedOther:
		   PopEmployedPubAdmin: mPopEmployedPubAdmin:
		   rename=(TotPop_2010_14=TotPop_tr_2010_14 mTotPop_2010_14=mTotPop_tr_2010_14))
         	;
	RealProp.num_units&geosuf
		(keep= &geo units_sf_2000 units_sf_2001 units_sf_2002 
				units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007 
				units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012 
				units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016)
				;
	RealProp.num_units&geosuf
		(keep= &geo units_condo_2000 units_condo_2001 units_condo_2002
				units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
				units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
				units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016);
	RealProp.sales_sum&geosuf
		(keep= &geo sales_sf_2000 sales_sf_2001
				sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
				sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
				sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
				sales_sf_2014 sales_sf_2015 sales_sf_2016); 
	RealProp.sales_sum&geosuf 
		(keep= &geo r_mprice_sf_2000
				r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
				r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
				r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
				r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016);
	RealProp.sales_sum&geosuf 
		(keep= &geo sales_condo_2000 sales_condo_2001
				sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
				sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
				sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
				sales_condo_2014 sales_condo_2015 sales_condo_2016); 
	RealProp.sales_sum&geosuf  
		(keep= &geo r_mprice_condo_2000
				r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
				r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
				r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
				r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016
			);
	Police.Crimes_sum&geosuf 
		(keep= &geo crimes_pt1_property_2000 crimes_pt1_property_2001 
				crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
				crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
				crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
				crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
				crimes_pt1_property_2014 crimes_pt1_property_2015 crimes_pt1_property_2016 
				crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
				crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
				crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
				crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
				crime_rate_pop_2016);
	Police.Crimes_sum&geosuf 
		(keep= &geo crimes_pt1_violent_2000 crimes_pt1_violent_2001 
				crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
				crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
				crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
				crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
				crimes_pt1_violent_2014 crimes_pt1_violent_2015 crimes_pt1_violent_2016 
				crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
				crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
				crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
				crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
				crime_rate_pop_2016);
	NCDB.Ncdb_sum&geosuf  (keep= totpop_1990 totpop_2000 numoccupiedhsgunits_1990 numoccupiedhsgunits_2000); 
	NCDB.Ncdb_sum_2010&geosuf  (keep= totpop_2010 numoccupiedhsgunits_2010 city);

     by &geo;

  run;

  data bridgepk.profile_acs&geosuf (compress=no label="DC Equity Indicators by Race/Ethnicity, 2010-14, &geo."); 
  
    set profile_acs&geosuf._A;

	%Pct_calc( var=PctLaborForce, label=% pop. 16+ yrs. in the labor force, num=PopInCivLaborForce, den=Pop16andOverYears, years=2010_14 )

    %Moe_prop_a( var=PctForeignBorn_m_2010_14, mult=100, num=PopForeignBorn_2010_14, den=PopWithRace_2010_14, 
                       num_moe=mPopForeignBorn_2010_14, den_moe=mPopWithRace_2010_14 );
