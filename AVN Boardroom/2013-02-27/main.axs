PROGRAM_NAME='main'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/10/2012  AT: 15:44:57        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History:
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvDVD_Sony_IR			=		5001:5:0;		//First IR port Sony BDP-S360
dvDSTV_Echo_IR		=		5001:6:0;		//Second IR port Echostar DV3
dvProjector				=	 	5001:1:0;		//First RS232 prt Sony Proj. VPL-EW5
dvAircon					=	 	5001:8:0;		//Fourth IR port Board Room Aircon
dvAirconDemo			=	 	5001:7:0;		//Third IR port Demo Room Aircon
dvTP							=		10001:1:0;		//NXT-CV7 Touch Panel
dvRelays					=		5001:4:0;		//Relays 2&3 Screen Up&Dwn
dvLights					=		96:1:0;		//RE-DM4 for Boardroom
dvLightsDemo			=		97:1:0;		//RE-DM4 for Demoroom
dvVol3						=		162:1:0;		//Ch1-Boardrm,Ch2-Demo Rm,Ch3-Recept
dvKP1							=		84:1:0;		//Metreau Keypad at Reception
dvKP2							=		85:1:0;		//Metreau Keypad in Demo Room
dvKP3							=		86:1:0;		//Novara Keypad in Demo Room
dviPad						=		11001:1:0;		//AVN's iPad
dvPIR							=		5001:9:0		// PIR's for light control

(***********************************************************)
(*          CONNECT LEVEL DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONNECT_LEVEL

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////CONSTANTS FOR DVD PLAYER///////////////////
VOLATILE INTEGER cPlay		=		1
VOLATILE INTEGER cPause	=		3
VOLATILE INTEGER cStop		=		2
VOLATILE INTEGER cPrev		=		5
VOLATILE INTEGER cNext		=		4
VOLATILE INTEGER cPower	=		9

/////////////////CONSTANTS FOR SATELITE TV//////////////////
VOLATILE INTEGER cdChUp		=		22
VOLATILE INTEGER cdChDn		=		23
VOLATILE INTEGER cdVolUp		=		24
VOLATILE INTEGER cdVolDn		=		25
VOLATILE INTEGER cdPower		=		9
VOLATILE INTEGER cdCh01		=		11
VOLATILE INTEGER cdCh02		=		12
VOLATILE INTEGER cdCh03		=		13

///////////////CONSTANTS FOR PIR////////////////////////////
VOLATILE INTEGER Passage = 1
VOLATILE INTEGER BoardRoom = 2
VOLATILE INTEGER DemoRoom = 3

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER Z1_LIGHT_LEVEL		//Zone 1 lights level
VOLATILE INTEGER Z2_LIGHT_LEVEL		//Zone 2 lights level
VOLATILE INTEGER Z3_LIGHT_LEVEL		//Zone 3 lights level
VOLATILE INTEGER Z4_LIGHT_LEVEL		//Zone 4 lights level
VOLATILE INTEGER VOL_LEVEL		//Boardroom Volume level for bargraph
VOLATILE INTEGER MUTE
VOLATILE INTEGER KP1_VAR_REC
VOLATILE INTEGER KP1_VAR_PAS
VOLATILE INTEGER KP2_VAR_LFT
VOLATILE INTEGER KP2_VAR_RGT
VOLATILE INTEGER KP1_VAR
VOLATILE INTEGER KP2_VAR
VOLATILE INTEGER AC_BR
VOLATILE INTEGER AC_DR
VOLATILE INTEGER PROJ_POWER
VOLATILE INTEGER DVD_POWER
VOLATILE INTEGER DSTV_POWER
VOLATILE INTEGER LIGHTS_STATUS
VOLATILE INTEGER PRESENTATION_STATUS
VOLATILE INTEGER PIR_CONTROL_PASSAGE
VOLATILE INTEGER PIR_CONTROL_BOARDRM
VOLATILE INTEGER PIR_CONTROL_DEMORM
VOLATILE INTEGER WAIT_TIME		=		3000		//WAIT TIME IS 5 MIN

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvRelays,3], [dvRelays,4])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

DEFINE_CALL 'DemoRoomLightsOn'		//DEMOROOM LIGHTS ON
{
		send_command dvLightsDemo,"'P2L100%T1'";		//Left Lights On
		KP2_VAR_LFT = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
		KP2_VAR = 1;		//Sets variable to 1 for left dimmer control buttons 7 & 8
		send_command dvLightsDemo,"'P3L100%T1'";		//Right Lights On
		KP2_VAR_RGT = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
		KP2_VAR = 2;		//Sets variable to 2 for right dimmer control buttons 7 & 8
}

DEFINE_CALL 'DemoRoomLightsOff'		//DEMOROOM LIGHTS OFF
{
		send_command dvLightsDemo,"'P3L0%T1'";		//Right Lights Off
		KP2_VAR_RGT = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
		KP2_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
		wait 5
		send_command dvLightsDemo,"'P2L0%T1'";		//Left Lights Off
		KP2_VAR_LFT = 0;		//Sets variable to 0 for volume control buttons 7 & 8
		KP2_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
}


