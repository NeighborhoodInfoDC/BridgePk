/**************************************************************************
 Program:  BPK Summary Tabs_2014-18.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   O.Arena
 Created:  1/31/2020
 Version:  SAS 9.2
 Environment:  Local Windows session
 
 Description:  An update to BPK Summary tab_2014-18.sas.
			   This program outputs compiled summary data at the city, ward, 11th Street Bridge Park geographies.
			   
 Updated with 2014-18 ACS data.

**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( ACS )
%DCData_lib( Realprop )
%DCData_lib( Police )
%DCData_lib( NCDB )
%DCData_lib( Bridgepk )
%DCData_lib( Hmda )
%DCData_lib( Dcra )
%DCData_lib( Vital )

** Define time periods  **;
%let _years = 2014_18;
%let year_lbl = 2014-18;

%macro Compile_bpk_data (geo, geosuf);

data compile_bpk_tabs_2014_18_&geosuf;
	merge 
		ACS.acs_2014_18_dc_sum_tr_&geosuf
			(keep= &geo
				totpop_&_years.
				popincivlaborforce_&_years.
				pop16andoveryears_&_years. popcivilianemployed_&_years. popunemployed_&_years. 
				poppoorpersons_&_years. personspovertydefined_&_years. popwithrace_&_years. 
				poppoorchildren_&_years. childrenpovertydefined_&_years.
				PopEmployedTravel_&_years. PopEmployedTravel_LT5_&_years.
				PopEmployedTravel_5_9_&_years. PopEmployedTravel_10_14_&_years.
				PopEmployedTravel_15_19_&_years. PopEmployedTravel_20_24_&_years. 
				PopEmployedTravel_25_29_&_years. PopEmployedTravel_30_34_&_years. 
				PopEmployedTravel_35_39_&_years. PopEmployedTravel_40_44_&_years. 
				PopEmployedTravel_45_59_&_years. PopEmployedTravel_60_89_&_years. 
				PopEmployedTravel_GT90_&_years.
				NumRenterOccupiedHU_&_years. NumOwnerOccupiedHU_&_years. NumOccupiedHsgUnits_&_years.
				medianhomevalue_&_years.
				GrossRentLT100_&_years. GrossRent100_149_&_years. GrossRent150_199_&_years.  
				GrossRent200_249_&_years. GrossRent250_299_&_years. 
				GrossRent300_349_&_years. GrossRent350_349_&_years. 
				GrossRent400_449_&_years. GrossRent450_499_&_years. 
				GrossRent500_549_&_years. GrossRent550_599_&_years. 
				GrossRent600_649_&_years. GrossRent650_699_&_years. 
				GrossRent700_749_&_years. GrossRent750_799_&_years. 
				GrossRent800_899_&_years. GrossRent900_999_&_years.
				GrossRent1000_1249_&_years. GrossRent1250_1499_&_years.
				GrossRent1500_1999_&_years. GrossRent2000_2499_&_years.
				GrossRent2500_2999_&_years. GrossRent3000_3499_&_years.
				GrossRentGT3500_&_years. GrossRentNoCash_&_years.
				IncmByRenterCst_LT10K_&_years. IncmByRenterCst_10_19K_&_years.
				IncmByRenterCst_20_34K_&_years. IncmByRenterCst_35_49K_&_years.
				IncmByRenterCst_50_74K_&_years. IncmByRenterCst_75_99K_&_years.
				IncmByRenterCst_GT100K_&_years.
				AgeByRenterCst_15_24_&_years. AgeByRenterCst_25_34_&_years.
				AgeByRenterCst_35_64_&_years. AgeByRenterCst_65Over_&_years.
				AgeByOwnerCst_15_24_&_years. AgeByOwnerCst_25_34_&_years.
				AgeByOwnerCst_35_64_&_years. AgeByOwnerCst_65Over_&_years.
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
				NumRentCstBurden_GT100K_&_years. IncmByOwnerCst_LT10K_&_years. 
				IncmByOwnerCst_10_19K_&_years.
				IncmByOwnerCst_20_34K_&_years. IncmByOwnerCst_35_49K_&_years.
				IncmByOwnerCst_50_74K_&_years. IncmByOwnerCst_75_99K_&_years.
				IncmByOwnerCst_100_149_&_years. IncmByOwnerCst_GT150K_&_years.
				NumOwnCstBurden_LT10K_&_years. NumOwnCstBurden_10_19K_&_years. 
				NumOwnCstBurden_20_34K_&_years. NumOwnCstBurden_35_49K_&_years. 
				NumOwnCstBurden_50_74K_&_years. NumOwnCstBurden_75_99K_&_years. 
				NumOwnCstBurden_100_149_&_years. NumOwnCstBurden_GT150K_&_years.
				MedFamIncm_&_years. FamIncomeLT75k_&_years. FamIncomeGT200k_&_years.)


		Acs.Acs_2014_18_dc_sum_bg_&geosuf
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
		
				NumFamilies_&_years.
					)

		RealProp.num_units_&geosuf 
			(keep= &geo units_sf_2000 units_sf_2001 units_sf_2002 
				units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007 
				units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012 
				units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016 units_sf_2017 
				units_sf_2018

				units_condo_2000 units_condo_2001 units_condo_2002
				units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
				units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
				units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016 units_condo_2017
				units_condo_2018)
					
		RealProp.sales_sum_&geosuf 
			(keep= &geo sales_sf_2000 sales_sf_2001
				sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
				sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
				sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
				sales_sf_2014 sales_sf_2015 sales_sf_2016 sales_sf_2017 
				sales_sf_2018

				r_mprice_sf_2000 
				r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
				r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
				r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
				r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016
				r_mprice_sf_2017 r_mprice_sf_2018

				sales_condo_2000 sales_condo_2001
				sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
				sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
				sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
				sales_condo_2014 sales_condo_2015 sales_condo_2016 sales_condo_2017
				sales_condo_2018

				r_mprice_condo_2000
				r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
				r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
				r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
				r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016
				r_mprice_condo_2017 r_mprice_condo_2018

				r_mprice_tot_2000
				r_mprice_tot_2001 r_mprice_tot_2002 r_mprice_tot_2003 r_mprice_tot_2004
				r_mprice_tot_2005 r_mprice_tot_2006 r_mprice_tot_2007 r_mprice_tot_2008
				r_mprice_tot_2009 r_mprice_tot_2010 r_mprice_tot_2011 r_mprice_tot_2012
				r_mprice_tot_2013 r_mprice_tot_2014 r_mprice_tot_2015 r_mprice_tot_2016
				r_mprice_tot_2017 r_mprice_tot_2018	)

		Police.Crimes_sum_&geosuf
			(keep=&geo 
				crimes_pt1_property_2000 crimes_pt1_property_2001 
				crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
				crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
				crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
				crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
				crimes_pt1_property_2014 crimes_pt1_property_2015 crimes_pt1_property_2016 
				crimes_pt1_property_2017 crimes_pt1_property_2018 
				crimes_pt1_violent_2000 crimes_pt1_violent_2001 
				crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
				crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
				crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
				crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
				crimes_pt1_violent_2014 crimes_pt1_violent_2015 crimes_pt1_violent_2016 
				crimes_pt1_violent_2017 crimes_pt1_violent_2018
				crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
				crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
				crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
				crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
				crime_rate_pop_2016 crime_rate_pop_2017 crime_rate_pop_2018)
		
		NCDB.Ncdb_sum_&geosuf
			(keep= &geo totpop_1990 totpop_2000 
				numoccupiedhsgunits_1990 numoccupiedhsgunits_2000)

		NCDB.Ncdb_sum_2010_&geosuf
			(keep= &geo totpop_2010 numoccupiedhsgunits_2010)

		Hmda.Hmda_sum_p09_&geosuf
			(keep= &geo 
				medianmrtginc1_4m_2009 medianmrtginc1_4m_2010 medianmrtginc1_4m_2011
				medianmrtginc1_4m_2012 medianmrtginc1_4m_2013 medianmrtginc1_4m_2014
				medianmrtginc1_4m_2015 medianmrtginc1_4m_2016 medianmrtginc1_4m_2017
				medianmrtginc1_4m_2018
				numconvmrtgorighomepurch_2009 numconvmrtgorighomepurch_2010 numconvmrtgorighomepurch_2011
				numconvmrtgorighomepurch_2012 numconvmrtgorighomepurch_2013 numconvmrtgorighomepurch_2014
				numconvmrtgorighomepurch_2015 numconvmrtgorighomepurch_2016 numconvmrtgorighomepurch_2017
				numconvmrtgorighomepurch_2018
				nummrtgorigwithrace_2009 nummrtgorigwithrace_2010 nummrtgorigwithrace_2011 
				nummrtgorigwithrace_2012 nummrtgorigwithrace_2013 nummrtgorigwithrace_2014
				nummrtgorigwithrace_2015 nummrtgorigwithrace_2016 nummrtgorigwithrace_2017
				nummrtgorigwithrace_2018
				nummrtgorigracenotprovided_2009	nummrtgorigracenotprovided_2010 nummrtgorigracenotprovided_2011
				nummrtgorigracenotprovided_2012 nummrtgorigracenotprovided_2013 nummrtgorigracenotprovided_2014
				nummrtgorigracenotprovided_2015 nummrtgorigracenotprovided_2016 nummrtgorigracenotprovided_2017
				nummrtgorigracenotprovided_2018
				nummrtgorigwhite_2009 nummrtgorigwhite_2010 nummrtgorigwhite_2011
				nummrtgorigwhite_2012 nummrtgorigwhite_2013 nummrtgorigwhite_2014
				nummrtgorigwhite_2015 nummrtgorigwhite_2016 nummrtgorigwhite_2017
				nummrtgorigwhite_2018
				nummrtgorigasianpi_2009 nummrtgorigasianpi_2010 nummrtgorigasianpi_2011 
				nummrtgorigasianpi_2012 nummrtgorigasianpi_2013 nummrtgorigasianpi_2014
				nummrtgorigasianpi_2015 nummrtgorigasianpi_2016 nummrtgorigasianpi_2017 
				nummrtgorigasianpi_2018
				nummrtgorigblack_2009 nummrtgorigblack_2010 nummrtgorigblack_2011 
				nummrtgorigblack_2012 nummrtgorigblack_2013 nummrtgorigblack_2014
				nummrtgorigblack_2015 nummrtgorigblack_2016 nummrtgorigblack_2017
				nummrtgorigblack_2018
				nummrtgorighisp_2009 nummrtgorighisp_2010 nummrtgorighisp_2011
				nummrtgorighisp_2012 nummrtgorighisp_2013 nummrtgorighisp_2014
				nummrtgorighisp_2015 nummrtgorighisp_2016 nummrtgorighisp_2017
				nummrtgorighisp_2018
				nummrtgorigotherx_2009 nummrtgorigotherx_2010 nummrtgorigotherx_2011
				nummrtgorigotherx_2012 nummrtgorigotherx_2013 nummrtgorigotherx_2014
				nummrtgorigotherx_2015 nummrtgorigotherx_2016 nummrtgorigotherx_2017
				nummrtgorigotherx_2018
				)

			Dcra.Permits_sum_&geosuf
				(keep= &geo 
					permits_2009 permits_2010 permits_2011 
					permits_2012 permits_2013 permits_2014
					permits_2015 permits_2016 permits_2017 
					permits_2018
					permits_construction_2009 permits_construction_2010 permits_construction_2011
					permits_construction_2012 permits_construction_2013 permits_construction_2014
					permits_construction_2015 permits_construction_2016 permits_construction_2017
					permits_construction_2018
					permits_homeoccupation_2009 permits_homeoccupation_2010 permits_homeoccupation_2011
					permits_homeoccupation_2012 permits_homeoccupation_2013 permits_homeoccupation_2014
					permits_homeoccupation_2015 permits_homeoccupation_2016 permits_homeoccupation_2017
					permits_homeoccupation_2018 
					permits_supplemental_2009 permits_supplemental_2010 permits_supplemental_2011
					permits_supplemental_2012 permits_supplemental_2013 permits_supplemental_2014
					permits_supplemental_2015 permits_supplemental_2016 permits_supplemental_2017 
					permits_supplemental_2018
					)


			Vital.Births_sum_&geosuf
				(keep= &geo 
					births_total_2003 births_total_2004 births_total_2005 births_total_2006 
					births_total_2007 births_total_2008 births_total_2009 births_total_2010
					births_total_2011 births_total_2012 births_total_2013 births_total_2014
					births_total_2015 births_total_2016 
					births_w_race_2003 births_w_race_2004 births_w_race_2005 births_w_race_2006
					births_w_race_2007 births_w_race_2008 births_w_race_2009 births_w_race_2010 
					births_w_race_2011 births_w_race_2012 births_w_race_2013 births_w_race_2014
					births_w_race_2015 births_w_race_2016
					births_white_2003 births_white_2004 births_white_2005 births_white_2006 
					births_white_2007 births_white_2008 births_white_2009 births_white_2010
					births_white_2011 births_white_2012 births_white_2013 births_white_2014
					births_white_2015 births_white_2016 
					births_oth_rac_2003 births_oth_rac_2004 births_oth_rac_2005 births_oth_rac_2006 
					births_oth_rac_2007 births_oth_rac_2008 births_oth_rac_2009 births_oth_rac_2010
					births_oth_rac_2011 births_oth_rac_2012 births_oth_rac_2013 births_oth_rac_2014
					births_oth_rac_2015 births_oth_rac_2016
					births_asian_2003 births_asian_2004 births_asian_2005 births_asian_2006 
					births_asian_2007 births_asian_2008 births_asian_2009 births_asian_2010
					births_asian_2011 births_asian_2012 births_asian_2013 births_asian_2014
					births_asian_2015 births_asian_2016
					births_black_2003 births_black_2004 births_black_2005 births_black_2006
					births_black_2007 births_black_2008 births_black_2009 births_black_2010
					births_black_2011 births_black_2012 births_black_2013 births_black_2014
					births_black_2015 births_black_2016
					births_hisp_2003 births_hisp_2004 births_hisp_2005 births_hisp_2006
					births_hisp_2007 births_hisp_2008 births_hisp_2009 births_hisp_2010
					births_hisp_2011 births_hisp_2012 births_hisp_2013 births_hisp_2014
					births_hisp_2015 births_hisp_2016
					births_w_prenat_2003 births_w_prenat_2004 births_w_prenat_2005 births_w_prenat_2006
					births_w_prenat_2007 births_w_prenat_2008 births_w_prenat_2009 births_w_prenat_2010
					births_w_prenat_2011 births_w_prenat_2012 births_w_prenat_2013 births_w_prenat_2014 
					births_w_prenat_2015 births_w_prenat_2016
					births_w_prenat_asn_2003 births_w_prenat_asn_2004 births_w_prenat_asn_2005 births_w_prenat_asn_2006
					births_w_prenat_asn_2007 births_w_prenat_asn_2008 births_w_prenat_asn_2009 births_w_prenat_asn_2010
					births_w_prenat_asn_2011 births_w_prenat_asn_2012 births_w_prenat_asn_2013 births_w_prenat_asn_2014
					births_w_prenat_asn_2015 births_w_prenat_asn_2016
					births_w_prenat_blk_2003 births_w_prenat_blk_2004 births_w_prenat_blk_2005 births_w_prenat_blk_2006
					births_w_prenat_blk_2007 births_w_prenat_blk_2008 births_w_prenat_blk_2009 births_w_prenat_blk_2010
					births_w_prenat_blk_2011 births_w_prenat_blk_2012 births_w_prenat_blk_2013 births_w_prenat_blk_2014
					births_w_prenat_blk_2015 births_w_prenat_blk_2016
					births_w_prenat_hsp_2003 births_w_prenat_hsp_2004 births_w_prenat_hsp_2005 births_w_prenat_hsp_2006
					births_w_prenat_hsp_2007 births_w_prenat_hsp_2008 births_w_prenat_hsp_2009 births_w_prenat_hsp_2010
					births_w_prenat_hsp_2011 births_w_prenat_hsp_2012 births_w_prenat_hsp_2013 births_w_prenat_hsp_2014
					births_w_prenat_hsp_2015 births_w_prenat_hsp_2015 births_w_prenat_hsp_2016
					births_w_prenat_oth_2003 births_w_prenat_oth_2004 births_w_prenat_oth_2005 births_w_prenat_oth_2006
					births_w_prenat_oth_2007 births_w_prenat_oth_2008 births_w_prenat_oth_2009 births_w_prenat_oth_2010 
					births_w_prenat_oth_2011 births_w_prenat_oth_2012 births_w_prenat_oth_2013 births_w_prenat_oth_2014
					births_w_prenat_oth_2015 births_w_prenat_oth_2016 
					births_w_prenat_wht_2003 births_w_prenat_wht_2004 births_w_prenat_wht_2005 births_w_prenat_wht_2006
					births_w_prenat_wht_2007 births_w_prenat_wht_2008 births_w_prenat_wht_2009 births_w_prenat_wht_2010 
					births_w_prenat_wht_2011 births_w_prenat_wht_2012 births_w_prenat_wht_2013 births_w_prenat_wht_2014
					births_w_prenat_wht_2015 births_w_prenat_wht_2016
					births_prenat_inad_asn_2003 births_prenat_inad_asn_2004 births_prenat_inad_asn_2005 births_prenat_inad_asn_2006
					births_prenat_inad_asn_2007 births_prenat_inad_asn_2008 births_prenat_inad_asn_2009 births_prenat_inad_asn_2010
					births_prenat_inad_asn_2011 births_prenat_inad_asn_2012 births_prenat_inad_asn_2013 births_prenat_inad_asn_2014
					births_prenat_inad_asn_2015 births_prenat_inad_asn_2016
					births_prenat_inad_blk_2003 births_prenat_inad_blk_2004 births_prenat_inad_blk_2005 births_prenat_inad_blk_2006
					births_prenat_inad_blk_2007 births_prenat_inad_blk_2008 births_prenat_inad_blk_2009 births_prenat_inad_blk_2010
					births_prenat_inad_blk_2011 births_prenat_inad_blk_2012 births_prenat_inad_blk_2013 births_prenat_inad_blk_2014
					births_prenat_inad_blk_2015 births_prenat_inad_blk_2016
					births_prenat_inad_hsp_2003 births_prenat_inad_hsp_2004 births_prenat_inad_hsp_2005 births_prenat_inad_hsp_2006
					births_prenat_inad_hsp_2007 births_prenat_inad_hsp_2008 births_prenat_inad_hsp_2009 births_prenat_inad_hsp_2010
					births_prenat_inad_hsp_2011 births_prenat_inad_hsp_2012 births_prenat_inad_hsp_2013 births_prenat_inad_hsp_2014
					births_prenat_inad_hsp_2015 births_prenat_inad_hsp_2016 
					births_prenat_inad_oth_2003 births_prenat_inad_oth_2004 births_prenat_inad_oth_2005 births_prenat_inad_oth_2006
					births_prenat_inad_oth_2007 births_prenat_inad_oth_2008 births_prenat_inad_oth_2009 births_prenat_inad_oth_2010
					births_prenat_inad_oth_2011 births_prenat_inad_oth_2012 births_prenat_inad_oth_2013 births_prenat_inad_oth_2014
					births_prenat_inad_oth_2015 births_prenat_inad_oth_2016
					births_prenat_inad_wht_2003 births_prenat_inad_wht_2004 births_prenat_inad_wht_2005 births_prenat_inad_wht_2006
					births_prenat_inad_wht_2007 births_prenat_inad_wht_2008 births_prenat_inad_wht_2009 births_prenat_inad_wht_2010
					births_prenat_inad_wht_2011 births_prenat_inad_wht_2012 births_prenat_inad_wht_2013 births_prenat_inad_wht_2014
					births_prenat_inad_wht_2015 births_prenat_inad_wht_2016
					births_prenat_adeq_asn_2003 births_prenat_adeq_asn_2004 births_prenat_adeq_asn_2005 births_prenat_adeq_asn_2006
					births_prenat_adeq_asn_2007 births_prenat_adeq_asn_2008 births_prenat_adeq_asn_2009 births_prenat_adeq_asn_2010
					births_prenat_adeq_asn_2011 births_prenat_adeq_asn_2012 births_prenat_adeq_asn_2013 births_prenat_adeq_asn_2014
					births_prenat_adeq_asn_2015 births_prenat_adeq_asn_2016
					births_prenat_adeq_blk_2003 births_prenat_adeq_blk_2004 births_prenat_adeq_blk_2005 births_prenat_adeq_blk_2006
					births_prenat_adeq_blk_2007 births_prenat_adeq_blk_2008 births_prenat_adeq_blk_2009 births_prenat_adeq_blk_2010
					births_prenat_adeq_blk_2011 births_prenat_adeq_blk_2012 births_prenat_adeq_blk_2013 births_prenat_adeq_blk_2014
					births_prenat_adeq_blk_2015 births_prenat_adeq_blk_2016
					births_prenat_adeq_hsp_2003 births_prenat_adeq_hsp_2004 births_prenat_adeq_hsp_2005 births_prenat_adeq_hsp_2006
					births_prenat_adeq_hsp_2007 births_prenat_adeq_hsp_2008 births_prenat_adeq_hsp_2009 births_prenat_adeq_hsp_2010
					births_prenat_adeq_hsp_2011 births_prenat_adeq_hsp_2012 births_prenat_adeq_hsp_2013 births_prenat_adeq_hsp_2014
					births_prenat_adeq_hsp_2015 births_prenat_adeq_hsp_2016 
					births_prenat_adeq_oth_2003 births_prenat_adeq_oth_2004 births_prenat_adeq_oth_2005 births_prenat_adeq_oth_2006
					births_prenat_adeq_oth_2007 births_prenat_adeq_oth_2008 births_prenat_adeq_oth_2009 births_prenat_adeq_oth_2010
					births_prenat_adeq_oth_2011 births_prenat_adeq_oth_2012 births_prenat_adeq_oth_2013 births_prenat_adeq_oth_2014
					births_prenat_adeq_oth_2015 births_prenat_adeq_oth_2016
					births_prenat_adeq_wht_2003 births_prenat_adeq_wht_2004 births_prenat_adeq_wht_2005 births_prenat_adeq_wht_2006
					births_prenat_adeq_wht_2007 births_prenat_adeq_wht_2008 births_prenat_adeq_wht_2009 births_prenat_adeq_wht_2010
					births_prenat_adeq_wht_2011 births_prenat_adeq_wht_2012 births_prenat_adeq_wht_2013 births_prenat_adeq_wht_2014
					births_prenat_adeq_wht_2015 births_prenat_adeq_wht_2016
					births_prenat_adeq_2003 births_prenat_adeq_2004 births_prenat_adeq_2005 births_prenat_adeq_2006
					births_prenat_adeq_2007 births_prenat_adeq_2008 births_prenat_adeq_2009 births_prenat_adeq_2010
					births_prenat_adeq_2011 births_prenat_adeq_2012 births_prenat_adeq_2013 births_prenat_adeq_2014
					births_prenat_adeq_2015 births_prenat_adeq_2016
					births_prenat_intr_asn_2003 births_prenat_intr_asn_2004 births_prenat_intr_asn_2005 births_prenat_intr_asn_2006
					births_prenat_intr_asn_2007 births_prenat_intr_asn_2008 births_prenat_intr_asn_2009 births_prenat_intr_asn_2010
					births_prenat_intr_asn_2011 births_prenat_intr_asn_2012 births_prenat_intr_asn_2013 births_prenat_intr_asn_2014
					births_prenat_intr_asn_2015 births_prenat_intr_asn_2016
					births_prenat_intr_blk_2003 births_prenat_intr_blk_2004 births_prenat_intr_blk_2005 births_prenat_intr_blk_2006
					births_prenat_intr_blk_2007 births_prenat_intr_blk_2008 births_prenat_intr_blk_2009 births_prenat_intr_blk_2010
					births_prenat_intr_blk_2011 births_prenat_intr_blk_2012 births_prenat_intr_blk_2013 births_prenat_intr_blk_2014
					births_prenat_intr_blk_2015 births_prenat_intr_blk_2016
					births_prenat_intr_hsp_2003 births_prenat_intr_hsp_2004 births_prenat_intr_hsp_2005 births_prenat_intr_hsp_2006
					births_prenat_intr_hsp_2007 births_prenat_intr_hsp_2008 births_prenat_intr_hsp_2009 births_prenat_intr_hsp_2010
					births_prenat_intr_hsp_2011 births_prenat_intr_hsp_2012 births_prenat_intr_hsp_2013 births_prenat_intr_hsp_2014
					births_prenat_intr_hsp_2015 births_prenat_intr_hsp_2016 
					births_prenat_intr_oth_2003 births_prenat_intr_oth_2004 births_prenat_intr_oth_2005 births_prenat_intr_oth_2006
					births_prenat_intr_oth_2007 births_prenat_intr_oth_2008 births_prenat_intr_oth_2009 births_prenat_intr_oth_2010
					births_prenat_intr_oth_2011 births_prenat_intr_oth_2012 births_prenat_intr_oth_2013 births_prenat_intr_oth_2014
					births_prenat_intr_oth_2015 births_prenat_intr_oth_2016
					births_prenat_intr_wht_2003 births_prenat_intr_wht_2004 births_prenat_intr_wht_2005 births_prenat_intr_wht_2006
					births_prenat_intr_wht_2007 births_prenat_intr_wht_2008 births_prenat_intr_wht_2009 births_prenat_intr_wht_2010
					births_prenat_intr_wht_2011 births_prenat_intr_wht_2012 births_prenat_intr_wht_2013 births_prenat_intr_wht_2014
					births_prenat_intr_wht_2015 births_prenat_intr_wht_2016
					births_prenat_intr_2003 births_prenat_intr_2004 births_prenat_intr_2005 births_prenat_intr_2006
					births_prenat_intr_2007 births_prenat_intr_2008 births_prenat_intr_2009 births_prenat_intr_2010 
					births_prenat_intr_2011 births_prenat_intr_2012 births_prenat_intr_2013 births_prenat_intr_2014
					births_prenat_intr_2015 births_prenat_intr_2016
					births_prenat_inad_2003 births_prenat_inad_2004 births_prenat_inad_2005 births_prenat_inad_2006
					births_prenat_inad_2007 births_prenat_inad_2008 births_prenat_inad_2009 births_prenat_inad_2010
					births_prenat_inad_2011 births_prenat_inad_2012 births_prenat_inad_2013 births_prenat_inad_2014
					births_prenat_inad_2015 births_prenat_inad_2016
					births_prenat_1st_asn_2003 births_prenat_1st_asn_2004 births_prenat_1st_asn_2005 births_prenat_1st_asn_2006
					births_prenat_1st_asn_2007 births_prenat_1st_asn_2008 births_prenat_1st_asn_2009 births_prenat_1st_asn_2010
					births_prenat_1st_asn_2011 births_prenat_1st_asn_2012 births_prenat_1st_asn_2013 births_prenat_1st_asn_2014
					births_prenat_1st_asn_2015 births_prenat_1st_asn_2016
					births_prenat_1st_blk_2003 births_prenat_1st_blk_2004 births_prenat_1st_blk_2005 births_prenat_1st_blk_2006
					births_prenat_1st_blk_2007 births_prenat_1st_blk_2008 births_prenat_1st_blk_2009 births_prenat_1st_blk_2010
					births_prenat_1st_blk_2011 births_prenat_1st_blk_2012 births_prenat_1st_blk_2013 births_prenat_1st_blk_2014
					births_prenat_1st_blk_2015 births_prenat_1st_blk_2016
					births_prenat_1st_hsp_2003 births_prenat_1st_hsp_2004 births_prenat_1st_hsp_2005 births_prenat_1st_hsp_2006
					births_prenat_1st_hsp_2007 births_prenat_1st_hsp_2008 births_prenat_1st_hsp_2009 births_prenat_1st_hsp_2010
					births_prenat_1st_hsp_2011 births_prenat_1st_hsp_2012 births_prenat_1st_hsp_2013 births_prenat_1st_hsp_2014
					births_prenat_1st_hsp_2015 births_prenat_1st_hsp_2016 
					births_prenat_1st_oth_2003 births_prenat_1st_oth_2004 births_prenat_1st_oth_2005 births_prenat_1st_oth_2006
					births_prenat_1st_oth_2007 births_prenat_1st_oth_2008 births_prenat_1st_oth_2009 births_prenat_1st_oth_2010
					births_prenat_1st_oth_2011 births_prenat_1st_oth_2012 births_prenat_1st_oth_2013 births_prenat_1st_oth_2014
					births_prenat_1st_oth_2015 births_prenat_1st_oth_2016
					births_prenat_1st_wht_2003 births_prenat_1st_wht_2004 births_prenat_1st_wht_2005 births_prenat_1st_wht_2006
					births_prenat_1st_wht_2007 births_prenat_1st_wht_2008 births_prenat_1st_wht_2009 births_prenat_1st_wht_2010
					births_prenat_1st_wht_2011 births_prenat_1st_wht_2012 births_prenat_1st_wht_2013 births_prenat_1st_wht_2014
					births_prenat_1st_wht_2015 births_prenat_1st_wht_2016
					births_prenat_1st_2003 births_prenat_1st_2004 births_prenat_1st_2005 births_prenat_1st_2006
					births_prenat_1st_2007 births_prenat_1st_2008 births_prenat_1st_2009 births_prenat_1st_2010
					births_prenat_1st_2011 births_prenat_1st_2012 births_prenat_1st_2013 births_prenat_1st_2014
					births_prenat_1st_2015 births_prenat_1st_2016
					)

			; 

		by &geo;

		%dollar_convert( medianmrtginc1_4m_2009, r_medianmrtginc1_4m_2009, 2009, 2018 )
		%dollar_convert( medianmrtginc1_4m_2010, r_medianmrtginc1_4m_2010, 2010, 2018 )
		%dollar_convert( medianmrtginc1_4m_2011, r_medianmrtginc1_4m_2011, 2011, 2018 )
		%dollar_convert( medianmrtginc1_4m_2012, r_medianmrtginc1_4m_2012, 2012, 2018 )
		%dollar_convert( medianmrtginc1_4m_2013, r_medianmrtginc1_4m_2013, 2013, 2018 )
		%dollar_convert( medianmrtginc1_4m_2014, r_medianmrtginc1_4m_2014, 2014, 2018 )
		%dollar_convert( medianmrtginc1_4m_2015, r_medianmrtginc1_4m_2015, 2015, 2018 )
		%dollar_convert( medianmrtginc1_4m_2016, r_medianmrtginc1_4m_2016, 2016, 2018 )
		%dollar_convert( medianmrtginc1_4m_2017, r_medianmrtginc1_4m_2017, 2017, 2018 )
		%dollar_convert( medianmrtginc1_4m_2018, r_medianmrtginc1_4m_2018, 2018, 2018 )


		/*Labor force, employment, and poverty*/
			PctLaborForce_&_years. = popincivlaborforce_&_years. / pop16andoveryears_&_years.;
			PctPopEmployed_&_years. = popcivilianemployed_&_years. / popincivlaborforce_&_years.;
			PctPopUnemployed_&_years. = popunemployed_&_years. / popincivlaborforce_&_years.;
			PctPoorPersons_&_years. = poppoorpersons_&_years. / personspovertydefined_&_years.;
			PctPoorChildren_&_years. = poppoorchildren_&_years. / childrenpovertydefined_&_years.;

		/*Employment by major occupations*/
			PctEmpMngmt_&_years. = popemployedmngmt_&_years. / popemployedbyocc_&_years.;
			PctEmpNatRes_&_years. = popemployednatres_&_years. / popemployedbyocc_&_years.;
			PctEmpProd_&_years. = popemployedprod_&_years. / popemployedbyocc_&_years.;
			PctEmpSales_&_years. = popemployedsales_&_years. / popemployedbyocc_&_years.;
			PctEmpServ_&_years. = popemployedserv_&_years. / popemployedbyocc_&_years.;

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
			PctOwnerOccupiedHU_&_years. = numowneroccupiedhu_&_years. / numoccupiedhsgunits_&_years.;
			PctRenterOccupiedHU_&_years. = numrenteroccupiedhu_&_years. / numoccupiedhsgunits_&_years.;
			PctRenterCostBurden_&_years. = NumRenterCostBurden_&_years./RentCostBurdenDenom_&_years.;
			PctRentSevereCostBurden_&_years. = NumRentSevereCostBurden_&_years./RentCostBurdenDenom_&_years.;
			PctOwnerCostBurden_&_years. = NumOwnerCostBurden_&_years./OwnerCostBurdenDenom_&_years.;
			PctOwnSevereCostBurden_&_years. = NumOwnSevereCostBurden_&_years./OwnerCostBurdenDenom_&_years.;

			PctRentCstBurden_15_24_&_years. = NumRentCstBurden_15_24_&_years. / AgeByRenterCst_15_24_&_years.;
			PctRentCstBurden_25_34_&_years. = NumRentCstBurden_25_34_&_years. / AgeByRenterCst_25_34_&_years.;
			PctRentCstBurden_35_64_&_years. = NumRentCstBurden_35_64_&_years. / AgeByRenterCst_35_64_&_years.;
			PctRentCstBurden_65Over_&_years. = NumRentCstBurden_65Over_&_years. / AgeByRenterCst_65Over_&_years.;

			PctOwnCstBurden_15_24_&_years. = NumOwnCstBurden_15_24_&_years. / AgeByOwnerCst_15_24_&_years.;
			PctOwnCstBurden_25_34_&_years. = NumOwnCstBurden_25_34_&_years. / AgeByOwnerCst_25_34_&_years.;
			PctOwnCstBurden_35_64_&_years. = NumOwnCstBurden_35_64_&_years. / AgeByOwnerCst_35_64_&_years.;
			PctOwnCstBurden_65Over_&_years. = NumOwnCstBurden_65Over_&_years. / AgeByOwnerCst_65Over_&_years.;

			PctRentCstBurden_LT10K_&_years. = NumRentCstBurden_LT10K_&_years. / IncmByRenterCst_LT10K_&_years.;
			PctRentCstBurden_10_19K_&_years. = NumRentCstBurden_10_19K_&_years. / IncmByRenterCst_10_19K_&_years.;
			PctRentCstBurden_20_34K_&_years. = NumRentCstBurden_20_34K_&_years. / IncmByRenterCst_20_34K_&_years.;
			PctRentCstBurden_35_49K_&_years. = NumRentCstBurden_35_49K_&_years. / IncmByRenterCst_35_49K_&_years.;
			PctRentCstBurden_50_74K_&_years. = NumRentCstBurden_50_74K_&_years. / IncmByRenterCst_50_74K_&_years.;
			PctRentCstBurden_75_99K_&_years. = NumRentCstBurden_75_99K_&_years. / IncmByRenterCst_75_99K_&_years.;
			PctRentCstBurden_GT100K_&_years. = NumRentCstBurden_GT100K_&_years. / IncmByRenterCst_GT100K_&_years.;

			PctOwnCstBurden_LT10K_&_years. = NumOwnCstBurden_LT10K_&_years. / IncmByOwnerCst_LT10K_&_years.;
			PctOwnCstBurden_10_19K_&_years. = NumOwnCstBurden_10_19K_&_years. / IncmByOwnerCst_10_19K_&_years.;
			PctOwnCstBurden_20_34K_&_years. = NumOwnCstBurden_20_34K_&_years. / IncmByOwnerCst_20_34K_&_years.;
			PctOwnCstBurden_35_49K_&_years. = NumOwnCstBurden_35_49K_&_years. / IncmByOwnerCst_35_49K_&_years.;
			PctOwnCstBurden_50_74K_&_years. = NumOwnCstBurden_50_74K_&_years. / IncmByOwnerCst_50_74K_&_years.;
			PctOwnCstBurden_75_99K_&_years. = NumOwnCstBurden_75_99K_&_years. / IncmByOwnerCst_75_99K_&_years;
			PctOwnCstBurden_100_149_&_years. = NumOwnCstBurden_100_149_&_years. / IncmByOwnerCst_100_149_&_years.;
			PctOwnCstBurden_GT150K_&_years. = NumOwnCstBurden_GT150K_&_years. / IncmByOwnerCst_GT150K_&_years.;

		/*Education*/
			PctHS_&_years. = pop25andoverwhs_&_years. / pop25andoveryears_&_years.;
			PctCol_&_years. = pop25andoverwcollege_&_years. / pop25andoveryears_&_years.;
			PctWoutHS_&_years. = Pop25andOverWoutHS_&_years. / pop25andoveryears_&_years.;

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
			property_crime_rate_2017 = crimes_pt1_property_2017 / crime_rate_pop_2017;
			property_crime_rate_2018 = crimes_pt1_property_2018 / crime_rate_pop_2018;

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
			violent_crime_rate_2017 = crimes_pt1_violent_2017 / crime_rate_pop_2017;
			violent_crime_rate_2018 = crimes_pt1_violent_2018 / crime_rate_pop_2018;
		
		/*HMDA*/
			PctMrtgorigWht_2009 = nummrtgorigwhite_2009/nummrtgorigwithrace_2009;
			PctMrtgorigWht_2010 = nummrtgorigwhite_2010/nummrtgorigwithrace_2010;
			PctMrtgorigWht_2011 = nummrtgorigwhite_2011/nummrtgorigwithrace_2011;
			PctMrtgorigWht_2012 = nummrtgorigwhite_2012/nummrtgorigwithrace_2012;
			PctMrtgorigWht_2013 = nummrtgorigwhite_2013/nummrtgorigwithrace_2013;				
			PctMrtgorigWht_2014 = nummrtgorigwhite_2014/nummrtgorigwithrace_2014;
			PctMrtgorigWht_2015 = nummrtgorigwhite_2015/nummrtgorigwithrace_2015;
			PctMrtgorigWht_2016 = nummrtgorigwhite_2016/nummrtgorigwithrace_2016;
			PctMrtgorigWht_2017 = nummrtgorigwhite_2017/nummrtgorigwithrace_2017;
			PctMrtgorigWht_2018 = nummrtgorigwhite_2018/nummrtgorigwithrace_2018;

			PctMrtgorigBlk_2009 = nummrtgorigblack_2009/nummrtgorigwithrace_2009;
			PctMrtgorigBlk_2010 = nummrtgorigblack_2010/nummrtgorigwithrace_2010;
			PctMrtgorigBlk_2011 = nummrtgorigblack_2011/nummrtgorigwithrace_2011;
			PctMrtgorigBlk_2012 = nummrtgorigblack_2012/nummrtgorigwithrace_2012;
			PctMrtgorigBlk_2013 = nummrtgorigblack_2013/nummrtgorigwithrace_2013;
			PctMrtgorigBlk_2014 = nummrtgorigblack_2014/nummrtgorigwithrace_2014;
			PctMrtgorigBlk_2015 = nummrtgorigblack_2015/nummrtgorigwithrace_2015;
			PctMrtgorigBlk_2016 = nummrtgorigblack_2016/nummrtgorigwithrace_2016;
			PctMrtgorigBlk_2017 = nummrtgorigblack_2017/nummrtgorigwithrace_2017;
			PctMrtgorigBlk_2018 = nummrtgorigblack_2018/nummrtgorigwithrace_2018;
				
			PctMrtgorigAsn_2009 = nummrtgorigasianpi_2009/nummrtgorigwithrace_2009;
			PctMrtgorigAsn_2010 = nummrtgorigasianpi_2010/nummrtgorigwithrace_2010;
			PctMrtgorigAsn_2011 = nummrtgorigasianpi_2011/nummrtgorigwithrace_2011;
			PctMrtgorigAsn_2012 = nummrtgorigasianpi_2012/nummrtgorigwithrace_2012;
			PctMrtgorigAsn_2013 = nummrtgorigasianpi_2013/nummrtgorigwithrace_2013;
			PctMrtgorigAsn_2014 = nummrtgorigasianpi_2014/nummrtgorigwithrace_2014;
			PctMrtgorigAsn_2015 = nummrtgorigasianpi_2015/nummrtgorigwithrace_2015;
			PctMrtgorigAsn_2016 = nummrtgorigasianpi_2016/nummrtgorigwithrace_2016;
			PctMrtgorigAsn_2017 = nummrtgorigasianpi_2017/nummrtgorigwithrace_2017;
			PctMrtgorigAsn_2018 = nummrtgorigasianpi_2018/nummrtgorigwithrace_2018;
				
			PctMrtgorigHisp_2009 = nummrtgorighisp_2009/nummrtgorigwithrace_2009;
			PctMrtgorigHisp_2010 = nummrtgorighisp_2010/nummrtgorigwithrace_2010;
			PctMrtgorigHisp_2011 = nummrtgorighisp_2011/nummrtgorigwithrace_2011;
			PctMrtgorigHisp_2012 = nummrtgorighisp_2012/nummrtgorigwithrace_2012;
			PctMrtgorigHisp_2013 = nummrtgorighisp_2013/nummrtgorigwithrace_2013;
			PctMrtgorigHisp_2014 = nummrtgorighisp_2014/nummrtgorigwithrace_2014;
			PctMrtgorigHisp_2015 = nummrtgorighisp_2015/nummrtgorigwithrace_2015;
			PctMrtgorigHisp_2016 = nummrtgorighisp_2016/nummrtgorigwithrace_2016;
			PctMrtgorigHisp_2017 = nummrtgorighisp_2017/nummrtgorigwithrace_2017;
			PctMrtgorigHisp_2018 = nummrtgorighisp_2018/nummrtgorigwithrace_2018;
				
			PctMrtgorigOth_2009 = nummrtgorigotherx_2009/nummrtgorigwithrace_2009;
			PctMrtgorigOth_2010 = nummrtgorigotherx_2010/nummrtgorigwithrace_2010;
			PctMrtgorigOth_2011 = nummrtgorigotherx_2011/nummrtgorigwithrace_2011;
			PctMrtgorigOth_2012 = nummrtgorigotherx_2012/nummrtgorigwithrace_2012;
			PctMrtgorigOth_2013 = nummrtgorigotherx_2013/nummrtgorigwithrace_2013;
			PctMrtgorigOth_2014 = nummrtgorigotherx_2014/nummrtgorigwithrace_2014;
			PctMrtgorigOth_2015 = nummrtgorigotherx_2015/nummrtgorigwithrace_2015;
			PctMrtgorigOth_2016 = nummrtgorigotherx_2016/nummrtgorigwithrace_2016;
			PctMrtgorigOth_2017 = nummrtgorigotherx_2017/nummrtgorigwithrace_2017;
			PctMrtgorigOth_2018 = nummrtgorigotherx_2018/nummrtgorigwithrace_2018;
				
			/*Births*/
			
			PctBirthsPrenatInad_2003 = births_prenat_inad_2003/births_w_prenat_2003; 
			PctBirthsPrenatInad_2004 = births_prenat_inad_2004/births_w_prenat_2004; 
			PctBirthsPrenatInad_2005 = births_prenat_inad_2005/births_w_prenat_2005; 
			PctBirthsPrenatInad_2006 = births_prenat_inad_2006/births_w_prenat_2006; 
			PctBirthsPrenatInad_2007 = births_prenat_inad_2007/births_w_prenat_2007; 
			PctBirthsPrenatInad_2008 = births_prenat_inad_2008/births_w_prenat_2008; 
			PctBirthsPrenatInad_2009 = births_prenat_inad_2009/births_w_prenat_2009; 
			PctBirthsPrenatInad_2010 = births_prenat_inad_2010/births_w_prenat_2010; 
			PctBirthsPrenatInad_2011 = births_prenat_inad_2011/births_w_prenat_2011; 
			PctBirthsPrenatInad_2012 = births_prenat_inad_2012/births_w_prenat_2012; 
			PctBirthsPrenatInad_2013 = births_prenat_inad_2013/births_w_prenat_2013; 
			PctBirthsPrenatInad_2014 = births_prenat_inad_2014/births_w_prenat_2014; 
			PctBirthsPrenatInad_2015 = births_prenat_inad_2015/births_w_prenat_2015; 
			PctBirthsPrenatInad_2016 = births_prenat_inad_2016/births_w_prenat_2016; 

			PctBirthsPrenatAdeq_2003 = births_prenat_adeq_2003/births_w_prenat_2003; 
			PctBirthsPrenatAdeq_2004 = births_prenat_adeq_2004/births_w_prenat_2004; 
			PctBirthsPrenatAdeq_2005 = births_prenat_adeq_2005/births_w_prenat_2005; 
			PctBirthsPrenatAdeq_2006 = births_prenat_adeq_2006/births_w_prenat_2006; 
			PctBirthsPrenatAdeq_2007 = births_prenat_adeq_2007/births_w_prenat_2007; 
			PctBirthsPrenatAdeq_2008 = births_prenat_adeq_2008/births_w_prenat_2008; 
			PctBirthsPrenatAdeq_2009 = births_prenat_adeq_2009/births_w_prenat_2009; 
			PctBirthsPrenatAdeq_2010 = births_prenat_adeq_2010/births_w_prenat_2010; 
			PctBirthsPrenatAdeq_2011 = births_prenat_adeq_2011/births_w_prenat_2011; 
			PctBirthsPrenatAdeq_2012 = births_prenat_adeq_2012/births_w_prenat_2012; 
			PctBirthsPrenatAdeq_2013 = births_prenat_adeq_2013/births_w_prenat_2013; 
			PctBirthsPrenatAdeq_2014 = births_prenat_adeq_2014/births_w_prenat_2014; 
			PctBirthsPrenatAdeq_2015 = births_prenat_adeq_2015/births_w_prenat_2015; 
			PctBirthsPrenatAdeq_2016 = births_prenat_adeq_2016/births_w_prenat_2016;

			PctBirthsPrenatIntr_2003 = births_prenat_intr_2003/births_w_prenat_2003; 
			PctBirthsPrenatIntr_2004 = births_prenat_intr_2004/births_w_prenat_2004; 
			PctBirthsPrenatIntr_2005 = births_prenat_intr_2005/births_w_prenat_2005; 
			PctBirthsPrenatIntr_2006 = births_prenat_intr_2006/births_w_prenat_2006; 
			PctBirthsPrenatIntr_2007 = births_prenat_intr_2007/births_w_prenat_2007; 
			PctBirthsPrenatIntr_2008 = births_prenat_intr_2008/births_w_prenat_2008; 
			PctBirthsPrenatIntr_2009 = births_prenat_intr_2009/births_w_prenat_2009; 
			PctBirthsPrenatIntr_2010 = births_prenat_intr_2010/births_w_prenat_2010; 
			PctBirthsPrenatIntr_2011 = births_prenat_intr_2011/births_w_prenat_2011; 
			PctBirthsPrenatIntr_2012 = births_prenat_intr_2012/births_w_prenat_2012; 
			PctBirthsPrenatIntr_2013 = births_prenat_intr_2013/births_w_prenat_2013; 
			PctBirthsPrenatIntr_2014 = births_prenat_intr_2014/births_w_prenat_2014; 
			PctBirthsPrenatIntr_2015 = births_prenat_intr_2015/births_w_prenat_2015; 
			PctBirthsPrenatIntr_2016 = births_prenat_intr_2016/births_w_prenat_2016;

			PctBirthsPrenat1st_2003 = births_prenat_1st_2003/births_w_prenat_2003; 
			PctBirthsPrenat1st_2004 = births_prenat_1st_2004/births_w_prenat_2004; 
			PctBirthsPrenat1st_2005 = births_prenat_1st_2005/births_w_prenat_2005; 
			PctBirthsPrenat1st_2006 = births_prenat_1st_2006/births_w_prenat_2006; 
			PctBirthsPrenat1st_2007 = births_prenat_1st_2007/births_w_prenat_2007; 
			PctBirthsPrenat1st_2008 = births_prenat_1st_2008/births_w_prenat_2008; 
			PctBirthsPrenat1st_2009 = births_prenat_1st_2009/births_w_prenat_2009; 
			PctBirthsPrenat1st_2010 = births_prenat_1st_2010/births_w_prenat_2010; 
			PctBirthsPrenat1st_2011 = births_prenat_1st_2011/births_w_prenat_2011; 
			PctBirthsPrenat1st_2012 = births_prenat_1st_2012/births_w_prenat_2012; 
			PctBirthsPrenat1st_2013 = births_prenat_1st_2013/births_w_prenat_2013; 
			PctBirthsPrenat1st_2014 = births_prenat_1st_2014/births_w_prenat_2014; 
			PctBirthsPrenat1st_2015 = births_prenat_1st_2015/births_w_prenat_2015; 
			PctBirthsPrenat1st_2016 = births_prenat_1st_2016/births_w_prenat_2016;

			PctBirthsWht_2003 = births_white_2003/births_w_race_2003;
			PctBirthsWht_2004 = births_white_2004/births_w_race_2004;
			PctBirthsWht_2005 = births_white_2005/births_w_race_2005;
			PctBirthsWht_2006 = births_white_2006/births_w_race_2006;
			PctBirthsWht_2007 = births_white_2007/births_w_race_2007;
			PctBirthsWht_2008 = births_white_2008/births_w_race_2008;
			PctBirthsWht_2009 = births_white_2009/births_w_race_2009;
			PctBirthsWht_2010 = births_white_2010/births_w_race_2010;
			PctBirthsWht_2011 = births_white_2011/births_w_race_2011;
			PctBirthsWht_2012 = births_white_2012/births_w_race_2012;
			PctBirthsWht_2013 = births_white_2013/births_w_race_2013;
			PctBirthsWht_2014 = births_white_2014/births_w_race_2014;
			PctBirthsWht_2015 = births_white_2015/births_w_race_2015;
			PctBirthsWht_2016 = births_white_2016/births_w_race_2016;

			PctBirthsAsn_2003 = births_asian_2003/births_w_race_2003;
			PctBirthsAsn_2004 = births_asian_2004/births_w_race_2004;
			PctBirthsAsn_2005 = births_asian_2005/births_w_race_2005;
			PctBirthsAsn_2006 = births_asian_2006/births_w_race_2006;
			PctBirthsAsn_2007 = births_asian_2007/births_w_race_2007;
			PctBirthsAsn_2008 = births_asian_2008/births_w_race_2008;
			PctBirthsAsn_2009 = births_asian_2009/births_w_race_2009;
			PctBirthsAsn_2010 = births_asian_2010/births_w_race_2010;
			PctBirthsAsn_2011 = births_asian_2011/births_w_race_2011;
			PctBirthsAsn_2012 = births_asian_2012/births_w_race_2012;
			PctBirthsAsn_2013 = births_asian_2013/births_w_race_2013;
			PctBirthsAsn_2014 = births_asian_2014/births_w_race_2014;
			PctBirthsAsn_2015 = births_asian_2015/births_w_race_2015;
			PctBirthsAsn_2016 = births_asian_2016/births_w_race_2016;

 			PctBirthsBlk_2003 = births_black_2003/births_w_race_2003;
			PctBirthsBlk_2004 = births_black_2004/births_w_race_2004;
			PctBirthsBlk_2005 = births_black_2005/births_w_race_2005;
			PctBirthsBlk_2006 = births_black_2006/births_w_race_2006;
			PctBirthsBlk_2007 = births_black_2007/births_w_race_2007;
			PctBirthsBlk_2008 = births_black_2008/births_w_race_2008;
			PctBirthsBlk_2009 = births_black_2009/births_w_race_2009;
			PctBirthsBlk_2010 = births_black_2010/births_w_race_2010;
			PctBirthsBlk_2011 = births_black_2011/births_w_race_2011;
			PctBirthsBlk_2012 = births_black_2012/births_w_race_2012;
			PctBirthsBlk_2013 = births_black_2013/births_w_race_2013;
			PctBirthsBlk_2014 = births_black_2014/births_w_race_2014;
			PctBirthsBlk_2015 = births_black_2015/births_w_race_2015;
			PctBirthsBlk_2016 = births_black_2016/births_w_race_2016;
				
 			PctBirthsHisp_2003 = births_hisp_2003/births_w_race_2003;
			PctBirthsHisp_2004 = births_hisp_2004/births_w_race_2004;
			PctBirthsHisp_2005 = births_hisp_2005/births_w_race_2005;
			PctBirthsHisp_2006 = births_hisp_2006/births_w_race_2006;
			PctBirthsHisp_2007 = births_hisp_2007/births_w_race_2007;
			PctBirthsHisp_2008 = births_hisp_2008/births_w_race_2008;
			PctBirthsHisp_2009 = births_hisp_2009/births_w_race_2009;
			PctBirthsHisp_2010 = births_hisp_2010/births_w_race_2010;
			PctBirthsHisp_2011 = births_hisp_2011/births_w_race_2011;
			PctBirthsHisp_2012 = births_hisp_2012/births_w_race_2012;
			PctBirthsHisp_2013 = births_hisp_2013/births_w_race_2013;
			PctBirthsHisp_2014 = births_hisp_2014/births_w_race_2014;
			PctBirthsHisp_2015 = births_hisp_2015/births_w_race_2015;
			PctBirthsHisp_2016 = births_hisp_2016/births_w_race_2016;

			PctBirthsOth_2003 = births_oth_rac_2003/births_w_race_2003;
			PctBirthsOth_2004 = births_oth_rac_2004/births_w_race_2004;
			PctBirthsOth_2005 = births_oth_rac_2005/births_w_race_2005;
			PctBirthsOth_2006 = births_oth_rac_2006/births_w_race_2006;
			PctBirthsOth_2007 = births_oth_rac_2007/births_w_race_2007;
			PctBirthsOth_2008 = births_oth_rac_2008/births_w_race_2008;
			PctBirthsOth_2009 = births_oth_rac_2009/births_w_race_2009;
			PctBirthsOth_2010 = births_oth_rac_2010/births_w_race_2010;
			PctBirthsOth_2011 = births_oth_rac_2011/births_w_race_2011;
			PctBirthsOth_2012 = births_oth_rac_2012/births_w_race_2012;
			PctBirthsOth_2013 = births_oth_rac_2013/births_w_race_2013;
			PctBirthsOth_2014 = births_oth_rac_2014/births_w_race_2014;
			PctBirthsOth_2015 = births_oth_rac_2015/births_w_race_2015;
			PctBirthsOth_2016 = births_oth_rac_2016/births_w_race_2016;
							
			PctBirthsPrenatInadWht_2003 = births_prenat_inad_wht_2003/births_w_prenat_wht_2003;
			PctBirthsPrenatInadWht_2004 = births_prenat_inad_wht_2004/births_w_prenat_wht_2004;
			PctBirthsPrenatInadWht_2005 = births_prenat_inad_wht_2005/births_w_prenat_wht_2005;
			PctBirthsPrenatInadWht_2006 = births_prenat_inad_wht_2006/births_w_prenat_wht_2006;
			PctBirthsPrenatInadWht_2007 = births_prenat_inad_wht_2007/births_w_prenat_wht_2007;
			PctBirthsPrenatInadWht_2008 = births_prenat_inad_wht_2008/births_w_prenat_wht_2008;
			PctBirthsPrenatInadWht_2009 = births_prenat_inad_wht_2009/births_w_prenat_wht_2009;
			PctBirthsPrenatInadWht_2010 = births_prenat_inad_wht_2010/births_w_prenat_wht_2010;
			PctBirthsPrenatInadWht_2011 = births_prenat_inad_wht_2011/births_w_prenat_wht_2011;
			PctBirthsPrenatInadWht_2012 = births_prenat_inad_wht_2012/births_w_prenat_wht_2012;
			PctBirthsPrenatInadWht_2013 = births_prenat_inad_wht_2013/births_w_prenat_wht_2013;
			PctBirthsPrenatInadWht_2014 = births_prenat_inad_wht_2014/births_w_prenat_wht_2014;
			PctBirthsPrenatInadWht_2015 = births_prenat_inad_wht_2015/births_w_prenat_wht_2015;
			PctBirthsPrenatInadWht_2016 = births_prenat_inad_wht_2016/births_w_prenat_wht_2016;

			PctBirthsPrenatInadAsn_2003 = births_prenat_inad_asn_2003/births_w_prenat_asn_2003;
			PctBirthsPrenatInadAsn_2004 = births_prenat_inad_asn_2004/births_w_prenat_asn_2004;
			PctBirthsPrenatInadAsn_2005 = births_prenat_inad_asn_2005/births_w_prenat_asn_2005;
			PctBirthsPrenatInadAsn_2006 = births_prenat_inad_asn_2006/births_w_prenat_asn_2006;
			PctBirthsPrenatInadAsn_2007 = births_prenat_inad_asn_2007/births_w_prenat_asn_2007;
			PctBirthsPrenatInadAsn_2008 = births_prenat_inad_asn_2008/births_w_prenat_asn_2008;
			PctBirthsPrenatInadAsn_2009 = births_prenat_inad_asn_2009/births_w_prenat_asn_2009;
			PctBirthsPrenatInadAsn_2010 = births_prenat_inad_asn_2010/births_w_prenat_asn_2010;
			PctBirthsPrenatInadAsn_2011 = births_prenat_inad_asn_2011/births_w_prenat_asn_2011;
			PctBirthsPrenatInadAsn_2012 = births_prenat_inad_asn_2012/births_w_prenat_asn_2012;
			PctBirthsPrenatInadAsn_2013 = births_prenat_inad_asn_2013/births_w_prenat_asn_2013;
			PctBirthsPrenatInadAsn_2014 = births_prenat_inad_asn_2014/births_w_prenat_asn_2014;
			PctBirthsPrenatInadAsn_2015 = births_prenat_inad_asn_2015/births_w_prenat_asn_2015;
			PctBirthsPrenatInadAsn_2016 = births_prenat_inad_asn_2016/births_w_prenat_asn_2016;

			PctBirthsPrenatInadBlk_2003 = births_prenat_inad_blk_2003/births_w_prenat_blk_2003;
			PctBirthsPrenatInadBlk_2004 = births_prenat_inad_blk_2004/births_w_prenat_blk_2004;
			PctBirthsPrenatInadBlk_2005 = births_prenat_inad_blk_2005/births_w_prenat_blk_2005;
			PctBirthsPrenatInadBlk_2006 = births_prenat_inad_blk_2006/births_w_prenat_blk_2006;
			PctBirthsPrenatInadBlk_2007 = births_prenat_inad_blk_2007/births_w_prenat_blk_2007;
			PctBirthsPrenatInadBlk_2008 = births_prenat_inad_blk_2008/births_w_prenat_blk_2008;
			PctBirthsPrenatInadBlk_2009 = births_prenat_inad_blk_2009/births_w_prenat_blk_2009;
			PctBirthsPrenatInadBlk_2010 = births_prenat_inad_blk_2010/births_w_prenat_blk_2010;
			PctBirthsPrenatInadBlk_2011 = births_prenat_inad_blk_2011/births_w_prenat_blk_2011;
			PctBirthsPrenatInadBlk_2012 = births_prenat_inad_blk_2012/births_w_prenat_blk_2012;
			PctBirthsPrenatInadBlk_2013 = births_prenat_inad_blk_2013/births_w_prenat_blk_2013;
			PctBirthsPrenatInadBlk_2014 = births_prenat_inad_blk_2014/births_w_prenat_blk_2014;
			PctBirthsPrenatInadBlk_2015 = births_prenat_inad_blk_2015/births_w_prenat_blk_2015;
			PctBirthsPrenatInadBlk_2016 = births_prenat_inad_blk_2016/births_w_prenat_blk_2016;

			PctBirthsPrenatInadHisp_2003 = births_prenat_inad_hsp_2003/births_w_prenat_hsp_2003;
			PctBirthsPrenatInadHisp_2004 = births_prenat_inad_hsp_2004/births_w_prenat_hsp_2004;
			PctBirthsPrenatInadHisp_2005 = births_prenat_inad_hsp_2005/births_w_prenat_hsp_2005;
			PctBirthsPrenatInadHisp_2006 = births_prenat_inad_hsp_2006/births_w_prenat_hsp_2006;
			PctBirthsPrenatInadHisp_2007 = births_prenat_inad_hsp_2007/births_w_prenat_hsp_2007;
			PctBirthsPrenatInadHisp_2008 = births_prenat_inad_hsp_2008/births_w_prenat_hsp_2008;
			PctBirthsPrenatInadHisp_2009 = births_prenat_inad_hsp_2009/births_w_prenat_hsp_2009;
			PctBirthsPrenatInadHisp_2010 = births_prenat_inad_hsp_2010/births_w_prenat_hsp_2010;
			PctBirthsPrenatInadHisp_2011 = births_prenat_inad_hsp_2011/births_w_prenat_hsp_2011;
			PctBirthsPrenatInadHisp_2012 = births_prenat_inad_hsp_2012/births_w_prenat_hsp_2012;
			PctBirthsPrenatInadHisp_2013 = births_prenat_inad_hsp_2013/births_w_prenat_hsp_2013;
			PctBirthsPrenatInadHisp_2014 = births_prenat_inad_hsp_2014/births_w_prenat_hsp_2014;
			PctBirthsPrenatInadHisp_2015 = births_prenat_inad_hsp_2015/births_w_prenat_hsp_2015;
			PctBirthsPrenatInadHisp_2016 = births_prenat_inad_hsp_2016/births_w_prenat_hsp_2016;

			PctBirthsPrenatInadOth_2003 = births_prenat_inad_oth_2003/births_w_prenat_oth_2003;
			PctBirthsPrenatInadOth_2004 = births_prenat_inad_oth_2004/births_w_prenat_oth_2004;
			PctBirthsPrenatInadOth_2005 = births_prenat_inad_oth_2005/births_w_prenat_oth_2005;
			PctBirthsPrenatInadOth_2006 = births_prenat_inad_oth_2006/births_w_prenat_oth_2006;
			PctBirthsPrenatInadOth_2007 = births_prenat_inad_oth_2007/births_w_prenat_oth_2007;
			PctBirthsPrenatInadOth_2008 = births_prenat_inad_oth_2008/births_w_prenat_oth_2008;
			PctBirthsPrenatInadOth_2009 = births_prenat_inad_oth_2009/births_w_prenat_oth_2009;
			PctBirthsPrenatInadOth_2010 = births_prenat_inad_oth_2010/births_w_prenat_oth_2010;
			PctBirthsPrenatInadOth_2011 = births_prenat_inad_oth_2011/births_w_prenat_oth_2011;
			PctBirthsPrenatInadOth_2012 = births_prenat_inad_oth_2012/births_w_prenat_oth_2012;
			PctBirthsPrenatInadOth_2013 = births_prenat_inad_oth_2013/births_w_prenat_oth_2013;
			PctBirthsPrenatInadOth_2014 = births_prenat_inad_oth_2014/births_w_prenat_oth_2014;
			PctBirthsPrenatInadOth_2015 = births_prenat_inad_oth_2015/births_w_prenat_oth_2015;
			PctBirthsPrenatInadOth_2016 = births_prenat_inad_oth_2016/births_w_prenat_oth_2016;

			PctBirthsPrenatAdeqWht_2003 = births_prenat_adeq_wht_2003/births_w_prenat_wht_2003;
			PctBirthsPrenatAdeqWht_2004 = births_prenat_adeq_wht_2004/births_w_prenat_wht_2004;
			PctBirthsPrenatAdeqWht_2005 = births_prenat_adeq_wht_2005/births_w_prenat_wht_2005;
			PctBirthsPrenatAdeqWht_2006 = births_prenat_adeq_wht_2006/births_w_prenat_wht_2006;
			PctBirthsPrenatAdeqWht_2007 = births_prenat_adeq_wht_2007/births_w_prenat_wht_2007;
			PctBirthsPrenatAdeqWht_2008 = births_prenat_adeq_wht_2008/births_w_prenat_wht_2008;
			PctBirthsPrenatAdeqWht_2009 = births_prenat_adeq_wht_2009/births_w_prenat_wht_2009;
			PctBirthsPrenatAdeqWht_2010 = births_prenat_adeq_wht_2010/births_w_prenat_wht_2010;
			PctBirthsPrenatAdeqWht_2011 = births_prenat_adeq_wht_2011/births_w_prenat_wht_2011;
			PctBirthsPrenatAdeqWht_2012 = births_prenat_adeq_wht_2012/births_w_prenat_wht_2012;
			PctBirthsPrenatAdeqWht_2013 = births_prenat_adeq_wht_2013/births_w_prenat_wht_2013;
			PctBirthsPrenatAdeqWht_2014 = births_prenat_adeq_wht_2014/births_w_prenat_wht_2014;
			PctBirthsPrenatAdeqWht_2015 = births_prenat_adeq_wht_2015/births_w_prenat_wht_2015;
			PctBirthsPrenatAdeqWht_2016 = births_prenat_adeq_wht_2016/births_w_prenat_wht_2016;

			PctBirthsPrenatAdeqAsn_2003 = births_prenat_adeq_asn_2003/births_w_prenat_asn_2003;
			PctBirthsPrenatAdeqAsn_2004 = births_prenat_adeq_asn_2004/births_w_prenat_asn_2004;
			PctBirthsPrenatAdeqAsn_2005 = births_prenat_adeq_asn_2005/births_w_prenat_asn_2005;
			PctBirthsPrenatAdeqAsn_2006 = births_prenat_adeq_asn_2006/births_w_prenat_asn_2006;
			PctBirthsPrenatAdeqAsn_2007 = births_prenat_adeq_asn_2007/births_w_prenat_asn_2007;
			PctBirthsPrenatAdeqAsn_2008 = births_prenat_adeq_asn_2008/births_w_prenat_asn_2008;
			PctBirthsPrenatAdeqAsn_2009 = births_prenat_adeq_asn_2009/births_w_prenat_asn_2009;
			PctBirthsPrenatAdeqAsn_2010 = births_prenat_adeq_asn_2010/births_w_prenat_asn_2010;
			PctBirthsPrenatAdeqAsn_2011 = births_prenat_adeq_asn_2011/births_w_prenat_asn_2011;
			PctBirthsPrenatAdeqAsn_2012 = births_prenat_adeq_asn_2012/births_w_prenat_asn_2012;
			PctBirthsPrenatAdeqAsn_2013 = births_prenat_adeq_asn_2013/births_w_prenat_asn_2013;
			PctBirthsPrenatAdeqAsn_2014 = births_prenat_adeq_asn_2014/births_w_prenat_asn_2014;
			PctBirthsPrenatAdeqAsn_2015 = births_prenat_adeq_asn_2015/births_w_prenat_asn_2015;
			PctBirthsPrenatAdeqAsn_2016 = births_prenat_adeq_asn_2016/births_w_prenat_asn_2016;

			PctBirthsPrenatAdeqBlk_2003 = births_prenat_adeq_blk_2003/births_w_prenat_blk_2003;
			PctBirthsPrenatAdeqBlk_2004 = births_prenat_adeq_blk_2004/births_w_prenat_blk_2004;
			PctBirthsPrenatAdeqBlk_2005 = births_prenat_adeq_blk_2005/births_w_prenat_blk_2005;
			PctBirthsPrenatAdeqBlk_2006 = births_prenat_adeq_blk_2006/births_w_prenat_blk_2006;
			PctBirthsPrenatAdeqBlk_2007 = births_prenat_adeq_blk_2007/births_w_prenat_blk_2007;
			PctBirthsPrenatAdeqBlk_2008 = births_prenat_adeq_blk_2008/births_w_prenat_blk_2008;
			PctBirthsPrenatAdeqBlk_2009 = births_prenat_adeq_blk_2009/births_w_prenat_blk_2009;
			PctBirthsPrenatAdeqBlk_2010 = births_prenat_adeq_blk_2010/births_w_prenat_blk_2010;
			PctBirthsPrenatAdeqBlk_2011 = births_prenat_adeq_blk_2011/births_w_prenat_blk_2011;
			PctBirthsPrenatAdeqBlk_2012 = births_prenat_adeq_blk_2012/births_w_prenat_blk_2012;
			PctBirthsPrenatAdeqBlk_2013 = births_prenat_adeq_blk_2013/births_w_prenat_blk_2013;
			PctBirthsPrenatAdeqBlk_2014 = births_prenat_adeq_blk_2014/births_w_prenat_blk_2014;
			PctBirthsPrenatAdeqBlk_2015 = births_prenat_adeq_blk_2015/births_w_prenat_blk_2015;
			PctBirthsPrenatAdeqBlk_2016 = births_prenat_adeq_blk_2016/births_w_prenat_blk_2016;

			PctBirthsPrenatAdeqHisp_2003 = births_prenat_adeq_hsp_2003/births_w_prenat_hsp_2003;
			PctBirthsPrenatAdeqHisp_2004 = births_prenat_adeq_hsp_2004/births_w_prenat_hsp_2004;
			PctBirthsPrenatAdeqHisp_2005 = births_prenat_adeq_hsp_2005/births_w_prenat_hsp_2005;
			PctBirthsPrenatAdeqHisp_2006 = births_prenat_adeq_hsp_2006/births_w_prenat_hsp_2006;
			PctBirthsPrenatAdeqHisp_2007 = births_prenat_adeq_hsp_2007/births_w_prenat_hsp_2007;
			PctBirthsPrenatAdeqHisp_2008 = births_prenat_adeq_hsp_2008/births_w_prenat_hsp_2008;
			PctBirthsPrenatAdeqHisp_2009 = births_prenat_adeq_hsp_2009/births_w_prenat_hsp_2009;
			PctBirthsPrenatAdeqHisp_2010 = births_prenat_adeq_hsp_2010/births_w_prenat_hsp_2010;
			PctBirthsPrenatAdeqHisp_2011 = births_prenat_adeq_hsp_2011/births_w_prenat_hsp_2011;
			PctBirthsPrenatAdeqHisp_2012 = births_prenat_adeq_hsp_2012/births_w_prenat_hsp_2012;
			PctBirthsPrenatAdeqHisp_2013 = births_prenat_adeq_hsp_2013/births_w_prenat_hsp_2013;
			PctBirthsPrenatAdeqHisp_2014 = births_prenat_adeq_hsp_2014/births_w_prenat_hsp_2014;
			PctBirthsPrenatAdeqHisp_2015 = births_prenat_adeq_hsp_2015/births_w_prenat_hsp_2015;
			PctBirthsPrenatAdeqHisp_2016 = births_prenat_adeq_hsp_2016/births_w_prenat_hsp_2016;

			PctBirthsPrenatAdeqOth_2003 = births_prenat_adeq_oth_2003/births_w_prenat_oth_2003;
			PctBirthsPrenatAdeqOth_2004 = births_prenat_adeq_oth_2004/births_w_prenat_oth_2004;
			PctBirthsPrenatAdeqOth_2005 = births_prenat_adeq_oth_2005/births_w_prenat_oth_2005;
			PctBirthsPrenatAdeqOth_2006 = births_prenat_adeq_oth_2006/births_w_prenat_oth_2006;
			PctBirthsPrenatAdeqOth_2007 = births_prenat_adeq_oth_2007/births_w_prenat_oth_2007;
			PctBirthsPrenatAdeqOth_2008 = births_prenat_adeq_oth_2008/births_w_prenat_oth_2008;
			PctBirthsPrenatAdeqOth_2009 = births_prenat_adeq_oth_2009/births_w_prenat_oth_2009;
			PctBirthsPrenatAdeqOth_2010 = births_prenat_adeq_oth_2010/births_w_prenat_oth_2010;
			PctBirthsPrenatAdeqOth_2011 = births_prenat_adeq_oth_2011/births_w_prenat_oth_2011;
			PctBirthsPrenatAdeqOth_2012 = births_prenat_adeq_oth_2012/births_w_prenat_oth_2012;
			PctBirthsPrenatAdeqOth_2013 = births_prenat_adeq_oth_2013/births_w_prenat_oth_2013;
			PctBirthsPrenatAdeqOth_2014 = births_prenat_adeq_oth_2014/births_w_prenat_oth_2014;
			PctBirthsPrenatAdeqOth_2015 = births_prenat_adeq_oth_2015/births_w_prenat_oth_2015;
			PctBirthsPrenatAdeqOth_2016 = births_prenat_adeq_oth_2016/births_w_prenat_oth_2016;

			PctBirthsPrenatIntrWht_2003 = births_prenat_intr_wht_2003/births_w_prenat_wht_2003;
			PctBirthsPrenatIntrWht_2004 = births_prenat_intr_wht_2004/births_w_prenat_wht_2004;
			PctBirthsPrenatIntrWht_2005 = births_prenat_intr_wht_2005/births_w_prenat_wht_2005;
			PctBirthsPrenatIntrWht_2006 = births_prenat_intr_wht_2006/births_w_prenat_wht_2006;
			PctBirthsPrenatIntrWht_2007 = births_prenat_intr_wht_2007/births_w_prenat_wht_2007;
			PctBirthsPrenatIntrWht_2008 = births_prenat_intr_wht_2008/births_w_prenat_wht_2008;
			PctBirthsPrenatIntrWht_2009 = births_prenat_intr_wht_2009/births_w_prenat_wht_2009;
			PctBirthsPrenatIntrWht_2010 = births_prenat_intr_wht_2010/births_w_prenat_wht_2010;
			PctBirthsPrenatIntrWht_2011 = births_prenat_intr_wht_2011/births_w_prenat_wht_2011;
			PctBirthsPrenatIntrWht_2012 = births_prenat_intr_wht_2012/births_w_prenat_wht_2012;
			PctBirthsPrenatIntrWht_2013 = births_prenat_intr_wht_2013/births_w_prenat_wht_2013;
			PctBirthsPrenatIntrWht_2014 = births_prenat_intr_wht_2014/births_w_prenat_wht_2014;
			PctBirthsPrenatIntrWht_2015 = births_prenat_intr_wht_2015/births_w_prenat_wht_2015;
			PctBirthsPrenatIntrWht_2016 = births_prenat_intr_wht_2016/births_w_prenat_wht_2016;

			PctBirthsPrenatIntrAsn_2003 = births_prenat_intr_asn_2003/births_w_prenat_asn_2003;
			PctBirthsPrenatIntrAsn_2004 = births_prenat_intr_asn_2004/births_w_prenat_asn_2004;
			PctBirthsPrenatIntrAsn_2005 = births_prenat_intr_asn_2005/births_w_prenat_asn_2005;
			PctBirthsPrenatIntrAsn_2006 = births_prenat_intr_asn_2006/births_w_prenat_asn_2006;
			PctBirthsPrenatIntrAsn_2007 = births_prenat_intr_asn_2007/births_w_prenat_asn_2007;
			PctBirthsPrenatIntrAsn_2008 = births_prenat_intr_asn_2008/births_w_prenat_asn_2008;
			PctBirthsPrenatIntrAsn_2009 = births_prenat_intr_asn_2009/births_w_prenat_asn_2009;
			PctBirthsPrenatIntrAsn_2010 = births_prenat_intr_asn_2010/births_w_prenat_asn_2010;
			PctBirthsPrenatIntrAsn_2011 = births_prenat_intr_asn_2011/births_w_prenat_asn_2011;
			PctBirthsPrenatIntrAsn_2012 = births_prenat_intr_asn_2012/births_w_prenat_asn_2012;
			PctBirthsPrenatIntrAsn_2013 = births_prenat_intr_asn_2013/births_w_prenat_asn_2013;
			PctBirthsPrenatIntrAsn_2014 = births_prenat_intr_asn_2014/births_w_prenat_asn_2014;
			PctBirthsPrenatIntrAsn_2015 = births_prenat_intr_asn_2015/births_w_prenat_asn_2015;
			PctBirthsPrenatIntrAsn_2016 = births_prenat_intr_asn_2016/births_w_prenat_asn_2016;

			PctBirthsPrenatIntrBlk_2003 = births_prenat_intr_blk_2003/births_w_prenat_blk_2003;
			PctBirthsPrenatIntrBlk_2004 = births_prenat_intr_blk_2004/births_w_prenat_blk_2004;
			PctBirthsPrenatIntrBlk_2005 = births_prenat_intr_blk_2005/births_w_prenat_blk_2005;
			PctBirthsPrenatIntrBlk_2006 = births_prenat_intr_blk_2006/births_w_prenat_blk_2006;
			PctBirthsPrenatIntrBlk_2007 = births_prenat_intr_blk_2007/births_w_prenat_blk_2007;
			PctBirthsPrenatIntrBlk_2008 = births_prenat_intr_blk_2008/births_w_prenat_blk_2008;
			PctBirthsPrenatIntrBlk_2009 = births_prenat_intr_blk_2009/births_w_prenat_blk_2009;
			PctBirthsPrenatIntrBlk_2010 = births_prenat_intr_blk_2010/births_w_prenat_blk_2010;
			PctBirthsPrenatIntrBlk_2011 = births_prenat_intr_blk_2011/births_w_prenat_blk_2011;
			PctBirthsPrenatIntrBlk_2012 = births_prenat_intr_blk_2012/births_w_prenat_blk_2012;
			PctBirthsPrenatIntrBlk_2013 = births_prenat_intr_blk_2013/births_w_prenat_blk_2013;
			PctBirthsPrenatIntrBlk_2014 = births_prenat_intr_blk_2014/births_w_prenat_blk_2014;
			PctBirthsPrenatIntrBlk_2015 = births_prenat_intr_blk_2015/births_w_prenat_blk_2015;
			PctBirthsPrenatIntrBlk_2016 = births_prenat_intr_blk_2016/births_w_prenat_blk_2016;

			PctBirthsPrenatIntrHisp_2003 = births_prenat_intr_hsp_2003/births_w_prenat_hsp_2003;
			PctBirthsPrenatIntrHisp_2004 = births_prenat_intr_hsp_2004/births_w_prenat_hsp_2004;
			PctBirthsPrenatIntrHisp_2005 = births_prenat_intr_hsp_2005/births_w_prenat_hsp_2005;
			PctBirthsPrenatIntrHisp_2006 = births_prenat_intr_hsp_2006/births_w_prenat_hsp_2006;
			PctBirthsPrenatIntrHisp_2007 = births_prenat_intr_hsp_2007/births_w_prenat_hsp_2007;
			PctBirthsPrenatIntrHisp_2008 = births_prenat_intr_hsp_2008/births_w_prenat_hsp_2008;
			PctBirthsPrenatIntrHisp_2009 = births_prenat_intr_hsp_2009/births_w_prenat_hsp_2009;
			PctBirthsPrenatIntrHisp_2010 = births_prenat_intr_hsp_2010/births_w_prenat_hsp_2010;
			PctBirthsPrenatIntrHisp_2011 = births_prenat_intr_hsp_2011/births_w_prenat_hsp_2011;
			PctBirthsPrenatIntrHisp_2012 = births_prenat_intr_hsp_2012/births_w_prenat_hsp_2012;
			PctBirthsPrenatIntrHisp_2013 = births_prenat_intr_hsp_2013/births_w_prenat_hsp_2013;
			PctBirthsPrenatIntrHisp_2014 = births_prenat_intr_hsp_2014/births_w_prenat_hsp_2014;
			PctBirthsPrenatIntrHisp_2015 = births_prenat_intr_hsp_2015/births_w_prenat_hsp_2015;
			PctBirthsPrenatIntrHisp_2016 = births_prenat_intr_hsp_2016/births_w_prenat_hsp_2016;

			PctBirthsPrenatIntrOth_2003 = births_prenat_intr_oth_2003/births_w_prenat_oth_2003;
			PctBirthsPrenatIntrOth_2004 = births_prenat_intr_oth_2004/births_w_prenat_oth_2004;
			PctBirthsPrenatIntrOth_2005 = births_prenat_intr_oth_2005/births_w_prenat_oth_2005;
			PctBirthsPrenatIntrOth_2006 = births_prenat_intr_oth_2006/births_w_prenat_oth_2006;
			PctBirthsPrenatIntrOth_2007 = births_prenat_intr_oth_2007/births_w_prenat_oth_2007;
			PctBirthsPrenatIntrOth_2008 = births_prenat_intr_oth_2008/births_w_prenat_oth_2008;
			PctBirthsPrenatIntrOth_2009 = births_prenat_intr_oth_2009/births_w_prenat_oth_2009;
			PctBirthsPrenatIntrOth_2010 = births_prenat_intr_oth_2010/births_w_prenat_oth_2010;
			PctBirthsPrenatIntrOth_2011 = births_prenat_intr_oth_2011/births_w_prenat_oth_2011;
			PctBirthsPrenatIntrOth_2012 = births_prenat_intr_oth_2012/births_w_prenat_oth_2012;
			PctBirthsPrenatIntrOth_2013 = births_prenat_intr_oth_2013/births_w_prenat_oth_2013;
			PctBirthsPrenatIntrOth_2014 = births_prenat_intr_oth_2014/births_w_prenat_oth_2014;
			PctBirthsPrenatIntrOth_2015 = births_prenat_intr_oth_2015/births_w_prenat_oth_2015;
			PctBirthsPrenatIntrOth_2016 = births_prenat_intr_oth_2016/births_w_prenat_oth_2016;

			PctBirthsPrenat1stWht_2003 = births_prenat_1st_wht_2003/births_w_prenat_wht_2003;
			PctBirthsPrenat1stWht_2004 = births_prenat_1st_wht_2004/births_w_prenat_wht_2004;
			PctBirthsPrenat1stWht_2005 = births_prenat_1st_wht_2005/births_w_prenat_wht_2005;
			PctBirthsPrenat1stWht_2006 = births_prenat_1st_wht_2006/births_w_prenat_wht_2006;
			PctBirthsPrenat1stWht_2007 = births_prenat_1st_wht_2007/births_w_prenat_wht_2007;
			PctBirthsPrenat1stWht_2008 = births_prenat_1st_wht_2008/births_w_prenat_wht_2008;
			PctBirthsPrenat1stWht_2009 = births_prenat_1st_wht_2009/births_w_prenat_wht_2009;
			PctBirthsPrenat1stWht_2010 = births_prenat_1st_wht_2010/births_w_prenat_wht_2010;
			PctBirthsPrenat1stWht_2011 = births_prenat_1st_wht_2011/births_w_prenat_wht_2011;
			PctBirthsPrenat1stWht_2012 = births_prenat_1st_wht_2012/births_w_prenat_wht_2012;
			PctBirthsPrenat1stWht_2013 = births_prenat_1st_wht_2013/births_w_prenat_wht_2013;
			PctBirthsPrenat1stWht_2014 = births_prenat_1st_wht_2014/births_w_prenat_wht_2014;
			PctBirthsPrenat1stWht_2015 = births_prenat_1st_wht_2015/births_w_prenat_wht_2015;
			PctBirthsPrenat1stWht_2016 = births_prenat_1st_wht_2016/births_w_prenat_wht_2016;

			PctBirthsPrenat1stAsn_2003 = births_prenat_1st_asn_2003/births_w_prenat_asn_2003;
			PctBirthsPrenat1stAsn_2004 = births_prenat_1st_asn_2004/births_w_prenat_asn_2004;
			PctBirthsPrenat1stAsn_2005 = births_prenat_1st_asn_2005/births_w_prenat_asn_2005;
			PctBirthsPrenat1stAsn_2006 = births_prenat_1st_asn_2006/births_w_prenat_asn_2006;
			PctBirthsPrenat1stAsn_2007 = births_prenat_1st_asn_2007/births_w_prenat_asn_2007;
			PctBirthsPrenat1stAsn_2008 = births_prenat_1st_asn_2008/births_w_prenat_asn_2008;
			PctBirthsPrenat1stAsn_2009 = births_prenat_1st_asn_2009/births_w_prenat_asn_2009;
			PctBirthsPrenat1stAsn_2010 = births_prenat_1st_asn_2010/births_w_prenat_asn_2010;
			PctBirthsPrenat1stAsn_2011 = births_prenat_1st_asn_2011/births_w_prenat_asn_2011;
			PctBirthsPrenat1stAsn_2012 = births_prenat_1st_asn_2012/births_w_prenat_asn_2012;
			PctBirthsPrenat1stAsn_2013 = births_prenat_1st_asn_2013/births_w_prenat_asn_2013;
			PctBirthsPrenat1stAsn_2014 = births_prenat_1st_asn_2014/births_w_prenat_asn_2014;
			PctBirthsPrenat1stAsn_2015 = births_prenat_1st_asn_2015/births_w_prenat_asn_2015;
			PctBirthsPrenat1stAsn_2016 = births_prenat_1st_asn_2016/births_w_prenat_asn_2016;

			PctBirthsPrenat1stBlk_2003 = births_prenat_1st_blk_2003/births_w_prenat_blk_2003;
			PctBirthsPrenat1stBlk_2004 = births_prenat_1st_blk_2004/births_w_prenat_blk_2004;
			PctBirthsPrenat1stBlk_2005 = births_prenat_1st_blk_2005/births_w_prenat_blk_2005;
			PctBirthsPrenat1stBlk_2006 = births_prenat_1st_blk_2006/births_w_prenat_blk_2006;
			PctBirthsPrenat1stBlk_2007 = births_prenat_1st_blk_2007/births_w_prenat_blk_2007;
			PctBirthsPrenat1stBlk_2008 = births_prenat_1st_blk_2008/births_w_prenat_blk_2008;
			PctBirthsPrenat1stBlk_2009 = births_prenat_1st_blk_2009/births_w_prenat_blk_2009;
			PctBirthsPrenat1stBlk_2010 = births_prenat_1st_blk_2010/births_w_prenat_blk_2010;
			PctBirthsPrenat1stBlk_2011 = births_prenat_1st_blk_2011/births_w_prenat_blk_2011;
			PctBirthsPrenat1stBlk_2012 = births_prenat_1st_blk_2012/births_w_prenat_blk_2012;
			PctBirthsPrenat1stBlk_2013 = births_prenat_1st_blk_2013/births_w_prenat_blk_2013;
			PctBirthsPrenat1stBlk_2014 = births_prenat_1st_blk_2014/births_w_prenat_blk_2014;
			PctBirthsPrenat1stBlk_2015 = births_prenat_1st_blk_2015/births_w_prenat_blk_2015;
			PctBirthsPrenat1stBlk_2016 = births_prenat_1st_blk_2016/births_w_prenat_blk_2016;

			PctBirthsPrenat1stHisp_2003 = births_prenat_1st_hsp_2003/births_w_prenat_hsp_2003;
			PctBirthsPrenat1stHisp_2004 = births_prenat_1st_hsp_2004/births_w_prenat_hsp_2004;
			PctBirthsPrenat1stHisp_2005 = births_prenat_1st_hsp_2005/births_w_prenat_hsp_2005;
			PctBirthsPrenat1stHisp_2006 = births_prenat_1st_hsp_2006/births_w_prenat_hsp_2006;
			PctBirthsPrenat1stHisp_2007 = births_prenat_1st_hsp_2007/births_w_prenat_hsp_2007;
			PctBirthsPrenat1stHisp_2008 = births_prenat_1st_hsp_2008/births_w_prenat_hsp_2008;
			PctBirthsPrenat1stHisp_2009 = births_prenat_1st_hsp_2009/births_w_prenat_hsp_2009;
			PctBirthsPrenat1stHisp_2010 = births_prenat_1st_hsp_2010/births_w_prenat_hsp_2010;
			PctBirthsPrenat1stHisp_2011 = births_prenat_1st_hsp_2011/births_w_prenat_hsp_2011;
			PctBirthsPrenat1stHisp_2012 = births_prenat_1st_hsp_2012/births_w_prenat_hsp_2012;
			PctBirthsPrenat1stHisp_2013 = births_prenat_1st_hsp_2013/births_w_prenat_hsp_2013;
			PctBirthsPrenat1stHisp_2014 = births_prenat_1st_hsp_2014/births_w_prenat_hsp_2014;
			PctBirthsPrenat1stHisp_2015 = births_prenat_1st_hsp_2015/births_w_prenat_hsp_2015;
			PctBirthsPrenat1stHisp_2016 = births_prenat_1st_hsp_2016/births_w_prenat_hsp_2016;

			PctBirthsPrenat1stOth_2003 = births_prenat_1st_oth_2003/births_w_prenat_oth_2003;
			PctBirthsPrenat1stOth_2004 = births_prenat_1st_oth_2004/births_w_prenat_oth_2004;
			PctBirthsPrenat1stOth_2005 = births_prenat_1st_oth_2005/births_w_prenat_oth_2005;
			PctBirthsPrenat1stOth_2006 = births_prenat_1st_oth_2006/births_w_prenat_oth_2006;
			PctBirthsPrenat1stOth_2007 = births_prenat_1st_oth_2007/births_w_prenat_oth_2007;
			PctBirthsPrenat1stOth_2008 = births_prenat_1st_oth_2008/births_w_prenat_oth_2008;
			PctBirthsPrenat1stOth_2009 = births_prenat_1st_oth_2009/births_w_prenat_oth_2009;
			PctBirthsPrenat1stOth_2010 = births_prenat_1st_oth_2010/births_w_prenat_oth_2010;
			PctBirthsPrenat1stOth_2011 = births_prenat_1st_oth_2011/births_w_prenat_oth_2011;
			PctBirthsPrenat1stOth_2012 = births_prenat_1st_oth_2012/births_w_prenat_oth_2012;
			PctBirthsPrenat1stOth_2013 = births_prenat_1st_oth_2013/births_w_prenat_oth_2013;
			PctBirthsPrenat1stOth_2014 = births_prenat_1st_oth_2014/births_w_prenat_oth_2014;
			PctBirthsPrenat1stOth_2015 = births_prenat_1st_oth_2015/births_w_prenat_oth_2015;
			PctBirthsPrenat1stOth_2016 = births_prenat_1st_oth_2016/births_w_prenat_oth_2016;

	run;

