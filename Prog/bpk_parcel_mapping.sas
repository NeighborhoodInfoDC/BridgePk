/**************************************************************************
 Program:  bpk_parcel_mapping.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   M. Cohen
 Created:  7/13/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Merges DC Open Data on Parcels with Real Property, DHCD, and PresCat data, and adds a Bridge Park Specific geography variable.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( RealProp )
%DCData_lib( BridgePk )
%DCData_lib( DHCD )
%DCData_lib( PresCat )
%DCData_lib( Mar )

** Load DC Open Data Parcel and Ownership data**;

data common_lots;
	length ssl $17;
	set BridgePk.Comm_Lots_Zone (keep = ssl usecode landarea premiseadd unitnumber ownername oldland oldimpr oldtotal newland
	newimpr newtotal mix: coopunits saleprice saledate assessment annualtax gis_id shapearea shapelen zoning_web zoning_sta
	zoning_lab zone_descr); 

run;

data dc_owned;

	length ssl $17;
	set BridgePk.District_Government_Land (keep = ownership_ building_u agency ssl comment_);

run;

/*options spool;

%Dc_mar_geocode(
  data=common_lots,
out=common_lots_geo,
  staddr=premiseadd,
)*/

** Sort DC Open Parcel and Ownership data by SSL**;

proc sort 
	data = common_lots /*nodupkey*/ out = common_lots;
	by SSL;
run;

proc sort 
	data = dc_owned out = dc_owned;
	by SSL;
run;

**Load Real Property Parcel Base, Geography, and Ownership Data**;

data base;
	
	set RealProp.Parcel_Base (keep = ssl ui_proptype streetname lownumber careofname);
	base_ssl = ssl;
run;

data who_owns;

	set RealProp.Parcel_Base_Who_Owns (keep = ssl hstd_code ownername_full ownercat);
run;

**Sort Real Property Parcel Geography Data by SSL**;
proc sort 
	data = RealProp.Parcel_Geo out = geo;
	by SSL;
run;

proc sort 
	data = who_owns;
	by SSL;
run;

proc sort 
	data = base;
	by SSL;
run;

**Load Cama Data, Merge Residential Commercial and Condo in Full Data Set**;

data cama_res;

	set realprop.camarespt_2017_08;
	res = 1;

run;

data cama_comm;

	set realprop.camacommpt_2017_08 (rename = extwall = extwalltype);
	comm = 1;

run;

data cama_cond;

	set realprop.camacondpt_2017_08;
	cond = 1;

run;



**Sort Cama Data by SSL and Merge**;
proc sort data = cama_res;

	by ssl;

run;

proc sort data = cama_comm;

	by ssl;

run;

proc sort data = cama_cond;

	by ssl;

run;

data cama_full;

	set cama_res cama_comm cama_cond;
	by ssl;

run;

%Dup_check( data = cama_full, by = ssl , id = objectid res cond comm)

** Load PADD data Should be replaced with PADD SAS data set when available**;

filename fimport "L:\Libraries\DHCD\Raw\PADD_Property_Sites_Geocode.csv" lrecl=2000;

proc import out=PADD
    datafile=fimport
    dbms=csv replace;
  datarow=2;
  getnames=yes;
  guessingrows=500;

run;

filename fimport clear;

data Padd_sites;
	
	set Padd;
	padd = 1;
	keep ssl property_site status developer disposition_method report_milestone property_type source 
		construction_completion__project closing__projected_or_actual_dat padd;

run;

proc sort data = padd_sites;
	by ssl;
run;

**Load DHCD data on Rent Controlled Properties**;

data rent_control;

	set DHCD.parcels_rent_control;
	keep SSL rent_controlled_2011 rent_controlled Receive_exempt;
	by SSL;

run;

** Pull in Project ID from Parcel Data Set **;


data parcel_id;

	set PresCat.parcel (keep = NLIHC_ID SSL);

run;


**Merge Project ID with Subsidy data**;

data subsidized;

	merge parcel_id prescat.project(keep = nlihc_id proj_name Subsidy_Start_First Subsidy_End_First Subsidy_Start_Last Subsidy_End_Last);
	by nlihc_id;

run;

