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
%DCData_lib( Bridgepk )


** Define time periods  **;
%let year = 2011_15;
%let year_lbl = 2011-15;

** Pull ACS Estimates for city **;

data ACS_regcnt 
	(keep= county ShrLaborForce_&year ShrEmpRate_&year ShrUnEmpRate_&year
	ShrPov_&year ShrHS_&year ShrCol_&year ShrWht_&year ShrBlk_&year ShrHisp_&year 
	ShrAsn_&year ShrOth_&year 
	ShrEmpMngmt_&year ShrEmpNatRes_&year ShrEmpProd_&year ShrEmpSales_&year ShrEmpServ_&year
	ShrEmpAgric_&year ShrEmpConstr_&year ShrEmpManuf_&year ShrEmpWhlsale_&year 
	ShrEmpRetail_&year ShrEmpTransprt_&year ShrEmpInfo_&year ShrEmpFinance_&year
	ShrEmpProfServ_&year ShrEmpEduction_&year ShrEmpArts_&year ShrEmpOther_&year
	ShrEmpPubAdmin_&year 
	ShrHomeownership_&year ShrRenterCostBurden_&year ShrRentSevereCostBurden_&year 
	ShrOwnerCostBurden_&year ShrOwnSevereCostBurden_&year
	ShrRentCstBurden_15_24_&year ShrRentCstBurden_25_34_&year 
	ShrRentCstBurden_35_64_&year ShrRentCstBurden_65Over_&year 
	ShrOwnCstBurden_15_24_&year ShrOwnCstBurden_25_34_&year 
	ShrOwnCstBurden_35_64_&year ShrOwnCstBurden_65Over_&year 
	ShrRentCstBurden_LT10K_&year ShrRentCstBurden_10_19K_&year 
	ShrRentCstBurden_20_34K_&year ShrRentCstBurden_35_49K_&year 
	ShrRentCstBurden_50_74K_&year ShrRentCstBurden_75_99_&year 
	ShrRentCstBurden_GT100K_&year 
	ShrOwnCstBurden_LT10K_&year ShrOwnCstBurden_10_19K_&year 
	ShrOwnCstBurden_20_34K_&year ShrOwnCstBurden_35_49K_&year 
	ShrOwnCstBurden_50_74K_&year ShrOwnCstBurden_75_99_&year 
	ShrOwnCstBurden_100_149_&year ShrOwnCstBurden_GT150K_&year 
	ShrEmployedWorkInState_&year ShrEmployedWorkOutState_&year
	ShrEmployedTravel_&year ShrEmployedTravel_LT5_&year
	ShrEmployedTravel_5_9_&year ShrEmployedTravel_10_14_&year
	ShrEmployedTravel_15_19_&year ShrEmployedTravel_20_24_&year 
	ShrEmployedTravel_25_29_&year ShrEmployedTravel_30_34_&year 
	ShrEmployedTravel_35_39_&year ShrEmployedTravel_40_44_&year 
	ShrEmployedTravel_45_59_&year ShrEmployedTravel_60_89_&year 
	ShrEmployedTravel_GT90_&year
	);

	set ACS.acs_2011_15_dc_sum_regcnt_regcnt
	(keep= popincivlaborforce_&year
	pop16andoveryears_&year popcivilianemployed_&year popunemployed_&year 
	poppoorpersons_&year personspovertydefined_&year popwithrace_&year 
	popwhitenonhispbridge_&year popblacknonhispbridge_&year pophisp_&year 
	popasianpinonhispbridge_&year popotherracenonhispbridg_&year 
	pop25andoveryears_&year pop25andoverwhs_&year pop25andoverwcollege_&year 
	popemployedmngmt_&year popemployednatres_&year popemployedprod_&year 
	popemployedsales_&year popemployedserv_&year popemployedbyocc_&year
	numrenteroccupiedhu_&year numowneroccupiedhu_&year numoccupiedhsgunits_&year
	RentCostBurdenDenom_&year OwnerCostBurdenDenom_&year 
	NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
	NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
	NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
	NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
	NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
	NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
	NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
	NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
	NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
	NumRentCstBurden_GT100K_&year 
	NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
	NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
	NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
	NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
	PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
	PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
	PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
	PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
	PopEmployedOther_&year PopEmployedPubAdmin_&year
	PopEmployedByOcc_&year PopEmployedMngmt_&year
	PopEmployedServ_&year PopEmployedSales_&year
	PopEmployedNatRes_&year PopEmployedProd_&year 
	PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
	PopEmployedTravel_&year PopEmployedTravel_LT5_&year
	PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
	PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
	PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
	PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
	PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
	PopEmployedTravel_GT90_&year county );

	/*Labor force, employment, and poverty*/
		ShrLaborForce_&year = popincivlaborforce_&year / pop16andoveryears_&year;
		ShrEmpRate_&year = popcivilianemployed_&year / popincivlaborforce_&year;
		ShrUnEmpRate_&year = popunemployed_&year / popincivlaborforce_&year;
		ShrPov_&year = poppoorpersons_&year / personspovertydefined_&year;

	/*Employment by major occupations*/
		ShrEmpMngmt_&year = popemployedmngmt_&year / popemployedbyocc_2011_15;
		ShrEmpNatRes_&year = popemployednatres_&year / popemployedbyocc_2011_15;
		ShrEmpProd_&year = popemployedprod_&year / popemployedbyocc_2011_15;
		ShrEmpSales_&year = popemployedsales_&year / popemployedbyocc_2011_15;
		ShrEmpServ_&year = popemployedserv_&year / popemployedbyocc_2011_15;

	/*Employment by major industries*/
		ShrEmpAgric_&year = PopEmployedAgric_&year / popemployedbyind_&year;
		ShrEmpConstr_&year = PopEmployedConstr_&year / popemployedbyind_&year;
		ShrEmpManuf_&year = PopEmployedManuf_&year / popemployedbyind_&year;
		ShrEmpWhlsale_&year = PopEmployedWhlsale_&year / popemployedbyind_&year;
		ShrEmpRetail_&year = PopEmployedRetail_&year / popemployedbyind_&year;
		ShrEmpTransprt_&year = PopEmployedTransprt_&year / popemployedbyind_&year;
		ShrEmpInfo_&year = PopEmployedInfo_&year / popemployedbyind_&year;
		ShrEmpFinance_&year = PopEmployedFinance_&year / popemployedbyind_&year;
		ShrEmpProfServ_&year = PopEmployedProfServ_&year / popemployedbyind_&year;
		ShrEmpEduction_&year = PopEmployedEduction_&year / popemployedbyind_&year;
		ShrEmpArts_&year = PopEmployedArts_&year / popemployedbyind_&year;
		ShrEmpOther_&year = PopEmployedOther_&year / popemployedbyind_&year;
		ShrEmpPubAdmin_&year = PopEmployedPubAdmin_&year / popemployedbyind_&year;

	/*Employment by place of work*/

		ShrEmployedWorkInState_&year = PopEmployedWorkInState_&year / PopEmployedWorkers_&year;
		ShrEmployedWorkOutState_&year = PopEmployedWorkOutState_&year / PopEmployedWorkers_&year;

	/*Employment by travel time to work*/

		ShrEmployedTravel_LT5_&year = PopEmployedTravel_LT5_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_5_9_&year = PopEmployedTravel_5_9_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_10_14_&year = PopEmployedTravel_10_14_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_15_19_&year = PopEmployedTravel_15_19_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_20_24_&year = PopEmployedTravel_20_24_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_25_29_&year = PopEmployedTravel_25_29_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_30_34_&year = PopEmployedTravel_30_34_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_35_39_&year = PopEmployedTravel_35_39_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_40_44_&year = PopEmployedTravel_40_44_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_45_59_&year = PopEmployedTravel_45_59_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_60_89_&year = PopEmployedTravel_60_89_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_GT90_&year = PopEmployedTravel_GT90_&year / PopEmployedTravel_&year;

	/*Homeownership, rent, and cost burden by age of householder and household income*/
		ShrHomeownership_&year = numowneroccupiedhu_&year / numoccupiedhsgunits_&year;
		ShrRenterCostBurden_&year = NumRenterCostBurden_&year/RentCostBurdenDenom_&year;
		ShrRentSevereCostBurden_&year = NumRentSevereCostBurden_&year/RentCostBurdenDenom_&year;
		ShrOwnerCostBurden_&year = NumOwnerCostBurden_&year/OwnerCostBurdenDenom_&year;
		ShrOwnSevereCostBurden_&year = NumOwnSevereCostBurden_&year/OwnerCostBurdenDenom_&year;

		ShrRentCstBurden_15_24_&year = NumRentCstBurden_15_24_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_25_34_&year = NumRentCstBurden_25_34_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_35_64_&year = NumRentCstBurden_35_64_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_65Over_&year = NumRentCstBurden_65Over_&year / RentCostBurdenDenom_&year;

		ShrOwnCstBurden_15_24_&year = NumOwnCstBurden_15_24_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_25_34_&year = NumOwnCstBurden_25_34_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_35_64_&year = NumOwnCstBurden_35_64_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_65Over_&year = NumOwnCstBurden_65Over_&year / OwnerCostBurdenDenom_&year;

		ShrRentCstBurden_LT10K_&year = NumRentCstBurden_LT10K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_10_19K_&year = NumRentCstBurden_10_19K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_20_35K_&year = NumRentCstBurden_20_35K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_35_50K_&year = NumRentCstBurden_35_50K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_50_75K_&year = NumRentCstBurden_50_75K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_75_100_&year = NumRentCstBurden_75_100_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_GT100K_&year = NumRentCstBurden_GT100K_&year / RentCostBurdenDenom_&year;

		ShrOwnCstBurden_LT10K_&year = NumOwnCstBurden_LT10K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_10_19K_&year = NumOwnCstBurden_10_19K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_20_35K_&year = NumOwnCstBurden_20_35K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_35_50K_&year = NumOwnCstBurden_35_50K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_50_75K_&year = NumOwnCstBurden_50_75K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_75_100_&year = NumOwnCstBurden_75_100_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_100_149_&year = NumOwnCstBurden_100_149_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_GT150K_&year = NumOwnCstBurden_GT150K_&year / OwnerCostBurdenDenom_&year;

	/*Education*/
		ShrHS_&year = pop25andoverwhs_&year / pop25andoveryears_&year;
		ShrCol_&year = pop25andoverwcollege_&year / pop25andoveryears_&year;

	/*Race and ethnicity*/
		ShrWht_&year = popwhitenonhispbridge_&year / popwithrace_&year;
		ShrBlk_&year = popblacknonhispbridge_&year / popwithrace_&year;
		ShrHisp_&year = pophisp_&year / popwithrace_&year;
		ShrAsn_&year = popasianpinonhispbridge_&year / popwithrace_&year;
		ShrOth_&year = popotherracenonhispbridg_&year / popwithrace_&year;