proc transpose data=compile_bpk_tabs_2014_18_&geosuf out=bpk_tabs_2014_18_&geosuf(label="Bridge Park Tabulations, &geo");
	var 	&geo 	

		/*Population*/
			totpop_&_years. totpop_1990 totpop_2000 totpop_2010
			numoccupiedhsgunits_1990 numoccupiedhsgunits_2000 numoccupiedhsgunits_2010 
			numoccupiedhsgunits_&_years.
		
		/*Race and ethnicity*/
			popwithrace_&_years. 
			PctWht_&_years. 
			PctBlk_&_years. 
			PctHisp_&_years.
			PctAsn_&_years.
			PctOth_&_years. 
	
		/*Homeownership, rent, and cost burden*/
			NumOwnerOccupiedHU_&_years.
			PctOwnerOccupiedHU_&_years. 
			NumRenterOccupiedHU_&_years. 
			PctRenterOccupiedHU_&_years. 
			PctOwnerOccupiedHU_&_years. 

			medianhomevalue_&_years.

			GrossRentLT100_&_years. GrossRent100_149_&_years. 
			GrossRent800_899_&_years. GrossRent900_999_&_years.
			GrossRent1000_1249_&_years. GrossRent1250_1499_&_years.
			GrossRent1500_1999_&_years. GrossRent2000_2499_&_years.
			GrossRent2500_2999_&_years. GrossRent3000_3499_&_years.
			GrossRentGT3500_&_years. 

			GrossRent150_199_&_years.  
			GrossRent200_249_&_years. GrossRent250_299_&_years. 
			GrossRent300_349_&_years. GrossRent350_349_&_years. 
			GrossRent400_449_&_years. GrossRent450_499_&_years. 
			GrossRent500_549_&_years. GrossRent550_599_&_years. 
			GrossRent600_649_&_years. GrossRent650_699_&_years. 
			GrossRent700_749_&_years. GrossRent750_799_&_years. 
			GrossRentNoCash_&_years.

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
			PctPoorChildren_&_years.
			poppoorchildren_&_years.
			childrenpovertydefined_&_years.
			MedFamIncm_&_years.
			FamIncomeLT75k_&_years.
			FamIncomeGT200k_&_years.
			NumFamilies_&_years.

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
			
		/*Residential property: total units, total sales, and median sales price: 2000 - 2018*/
			units_sf_2000 units_sf_2001 units_sf_2002 
			units_sf_2003 units_sf_2004 units_sf_2005 units_sf_2006 units_sf_2007 
			units_sf_2008 units_sf_2009 units_sf_2010 units_sf_2011 units_sf_2012 
			units_sf_2013 units_sf_2014 units_sf_2015 units_sf_2016 units_sf_2017 
			units_sf_2018

			units_condo_2000 units_condo_2001 units_condo_2002
			units_condo_2003 units_condo_2004 units_condo_2005 units_condo_2006 units_condo_2007 
			units_condo_2008 units_condo_2009 units_condo_2010 units_condo_2011 units_condo_2012 
			units_condo_2013 units_condo_2014 units_condo_2015 units_condo_2016 units_condo_2017
			units_condo_2018
				
			sales_sf_2000 sales_sf_2001
			sales_sf_2002 sales_sf_2003 sales_sf_2004 sales_sf_2005 
			sales_sf_2006 sales_sf_2007 sales_sf_2008 sales_sf_2009 
			sales_sf_2010 sales_sf_2011 sales_sf_2012 sales_sf_2013
			sales_sf_2014 sales_sf_2015 sales_sf_2016 sales_sf_2017
			sales_sf_2018

			r_mprice_sf_2000 
			r_mprice_sf_2001 r_mprice_sf_2002 r_mprice_sf_2003 r_mprice_sf_2004
			r_mprice_sf_2005 r_mprice_sf_2006 r_mprice_sf_2007 r_mprice_sf_2008
			r_mprice_sf_2009 r_mprice_sf_2010 r_mprice_sf_2011 r_mprice_sf_2012
			r_mprice_sf_2013 r_mprice_sf_2014 r_mprice_sf_2015 r_mprice_sf_2016
			r_mprice_sf_2017 r_mprice_sf_2018

			sales_condo_2000 sales_condo_2001
			sales_condo_2002 sales_condo_2003 sales_condo_2004 sales_condo_2005 
			sales_condo_2006 sales_condo_2007 sales_condo_2008 sales_condo_2009 
			sales_condo_2010 sales_condo_2011 sales_condo_2012 sales_condo_2013
			sales_condo_2014 sales_condo_2015 sales_condo_2016 sales_condo_2017
			sales_condo_2018

			r_mprice_condo_2000
			r_mprice_condo_2001 r_mprice_condo_2002 r_mprice_condo_2003 r_mprice_condo_2004
			r_mprice_condo_2005 r_mprice_condo_2006 r_mprice_condo_2007 r_mprice_condo_2008
			r_mprice_condo_2009 r_mprice_condo_2010 r_mprice_condo_2011 r_mprice_condo_2012
			r_mprice_condo_2013 r_mprice_condo_2014 r_mprice_condo_2015 r_mprice_condo_2016
			r_mprice_condo_2017 r_mprice_condo_2018

			r_mprice_tot_2000
			r_mprice_tot_2001 r_mprice_tot_2002 r_mprice_tot_2003 r_mprice_tot_2004
			r_mprice_tot_2005 r_mprice_tot_2006 r_mprice_tot_2007 r_mprice_tot_2008
			r_mprice_tot_2009 r_mprice_tot_2010 r_mprice_tot_2011 r_mprice_tot_2012
			r_mprice_tot_2013 r_mprice_tot_2014 r_mprice_tot_2015 r_mprice_tot_2016
			r_mprice_tot_2017 r_mprice_tot_2018


		/*Violent and property crime rates: 2000 - 2018*/
			property_crime_rate_2000
			property_crime_rate_2001 property_crime_rate_2002 
			property_crime_rate_2003 property_crime_rate_2004
			property_crime_rate_2005 property_crime_rate_2006
			property_crime_rate_2007 property_crime_rate_2008
			property_crime_rate_2009 property_crime_rate_2010
			property_crime_rate_2011 property_crime_rate_2012 
			property_crime_rate_2013 property_crime_rate_2014
			property_crime_rate_2015 property_crime_rate_2016 
			property_crime_rate_2017 property_crime_rate_2018
			
			violent_crime_rate_2000
			violent_crime_rate_2001 violent_crime_rate_2002 
			violent_crime_rate_2003 violent_crime_rate_2004
			violent_crime_rate_2005 violent_crime_rate_2006
			violent_crime_rate_2007 violent_crime_rate_2008
			violent_crime_rate_2009 violent_crime_rate_2010
			violent_crime_rate_2011 violent_crime_rate_2012 
			violent_crime_rate_2013 violent_crime_rate_2014
			violent_crime_rate_2015 violent_crime_rate_2016 
			violent_crime_rate_2017 violent_crime_rate_2018
		
		/*HMDA*/

			medianmrtginc1_4m_2009 medianmrtginc1_4m_2010 medianmrtginc1_4m_2011
			medianmrtginc1_4m_2012 medianmrtginc1_4m_2013 medianmrtginc1_4m_2014
			medianmrtginc1_4m_2015 medianmrtginc1_4m_2016 medianmrtginc1_4m_2017
			medianmrtginc1_4m_2018

			numconvmrtgorighomepurch_2009 numconvmrtgorighomepurch_2010 numconvmrtgorighomepurch_2011
			numconvmrtgorighomepurch_2012 numconvmrtgorighomepurch_2013 numconvmrtgorighomepurch_2014
			numconvmrtgorighomepurch_2015 numconvmrtgorighomepurch_2016 numconvmrtgorighomepurch_2017
			numconvmrtgorighomepurch_2018

			PctMrtgorigWht_2009	PctMrtgorigWht_2010	PctMrtgorigWht_2011 PctMrtgorigWht_2012 
			PctMrtgorigWht_2013 PctMrtgorigWht_2014 PctMrtgorigWht_2015 PctMrtgorigWht_2016
			PctMrtgorigWht_2017 PctMrtgorigWht_2018

			PctMrtgorigBlk_2009	PctMrtgorigBlk_2010	PctMrtgorigBlk_2011	PctMrtgorigBlk_2012
			PctMrtgorigBlk_2013 PctMrtgorigBlk_2014 PctMrtgorigBlk_2015	PctMrtgorigBlk_2016
			PctMrtgorigBlk_2017	PctMrtgorigBlk_2018
				
			PctMrtgorigAsn_2009 PctMrtgorigAsn_2010 PctMrtgorigAsn_2011	PctMrtgorigAsn_2012 
			PctMrtgorigAsn_2013	PctMrtgorigAsn_2014 PctMrtgorigAsn_2015 PctMrtgorigAsn_2016
			PctMrtgorigAsn_2017	PctMrtgorigAsn_2018
				
			PctMrtgorigHisp_2009 PctMrtgorigHisp_2010 PctMrtgorigHisp_2011 PctMrtgorigHisp_2012
			PctMrtgorigHisp_2013 PctMrtgorigHisp_2014 PctMrtgorigHisp_2015 PctMrtgorigHisp_2016
			PctMrtgorigHisp_2017 PctMrtgorigHisp_2018
				
			PctMrtgorigOth_2009 PctMrtgorigOth_2010	PctMrtgorigOth_2011	PctMrtgorigOth_2012
			PctMrtgorigOth_2013	PctMrtgorigOth_2014	PctMrtgorigOth_2015	PctMrtgorigOth_2016
			PctMrtgorigOth_2017 PctMrtgorigOth_2018
			
			/*Permits*/
			permits_2009 permits_2010 permits_2011 
			permits_2012 permits_2013 permits_2014
			permits_2015 permits_2016 permits_2017 
			permits_2018

			permits_construction_2009 permits_construction_2010 permits_construction_2011
			permits_construction_2012 permits_construction_2013 permits_construction_2014
			permits_construction_2015 permits_construction_2016 permits_construction_2017
			permits_construction_2018

			permits_homeoccupation_2009 permits_homeoccupation_2010 permits_homeoccupation_2011
			permits_homeoccupation_2012 permits_homeoccupation_2013 permits_homeoccupation_2014
			permits_homeoccupation_2015 permits_homeoccupation_2016 permits_homeoccupation_2017
			permits_homeoccupation_2018 

			permits_supplemental_2009 permits_supplemental_2010 permits_supplemental_2011
			permits_supplemental_2012 permits_supplemental_2013 permits_supplemental_2014
			permits_supplemental_2015 permits_supplemental_2016 permits_supplemental_2017 
			permits_supplemental_2018

			/*Births*/
			
			PctBirthsPrenatInad_2003 PctBirthsPrenatInad_2004 PctBirthsPrenatInad_2005 PctBirthsPrenatInad_2006
			PctBirthsPrenatInad_2007 PctBirthsPrenatInad_2008 PctBirthsPrenatInad_2009 PctBirthsPrenatInad_2010 
			PctBirthsPrenatInad_2011 PctBirthsPrenatInad_2012 PctBirthsPrenatInad_2013 PctBirthsPrenatInad_2014
			PctBirthsPrenatInad_2015 PctBirthsPrenatInad_2016 

			PctBirthsPrenatAdeq_2003 PctBirthsPrenatAdeq_2004 PctBirthsPrenatAdeq_2005 PctBirthsPrenatAdeq_2006
			PctBirthsPrenatAdeq_2007 PctBirthsPrenatAdeq_2008 PctBirthsPrenatAdeq_2009 PctBirthsPrenatAdeq_2010
			PctBirthsPrenatAdeq_2011 PctBirthsPrenatAdeq_2012 PctBirthsPrenatAdeq_2013 PctBirthsPrenatAdeq_2014
			PctBirthsPrenatAdeq_2015 PctBirthsPrenatAdeq_2016

			PctBirthsPrenatIntr_2003 PctBirthsPrenatIntr_2004 PctBirthsPrenatIntr_2005 PctBirthsPrenatIntr_2006 
			PctBirthsPrenatIntr_2007 PctBirthsPrenatIntr_2008 PctBirthsPrenatIntr_2009 PctBirthsPrenatIntr_2010 
			PctBirthsPrenatIntr_2011 PctBirthsPrenatIntr_2012 PctBirthsPrenatIntr_2013 PctBirthsPrenatIntr_2014
			PctBirthsPrenatIntr_2015 PctBirthsPrenatIntr_2016

			PctBirthsPrenat1st_2003 PctBirthsPrenat1st_2004 PctBirthsPrenat1st_2005 PctBirthsPrenat1st_2006 
			PctBirthsPrenat1st_2007 PctBirthsPrenat1st_2008 PctBirthsPrenat1st_2009 PctBirthsPrenat1st_2010
			PctBirthsPrenat1st_2011 PctBirthsPrenat1st_2012 PctBirthsPrenat1st_2013 PctBirthsPrenat1st_2014
			PctBirthsPrenat1st_2015 PctBirthsPrenat1st_2016 

			PctBirthsWht_2003 PctBirthsWht_2004	PctBirthsWht_2005 PctBirthsWht_2006	PctBirthsWht_2007
			PctBirthsWht_2008 PctBirthsWht_2009 PctBirthsWht_2010 PctBirthsWht_2011 PctBirthsWht_2012 
			PctBirthsWht_2013 PctBirthsWht_2014 PctBirthsWht_2015 PctBirthsWht_2016

			PctBirthsAsn_2003 PctBirthsAsn_2004 PctBirthsAsn_2005 PctBirthsAsn_2006 PctBirthsAsn_2007 
			PctBirthsAsn_2008 PctBirthsAsn_2009 PctBirthsAsn_2010 PctBirthsAsn_2011	PctBirthsAsn_2012
			PctBirthsAsn_2013 PctBirthsAsn_2014 PctBirthsAsn_2015 PctBirthsAsn_2016 

 			PctBirthsBlk_2003 PctBirthsBlk_2004 PctBirthsBlk_2005 PctBirthsBlk_2006 PctBirthsBlk_2007
			PctBirthsBlk_2008 PctBirthsBlk_2009 PctBirthsBlk_2010 PctBirthsBlk_2011 PctBirthsBlk_2012
			PctBirthsBlk_2013 PctBirthsBlk_2014 PctBirthsBlk_2015 PctBirthsBlk_2016 
				
 			PctBirthsHisp_2003 PctBirthsHisp_2004 PctBirthsHisp_2005 PctBirthsHisp_2006 PctBirthsHisp_2007
			PctBirthsHisp_2008 PctBirthsHisp_2009 PctBirthsHisp_2010 PctBirthsHisp_2011 PctBirthsHisp_2012
			PctBirthsHisp_2013 PctBirthsHisp_2014 PctBirthsHisp_2015 PctBirthsHisp_2016

			PctBirthsOth_2003 PctBirthsOth_2004 PctBirthsOth_2005 PctBirthsOth_2006 PctBirthsOth_2007
			PctBirthsOth_2008 PctBirthsOth_2009 PctBirthsOth_2010 PctBirthsOth_2011 PctBirthsOth_2012
			PctBirthsOth_2013 PctBirthsOth_2014 PctBirthsOth_2015 PctBirthsOth_2016
							
			PctBirthsPrenatInadWht_2003 PctBirthsPrenatInadWht_2004 PctBirthsPrenatInadWht_2005
			PctBirthsPrenatInadWht_2006 PctBirthsPrenatInadWht_2007 PctBirthsPrenatInadWht_2008
			PctBirthsPrenatInadWht_2009 PctBirthsPrenatInadWht_2010 PctBirthsPrenatInadWht_2011 
			PctBirthsPrenatInadWht_2012 PctBirthsPrenatInadWht_2013 PctBirthsPrenatInadWht_2014 
			PctBirthsPrenatInadWht_2015 PctBirthsPrenatInadWht_2016 

			PctBirthsPrenatInadAsn_2003 PctBirthsPrenatInadAsn_2004 PctBirthsPrenatInadAsn_2005
			PctBirthsPrenatInadAsn_2006 PctBirthsPrenatInadAsn_2007 PctBirthsPrenatInadAsn_2008
			PctBirthsPrenatInadAsn_2009 PctBirthsPrenatInadAsn_2010 PctBirthsPrenatInadAsn_2011 
			PctBirthsPrenatInadAsn_2012 PctBirthsPrenatInadAsn_2013 PctBirthsPrenatInadAsn_2014 
			PctBirthsPrenatInadAsn_2015 PctBirthsPrenatInadAsn_2016

			PctBirthsPrenatInadBlk_2003 PctBirthsPrenatInadBlk_2004 PctBirthsPrenatInadBlk_2005
			PctBirthsPrenatInadBlk_2006 PctBirthsPrenatInadBlk_2007 PctBirthsPrenatInadBlk_2008
			PctBirthsPrenatInadBlk_2009 PctBirthsPrenatInadBlk_2010 PctBirthsPrenatInadBlk_2011 
			PctBirthsPrenatInadBlk_2012 PctBirthsPrenatInadBlk_2013 PctBirthsPrenatInadBlk_2014 
			PctBirthsPrenatInadBlk_2015 PctBirthsPrenatInadBlk_2016

			PctBirthsPrenatInadHisp_2003 PctBirthsPrenatInadHisp_2004 PctBirthsPrenatInadHisp_2005
			PctBirthsPrenatInadHisp_2006 PctBirthsPrenatInadHisp_2007 PctBirthsPrenatInadHisp_2008
			PctBirthsPrenatInadHisp_2009 PctBirthsPrenatInadHisp_2010 PctBirthsPrenatInadHisp_2011 
			PctBirthsPrenatInadHisp_2012 PctBirthsPrenatInadHisp_2013 PctBirthsPrenatInadHisp_2014 
			PctBirthsPrenatInadHisp_2015 PctBirthsPrenatInadHisp_2016

			PctBirthsPrenatInadOth_2003 PctBirthsPrenatInadOth_2004 PctBirthsPrenatInadOth_2005
			PctBirthsPrenatInadOth_2006 PctBirthsPrenatInadOth_2007 PctBirthsPrenatInadOth_2008
			PctBirthsPrenatInadOth_2009 PctBirthsPrenatInadOth_2010 PctBirthsPrenatInadOth_2011 
			PctBirthsPrenatInadOth_2012 PctBirthsPrenatInadOth_2013 PctBirthsPrenatInadOth_2014 
			PctBirthsPrenatInadOth_2015 PctBirthsPrenatInadOth_2016

			PctBirthsPrenatAdeqWht_2003 PctBirthsPrenatAdeqWht_2004 PctBirthsPrenatAdeqWht_2005
			PctBirthsPrenatAdeqWht_2006 PctBirthsPrenatAdeqWht_2007 PctBirthsPrenatAdeqWht_2008 
			PctBirthsPrenatAdeqWht_2009 PctBirthsPrenatAdeqWht_2010 PctBirthsPrenatAdeqWht_2011 
			PctBirthsPrenatAdeqWht_2012 PctBirthsPrenatAdeqWht_2013 PctBirthsPrenatAdeqWht_2014 
			PctBirthsPrenatAdeqWht_2015 PctBirthsPrenatAdeqWht_2016 

			PctBirthsPrenatAdeqAsn_2003 PctBirthsPrenatAdeqAsn_2004 PctBirthsPrenatAdeqAsn_2005
			PctBirthsPrenatAdeqAsn_2006 PctBirthsPrenatAdeqAsn_2007 PctBirthsPrenatAdeqAsn_2008 
			PctBirthsPrenatAdeqAsn_2009 PctBirthsPrenatAdeqAsn_2010 PctBirthsPrenatAdeqAsn_2011 
			PctBirthsPrenatAdeqAsn_2012 PctBirthsPrenatAdeqAsn_2013 PctBirthsPrenatAdeqAsn_2014 
			PctBirthsPrenatAdeqAsn_2015 PctBirthsPrenatAdeqAsn_2016

			PctBirthsPrenatAdeqBlk_2003 PctBirthsPrenatAdeqBlk_2004 PctBirthsPrenatAdeqBlk_2005
			PctBirthsPrenatAdeqBlk_2006 PctBirthsPrenatAdeqBlk_2007 PctBirthsPrenatAdeqBlk_2008 
			PctBirthsPrenatAdeqBlk_2009 PctBirthsPrenatAdeqBlk_2010 PctBirthsPrenatAdeqBlk_2011 
			PctBirthsPrenatAdeqBlk_2012 PctBirthsPrenatAdeqBlk_2013 PctBirthsPrenatAdeqBlk_2014 
			PctBirthsPrenatAdeqBlk_2015 PctBirthsPrenatAdeqBlk_2016

			PctBirthsPrenatAdeqHisp_2003 PctBirthsPrenatAdeqHisp_2004 PctBirthsPrenatAdeqHisp_2005
			PctBirthsPrenatAdeqHisp_2006 PctBirthsPrenatAdeqHisp_2007 PctBirthsPrenatAdeqHisp_2008 
			PctBirthsPrenatAdeqHisp_2009 PctBirthsPrenatAdeqHisp_2010 PctBirthsPrenatAdeqHisp_2011 
			PctBirthsPrenatAdeqHisp_2012 PctBirthsPrenatAdeqHisp_2013 PctBirthsPrenatAdeqHisp_2014 
			PctBirthsPrenatAdeqHisp_2015 PctBirthsPrenatAdeqHisp_2016

			PctBirthsPrenatAdeqOth_2003 PctBirthsPrenatAdeqOth_2004 PctBirthsPrenatAdeqOth_2005
			PctBirthsPrenatAdeqOth_2006 PctBirthsPrenatAdeqOth_2007 PctBirthsPrenatAdeqOth_2008 
			PctBirthsPrenatAdeqOth_2009 PctBirthsPrenatAdeqOth_2010 PctBirthsPrenatAdeqOth_2011 
			PctBirthsPrenatAdeqOth_2012 PctBirthsPrenatAdeqOth_2013 PctBirthsPrenatAdeqOth_2014 
			PctBirthsPrenatAdeqOth_2015 PctBirthsPrenatAdeqOth_2016

			PctBirthsPrenatIntrWht_2003 PctBirthsPrenatIntrWht_2004 PctBirthsPrenatIntrWht_2005 
			PctBirthsPrenatIntrWht_2006 PctBirthsPrenatIntrWht_2007 PctBirthsPrenatIntrWht_2008
			PctBirthsPrenatIntrWht_2009 PctBirthsPrenatIntrWht_2010 PctBirthsPrenatIntrWht_2011
			PctBirthsPrenatIntrWht_2012 PctBirthsPrenatIntrWht_2013 PctBirthsPrenatIntrWht_2014 
			PctBirthsPrenatIntrWht_2015 PctBirthsPrenatIntrWht_2016 

			PctBirthsPrenatIntrAsn_2003 PctBirthsPrenatIntrAsn_2004 PctBirthsPrenatIntrAsn_2005 
			PctBirthsPrenatIntrAsn_2006 PctBirthsPrenatIntrAsn_2007 PctBirthsPrenatIntrAsn_2008
			PctBirthsPrenatIntrAsn_2009 PctBirthsPrenatIntrAsn_2010 PctBirthsPrenatIntrAsn_2011
			PctBirthsPrenatIntrAsn_2012 PctBirthsPrenatIntrAsn_2013 PctBirthsPrenatIntrAsn_2014 
			PctBirthsPrenatIntrAsn_2015 PctBirthsPrenatIntrAsn_2016

			PctBirthsPrenatIntrBlk_2003 PctBirthsPrenatIntrBlk_2004 PctBirthsPrenatIntrBlk_2005 
			PctBirthsPrenatIntrBlk_2006 PctBirthsPrenatIntrBlk_2007 PctBirthsPrenatIntrBlk_2008
			PctBirthsPrenatIntrBlk_2009 PctBirthsPrenatIntrBlk_2010 PctBirthsPrenatIntrBlk_2011
			PctBirthsPrenatIntrBlk_2012 PctBirthsPrenatIntrBlk_2013 PctBirthsPrenatIntrBlk_2014 
			PctBirthsPrenatIntrBlk_2015 PctBirthsPrenatIntrBlk_2016

			PctBirthsPrenatIntrHisp_2003 PctBirthsPrenatIntrHisp_2004 PctBirthsPrenatIntrHisp_2005 
			PctBirthsPrenatIntrHisp_2006 PctBirthsPrenatIntrHisp_2007 PctBirthsPrenatIntrHisp_2008
			PctBirthsPrenatIntrHisp_2009 PctBirthsPrenatIntrHisp_2010 PctBirthsPrenatIntrHisp_2011
			PctBirthsPrenatIntrHisp_2012 PctBirthsPrenatIntrHisp_2013 PctBirthsPrenatIntrHisp_2014 
			PctBirthsPrenatIntrHisp_2015 PctBirthsPrenatIntrHisp_2016

			PctBirthsPrenatIntrOth_2003 PctBirthsPrenatIntrOth_2004 PctBirthsPrenatIntrOth_2005 
			PctBirthsPrenatIntrOth_2006 PctBirthsPrenatIntrOth_2007 PctBirthsPrenatIntrOth_2008
			PctBirthsPrenatIntrOth_2009 PctBirthsPrenatIntrOth_2010 PctBirthsPrenatIntrOth_2011
			PctBirthsPrenatIntrOth_2012 PctBirthsPrenatIntrOth_2013 PctBirthsPrenatIntrOth_2014 
			PctBirthsPrenatIntrOth_2015 PctBirthsPrenatIntrOth_2016

			PctBirthsPrenat1stWht_2003 PctBirthsPrenat1stWht_2004 PctBirthsPrenat1stWht_2005 
			PctBirthsPrenat1stWht_2006 PctBirthsPrenat1stWht_2007 PctBirthsPrenat1stWht_2008
			PctBirthsPrenat1stWht_2009 PctBirthsPrenat1stWht_2010 PctBirthsPrenat1stWht_2011 
			PctBirthsPrenat1stWht_2012 PctBirthsPrenat1stWht_2013 PctBirthsPrenat1stWht_2014 
			PctBirthsPrenat1stWht_2015 PctBirthsPrenat1stWht_2016

			PctBirthsPrenat1stAsn_2003 PctBirthsPrenat1stAsn_2004 PctBirthsPrenat1stAsn_2005 
			PctBirthsPrenat1stAsn_2006 PctBirthsPrenat1stAsn_2007 PctBirthsPrenat1stAsn_2008
			PctBirthsPrenat1stAsn_2009 PctBirthsPrenat1stAsn_2010 PctBirthsPrenat1stAsn_2011 
			PctBirthsPrenat1stAsn_2012 PctBirthsPrenat1stAsn_2013 PctBirthsPrenat1stAsn_2014 
			PctBirthsPrenat1stAsn_2015 PctBirthsPrenat1stAsn_2016

			PctBirthsPrenat1stBlk_2003 PctBirthsPrenat1stBlk_2004 PctBirthsPrenat1stBlk_2005 
			PctBirthsPrenat1stBlk_2006 PctBirthsPrenat1stBlk_2007 PctBirthsPrenat1stBlk_2008
			PctBirthsPrenat1stBlk_2009 PctBirthsPrenat1stBlk_2010 PctBirthsPrenat1stBlk_2011 
			PctBirthsPrenat1stBlk_2012 PctBirthsPrenat1stBlk_2013 PctBirthsPrenat1stBlk_2014 
			PctBirthsPrenat1stBlk_2015 PctBirthsPrenat1stBlk_2016

			PctBirthsPrenat1stHisp_2003 PctBirthsPrenat1stHisp_2004 PctBirthsPrenat1stHisp_2005
			PctBirthsPrenat1stHisp_2006 PctBirthsPrenat1stHisp_2007 PctBirthsPrenat1stHisp_2008 
			PctBirthsPrenat1stHisp_2009 PctBirthsPrenat1stHisp_2010 PctBirthsPrenat1stHisp_2011
			PctBirthsPrenat1stHisp_2012 PctBirthsPrenat1stHisp_2013 PctBirthsPrenat1stHisp_2014 
			PctBirthsPrenat1stHisp_2015 PctBirthsPrenat1stHisp_2016 

			PctBirthsPrenat1stOth_2003 PctBirthsPrenat1stOth_2004 PctBirthsPrenat1stOth_2005 
			PctBirthsPrenat1stOth_2006 PctBirthsPrenat1stOth_2007 PctBirthsPrenat1stOth_2008
			PctBirthsPrenat1stOth_2009 PctBirthsPrenat1stOth_2010 PctBirthsPrenat1stOth_2011 
			PctBirthsPrenat1stOth_2012 PctBirthsPrenat1stOth_2013 PctBirthsPrenat1stOth_2014 
			PctBirthsPrenat1stOth_2015 PctBirthsPrenat1stOth_2016
	
				;

id &geo; 
run; 

%File_info( data=compile_bpk_tabs_2014_18_&geosuf, contents=n, printobs=0 )

proc export data=bpk_tabs_2014_18_&geosuf
	outfile="&_dcdata_default_path\BridgePk\Data\bpktabs_2014_18_&geosuf..csv"
	dbms=csv replace;
	run;


%mend Compile_bpk_data;


%Compile_bpk_data (bridgepk, bpk);
%Compile_bpk_data (ward2012, wd12);
%Compile_bpk_data (city, city);