data portfolio;

  set PresCat.Subsidy
    (keep=nlihc_id Portfolio Subsidy_Active Units_assist
     where=(Subsidy_Active));
  
  Sub_all_proj = 1;
  Sub_all_units = Units_assist;
  
  select ( Portfolio );
    when ( "CDBG" ) do; 
      Sub_CDBG_proj = 1;
      Sub_CDBG_units = Units_assist;
    end;

    when ( "DC HPTF" ) do; 
      Sub_HPTF_proj = 1;
      Sub_HPTF_units = Units_assist;
    end;

    when ( "HOME" ) do; 
      Sub_HOME_proj = 1;
      Sub_HOME_units = Units_assist;
    end;

    when ( "LIHTC" ) do; 
      Sub_LIHTC_proj = 1;
      Sub_LIHTC_units = Units_assist;
    end;

    when ( "MCKINNEY" ) do; 
      Sub_McKinney_proj = 1;
      Sub_McKinney_units = Units_assist;
    end;

    when ( "PBV", "HUDMORT", "HOPE VI", "FHLB" ) do; 
      Sub_Other_proj = 1;
      Sub_Other_units = Units_assist;
    end;

    when ( "PRAC" ) do; 
      Sub_ProjectBased_proj = 1;
      Sub_ProjectBased_units = Units_assist;
    end;

    when ( "PB8" ) do;
      Sub_ProjectBased_proj = 1;
      Sub_ProjectBased_units = Units_assist;
    end;

    when ( "PUBHSNG" ) do; 
      Sub_PublicHsng_proj = 1;
      Sub_PublicHsng_units = Units_assist;
      end;

    when ( "202/811" ) do;
      Sub_ProjectBased_proj = 1;
      Sub_ProjectBased_units = Units_assist;
    end;

    when ( "TEBOND" ) do; 
      Sub_TEBond_proj = 1;
      Sub_TEBond_units = Units_assist;
      end;

    otherwise do;
      %err_put( msg='Subsidy not found: ' Nlihc_id= Portfolio= )
    end;
    
  end;

  array Sub{*} Sub_: ;
  
  do i = 1 to dim( Sub );
    if Sub{i} = . then Sub{i} = 0;
  end;
  
  label
    Sub_all_proj = 'Any assisted project'
    Sub_CDBG_proj = 'CDBG project'
    Sub_HOME_proj = 'HOME project'
    Sub_HPTF_proj = 'DC Housing Production Trust Fund project'
    Sub_LIHTC_proj = 'Low-Income Housing Tax Credit project'
    Sub_McKinney_proj = 'McKinney Vento loan project'
    Sub_Other_proj = 'Other subsidy project'
    Sub_ProjectBased_proj = 'Federal project-based assistance project'
    Sub_PublicHsng_proj = 'Public housing project'
    Sub_TEBond_proj = 'Tax-exempt bond project'
    Sub_all_units = 'All assisted units'
    Sub_CDBG_units = 'CDBG assisted units'
    Sub_HOME_units = 'HOME assisted units'
    Sub_HPTF_units = 'DC Housing Production Trust Fund assisted units'
    Sub_LIHTC_units = 'Low-Income Housing Tax Credit assisted units'
    Sub_McKinney_units = 'McKinney Vento loan assisted units'
    Sub_Other_units = 'Other subsidy assisted units'
    Sub_ProjectBased_units = 'Federal project-based assistance assisted units'
    Sub_PublicHsng_units = 'Public housing assisted units'
    Sub_TEBond_units = 'Tax-exempt bond units';
  
  drop i;
  
run;

proc summary data=portfolio nway;
  class nlihc_id;
  var 
    Sub_all_proj
    Sub_CDBG_proj Sub_HOME_proj Sub_HPTF_proj Sub_LIHTC_proj
    Sub_McKinney_proj Sub_Other_proj Sub_ProjectBased_proj
    Sub_PublicHsng_proj Sub_TEBond_proj
    Sub_all_units
    Sub_CDBG_units Sub_HOME_units Sub_HPTF_units Sub_LIHTC_units
    Sub_McKinney_units Sub_Other_units Sub_ProjectBased_units
    Sub_PublicHsng_units Sub_TEBond_units;
  output out=portfolio_agg 
    max( 
      Sub_all_proj
      Sub_CDBG_proj Sub_HOME_proj Sub_HPTF_proj Sub_LIHTC_proj
      Sub_McKinney_proj Sub_Other_proj Sub_ProjectBased_proj
      Sub_PublicHsng_proj Sub_TEBond_proj
      Sub_all_units
      Sub_CDBG_units Sub_HOME_units Sub_HPTF_units Sub_LIHTC_units
      Sub_McKinney_units Sub_Other_units Sub_ProjectBased_units
      Sub_PublicHsng_units Sub_TEBond_units 
    )=
    ;