run;

proc export data = ACS_county outfile = "L:\Libraries\Bridgepk\Data\ACS_county_pct.csv" dbms = csv replace;
run;

data ACS_regcnt_n 
	(keep= county pop16andoveryears_&year popincivlaborforce_&year
			personspovertydefined_&year pop25andoveryears_&year popwithrace_&year
			numrenteroccupiedhu_&year numowneroccupiedhu_&year 
			NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
			NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
			GrossRentLT100_499_&year GrossRent500_799_&year GrossRent800_899_&year 
			GrossRent900_999_&year GrossRent1000_1249_&year GrossRent1250_1499_&year 
			GrossRent1500_1999_&year GrossRent2000_2499_&year GrossRent2500_2999_&year 
			GrossRent3000_3499_&year GrossRentGT3500_&year 
			PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
			PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
			PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
			PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
			PopEmployedOther_&year PopEmployedPubAdmin_&year
			PopEmployedByOcc_&year PopEmployedMngmt_&year
			PopEmployedServ_&year PopEmployedSales_&year
			PopEmployedNatRes_&year PopEmployedProd_&year
			NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
			NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
			NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
			NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
			NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
			NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
			NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
			NumRentCstBurden_GT100K_&year 
			NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
			NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
			NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
			NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
			PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
			PopEmployedTravel_&year PopEmployedTravel_LT5_&year
			PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
			PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
			PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
			PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
			PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
			PopEmployedTravel_GT90_&year
			);
	set ACS.acs_2011_15_dc_sum_regcnt_regcnt
	(keep= pop16andoveryears_&year 
			popincivlaborforce_&year personspovertydefined_&year 
			pop25andoveryears_&year popwithrace_&year 
			numrenteroccupiedhu_&year numowneroccupiedhu_&year 
			GrossRentLT100_499_&year GrossRent500_799_&year GrossRent800_899_&year 
			GrossRent900_999_&year GrossRent1000_1249_&year GrossRent1250_1499_&year 
			GrossRent1500_1999_&year GrossRent2000_2499_&year GrossRent2500_2999_&year 
			GrossRent3000_3499_&year GrossRentGT3500_&year
			NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
			NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
			PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
			PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
			PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
			PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
			PopEmployedOther_&year PopEmployedPubAdmin_&year
			PopEmployedByOcc_&year PopEmployedMngmt_&year
			PopEmployedServ_&year PopEmployedSales_&year
			PopEmployedNatRes_&year PopEmployedProd_&year
			NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
			NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
			NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
			NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
			NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
			NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
			NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
			NumRentCstBurden_GT100K_&year 
			NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
			NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
			NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
			NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
			PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
			PopEmployedTravel_&year PopEmployedTravel_LT5_&year
			PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
			PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
			PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
			PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
			PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
			PopEmployedTravel_GT90_&year
			county);