#include 'dvTP'
#include 'dvKP'
#include 'dviPad'
#include 'dvKP_Novara'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)

DEFINE_START

send_command dvProjector, 'SET BAUD,38400,E,8,1'	//Sony RS-232 SETTINGS
create_level dvLights,1,Z1_LIGHT_LEVEL	//Reads level value of z1
create_level dvLights,2,Z2_LIGHT_LEVEL	//Reads level value of z2
create_level dvLights,3,Z3_LIGHT_LEVEL	//Reads level value of z3
create_level dvLights,4,Z4_LIGHT_LEVEL	//Reads level value of z4
create_level dvVol3,1,VOL_LEVEL	//Level for TP & iPad bargraph
set_pulse_time (2)
KP1_VAR_REC = 0		//Sets variable for keypad selector buttons (7&8) to volume control
KP1_VAR_PAS = 0		//Sets variable for keypad selector buttons (7&8) to volume control
KP2_VAR_LFT = 0		//Sets variable for keypad selector buttons (7&8) to volume control
KP2_VAR_RGT = 0		//Sets variable for keypad selector buttons (7&8) to volume control
KP1_VAR = 0		//Sets variable for keypad selector buttons (7&8) to volume control
KP2_VAR = 0		//Sets variable for keypad selector buttons (7&8) to volume control
AC_BR = 0		//Variable to check if boardroom aircon is switched on/off
AC_DR = 0		//Variable to check if demoroom aircon is switched on/off
PROJ_POWER = 0		//Variable to check if demoroom projector is switched on/off
DVD_POWER = 0		//Variable to check if demoroom dvd is switched on/off
DSTV_POWER = 0		//Variable to check if demoroom dstv is switched on/off
LIGHTS_STATUS = 0		//Variable to check if lights is switched on/off
PRESENTATION_STATUS = 0		//Variable to check if presentation mode is switched on/off
PIR_CONTROL_PASSAGE = 0		// Variable to monitor state of PIR's
PIR_CONTROL_BOARDRM = 0		// Variable to monitor state of PIR's
PIR_CONTROL_DEMORM = 0		// Variable to monitor state of PIR's

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

CHANNEL_EVENT[dvPIR,Passage]
{
	OFF:
	{
			CANCEL_ALL_WAIT															//CALCELS ALL ACTIVE WAITS
			send_command dvLightsDemo,"'P1L100%T1'";		//Passage Lights Off
			KP1_VAR_PAS = 1;		//Sets variable to 3 for dimmer control buttons 7 & 8
			KP1_VAR = 2;		//Sets variable to 1 for passage dimmer control buttons 7 & 8	}
  }
	ON:
	{
			WAIT WAIT_TIME															//STARTS WAITTIME (6000)(10MIN)
			send_command dvLightsDemo,"'P1L0%T1'";		//Passage Lights Off
			KP1_VAR_PAS = 0;		//Sets variable to 5 for Volume control buttons 7 & 8
			KP1_VAR = 0;		//Sets variable to 0 for Volume control buttons 7 & 8
	}
}

CHANNEL_EVENT[dvPIR,BoardRoom]
{
	OFF:
	{
			CANCEL_ALL_WAIT		//CALCELS ALL ACTIVE WAITS
			pulse[dvLights,143];		//All On
		  LIGHTS_STATUS = 1
	}

	ON:
	{
			WAIT WAIT_TIME		//STARTS WAITTIME (6000)(10MIN)
			pulse[dvLights,144];		//All Off
		  LIGHTS_STATUS = 0
	}
}

CHANNEL_EVENT[dvPIR,DemoRoom]
{
	OFF:
	 {
		CANCEL_ALL_WAIT		//CALCELS ALL ACTIVE WAITS
		CALL 'DemoRoomLightsOn'		//DEMOROOM LIGHTS ON
	 }

	ON:
	 {
		WAIT WAIT_TIME		//STARTS WAITTIME (6000)(10MIN)
		CALL 'DemoRoomLightsOff'	
	 }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

send_level dvTP,1,Z1_LIGHT_LEVEL		//Show ZONE 1 bargraph on TP
send_level dvTP,2,Z2_LIGHT_LEVEL		//Show ZONE 2 bargraph on TP
send_level dvTP,3,Z3_LIGHT_LEVEL		//Show ZONE 3 bargraph on TP
send_level dvTP,4,Z4_LIGHT_LEVEL		//Show ZONE 4 bargraph on TP
send_level dvTP,5,VOL_LEVEL		//Show volume level on bargraph on TP

send_level dviPad,1,Z1_LIGHT_LEVEL		//Show ZONE 1 bargraph on iPad
send_level dviPad,2,Z2_LIGHT_LEVEL		//Show ZONE 2 bargraph on iPad
send_level dviPad,3,Z3_LIGHT_LEVEL		//Show ZONE 3 bargraph on iPad
send_level dviPad,4,Z4_LIGHT_LEVEL		//Show ZONE 4 bargraph on iPad
send_level dviPad,5,VOL_LEVEL		//Show volume level on bargraph on iPad

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)