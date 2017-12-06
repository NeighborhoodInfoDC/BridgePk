/**************************************************************************
 Program:  BPK_Metrics.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   S.Diby
 Created:  3/20/17
 Version:  SAS 9.2
 Environment:  Local Windows session
 
 Description:  Adapted from "BPKPresentationResults" program created by Jay Dev in March 2017.
			   This program outputs compiled summary data at the city, ward, 11th Street Bridge Park geographies.

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( ACS )
%DCData_lib( Realprop )
%DCData_lib( Police )
%DCData_lib( NCDB )
%DCData_lib( Bridgepk )


** Define time periods  **;
%let _years = 2011_15;
%let year_lbl = 2011-15;


%macro Compile_bpk_data (geo, geosuf);

data bridgepk.compile_bpk_tabs_&geosuf;
	merge 
		ACS.acs_2011_15_dc_sum_tr_&geosuf
			(keep= &geo
				popincivlaborforce_&_years.
				pop16andoveryears_&_years. popcivilianemployed_&_years. popunemployed_&_years. 
				poppoorpersons_&_years. personspovertydefined_&_years. popwithrace_&_years. 
				PopEmployedTravel_&_years. PopEmployedTravel_LT5_&_years.
				PopEmployedTravel_5_9_&_years. PopEmployedTravel_10_14_&_years.
				PopEmployedTravel_15_19_&_years. PopEmployedTravel_20_24_&_years. 
				PopEmployedTravel_25_29_&_years. PopEmployedTravel_30_34_&_years. 
				PopEmployedTravel_35_39_&_years. PopEmployedTravel_40_44_&_years. 
				PopEmployedTravel_45_59_&_years. PopEmployedTravel_60_89_&_years. 
				PopEmployedTravel_GT90_&_years.
				NumOwnCstBurden_LT10K_&_years. NumOwnCstBurden_10_19K_&_years. 
				NumOwnCstBurden_20_34K_&_years. NumOwnCstBurden_35_49K_&_years. 
				NumOwnCstBurden_50_74K_&_years. NumOwnCstBurden_75_99K_&_years. 
				NumOwnCstBurden_100_149_&_years. NumOwnCstBurden_GT150K_&_years. )


		Acs.Acs_2011_15_dc_sum_bg_&geosuf
			(keep= &geo 
				popwhitenonhispbridge_&_years. popblacknonhispbridge_&_years. pophisp_&_years. 
				popasianpinonhispbridge_&_years. popotherracenonhispbridg_&_years. 
				pop25andoveryears_&_years. pop25andoverwhs_&_years. Pop25andOverWoutHS_&_years. pop25andoverwcollege_&_years. 
				PopEmployedByInd_&_years. PopEmployedAgric_&_years. PopEmployedConstr_&_years. 
				PopEmployedManuf_&_years. PopEmployedWhlsale_&_years. PopEmployedRetail_&_years. 
				PopEmployedTransprt_&_years. PopEmployedInfo_&_years. PopEmployedFinance_&_years. 
				PopEmployedProfServ_&_years. PopEmployedEduction_&_years. PopEmployedArts_&_years. 
				PopEmployedOther_&_years. PopEmployedPubAdmin_&_years.
				PopEmployedByOcc_&_years. PopEmployedMngmt_&_years.
				PopEmployedServ_&_years. PopEmployedSales_&_years.
				PopEmployedNatRes_&_years. PopEmployedProd_&_years. 
				PopEmployedWorkers_&_years. PopEmployedWorkInState_&_years. PopEmployedWorkOutState_&_years.
				NumRenterOccupiedHU_&_years. NumOwnerOccupiedHU_&_years. NumOccupiedHsgUnits_&_years.
				RentCostBurdenDenom_&_years. OwnerCostBurdenDenom_&_years. 
				NumRenterCostBurden_&_years. NumRentSevereCostBurden_&_years. 
				NumOwnerCostBurden_&_years. NumOwnSevereCostBurden_&_years.
				NumRentCstBurden_15_24_&_years. NumRentCstBurden_25_34_&_years. 
				NumRentCstBurden_35_64_&_years. NumRentCstBurden_65Over_&_years. 
				NumOwnCstBurden_15_24_&_years. NumOwnCstBurden_25_34_&_years. 
				NumOwnCstBurden_35_64_&_years. NumOwnCstBurden_65Over_&_years. 
				NumRentCstBurden_LT10K_&_years. NumRentCstBurden_10_19K_&_years. 
				NumRentCstBurden_20_34K_&_years. NumRentCstBurden_35_49K_&_years. 
				NumRentCstBurden_50_74K_&_years. NumRentCstBurden_75_99K_&_years. 
				NumRentCstBurden_GT100K_&_years.
				GrossRentLT100_499_&_years. GrossRent500_799_&_years.
				GrossRent800_899_&_years. GrossRent900_999_&_years.
				GrossRent1000_1249_&_years. GrossRent1250_1499_&_years.
				GrossRent1500_1999_&_years. GrossRent2000_2499_&_years.
				GrossRent2500_2999_&_years. GrossRent3000_3499_&_years.
				GrossRentGT3500_&_years. )


		RealProp.num_units_&geosuf 
			(keep= &geo units_sf_2000 units_sf_2001 units_sf_2002 
				units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007 
				units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012 
				units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016

				units_condo_2000 units_condo_2001 units_condo_2002
				units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
				units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
				units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016)
					
		RealProp.sales_sum_&geosuf 
			(keep= &geo sales_sf_2000 sales_sf_2001
				sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
				sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
				sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
				sales_sf_2014 sales_sf_2015 sales_sf_2016 

				r_mprice_sf_2000 
				r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
				r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
				r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
				r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016

				sales_condo_2000 sales_condo_2001
				sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
				sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
				sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
				sales_condo_2014 sales_condo_2015 sales_condo_2016

				r_mprice_condo_2000
				r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
				r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
				r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
				r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016)

		Police.Crimes_sum_&geosuf
			(keep=&geo 
				crimes_pt1_property_2000 crimes_pt1_property_2001 
				crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
				crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
				crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
				crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
				crimes_pt1_property_2014 crimes_pt1_property_2015 crimes_pt1_property_2016 
				crimes_pt1_violent_2000 crimes_pt1_violent_2001 
				crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
				crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
				crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
				crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
				crimes_pt1_violent_2014 crimes_pt1_violent_2015 crimes_pt1_violent_2016 
				crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
				crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
				crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
				crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
				crime_rate_pop_2016)
		
		NCDB.Ncdb_sum_&geosuf
			(keep= &geo totpop_1990 totpop_2000 
				numoccupiedhsgunits_1990 numoccupiedhsgunits_2000)

		NCDB.Ncdb_sum_2010_&geosuf
			(keep= &geo totpop_2010 numoccupiedhsgunits_2010); 

		by &geo;

		/*Labor force, employment, and poverty*/
			PctLaborForce_&_years. = popincivlaborforce_&_years. / pop16andoveryears_&_years.;
			PctPopEmployed_&_years. = popcivilianemployed_&_years. / popincivlaborforce_&_years.;
			PctPopUnemployed_&_years. = popunemployed_&_years. / popincivlaborforce_&_years.;
			PctPoorPersons_&_years. = poppoorpersons_&_years. / personspovertydefined_&_years.;

		/*Employment by major occupations*/
			PctEmpMngmt_&_years. = popemployedmngmt_&_years. / popemployedbyocc_2011_15;
			PctEmpNatRes_&_years. = popemployednatres_&_years. / popemployedbyocc_2011_15;
			PctEmpProd_&_years. = popemployedprod_&_years. / popemployedbyocc_2011_15;
			PctEmpSales_&_years. = popemployedsales_&_years. / popemployedbyocc_2011_15;
			PctEmpServ_&_years. = popemployedserv_&_years. / popemployedbyocc_2011_15;

		/*Employment by major industries*/
			PctEmpAgric_&_years. = PopEmployedAgric_&_years. / popemployedbyind_&_years.;
			PctEmpConstr_&_years. = PopEmployedConstr_&_years. / popemployedbyind_&_years.;
			PctEmpManuf_&_years. = PopEmployedManuf_&_years. / popemployedbyind_&_years.;
			PctEmpWhlsale_&_years. = PopEmployedWhlsale_&_years. / popemployedbyind_&_years.;
			PctEmpRetail_&_years. = PopEmployedRetail_&_years. / popemployedbyind_&_years.;
			PctEmpTransprt_&_years. = PopEmployedTransprt_&_years. / popemployedbyind_&_years.;
			PctEmpInfo_&_years. = PopEmployedInfo_&_years. / popemployedbyind_&_years.;
			PctEmpFinance_&_years. = PopEmployedFinance_&_years. / popemployedbyind_&_years.;
			PctEmpProfServ_&_years. = PopEmployedProfServ_&_years. / popemployedbyind_&_years.;
			PctEmpEduction_&_years. = PopEmployedEduction_&_years. / popemployedbyind_&_years.;
			PctEmpArts_&_years. = PopEmployedArts_&_years. / popemployedbyind_&_years.;
			PctEmpOther_&_years. = PopEmployedOther_&_years. / popemployedbyind_&_years.;
			PctEmpPubAdmin_&_years. = PopEmployedPubAdmin_&_years. / popemployedbyind_&_years.;

		/*Employment by place of work*/

			PctEmployedWorkInState_&_years. = PopEmployedWorkInState_&_years. / PopEmployedWorkers_&_years.;
			PctEmployedWorkOutState_&_years. = PopEmployedWorkOutState_&_years. / PopEmployedWorkers_&_years.;

		/*Employment by travel time to work*/

			PctEmployedTravel_LT5_&_years. = PopEmployedTravel_LT5_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_5_9_&_years. = PopEmployedTravel_5_9_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_10_14_&_years. = PopEmployedTravel_10_14_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_15_19_&_years. = PopEmployedTravel_15_19_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_20_24_&_years. = PopEmployedTravel_20_24_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_25_29_&_years. = PopEmployedTravel_25_29_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_30_34_&_years. = PopEmployedTravel_30_34_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_35_39_&_years. = PopEmployedTravel_35_39_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_40_44_&_years. = PopEmployedTravel_40_44_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_45_59_&_years. = PopEmployedTravel_45_59_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_60_89_&_years. = PopEmployedTravel_60_89_&_years. / PopEmployedTravel_&_years.;
			PctEmployedTravel_GT90_&_years. = PopEmployedTravel_GT90_&_years. / PopEmployedTravel_&_years.;

		/*Homeownership, rent, and cost burden by age of householder and household income*/
			PctHomeownership_&_years. = numowneroccupiedhu_&_years. / numoccupiedhsgunits_&_years.;
			PctRenterCostBurden_&_years. = NumRenterCostBurden_&_years./RentCostBurdenDenom_&_years.;
			PctRentSevereCostBurden_&_years. = NumRentSevereCostBurden_&_years./RentCostBurdenDenom_&_years.;
			PctOwnerCostBurden_&_years. = NumOwnerCostBurden_&_years./OwnerCostBurdenDenom_&_years.;
			PctOwnSevereCostBurden_&_years. = NumOwnSevereCostBurden_&_years./OwnerCostBurdenDenom_&_years.;

			PctRentCstBurden_15_24_&_years. = NumRentCstBurden_15_24_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_25_34_&_years. = NumRentCstBurden_25_34_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_35_64_&_years. = NumRentCstBurden_35_64_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_65Over_&_years. = NumRentCstBurden_65Over_&_years. / RentCostBurdenDenom_&_years.;

			PctOwnCstBurden_15_24_&_years. = NumOwnCstBurden_15_24_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_25_34_&_years. = NumOwnCstBurden_25_34_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_35_64_&_years. = NumOwnCstBurden_35_64_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_65Over_&_years. = NumOwnCstBurden_65Over_&_years. / OwnerCostBurdenDenom_&_years.;

			PctRentCstBurden_LT10K_&_years. = NumRentCstBurden_LT10K_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_10_19K_&_years. = NumRentCstBurden_10_19K_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_20_34K_&_years. = NumRentCstBurden_20_34K_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_35_49K_&_years. = NumRentCstBurden_35_49K_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_50_74K_&_years. = NumRentCstBurden_50_74K_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_75_99K_&_years. = NumRentCstBurden_75_99K_&_years. / RentCostBurdenDenom_&_years.;
			PctRentCstBurden_GT100K_&_years. = NumRentCstBurden_GT100K_&_years. / RentCostBurdenDenom_&_years.;

			PctOwnCstBurden_LT10K_&_years. = NumOwnCstBurden_LT10K_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_10_19K_&_years. = NumOwnCstBurden_10_19K_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_20_34K_&_years. = NumOwnCstBurden_20_34K_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_35_49K_&_years. = NumOwnCstBurden_35_49K_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_50_74K_&_years. = NumOwnCstBurden_50_74K_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_75_99K_&_years. = NumOwnCstBurden_75_99K_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_100_149_&_years. = NumOwnCstBurden_100_149_&_years. / OwnerCostBurdenDenom_&_years.;
			PctOwnCstBurden_GT150K_&_years. = NumOwnCstBurden_GT150K_&_years. / OwnerCostBurdenDenom_&_years.;

		/*Education*/
			PctHS_&_years. = pop25andoverwhs_&_years. / pop25andoveryears_&_years.;
			PctCol_&_years. = pop25andoverwcollege_&_years. / pop25andoveryears_&_years.;
			PctWoutHS_&_years. = Pop25andOverWoutHS / pop25andoveryears_&_years.;

		/*Race and ethnicity*/
			PctWht_&_years. = popwhitenonhispbridge_&_years. / popwithrace_&_years.;
			PctBlk_&_years. = popblacknonhispbridge_&_years. / popwithrace_&_years.;
			PctHisp_&_years. = pophisp_&_years. / popwithrace_&_years.;
			PctAsn_&_years. = popasianpinonhispbridge_&_years. / popwithrace_&_years.;
			PctOth_&_years. = popotherracenonhispbridg_&_years. / popwithrace_&_years.;

		/*Property crime rates*/
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
			property_crime_rate_2016 = crimes_pt1_property_2016 / crime_rate_pop_2016;

		/*Violent crime rates*/
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
			violent_crime_rate_2016 = crimes_pt1_violent_2016 / crime_rate_pop_2016;

	run;