run;

proc export data = ACS_county_n outfile = "L:\Libraries\Bridgepk\Data\ACS_county_n.csv" dbms = csv replace;
run;

** Pull ACS Estimates for wards **;

data ACS_ward 
	(keep= ward2012 ShrLaborForce_&year ShrEmpRate_&year ShrUnEmpRate_&year
	ShrPov_&year ShrHS_&year ShrCol_&year ShrWht_&year ShrBlk_&year ShrHisp_&year 
	ShrAsn_&year ShrOth_&year 
	ShrEmpMngmt_&year ShrEmpNatRes_&year ShrEmpProd_&year ShrEmpSales_&year ShrEmpServ_&year
	ShrEmpAgric_&year ShrEmpConstr_&year ShrEmpManuf_&year ShrEmpWhlsale_&year 
	ShrEmpRetail_&year ShrEmpTransprt_&year ShrEmpInfo_&year ShrEmpFinance_&year
	ShrEmpProfServ_&year ShrEmpEduction_&year ShrEmpArts_&year ShrEmpOther_&year
	ShrEmpPubAdmin_&year 
	ShrHomeownership_&year ShrRenterCostBurden_&year ShrRentSevereCostBurden_&year 
	ShrOwnerCostBurden_&year ShrOwnSevereCostBurden_&year
	ShrRentCstBurden_15_24_&year ShrRentCstBurden_25_34_&year 
	ShrRentCstBurden_35_64_&year ShrRentCstBurden_65Over_&year 
	ShrOwnCstBurden_15_24_&year ShrOwnCstBurden_25_34_&year 
	ShrOwnCstBurden_35_64_&year ShrOwnCstBurden_65Over_&year 
	ShrRentCstBurden_LT10K_&year ShrRentCstBurden_10_19K_&year 
	ShrRentCstBurden_20_34K_&year ShrRentCstBurden_35_49K_&year 
	ShrRentCstBurden_50_74K_&year ShrRentCstBurden_75_99_&year 
	ShrRentCstBurden_GT100K_&year 
	ShrOwnCstBurden_LT10K_&year ShrOwnCstBurden_10_19K_&year 
	ShrOwnCstBurden_20_34K_&year ShrOwnCstBurden_35_49K_&year 
	ShrOwnCstBurden_50_74K_&year ShrOwnCstBurden_75_99_&year 
	ShrOwnCstBurden_100_149_&year ShrOwnCstBurden_GT150K_&year 
	ShrEmployedWorkInState_&year ShrEmployedWorkOutState_&year
	ShrEmployedTravel_&year ShrEmployedTravel_LT5_&year
	ShrEmployedTravel_5_9_&year ShrEmployedTravel_10_14_&year
	ShrEmployedTravel_15_19_&year ShrEmployedTravel_20_24_&year 
	ShrEmployedTravel_25_29_&year ShrEmployedTravel_30_34_&year 
	ShrEmployedTravel_35_39_&year ShrEmployedTravel_40_44_&year 
	ShrEmployedTravel_45_59_&year ShrEmployedTravel_60_89_&year 
	ShrEmployedTravel_GT90_&year
	);

	set ACS.acs_2011_15_dc_sum_tr_wd12 
	(keep= popincivlaborforce_&year
	pop16andoveryears_&year popcivilianemployed_&year popunemployed_&year 
	poppoorpersons_&year personspovertydefined_&year popwithrace_&year 
	popwhitenonhispbridge_&year popblacknonhispbridge_&year pophisp_&year 
	popasianpinonhispbridge_&year popotherracenonhispbridg_&year 
	pop25andoveryears_&year pop25andoverwhs_&year pop25andoverwcollege_&year 
	popemployedmngmt_&year popemployednatres_&year popemployedprod_&year 
	popemployedsales_&year popemployedserv_&year popemployedbyocc_&year
	numrenteroccupiedhu_&year numowneroccupiedhu_&year numoccupiedhsgunits_&year 
	RentCostBurdenDenom_&year OwnerCostBurdenDenom_&year
	NumRenterCostBurden_&year NumRentSevereCostBurden_&year NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
	PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
	PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
	PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
	PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
	PopEmployedOther_&year PopEmployedPubAdmin_&year
	PopEmployedByOcc_&year PopEmployedMngmt_&year
	PopEmployedServ_&year PopEmployedSales_&year
	PopEmployedNatRes_&year PopEmployedProd_&year 
	NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
	NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
	NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
	NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
	NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
	NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
	NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
	NumRentCstBurden_GT100K_&year 
	NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
	NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
	NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
	NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
	PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
	PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
	PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
	PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
	PopEmployedOther_&year PopEmployedPubAdmin_&year
	PopEmployedByOcc_&year PopEmployedMngmt_&year
	PopEmployedServ_&year PopEmployedSales_&year
	PopEmployedNatRes_&year PopEmployedProd_&year 
	PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
	PopEmployedTravel_&year PopEmployedTravel_LT5_&year
	PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
	PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
	PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
	PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
	PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
	PopEmployedTravel_GT90_&year ward2012 );

	/*Labor force, employment, and poverty*/
		ShrLaborForce_&year = popincivlaborforce_&year / pop16andoveryears_&year;
		ShrEmpRate_&year = popcivilianemployed_&year / popincivlaborforce_&year;
		ShrUnEmpRate_&year = popunemployed_&year / popincivlaborforce_&year;
		ShrPov_&year = poppoorpersons_&year / personspovertydefined_&year;

	/*Employment by major occupations*/
		ShrEmpMngmt_&year = popemployedmngmt_&year / popemployedbyocc_&year;
		ShrEmpNatRes_&year = popemployednatres_&year / popemployedbyocc_&year;
		ShrEmpProd_&year = popemployedprod_&year / popemployedbyocc_&year;
		ShrEmpSales_&year = popemployedsales_&year / popemployedbyocc_&year;
		ShrEmpServ_&year = popemployedserv_&year / popemployedbyocc_&year;

	/*Employment by major industries*/
		ShrEmpAgric_&year = PopEmployedAgric_&year / popemployedbyind_&year;
		ShrEmpConstr_&year = PopEmployedConstr_&year / popemployedbyind_&year;
		ShrEmpManuf_&year = PopEmployedManuf_&year / popemployedbyind_&year;
		ShrEmpWhlsale_&year = PopEmployedWhlsale_&year / popemployedbyind_&year;
		ShrEmpRetail_&year = PopEmployedRetail_&year / popemployedbyind_&year;
		ShrEmpTransprt_&year = PopEmployedTransprt_&year / popemployedbyind_&year;
		ShrEmpInfo_&year = PopEmployedInfo_&year / popemployedbyind_&year;
		ShrEmpFinance_&year = PopEmployedFinance_&year / popemployedbyind_&year;
		ShrEmpProfServ_&year = PopEmployedProfServ_&year / popemployedbyind_&year;
		ShrEmpEduction_&year = PopEmployedEduction_&year / popemployedbyind_&year;
		ShrEmpArts_&year = PopEmployedArts_&year / popemployedbyind_&year;
		ShrEmpOther_&year = PopEmployedOther_&year / popemployedbyind_&year;
		ShrEmpPubAdmin_&year = PopEmployedPubAdmin_&year / popemployedbyind_&year;

	/*Employment by place of work*/

		ShrEmployedWorkInState_&year = PopEmployedWorkInState_&year / PopEmployedWorkers_&year;
		ShrEmployedWorkOutState_&year = PopEmployedWorkOutState_&year / PopEmployedWorkers_&year;

	/*Employment by travel time to work*/

		ShrEmployedTravel_LT5_&year = PopEmployedTravel_LT5_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_5_9_&year = PopEmployedTravel_5_9_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_10_14_&year = PopEmployedTravel_10_14_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_15_19_&year = PopEmployedTravel_15_19_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_20_24_&year = PopEmployedTravel_20_24_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_25_29_&year = PopEmployedTravel_25_29_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_30_34_&year = PopEmployedTravel_30_34_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_35_39_&year = PopEmployedTravel_35_39_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_40_44_&year = PopEmployedTravel_40_44_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_45_59_&year = PopEmployedTravel_45_59_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_60_89_&year = PopEmployedTravel_60_89_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_GT90_&year = PopEmployedTravel_GT90_&year / PopEmployedTravel_&year;

	/*Homeownership, rent, and cost burden by age of householder and household income*/
		ShrHomeownership_&year = numowneroccupiedhu_&year / numoccupiedhsgunits_&year;
		ShrRenterCostBurden_&year = NumRenterCostBurden_&year/RentCostBurdenDenom_&year;
		ShrRentSevereCostBurden_&year = NumRentSevereCostBurden_&year/RentCostBurdenDenom_&year;
		ShrOwnerCostBurden_&year = NumOwnerCostBurden_&year/OwnerCostBurdenDenom_&year;
		ShrOwnSevereCostBurden_&year = NumOwnSevereCostBurden_&year/OwnerCostBurdenDenom_&year;

		ShrRentCstBurden_15_24_&year = NumRentCstBurden_15_24_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_25_34_&year = NumRentCstBurden_25_34_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_35_64_&year = NumRentCstBurden_35_64_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_65Over_&year = NumRentCstBurden_65Over_&year / RentCostBurdenDenom_&year;

		ShrOwnCstBurden_15_24_&year = NumOwnCstBurden_15_24_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_25_34_&year = NumOwnCstBurden_25_34_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_35_64_&year = NumOwnCstBurden_35_64_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_65Over_&year = NumOwnCstBurden_65Over_&year / OwnerCostBurdenDenom_&year;

		ShrRentCstBurden_LT10K_&year = NumRentCstBurden_LT10K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_10_19K_&year = NumRentCstBurden_10_19K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_20_35K_&year = NumRentCstBurden_20_35K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_35_50K_&year = NumRentCstBurden_35_50K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_50_75K_&year = NumRentCstBurden_50_75K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_75_100_&year = NumRentCstBurden_75_100_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_GT100K_&year = NumRentCstBurden_GT100K_&year / RentCostBurdenDenom_&year;

		ShrOwnCstBurden_LT10K_&year = NumOwnCstBurden_LT10K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_10_19K_&year = NumOwnCstBurden_10_19K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_20_35K_&year = NumOwnCstBurden_20_35K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_35_50K_&year = NumOwnCstBurden_35_50K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_50_75K_&year = NumOwnCstBurden_50_75K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_75_100_&year = NumOwnCstBurden_75_100_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_100_149_&year = NumOwnCstBurden_100_149_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_GT150K_&year = NumOwnCstBurden_GT150K_&year / OwnerCostBurdenDenom_&year;

	/*Education*/
		ShrHS_&year = pop25andoverwhs_&year / pop25andoveryears_&year;
		ShrCol_&year = pop25andoverwcollege_&year / pop25andoveryears_&year;

	/*Race and ethnicity*/
		ShrWht_&year = popwhitenonhispbridge_&year / popwithrace_&year;
		ShrBlk_&year = popblacknonhispbridge_&year / popwithrace_&year;
		ShrHisp_&year = pophisp_&year / popwithrace_&year;
		ShrAsn_&year = popasianpinonhispbridge_&year / popwithrace_&year;
		ShrOth_&year = popotherracenonhispbridg_&year / popwithrace_&year;

