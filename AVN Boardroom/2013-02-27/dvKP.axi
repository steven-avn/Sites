PROGRAM_NAME='dvKP'
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
(*          CONNECT LEVEL DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONNECT_LEVEL

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

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

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

///////////////////////Reception Keypad 1 ////////////////////////////
button_event[dvKP1,1]		//All Lights & Aircons off
button_event[dvKP1,2]		//Reception Lights on/off
button_event[dvKP1,3]		//Passage Lights on/off
button_event[dvKP1,4]		//
button_event[dvKP1,5]		//
button_event[dvKP1,6]		//
button_event[dvKP1,7]		//Volume/Lights -
button_event[dvKP1,8]		//Volume/Lights +

{
  push:
  {
		to[dvKP1,BUTTON.INPUT.CHANNEL]
				switch(BUTTON.INPUT.CHANNEL)
		{
		case 1: pulse [dvLightsDemo,144];		//Switch Demo Room Lights Off
						pulse [dvLights,144];		//Switch Boardroom Lights Off
						KP1_VAR_REC = 0;		//Sets variable to 0 for volume control buttons 7&8
						KP1_VAR_PAS = 0;		//Sets variable to 0 for volume control buttons 7&8
						KP1_VAR = 0;		//Sets variable to 0 for volume control buttons 7&8
						KP2_VAR = 0;		//Sets variable to 0 for volume control buttons 7&8
						if (AC_BR == 1)	{
							pulse[dvAircon,2];
							AC_BR = 0;
						}
						if (AC_DR == 1)	{
							pulse[dvAirconDemo,2];
							AC_DR = 0;
						}
						
		case 2: if (KP1_VAR_REC == 0)	{		
							send_command dvLightsDemo,"'P4L100%T1'";		//Reception Lights On
							KP1_VAR_REC = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
							KP1_VAR = 1;		//Sets variable to 1 for reception dimmer control buttons 7 & 8
						}	else {
							send_command dvLightsDemo,"'P4L0%T1'";		//Reception Lights Off
							KP1_VAR_REC = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
							KP1_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
						}
						
		case 3: if (KP1_VAR_PAS == 0)	{		
							send_command dvLightsDemo,"'P1L100%T1'";		//Passage Lights Off
							KP1_VAR_PAS = 1;		//Sets variable to 3 for dimmer control buttons 7 & 8
							KP1_VAR = 2;		//Sets variable to 1 for passage dimmer control buttons 7 & 8
						}	else {
							send_command dvLightsDemo,"'P1L0%T1'";		//Passage Lights Off
							KP1_VAR_PAS = 0;		//Sets variable to 5 for Volume control buttons 7 & 8
							KP1_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
						}
						
		case 7: if (KP1_VAR == 1)	{
							to [dvLightsDemo,138];		//Ramp Reception lights down
						}	else if (KP1_VAR = 2)	{
							to [dvLightsDemo,135];		//Ramp Passage lights down
						}	else {
							to [dvVol3,5];		//Ramps Passage/Reception volume down
						}
						
		case 8: if (KP1_VAR == 1)	{
							to [dvLightsDemo,132];		//Ramp Reseption lights up
						} else if (KP1_VAR = 2)	{
							to [dvLightsDemo,129];		//Ramp Passage lights up
						}	else {
							to [dvVol3,4];		//Ramps Passage/Reception volume up
						}
		}
  }
}

///////////////////////Demo Room Keypad 2 ////////////////////////////
button_event[dvKP2,1]		//Demo Room 1 Lights on/off
button_event[dvKP2,2]		//Demo Room 2 Lights on/off
button_event[dvKP2,3]		//Demo Room Aircon on/off
button_event[dvKP2,4]		//
button_event[dvKP2,5]		//
button_event[dvKP2,6]		//
button_event[dvKP2,7]		//Volume/Lights -
button_event[dvKP2,8]		//Volume/Lights +

{
  push:
  {
		to[dvKP2,BUTTON.INPUT.CHANNEL]
				switch(BUTTON.INPUT.CHANNEL)
		{
		case 1: if (KP2_VAR_LFT == 0)	{		
							send_command dvLightsDemo,"'P2L100%T1'";		//Left Lights On
							KP2_VAR_LFT = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
							KP2_VAR = 1;		//Sets variable to 1 for left dimmer control buttons 7 & 8
						} else {
							send_command dvLightsDemo,"'P2L0%T1'";		//Left Lights Off
							KP2_VAR_LFT = 0;		//Sets variable to 0 for volume control buttons 7 & 8
							KP2_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
						}
						
		case 2: if (KP2_VAR_RGT == 0)	{		
							send_command dvLightsDemo,"'P3L100%T1'";		//Right Lights On
							KP2_VAR_RGT = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
							KP2_VAR = 2;		//Sets variable to 2 for right dimmer control buttons 7 & 8
						}	else {
							send_command dvLightsDemo,"'P3L0%T1'";		//Right Lights Off
							KP2_VAR_RGT = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
							KP2_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
						}
						
		case 3: if (AC_DR == 0)	{
							pulse[dvAirconDemo,1];		//Switches Demoroom Aircon on
							AC_DR = 1;
						}	else	{
							pulse[dvAirconDemo,2];		//Switches Demoroom Aircon off
							AC_DR = 0;
						}
						
		case 7: if (KP2_VAR == 1)	{
							to [dvLightsDemo,136];		//Ramp Left lights down
						}	else if (KP2_VAR == 2)	{
							to [dvLightsDemo,137];		//Ramp right lights down
						}	else	{
							to [dvVol3,5];		//Ramps Demo Room volume down
						}
						
		case 8: if (KP2_VAR == 1)	{
							to [dvLightsDemo,130];		//Ramp Left lights up
						}	else if (KP2_VAR == 2)	{
							to [dvLightsDemo,131];		//Ramp Right lights up
						}	else	{
							to [dvVol3,4];		//Ramps Demo Room volume up
						}
		}
  }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)