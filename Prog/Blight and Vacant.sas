/**************************************************************************
 Program:  Read_Vacant_Blight.sas
 Library:  BridgePk
 Project:  NeighborhoodInfo DC
 Author:   M. Cohen
 Created:  7/13/17
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Reads DCRA data on vacant and blighted properties

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( DCRA )
%DCData_lib( DHCD )
%DCData_lib( MAR )
libname bridge 'D:\Users\MCohen\Box Sync\MCohen\Bridge';
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

proc sort data = bridge.bridge_blog_map out =blog_map;
by ssl_1;
run;

data bridge_cfe_map;
	merge blog_map (rename=( ssl_1=ssl)) vac blight;
	by ssl;
run; 