run;

proc export data = ACS_ward outfile = "L:\Libraries\Bridgepk\Data\ACS_ward_pct.csv" dbms = csv replace;
run;


data ACS_ward_n 
	(keep= ward2012 pop16andoveryears_&year popincivlaborforce_&year
			personspovertydefined_&year pop25andoveryears_&year popwithrace_&year
			numrenteroccupiedhu_&year numowneroccupiedhu_&year 
			NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
			NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
			GrossRentLT100_499_&year GrossRent500_799_&year GrossRent800_899_&year 
			GrossRent900_999_&year GrossRent1000_1249_&year GrossRent1250_1499_&year 
			GrossRent1500_1999_&year GrossRent2000_2499_&year GrossRent2500_2999_&year 
			GrossRent3000_3499_&year GrossRentGT3500_&year 
			PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
			PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
			PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
			PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
			PopEmployedOther_&year PopEmployedPubAdmin_&year
			PopEmployedByOcc_&year PopEmployedMngmt_&year
			PopEmployedServ_&year PopEmployedSales_&year
			PopEmployedNatRes_&year PopEmployedProd_&year 
			NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
			NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
			NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
			NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
			NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
			NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
			NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
			NumRentCstBurden_GT100K_&year 
			NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
			NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
			NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
			NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
			PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
			PopEmployedTravel_&year PopEmployedTravel_LT5_&year
			PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
			PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
			PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
			PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
			PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
			PopEmployedTravel_GT90_&year);
	set ACS.acs_2011_15_dc_sum_tr_wd12 
	(keep= pop16andoveryears_&year 
			popincivlaborforce_&year personspovertydefined_&year 
			pop25andoveryears_&year popwithrace_&year 
			numrenteroccupiedhu_&year numowneroccupiedhu_&year 
			GrossRentLT100_499_&year GrossRent500_799_&year GrossRent800_899_&year 
			GrossRent900_999_&year GrossRent1000_1249_&year GrossRent1250_1499_&year 
			GrossRent1500_1999_&year GrossRent2000_2499_&year GrossRent2500_2999_&year 
			GrossRent3000_3499_&year GrossRentGT3500_&year
			NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
			NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
			PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
			PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
			PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
			PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
			PopEmployedOther_&year PopEmployedPubAdmin_&year
			PopEmployedByOcc_&year PopEmployedMngmt_&year
			PopEmployedServ_&year PopEmployedSales_&year
			PopEmployedNatRes_&year PopEmployedProd_&year
			NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
			NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
			NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
			NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
			NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
			NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
			NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
			NumRentCstBurden_GT100K_&year 
			NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
			NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
			NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
			NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
			PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
			PopEmployedTravel_&year PopEmployedTravel_LT5_&year
			PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
			PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
			PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
			PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
			PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
			PopEmployedTravel_GT90_&year
			ward2012);