run;


data subsidized;

	merge subsidized portfolio_agg;
	by nlihc_id;

run;


proc sort data = subsidized;

	by ssl;

run;

** Read in vacant and blight data sets **;

filename fimport "L:\Libraries\DCRA\raw\Vacant Buildings as of February 7 2018.csv" lrecl=2000;

data vac    ;
	%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
	infile FIMPORT delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
	informat WARD $1. ;
	informat STREET_NUMBER $6. ;
	informat STREET_NAME $17. ;
	informat STREET_TYPE $11. ;
	informat QUADRANT $2. ;
	informat SQUARE_SUFFIX_LOT $17. ;
	informat VAR7 $8. ;
	format WARD $1. ;
	format STREET_NUMBER $13. ;
	format STREET_NAME $17. ;
	format STREET_TYPE $11. ;
	format QUADRANT $9. ;
	format SQUARE_SUFFIX_LOT $17. ;
	format VAR7 $8. ;
		input
			WARD $
			STREET_NUMBER $
			STREET_NAME $
			STREET_TYPE $
			QUADRANT $
			SQUARE_SUFFIX_LOT $
			VAR7 $
			;
	if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;

filename fimport clear;

data vac;
	set vac;
	if street_name = "STREET NAME" then delete;
	if street_name = "Street Name" then delete;
	lot = put(input(var7,best4.),z4.);
	vacant = 1;

	if index( SQUARE_SUFFIX_LOT, "PAR" ) = 0 and index( SQUARE_SUFFIX_LOT, "RES" ) = 0 and index( SQUARE_SUFFIX_LOT, "RT" ) = 0 then do;

		_i = indexc( SQUARE_SUFFIX_LOT, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
        
        if _i > 0 then do;
		  _suffix = substr( SQUARE_SUFFIX_LOT, _i, 2);
          *put _n_= DocumentNo= _i= SQUARE_SUFFIX_LOT= _suffix= ;
          square = compress( SQUARE_SUFFIX_LOT, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
		  _suffix = compress( _suffix, "1234567890" );
		  _square = cats (square,_suffix);
		  ssl = catx ('   ',_square,lot);
        end;
        else do;
		  square = put(input(SQUARE_SUFFIX_LOT,best4.),z4.);
		  _suffix = "";
		  ssl = catx ('    ',square,lot);
        end;
        
        *_nsquare = input( square, 8. );
        
        *if _nsquare > 0 then        
          square = trim( left( put( _nsquare, z4. ) ) ) || _suffix;
      
      end;
      else do;
        prefix = compress( SQUARE_SUFFIX_LOT, "0123456789" );
		_square_ = compress( SQUARE_SUFFIX_LOT, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
        _ssl = catx (' ',prefix,_square_);
		ssl = catx (' ',_ssl,var7);
      
      end;

drop _ssl _square prefix _square_ _i var7 SQUARE_SUFFIX_LOT square lot;
run;

filename fimport "L:\Libraries\DCRA\raw\Blighted Buildings as of February 7 2018.csv" lrecl=2000;

data blight    ;
	%let _EFIERR_ = 0; /* set the ERROR detection macro variable */
	infile FIMPORT delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
	informat WARD $1. ;
	informat STREET_NUMBER $6. ;
	informat STREET_NAME $17. ;
	informat STREET_TYPE $11. ;
	informat QUADRANT $2. ;
	informat SQUARE_SUFFIX_LOT $17. ;
	informat VAR7 $8. ;
	format WARD $1. ;
	format STREET_NUMBER $13. ;
	format STREET_NAME $17. ;
	format STREET_TYPE $11. ;
	format QUADRANT $9. ;
	format SQUARE_SUFFIX_LOT $17. ;
	format VAR7 $8. ;
		input
			WARD $
			STREET_NUMBER $
			STREET_NAME $
			STREET_TYPE $
			QUADRANT $
			SQUARE_SUFFIX_LOT $
			VAR7 $
			;
	if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;

filename fimport clear;

data blight;
	set blight;
	if street_name = "STREET NAME" then delete;
	if street_name = "Street Name" then delete;
	lot = put(input(var7,best4.),z4.);
    blight = 1;
    

	if index( SQUARE_SUFFIX_LOT, "PAR" ) = 0 and index( SQUARE_SUFFIX_LOT, "RES" ) = 0 and index( SQUARE_SUFFIX_LOT, "RT" ) = 0 then do;

		_i = indexc( SQUARE_SUFFIX_LOT, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
        
        if _i > 0 then do;
		  _suffix = substr( SQUARE_SUFFIX_LOT, _i, 2);
          *put _n_= DocumentNo= _i= SQUARE_SUFFIX_LOT= _suffix= ;
          square = compress( SQUARE_SUFFIX_LOT, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
		  _suffix = compress( _suffix, "1234567890" );
		  _square = cats (square,_suffix);
		  ssl = catx ('   ',_square,lot);
        end;
        else do;
		  square = put(input(SQUARE_SUFFIX_LOT,best4.),z4.);
		  _suffix = "";
		  ssl = catx ('    ',square,lot);
        end;
        
        *_nsquare = input( square, 8. );
        
        *if _nsquare > 0 then        
          square = trim( left( put( _nsquare, z4. ) ) ) || _suffix;
      
      end;
      else do;
        prefix = compress( SQUARE_SUFFIX_LOT, "0123456789" );
		_square_ = compress( SQUARE_SUFFIX_LOT, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
        _ssl = catx ('',prefix,_square_);
		ssl = cats (_ssl,lot);
      
      end;
drop _ssl _square prefix _square_ _i var7 SQUARE_SUFFIX_LOT square lot;
run;

proc sort data = blight;
by ssl;
run;

proc sort data = vac;
by ssl;
run;


** Merge parcel, geography, ownership, rent control, cama, and subsidy data by SSL **;

data parcel_combined;

	merge common_lots (in=a) base geo who_owns dc_owned rent_control cama_full (drop = saledate usecode landarea) subsidized padd_sites (keep = ssl padd) 
				vac (keep =ssl vacant) blight (keep = ssl blight);
	by SSL;
	if  a;

run;


**Match missing SSLs**;

data parcel_base_miss;

	set parcel_combined;
	where not missing( ssl ) and missing (base_ssl);

run;

data parcel_matched;

	set parcel_combined;
	where not missing( ssl ) and not missing (base_ssl);

run;

proc sort data = parcel_base_miss;
	by streetname lownumber;

run;

proc sort data = base;
	by streetname lownumber;

run;

data parcel_base_miss_clean;

	merge parcel_base_miss (in=a drop = base_ssl)  base (drop = ssl);
	by streetname lownumber;
	if a;

run;

proc sort data = parcel_base_miss_clean nodupkey;
	by base_ssl;
run;

data parcel_miss_clean;

	merge parcel_base_miss_clean (in=a) geo (rename =(ssl=base_ssl)) who_owns (rename =(ssl=base_ssl)) dc_owned (rename =(ssl=base_ssl)) rent_control (rename =(ssl=base_ssl)) 
			cama_full (rename =(ssl=base_ssl)) subsidized (rename=(ssl=base_ssl)) padd_sites (keep = ssl padd rename =(ssl=base_ssl)) vac (keep =ssl vacant rename =(ssl=base_ssl)) 
			blight (keep = ssl blight rename =(ssl=base_ssl));
	by base_ssl;
	if  a;
run;

proc sort data = parcel_miss_clean nodupkey;
	by ssl;
run;

data parcel_combined;
	set parcel_matched parcel_miss_clean;
run;


** Add bridge park geography**;

data parcel_combined;

	set parcel_combined;
	%block10_to_bpk( );

run;

%Finalize_data_set( 
  data=parcel_combined,
  out=parcel_combined_bridge,
  outlib=BridgePk,
  label="Bridge Park Parcel Data",
  sortby=ssl,
  revisions=%str(New file.)
)
