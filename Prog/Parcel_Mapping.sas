/**************************************************************************
 Program:  Parcel_Mapping.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   M. Cohen
 Created:  7/13/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Merges DC Open Data on Parcels with Real Property Geographies and Ownership Data.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( RealProp )
%DCData_lib( BridgePk )

** Load DC Parcel and District-owned Land Data**;

proc sort 
	data = BridgePk.Common_Owner_Polygon_Lots out = common_lots;
	by SSL;
run;

data dc_owned;

	length ssl $17;
	set BridgePk.District_Government_Land;
	keep objectid address_id ownership_ building_u use_code use_descri leased agency ssl source;

run;

proc sort 
	data = dc_owned out = dc_owned;
	by SSL;
run;

/*data base;
	
	set RealProp.Parcel_Base;
	by SSL;

run;*/

** Compile Real Property Data Files **;

data geo;

	set RealProp.Parcel_Geo;
	by SSL;

run;


data who_owns;

	set RealProp.Parcel_Base_Who_Owns (drop=premiseadd mix1txtype mix2txtype);
	by SSL;

run;

** Merge SSLs from DC Parcel data with Real Property Data. Will be joined with the DC Parcel Shapefile in ArcMap **;

data dc_parcel;

	merge common_lots (keep = SSL) /*base*/ geo who_owns dc_owned;
	by SSL;

run;

%Finalize_data_set( 
  data=dc_parcel,
  out=dc_parcel,
  outlib=BridgePk,
  label=Bridge Park parcel map,
  sortby=ssl,
  revisions=%str(New file.)
)



/*
data BridgePk.dc_parcel;

	set dc_parcel;
	%block10_to_bpk( );

run;
*/

** Create a test merge using full DC Parcel data to check unmatched parcels **;

data dc_parcel_test;

	merge common_lots /*base*/ geo who_owns dc_owned;
	by SSL;

run;

data dc_parcel_test;

	set dc_parcel_test;
	%block10_to_bpk( );

run;

  proc print data= dc_parcel_test n='Total unmatched = ';
    where missing( ward2012 );
    id SSL ;
    var Address1 condolot ownercat;
    title2 "**** UNMATCHED PARCELS (MISSING GEOGRAPHY) ****";
  run;