run;

proc export data = ACS_ward_n outfile = "L:\Libraries\Bridgepk\Data\ACS_ward_n.csv" dbms = csv replace;
run;


** Pull ACS Estimates for BP Areas **;

data ACS_bpk 
	(keep= bridgepk ShrLaborForce_&year ShrEmpRate_&year ShrUnEmpRate_&year
	ShrPov_&year ShrHS_&year ShrCol_&year ShrWht_&year ShrBlk_&year ShrHisp_&year 
	ShrAsn_&year ShrOth_&year 
	ShrEmpMngmt_&year ShrEmpNatRes_&year ShrEmpProd_&year ShrEmpSales_&year ShrEmpServ_&year
	ShrEmpAgric_&year ShrEmpConstr_&year ShrEmpManuf_&year ShrEmpWhlsale_&year 
	ShrEmpRetail_&year ShrEmpTransprt_&year ShrEmpInfo_&year ShrEmpFinance_&year
	ShrEmpProfServ_&year ShrEmpEduction_&year ShrEmpArts_&year ShrEmpOther_&year
	ShrEmpPubAdmin_&year 
	ShrHomeownership_&year ShrRenterCostBurden_&year ShrRentSevereCostBurden_&year 
	ShrOwnerCostBurden_&year ShrOwnSevereCostBurden_&year
	ShrRentCstBurden_15_24_&year ShrRentCstBurden_25_34_&year 
	ShrRentCstBurden_35_64_&year ShrRentCstBurden_65Over_&year 
	ShrOwnCstBurden_15_24_&year ShrOwnCstBurden_25_34_&year 
	ShrOwnCstBurden_35_64_&year ShrOwnCstBurden_65Over_&year 
	ShrRentCstBurden_LT10K_&year ShrRentCstBurden_10_19K_&year 
	ShrRentCstBurden_20_34K_&year ShrRentCstBurden_35_49K_&year 
	ShrRentCstBurden_50_74K_&year ShrRentCstBurden_75_99_&year 
	ShrRentCstBurden_GT100K_&year 
	ShrOwnCstBurden_LT10K_&year ShrOwnCstBurden_10_19K_&year 
	ShrOwnCstBurden_20_34K_&year ShrOwnCstBurden_35_49K_&year 
	ShrOwnCstBurden_50_74K_&year ShrOwnCstBurden_75_99_&year 
	ShrOwnCstBurden_100_149_&year ShrOwnCstBurden_GT150K_&year 
	ShrEmployedWorkInState_&year ShrEmployedWorkOutState_&year
	ShrEmployedTravel_&year ShrEmployedTravel_LT5_&year
	ShrEmployedTravel_5_9_&year ShrEmployedTravel_10_14_&year
	ShrEmployedTravel_15_19_&year ShrEmployedTravel_20_24_&year 
	ShrEmployedTravel_25_29_&year ShrEmployedTravel_30_34_&year 
	ShrEmployedTravel_35_39_&year ShrEmployedTravel_40_44_&year 
	ShrEmployedTravel_45_59_&year ShrEmployedTravel_60_89_&year 
	ShrEmployedTravel_GT90_&year
	);

	set ACS.acs_2011_15_dc_sum_tr_bpk 
	(keep= popincivlaborforce_&year
	pop16andoveryears_&year popcivilianemployed_&year popunemployed_&year 
	poppoorpersons_&year personspovertydefined_&year popwithrace_&year 
	popwhitenonhispbridge_&year popblacknonhispbridge_&year pophisp_&year 
	popasianpinonhispbridge_&year popotherracenonhispbridg_&year 
	pop25andoveryears_&year pop25andoverwhs_&year pop25andoverwcollege_&year 
	popemployedmngmt_&year popemployednatres_&year popemployedprod_&year 
	popemployedsales_&year popemployedserv_&year popemployedbyocc_&year
	numrenteroccupiedhu_&year numowneroccupiedhu_&year numoccupiedhsgunits_&year 
	RentCostBurdenDenom_&year OwnerCostBurdenDenom_&year
	NumRenterCostBurden_&year NumRentSevereCostBurden_&year NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
	PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
	PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
	PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
	PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
	PopEmployedOther_&year PopEmployedPubAdmin_&year
	PopEmployedByOcc_&year PopEmployedMngmt_&year
	PopEmployedServ_&year PopEmployedSales_&year
	PopEmployedNatRes_&year PopEmployedProd_&year 
	NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
	NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
	NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
	NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
	NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
	NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
	NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
	NumRentCstBurden_GT100K_&year 
	NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
	NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
	NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
	NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
	PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
	PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
	PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
	PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
	PopEmployedOther_&year PopEmployedPubAdmin_&year
	PopEmployedByOcc_&year PopEmployedMngmt_&year
	PopEmployedServ_&year PopEmployedSales_&year
	PopEmployedNatRes_&year PopEmployedProd_&year 
	PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
	PopEmployedTravel_&year PopEmployedTravel_LT5_&year
	PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
	PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
	PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
	PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
	PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
	PopEmployedTravel_GT90_&year bridgepk );

	/*Labor force, employment, and poverty*/
		ShrLaborForce_&year = popincivlaborforce_&year / pop16andoveryears_&year;
		ShrEmpRate_&year = popcivilianemployed_&year / popincivlaborforce_&year;
		ShrUnEmpRate_&year = popunemployed_&year / popincivlaborforce_&year;
		ShrPov_&year = poppoorpersons_&year / personspovertydefined_&year;

	/*Employment by major occupations*/
		ShrEmpMngmt_&year = popemployedmngmt_&year / popemployedbyocc_&year;
		ShrEmpNatRes_&year = popemployednatres_&year / popemployedbyocc_&year;
		ShrEmpProd_&year = popemployedprod_&year / popemployedbyocc_&year;
		ShrEmpSales_&year = popemployedsales_&year / popemployedbyocc_&year;
		ShrEmpServ_&year = popemployedserv_&year / popemployedbyocc_&year;

	/*Employment by major industries*/
		ShrEmpAgric_&year = PopEmployedAgric_&year / popemployedbyind_&year;
		ShrEmpConstr_&year = PopEmployedConstr_&year / popemployedbyind_&year;
		ShrEmpManuf_&year = PopEmployedManuf_&year / popemployedbyind_&year;
		ShrEmpWhlsale_&year = PopEmployedWhlsale_&year / popemployedbyind_&year;
		ShrEmpRetail_&year = PopEmployedRetail_&year / popemployedbyind_&year;
		ShrEmpTransprt_&year = PopEmployedTransprt_&year / popemployedbyind_&year;
		ShrEmpInfo_&year = PopEmployedInfo_&year / popemployedbyind_&year;
		ShrEmpFinance_&year = PopEmployedFinance_&year / popemployedbyind_&year;
		ShrEmpProfServ_&year = PopEmployedProfServ_&year / popemployedbyind_&year;
		ShrEmpEduction_&year = PopEmployedEduction_&year / popemployedbyind_&year;
		ShrEmpArts_&year = PopEmployedArts_&year / popemployedbyind_&year;
		ShrEmpOther_&year = PopEmployedOther_&year / popemployedbyind_&year;
		ShrEmpPubAdmin_&year = PopEmployedPubAdmin_&year / popemployedbyind_&year;

	/*Employment by place of work*/

		ShrEmployedWorkInState_&year = PopEmployedWorkInState_&year / PopEmployedWorkers_&year;
		ShrEmployedWorkOutState_&year = PopEmployedWorkOutState_&year / PopEmployedWorkers_&year;

	/*Employment by travel time to work*/

		ShrEmployedTravel_LT5_&year = PopEmployedTravel_LT5_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_5_9_&year = PopEmployedTravel_5_9_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_10_14_&year = PopEmployedTravel_10_14_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_15_19_&year = PopEmployedTravel_15_19_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_20_24_&year = PopEmployedTravel_20_24_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_25_29_&year = PopEmployedTravel_25_29_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_30_34_&year = PopEmployedTravel_30_34_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_35_39_&year = PopEmployedTravel_35_39_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_40_44_&year = PopEmployedTravel_40_44_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_45_59_&year = PopEmployedTravel_45_59_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_60_89_&year = PopEmployedTravel_60_89_&year / PopEmployedTravel_&year;
		ShrEmployedTravel_GT90_&year = PopEmployedTravel_GT90_&year / PopEmployedTravel_&year;

	/*Homeownership, rent, and cost burden by age of householder and household income*/
		ShrHomeownership_&year = numowneroccupiedhu_&year / numoccupiedhsgunits_&year;
		ShrRenterCostBurden_&year = NumRenterCostBurden_&year/RentCostBurdenDenom_&year;
		ShrRentSevereCostBurden_&year = NumRentSevereCostBurden_&year/RentCostBurdenDenom_&year;
		ShrOwnerCostBurden_&year = NumOwnerCostBurden_&year/OwnerCostBurdenDenom_&year;
		ShrOwnSevereCostBurden_&year = NumOwnSevereCostBurden_&year/OwnerCostBurdenDenom_&year;

		ShrRentCstBurden_15_24_&year = NumRentCstBurden_15_24_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_25_34_&year = NumRentCstBurden_25_34_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_35_64_&year = NumRentCstBurden_35_64_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_65Over_&year = NumRentCstBurden_65Over_&year / RentCostBurdenDenom_&year;

		ShrOwnCstBurden_15_24_&year = NumOwnCstBurden_15_24_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_25_34_&year = NumOwnCstBurden_25_34_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_35_64_&year = NumOwnCstBurden_35_64_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_65Over_&year = NumOwnCstBurden_65Over_&year / OwnerCostBurdenDenom_&year;

		ShrRentCstBurden_LT10K_&year = NumRentCstBurden_LT10K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_10_19K_&year = NumRentCstBurden_10_19K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_20_35K_&year = NumRentCstBurden_20_35K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_35_50K_&year = NumRentCstBurden_35_50K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_50_75K_&year = NumRentCstBurden_50_75K_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_75_100_&year = NumRentCstBurden_75_100_&year / RentCostBurdenDenom_&year;
		ShrRentCstBurden_GT100K_&year = NumRentCstBurden_GT100K_&year / RentCostBurdenDenom_&year;

		ShrOwnCstBurden_LT10K_&year = NumOwnCstBurden_LT10K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_10_19K_&year = NumOwnCstBurden_10_19K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_20_35K_&year = NumOwnCstBurden_20_35K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_35_50K_&year = NumOwnCstBurden_35_50K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_50_75K_&year = NumOwnCstBurden_50_75K_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_75_100_&year = NumOwnCstBurden_75_100_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_100_149_&year = NumOwnCstBurden_100_149_&year / OwnerCostBurdenDenom_&year;
		ShrOwnCstBurden_GT150K_&year = NumOwnCstBurden_GT150K_&year / OwnerCostBurdenDenom_&year;

	/*Education*/
		ShrHS_&year = pop25andoverwhs_&year / pop25andoveryears_&year;
		ShrCol_&year = pop25andoverwcollege_&year / pop25andoveryears_&year;

	/*Race and ethnicity*/
		ShrWht_&year = popwhitenonhispbridge_&year / popwithrace_&year;
		ShrBlk_&year = popblacknonhispbridge_&year / popwithrace_&year;
		ShrHisp_&year = pophisp_&year / popwithrace_&year;
		ShrAsn_&year = popasianpinonhispbridge_&year / popwithrace_&year;
		ShrOth_&year = popotherracenonhispbridg_&year / popwithrace_&year;

