PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

LIFT_UP     	=  	 1;		//PROJECTOR LIFT UP
LIFT_DOWN   	=  	 2;		//PROJECTOR LIFT DOWN
SCREEN_UP     =  	 3;		//SCREEN UP      
SCREEN_DOWN   =  	 4;		//SCREEN DOWN
CURTAIN_OUT_CLOSE =  	 5;		//CURTAIN OUTSIDE CLOSE
CURTAIN_OUT_OPEN	=  	 6;		//CURTAIN OUTSIDE OPEN
CURTAIN_IN_CLOSE 	=  	 7;		//CURTAIN INSIDE CLOSE
CURTAIN_IN_OPEN		=  	 8;		//CURTAIN INSIDE OPEN

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)


DEFINE_CALL 'Projector1_On'		//PROJECTOR ON
{
	 PULSE [dvProjLiftMainBedRm,LIFT_DOWN];
	 PULSE [dvScreenMainBedRm,SCREEN_DOWN];
	 SEND_COMMAND dvProjMainBedRm,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvProjMainBedRm, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 WAIT 50
	 SEND_STRING dvProjMainBedRm, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
}

DEFINE_CALL 'Projector1_Off'		//PROJECTOR OFF
{
	 PULSE [dvProjLiftMainBedRm,LIFT_UP];
	 PULSE [dvScreenMainBedRm,SCREEN_UP];
	 SEND_COMMAND dvProjMainBedRm,'SET BAUD,38400,E,8,1,DISABLE'		// SONY EX-100
	 WAIT 50
	 SEND_STRING dvProjMainBedRm, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		// OFF
}

DEFINE_CALL 'ProjectorCinema_On'		//PROJECTOR ON
{
		SEND_COMMAND dvProjCinemaRoom,'SET BAUD,19200,N,8,1,DISABLE'		// NERO 3D PROJECTOR CINEMA ROOM
	 WAIT 50
	 SEND_STRING dvProjCinemaRoom, "$BE,$EF,$02,$06,$00,$6B,$E6,$52,$01,$00,$00,$00,$00"		//ON
	 //SEND_STRING dvProjCinemaRoom, "$BE,$EF,$02,$06,$00,$6B,$E6,$52,$01,$00,$00,$00,$00"		//ON
	 WAIT 50
	 SEND_STRING dvProjCinemaRoom, "$BE,$EF,$02,$06,$00,$6B,$E6,$52,$01,$00,$00,$00,$00"		//ON
	 //SEND_STRING dvProjCinemaRoom, "$BE,$EF,$02,$06,$00,$6B,$E6,$52,$01,$00,$00,$00,$00"		//ON
}

DEFINE_CALL 'ProjectorCinema_Off'		//PROJECTOR OFF
{
	 SEND_COMMAND dvProjCinemaRoom,'SET BAUD,19200,N,8,1,DISABLE'		// NERO 3D PROJECTOR CINEMA ROOM
	 WAIT 50
	 SEND_STRING dvProjCinemaRoom, "$BE,$EF,$02,$06,$00,$51,$E4,$48,$01,$00,$00,$00,$00"		//OFF
	 //SEND_STRING dvProjCinemaRoom, "$BE,$EF,$02,$06,$00,$51,$E4,$48,$01,$00,$00,$00,$00"		//OFF
}

DEFINE_CALL 'XivaMainBedroom'		// Main Bedroom output S3000
{
	 SEND_COMMAND vdvXIVAModule,'SET-ZONE1=1';		// TP(1) Output1
	 SEND_COMMAND vdvXIVAModule,'SET-ZONE2=1';		// R4(2) Output1
}

DEFINE_CALL 'XivaBedroom1'		// Bedroom 1 output S3000
{
	 SEND_COMMAND vdvXIVAModule,'SET-ZONE1=2';		// TP(1) Output2
	 SEND_COMMAND vdvXIVAModule,'SET-ZONE2=2';		// R4(3) Output2
}

DEFINE_CALL 'XivaBedroom2'		// Bedroom 2 output S3000
{
	 SEND_COMMAND vdvXIVAModule,'SET-ZONE1=3';		// TP(1) Output3
	 SEND_COMMAND vdvXIVAModule,'SET-ZONE2=3';		// R4(4) Output3
}


DEFINE_CALL 'CurtainOutOpen'		//CURTAIN OUTSIDE OPEN
{
	 PULSE [dvCurtainOutMainBedRm,CURTAIN_OUT_OPEN];
}

DEFINE_CALL 'CurtainOutClose'		//CURTAIN OUTSIDE CLOSE
{
	 PULSE [dvCurtainOutMainBedRm,CURTAIN_OUT_CLOSE];
}

DEFINE_CALL 'CurtainInOpen'		//CURTAIN INSIDE OPEN
{
	 PULSE [dvCurtainInMainBedRm,CURTAIN_IN_OPEN];
}

DEFINE_CALL 'CurtainInClose'		//CURTAIN INSIDE CLOSE
{
	 PULSE [dvCurtainInMainBedRm,CURTAIN_IN_CLOSE];
}

DEFINE_CALL 'EntranceLightsOn'		// ENTRANCE LIGHTS
{
	 CALL 'lightsEntranceOn'		//ENTRANCE LIGHTS ON
	 CALL 'LightsEntrStrip_On'
	 CALL 'lightsPassage_On'
}

DEFINE_CALL 'EntranceLightsOff'		//ENTRANCE LIGHTS
{
	 CALL 'lightsEntranceOff'		//ENTRANCE LIGHTS ON
	 CALL 'LightsEntrStrip_Off'
	 CALL 'lightsPassage_Off'
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)