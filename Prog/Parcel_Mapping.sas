/**************************************************************************
 Program:  BridgePk_Parcels.sas
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

** Load DC Open Parcel and Ownership data**;

data common_lots;

	set BridgePk.Comm_Lots_Zone (keep = ssl usecode landarea premiseadd unitnumber ownername careofname); 


proc sort 
	data = common_lots out = common_lots;
	by SSL;
run;

data dc_owned;

	length ssl $17;
	set BridgePk.District_Government_Land;
	keep objectid address_id ownership_ building_u use_code use_descri leased agency ssl source address;

run;

proc sort 
	data = dc_owned out = dc_owned;
	by SSL;
run;

**Load Real Property Parcel Base, Geograhpy, Ownership, and Cama Data**;

data base;
	
	set RealProp.Parcel_Base;
	by SSL;

run;


proc sort 
	data = RealProp.Parcel_Geo out = geo;
	by SSL;
run;


data who_owns;

	set RealProp.Parcel_Base_Who_Owns (drop=premiseadd mix1txtype mix2txtype);
	by SSL;

run;


data cama_res;

	length ssl $17;
	set realprop.camarespt_2017_08;

run;

proc sort data = cama_res;

	by ssl;

run;

data cama_comm;

	length ssl $17;
	set realprop.camacommpt_2017_08 (rename = extwall = extwalltype);

run;

proc sort data = cama_comm;

	by ssl;

run;

data cama_cond;

	length ssl $17;
	set realprop.camacondpt_2017_08;

run;

proc sort data = cama_cond;

	by ssl;

run;

data cama_full;

	set cama_res cama_comm cama_cond;
	by ssl;

run;

**Load DHCD data on Rent Controlled Properties**;

data rent_control;

	set DHCD.parcels_rent_control;
	keep SSL exempt_govowned excluded_foreign rent_controlled_2011 rent_controlled Receive_exempt;
	by SSL;

run;

/*merge bridge_parcels;
	
	set common_lots dc_owned geo who_owns rent_control cama_full;
	by ssl;

run;*/
** Pull in Project ID from Parcel Data Set **;


data parcel_id;

	set PresCat.parcel (keep = NLIHC_ID SSL);

run;

/*data subsidized;

	merge parcel_id prescat.parcel_subsidy;
	by ssl;

run;*/


/*proc sort data = parcel_id;

	by nlihc_id;

run;*/

**Merge Project ID with Subsidy data**;

data subsidized;

	merge parcel_id prescat.project(keep = nlihc_id proj_name Subsidy_Start_First Subsidy_End_First Subsidy_Start_Last Subsidy_End_Last);
	by nlihc_id;

run;

/*proc sort data = subsidized;
	
	by ssl;

run;*/


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

** Merge parcel, geography, ownership, rent control, cama, and subsidy data by SSL **;

data parcel_geo_owns;

	merge common_lots (keep = SSL premiseadd) base geo who_owns dc_owned rent_control cama_full (rename=(usecode=usecode_cama)) subsidized;
	by SSL;

run;

** Add bridge park geography**;

data parcel_geo_owns;

	set parcel_geo_owns;
	%block10_to_bpk( );

run;


%Finalize_data_set( 
  data=parcel_geo_owns,
  out=parcel_geo_owns,
  outlib=BridgePk,
  label=Bridge Park parcel map,
  sortby=ssl,
  revisions=%str(New file.)
)


proc print data = parcel_geo_owns;

where not missing (Sub_all_proj);

id ssl;

var nlihc_id;

run;


** Create a test merge using full DC Parcel data to check unmatched parcels **;

data parcel_geo_owns_test;

	merge common_lots /*base*/ geo who_owns dc_owned;
	by SSL;

run;

data parcel_geo_owns_test;

	set parcel_geo_owns_test;
	%block10_to_bpk( );

run;

  proc print data= parcel_geo_owns_test n='Total unmatched = ';
    where missing( ward2012 );
    id SSL ;
    var address premiseadd /*condolot*/ ownercat;
    title2 "**** UNMATCHED PARCELS (MISSING GEOGRAPHY) ****";
  run;