run;

proc export data = ACS_bpk outfile = "L:\Libraries\Bridgepk\Data\ACS_bpk_pct.csv" dbms = csv replace;
run;

data ACS_bpk_n 
	(keep= bridgepk pop16andoveryears_&year popincivlaborforce_&year
			personspovertydefined_&year pop25andoveryears_&year popwithrace_&year
			numrenteroccupiedhu_&year numowneroccupiedhu_&year 
			NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
			NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
			GrossRentLT100_499_&year GrossRent500_799_&year GrossRent800_899_&year 
			GrossRent900_999_&year GrossRent1000_1249_&year GrossRent1250_1499_&year 
			GrossRent1500_1999_&year GrossRent2000_2499_&year GrossRent2500_2999_&year 
			GrossRent3000_3499_&year GrossRentGT3500_&year 
			PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
			PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
			PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
			PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
			PopEmployedOther_&year PopEmployedPubAdmin_&year
			PopEmployedByOcc_&year PopEmployedMngmt_&year
			PopEmployedServ_&year PopEmployedSales_&year
			PopEmployedNatRes_&year PopEmployedProd_&year
			NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
			NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
			NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
			NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
			NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
			NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
			NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
			NumRentCstBurden_GT100K_&year 
			NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
			NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
			NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
			NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
			PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
			PopEmployedTravel_&year PopEmployedTravel_LT5_&year
			PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
			PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
			PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
			PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
			PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
			PopEmployedTravel_GT90_&year);
	set ACS.acs_2011_15_dc_sum_tr_bpk 
	(keep= pop16andoveryears_&year 
			popincivlaborforce_&year personspovertydefined_&year 
			pop25andoveryears_&year popwithrace_&year 
			numrenteroccupiedhu_&year numowneroccupiedhu_&year 
			GrossRentLT100_499_&year GrossRent500_799_&year GrossRent800_899_&year 
			GrossRent900_999_&year GrossRent1000_1249_&year GrossRent1250_1499_&year 
			GrossRent1500_1999_&year GrossRent2000_2499_&year GrossRent2500_2999_&year 
			GrossRent3000_3499_&year GrossRentGT3500_&year
			NumRenterCostBurden_&year NumRentSevereCostBurden_&year 
			NumOwnerCostBurden_&year NumOwnSevereCostBurden_&year
			PopEmployedByInd_&year PopEmployedAgric_&year PopEmployedConstr_&year 
			PopEmployedManuf_&year PopEmployedWhlsale_&year PopEmployedRetail_&year 
			PopEmployedTransprt_&year PopEmployedInfo_&year PopEmployedFinance_&year 
			PopEmployedProfServ_&year PopEmployedEduction_&year PopEmployedArts_&year 
			PopEmployedOther_&year PopEmployedPubAdmin_&year
			PopEmployedByOcc_&year PopEmployedMngmt_&year
			PopEmployedServ_&year PopEmployedSales_&year
			PopEmployedNatRes_&year PopEmployedProd_&year
			NumRentCstBurden_15_24_&year NumRentCstBurden_25_34_&year 
			NumRentCstBurden_35_64_&year NumRentCstBurden_65Over_&year 
			NumOwnCstBurden_15_24_&year NumOwnCstBurden_25_34_&year 
			NumOwnCstBurden_35_64_&year NumOwnCstBurden_65Over_&year 
			NumRentCstBurden_LT10K_&year NumRentCstBurden_10_19K_&year 
			NumRentCstBurden_20_34K_&year NumRentCstBurden_35_49K_&year 
			NumRentCstBurden_50_74K_&year NumRentCstBurden_75_99_&year 
			NumRentCstBurden_GT100K_&year 
			NumOwnCstBurden_LT10K_&year NumOwnCstBurden_10_19K_&year 
			NumOwnCstBurden_20_34K_&year NumOwnCstBurden_35_49K_&year 
			NumOwnCstBurden_50_74K_&year NumOwnCstBurden_75_99_&year 
			NumOwnCstBurden_100_149_&year NumOwnCstBurden_GT150K_&year 
			PopEmployedWorkers_&year PopEmployedWorkInState_&year PopEmployedWorkOutState_&year
			PopEmployedTravel_&year PopEmployedTravel_LT5_&year
			PopEmployedTravel_5_9_&year PopEmployedTravel_10_14_&year
			PopEmployedTravel_15_19_&year PopEmployedTravel_20_24_&year 
			PopEmployedTravel_25_29_&year PopEmployedTravel_30_34_&year 
			PopEmployedTravel_35_39_&year PopEmployedTravel_40_44_&year 
			PopEmployedTravel_45_59_&year PopEmployedTravel_60_89_&year 
			PopEmployedTravel_GT90_&year
			bridgepk);
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
property_crime_rate_2014 property_crime_rate_2015 property_crime_rate_2016);
set Police.Crimes_sum_city (keep= crimes_pt1_property_2000 crimes_pt1_property_2001 
crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
crimes_pt1_property_2014 crimes_pt1_property_2015 crimes_pt1_property_2016 
crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
crime_rate_pop_2016 city);

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