proc transpose data=bridgepk.compile_bpk_tabs_&geosuf out=bridgepk.bpk_tabs_&geosuf(label="Bridge Park Tabulations, &geo");
	var 	&geo 	

		/*Population*/
			totpop_1990 totpop_2000 totpop_2010
			numoccupiedhsgunits_1990 numoccupiedhsgunits_2000 numoccupiedhsgunits_2010 
		
		/*Race and ethnicity*/
			popwithrace_&_years. 
			PctWht_&_years. 
			PctBlk_&_years. 
			PctHisp_&_years.
			PctAsn_&_years.
			PctOth_&_years. 
	
		/*Homeownership, rent, and cost burden*/
			NumOwnerOccupiedHU_&_years.
			NumRenterOccupiedHU_&_years. 
			PctHomeownership_&_years. 

			GrossRentLT100_499_&_years. GrossRent500_799_&_years.
			GrossRent800_899_&_years. GrossRent900_999_&_years.
			GrossRent1000_1249_&_years. GrossRent1250_1499_&_years.
			GrossRent1500_1999_&_years. GrossRent2000_2499_&_years.
			GrossRent2500_2999_&_years. GrossRent3000_3499_&_years.
			GrossRentGT3500_&_years. 

			NumRenterCostBurden_&_years. 
			NumRentSevereCostBurden_&_years. 
			PctRenterCostBurden_&_years. 
			PctRentSevereCostBurden_&_years.

			NumOwnerCostBurden_&_years. 
			NumOwnSevereCostBurden_&_years. 
			PctOwnerCostBurden_&_years. 
			PctOwnSevereCostBurden_&_years. 

			PctRentCstBurden_15_24_&_years. 
			PctRentCstBurden_25_34_&_years. 
			PctRentCstBurden_35_64_&_years. 
			PctRentCstBurden_65Over_&_years. 

			PctOwnCstBurden_15_24_&_years. 
			PctOwnCstBurden_25_34_&_years. 
			PctOwnCstBurden_35_64_&_years. 
			PctOwnCstBurden_65Over_&_years. 

			PctRentCstBurden_LT10K_&_years. 
			PctRentCstBurden_10_19K_&_years. 
			PctRentCstBurden_20_34K_&_years. 
			PctRentCstBurden_35_49K_&_years. 
			PctRentCstBurden_50_74K_&_years. 
			PctRentCstBurden_75_99K_&_years. 
			PctRentCstBurden_GT100K_&_years. 

			PctOwnCstBurden_LT10K_&_years. 
			PctOwnCstBurden_10_19K_&_years. 
			PctOwnCstBurden_20_34K_&_years. 
			PctOwnCstBurden_35_49K_&_years. 
			PctOwnCstBurden_50_74K_&_years. 
			PctOwnCstBurden_75_99K_&_years. 
			PctOwnCstBurden_100_149_&_years. 
			PctOwnCstBurden_GT150K_&_years. 

		/*Poverty*/		
			PctPoorPersons_&_years.
			poppoorpersons_&_years. 
			personspovertydefined_&_years. 

		/*Education*/
			Pop25andoveryears_&_years.
			PctHS_&_years. 
			PctCol_&_years. 
			PctWoutHS_&_years.

		/*Labor force and employment*/
			PctLaborForce_&_years.
			PctPopEmployed_&_years. 
			PctPopUnemployed_&_years. 
			popincivlaborforce_&_years.
			pop16andoveryears_&_years. 
			popcivilianemployed_&_years. 
			popunemployed_&_years. 
			
		/*Employment by major occupations*/
			PopEmployedByOcc_&_years. 
			PopEmployedMngmt_&_years.
			PopEmployedServ_&_years. 
			PopEmployedSales_&_years.
			PopEmployedNatRes_&_years. 
			PopEmployedProd_&_years. 


		/*Employment by major industries*/
			PopEmployedByInd_&_years. 
			PopEmployedAgric_&_years. 
			PopEmployedConstr_&_years. 
			PopEmployedManuf_&_years. 
			PopEmployedWhlsale_&_years. 
			PopEmployedRetail_&_years. 
			PopEmployedTransprt_&_years. 
			PopEmployedInfo_&_years. 
			PopEmployedFinance_&_years. 
			PopEmployedProfServ_&_years. 
			PopEmployedEduction_&_years. 
			PopEmployedArts_&_years. 
			PopEmployedOther_&_years. 
			PopEmployedPubAdmin_&_years.

		/*Employment by workplace location*/
			PctEmployedWorkInState_&_years. 
			PctEmployedWorkOutState_&_years. 

		/*Employment by travel time to work*/
			PctEmployedTravel_LT5_&_years. 
			PctEmployedTravel_5_9_&_years. 
			PctEmployedTravel_10_14_&_years. 
			PctEmployedTravel_15_19_&_years. 
			PctEmployedTravel_20_24_&_years. 
			PctEmployedTravel_25_29_&_years. 
			PctEmployedTravel_30_34_&_years. 
			PctEmployedTravel_35_39_&_years. 
			PctEmployedTravel_40_44_&_years. 
			PctEmployedTravel_45_59_&_years. 
			PctEmployedTravel_60_89_&_years. 
			PctEmployedTravel_GT90_&_years. 
			
		/*Residential property: total units, total sales, and median sales price: 2000 - 2016*/
			units_sf_2000 units_sf_2001 units_sf_2002 
			units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007 
			units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012 
			units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016

			units_condo_2000 units_condo_2001 units_condo_2002
			units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
			units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
			units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016
				
			sales_sf_2000 sales_sf_2001
			sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
			sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
			sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
			sales_sf_2014 sales_sf_2015 sales_sf_2016 

			r_mprice_sf_2000 
			r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
			r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
			r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
			r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016

			sales_condo_2000 sales_condo_2001
			sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
			sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
			sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
			sales_condo_2014 sales_condo_2015 sales_condo_2016

			r_mprice_condo_2000
			r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
			r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
			r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
			r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016


		/*Violent and property crime rates: 2000 - 2016*/
			property_crime_rate_2001 property_crime_rate_2002 
			property_crime_rate_2003 property_crime_rate_2004
			property_crime_rate_2005 property_crime_rate_2006
			property_crime_rate_2007 property_crime_rate_2008
			property_crime_rate_2009 property_crime_rate_2010
			property_crime_rate_2011 property_crime_rate_2012 
			property_crime_rate_2013 property_crime_rate_2014
			property_crime_rate_2015 property_crime_rate_2016 
			
			violent_crime_rate_2001 violent_crime_rate_2002 
			violent_crime_rate_2003 violent_crime_rate_2004
			violent_crime_rate_2005 violent_crime_rate_2006
			violent_crime_rate_2007 violent_crime_rate_2008
			violent_crime_rate_2009 violent_crime_rate_2010
			violent_crime_rate_2011 violent_crime_rate_2012 
			violent_crime_rate_2013 violent_crime_rate_2014
			violent_crime_rate_2015 violent_crime_rate_2016 
		;
id &geo; 
run; 

proc export data=bridgepk.bpk_tabs_&geosuf
	outfile="L:\Libraries\BridgePk\Data\bpktabs_&geosuf..csv"
	dbms=csv replace;
	run;


%mend Compile_bpk_data;


%Compile_bpk_data (bridgepk, bpk);
%Compile_bpk_data (ward2012, wd12);
%Compile_bpk_data (city, city);