run;

proc export data = Crime_prop_stats_city outfile = "L:\Libraries\Bridgepk\Data\Crime_prop_stats_city.csv" dbms = csv replace;
run;

data Crime_viol_stats_city (keep= city violent_crime_rate_2000 violent_crime_rate_2001 
violent_crime_rate_2002 violent_crime_rate_2003 violent_crime_rate_2004 
violent_crime_rate_2005 violent_crime_rate_2006 violent_crime_rate_2007 
violent_crime_rate_2008 violent_crime_rate_2009 violent_crime_rate_2010 
violent_crime_rate_2011 violent_crime_rate_2012 violent_crime_rate_2013 
violent_crime_rate_2014 violent_crime_rate_2015 violent_crime_rate_2016);
set Police.Crimes_sum_city (keep= crimes_pt1_violent_2000 crimes_pt1_violent_2001 
crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
crimes_pt1_violent_2014 crimes_pt1_violent_2015 crimes_pt1_violent_2016 
crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
crime_rate_pop_2016 city);

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

proc export data = Crime_viol_stats_city outfile = "L:\Libraries\Bridgepk\Data\Crime_viol_stats_city.csv" dbms = csv replace;
run;

** Pull Crime Stats for BP Area **;
data Crime_prop_stats_bpk (keep= bridgepk property_crime_rate_2000 property_crime_rate_2001
property_crime_rate_2002 property_crime_rate_2003 property_crime_rate_2004 
property_crime_rate_2005 property_crime_rate_2006 property_crime_rate_2007 
property_crime_rate_2008 property_crime_rate_2009 property_crime_rate_2010
property_crime_rate_2011 property_crime_rate_2012 property_crime_rate_2013
property_crime_rate_2014 property_crime_rate_2015 property_crime_rate_2016);
set Police.Crimes_sum_bpk (keep= crimes_pt1_property_2000 crimes_pt1_property_2001 
crimes_pt1_property_2002 crimes_pt1_property_2003 crimes_pt1_property_2004 
crimes_pt1_property_2005 crimes_pt1_property_2006 crimes_pt1_property_2007 
crimes_pt1_property_2008 crimes_pt1_property_2009 crimes_pt1_property_2010
crimes_pt1_property_2011 crimes_pt1_property_2012 crimes_pt1_property_2013
crimes_pt1_property_2014 crimes_pt1_property_2015 crimes_pt1_property_2016 
crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
crime_rate_pop_2016 bridgepk);

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

run;

proc export data = Crime_prop_stats_bpk outfile = "L:\Libraries\Bridgepk\Data\Crime_prop_stats_bpk.csv" dbms = csv replace;
run;

data Crime_viol_stats_bpk (keep= bridgepk violent_crime_rate_2000 violent_crime_rate_2001 
violent_crime_rate_2002 violent_crime_rate_2003 violent_crime_rate_2004 
violent_crime_rate_2005 violent_crime_rate_2006 violent_crime_rate_2007 
violent_crime_rate_2008 violent_crime_rate_2009 violent_crime_rate_2010 
violent_crime_rate_2011 violent_crime_rate_2012 violent_crime_rate_2013 
violent_crime_rate_2014 violent_crime_rate_2015 violent_crime_rate_2016);
set Police.Crimes_sum_bpk (keep= crimes_pt1_violent_2000 crimes_pt1_violent_2001 
crimes_pt1_violent_2002 crimes_pt1_violent_2003 crimes_pt1_violent_2004 
crimes_pt1_violent_2005 crimes_pt1_violent_2006 crimes_pt1_violent_2007 
crimes_pt1_violent_2008 crimes_pt1_violent_2009 crimes_pt1_violent_2010 
crimes_pt1_violent_2011 crimes_pt1_violent_2012 crimes_pt1_violent_2013 
crimes_pt1_violent_2014 crimes_pt1_violent_2015 crimes_pt1_violent_2016 
crime_rate_pop_2000 crime_rate_pop_2001 crime_rate_pop_2002 crime_rate_pop_2003 
crime_rate_pop_2004 crime_rate_pop_2005 crime_rate_pop_2006 crime_rate_pop_2007 
crime_rate_pop_2008 crime_rate_pop_2009 crime_rate_pop_2010 crime_rate_pop_2011 
crime_rate_pop_2012 crime_rate_pop_2013 crime_rate_pop_2014 crime_rate_pop_2015 
crime_rate_pop_2016 bridgepk);

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
