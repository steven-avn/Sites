PROGRAM_NAME='dvTP'
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

/////////////////////DVD CONTROLS////////////////////
button_event[dvTP,1]		//DVD Play
button_event[dvTP,2]		//DVD Pause
button_event[dvTP,3]		//DVD Stop
button_event[dvTP,4]		//DVD Previous
button_event[dvTP,5]		//DVD Next

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 1: pulse[dvDVD_Sony_IR,cPlay];		//DVD Play
			case 2: pulse[dvDVD_Sony_IR,cPause];		//DVD Stop
			case 3: pulse[dvDVD_Sony_IR,cStop];		//DVD Previus
			case 4: pulse[dvDVD_Sony_IR,cPrev];		//DVD Next
			case 5: pulse[dvDVD_Sony_IR,cNext];		//DVD Pause
		}
  }
}

/////////////////////DSTV CONTROLS/////////////////////
button_event[dvTP,7]		//DSTV Channel Up
button_event[dvTP,8]		//DSTV Channel Dn
button_event[dvTP,9]		//DSTV Volume Up
button_event[dvTP,10]		//DSTV Volume Dn

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 7: pulse[dvDSTV_Echo_IR,cdChUp];		//DSTV Channel Up
			case 8: pulse[dvDSTV_Echo_IR,cdChDn];		//DSTV Channel Down
			case 9: pulse[dvDSTV_Echo_IR,cdVolUp];		//DSTV Volume Up
			case 10: pulse[dvDSTV_Echo_IR,cdVolDn];		//DSTV Volume Down
		}
  }
}

////////////////////BOARDROOM CONTROLS/////////////////////
BUTTON_EVENT[dvTP,12]		//Proj On/Off
BUTTON_EVENT[dvTP,14]		//Screen Up
BUTTON_EVENT[dvTP,15]		//Screen Dn
BUTTON_EVENT[dvTP,17]		//Aircon On
button_event[dvTP,16]		//Aircon Off
button_event[dvTP,11]		//Proj Input DVD
button_event[dvTP,13]		//Proj Input DSTV
button_event[dvTP,52]		//Proj Input PC
button_event[dvTP,6]		//All Off
{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			CASE 12: IF (PROJ_POWER == 0) {
									SEND_STRING dvProjector, "$A9,$17,$2E,$00,$00,$00,$3F,$9A" 	//ON
									PROJ_POWER = 1
							 } ELSE {
									SEND_STRING dvProjector, "$A9,$17,$2F,$00,$00,$00,$3F,$9A" 	//OFF
									PROJ_POWER = 0
							 }
			CASE 14: ON[dvRelays,4];		//Screen Up
							 WAIT 150
							 OFF[dvRelays,4];		//Screen Up
			CASE 15: ON[dvRelays,3];		//Screen Dn
							 WAIT 150
							 OFF[dvRelays,3];		//Screen Dn
			CASE 16: PULSE[dvAircon,1];		//Aircon On
							 AC_BR = 1;
			CASE 17: PULSE[dvAircon,2];		//Aircon Off
							 AC_BR = 0;
			CASE 11: IF (PROJ_POWER == 1) {
									SEND_STRING dvProjector, "$A9,$00,$01,$00,$00,$03,$03,$9A" 	//DVD Input
									IF (DVD_POWER == 0) {
										 PULSE[dvDVD_Sony_IR,cPower];		//DVD Power 
										 PULSE[dvDSTV_Echo_IR,cdPower];		//DSTV Power
										 DVD_POWER = 1
										 DSTV_POWER = 0
									}
							 }
			CASE 13: IF (PROJ_POWER == 1) {
									SEND_STRING dvProjector, "$A9,$00,$01,$00,$00,$00,$01,$9A" 	//DSTV Input
									IF (DSTV_POWER == 0) {
										 PULSE[dvDVD_Sony_IR,cPower];		//DVD Power 
										 PULSE[dvDSTV_Echo_IR,cdPower];		//DSTV Power
										 DVD_POWER = 0
										 DSTV_POWER = 1
									}
							 }
			CASE 52: SEND_STRING dvProjector, "$A9,$00,$01,$00,$00,$02,$03,$9A" 	//PC Input
			CASE 6:	 PULSE[dvLights,133];		//Zone 5 & 6 On
							 PULSE[dvLights,134];
							 SEND_COMMAND dvVol3,"'P1L0%T1'";		//Boardroom Volume Off
							 SEND_COMMAND dvVol3,"'P2L0%T1'";		//Boardroom Volume Off
							 SEND_COMMAND dvVol3,"'P3L0%T1'";		//Boardroom Volume Off
							 SEND_STRING dvProjector, "$A9,$17,$2F,$00,$00,$00,$3F,$9A" 	//OFF
							 PROJ_POWER = 0
							 ON[dvRelays,4];		//Screen Up
							 WAIT 150
							 off[dvRelays,4];		//Screen Up
							 send_command dvLights,"'P1L100%T1'";		//ch 1 100% in 5sec
							 send_command dvLights,"'P2L100%T1'";		//ch 2 100% in 5sec
							 wait 5
							 send_command dvLights,"'P3L100%T1'";		//ch 3 100% in 5sec
							 wait 5
							 send_command dvLights,"'P4L100%T1'";		//ch 4 100% in 5sec
							 if (AC_BR == 1) {
								 pulse[dvAircon,2];
								 AC_BR = 0;
							 }
							 LIGHTS_STATUS = 1
							 PRESENTATION_STATUS = 0
		}
  }
}

/////////////////////VOLUME CONTROLS////////////////////
button_event[dvTP,18]		//Board Volume Up
button_event[dvTP,19]		//Board Volume Down
button_event[dvTP,20]		//Demo Volume Up
button_event[dvTP,21]		//Demo Volume Down
button_event[dvTP,22]		//Recption Volume Up
button_event[dvTP,23]		//Reception Volume Down
{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 18:to[dvVol3,1];		//Board Volume Up
			case 19:to[dvVol3,2];		//Board Volume Down
			case 20:to[dvVol3,4];		//Demo Volume Up
			case 21:to[dvVol3,5];		//Demo Volume Down
			case 22:to[dvVol3,4];		//Recption Volume Up
			case 23:to[dvVol3,5];		//Recption Volume Down
		}
  }
}

/////////////LIGHTING CONTROLS BOARD ROOM//////////////
button_event[dvTP,24]		//Zone 1 Up
button_event[dvTP,25]		//Zone 1 Down
button_event[dvTP,26]		//Zone 2 Up
button_event[dvTP,27]		//Zone 2 Down
button_event[dvTP,28]		//Zone 3 Up
button_event[dvTP,29]		//Zone 3 Down
button_event[dvTP,30]		//Zone 4 Up
button_event[dvTP,31]		//Zone 4 Down
button_event[dvTP,32]		//Zone 5 & 6 0n
button_event[dvTP,34]		//All On
button_event[dvTP,35]		//All Off
button_event[dvTP,36]		//Meeting
button_event[dvTP,51]		//Presentation
{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL];
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 24:to[dvLights,129];		//Zone 1 Up
			case 25:to[dvLights,135];		//Zone 1 Down
			case 26:to[dvLights,130];		//Zone 2 Up
			case 27:to[dvLights,136];		//Zone 2 Down
			case 28:to[dvLights,131];		//Zone 3 Up
			case 29:to[dvLights,137];		//Zone 3 Down
			case 30:to[dvLights,132];		//Zone 4 Up
			case 31:to[dvLights,138];		//Zone 4 Down
			case 32:pulse[dvLights,143];		//Zone 5 & 6 On
							send_command dvLights,"'P1L0%T1'";		//ch 1 0%
							send_command dvLights,"'P2L0%T1'";		//ch 2 0%
							send_command dvLights,"'P3L0%T1'";		//ch 3 0%
							send_command dvLights,"'P4L0%T1'";		//ch 4 0%
			case 34:pulse[dvLights,143];		//All On
							 LIGHTS_STATUS = 1
			case 35:pulse[dvLights,144];		//All Off
							 LIGHTS_STATUS = 0
							send_command dvVol3,"'P1L0%T1'";		//Boardroom Volume Off
							send_command dvVol3,"'P2L0%T1'";		//Boardroom Volume Off
							send_command dvVol3,"'P3L0%T1'";		//Boardroom Volume Off
			case 36: pulse[dvLights,144];			//All lights off
							 send_command dvVol3,"'P1L0%T1'";		//Boardroom Volume Off
							 send_command dvVol3,"'P2L0%T1'";		//Boardroom Volume Off
							 send_command dvVol3,"'P3L0%T1'";		//Boardroom Volume Off
							 SEND_STRING dvProjector, "$A9,$17,$2F,$00,$00,$00,$3F,$9A" 	//OFF
							 PROJ_POWER = 0
							 send_command dvLights,"'P1L100%T1'";		//ch 1 100% in 5sec
							 send_command dvLights,"'P2L100%T1'";		//ch 2 100% in 5sec
							 send_command dvLights,"'P3L100%T1'";		//ch 3 100% in 5sec
							 send_command dvLights,"'P4L100%T1'";		//ch 4 100% in 5sec
							 on[dvRelays,4];		//Screen Up
							 wait 150
							 off[dvRelays,4];		//Screen Up
							
			case 51:	if (PRESENTATION_STATUS == 0) {
									pulse[dvLights,144];		//All lights off
									send_command dvVol3,"'P1L50%T1'";		//Boardroom Volume 50%
									send_command dvVol3,"'P2L50%T1'";		//Boardroom Volume 50%
									send_command dvVol3,"'P3L50%T1'";		//Boardroom Volume 50%
									SEND_STRING dvProjector, "$A9,$17,$2E,$00,$00,$00,$3F,$9A" 	//ON
									PROJ_POWER = 1
									on [dvRelays,3];		//Screen Dn
									wait 150
									off [dvRelays,3];		//Screen Dn
									send_command dvLights,"'P1L0%T1'";		//ch 1 0%
									send_command dvLights,"'P2L0%T1'";		//ch 2 0%
									send_command dvLights,"'P3L0%T1'";		//ch 3 0%
									send_command dvLights,"'P4L100%T1'"; 		//ch 4 100%
									PRESENTATION_STATUS = 1
						  } else {
									pulse[dvLights,133];		//Display lights on
									pulse[dvLights,134];		//Display lights on
									send_command dvVol3,"'P1L0%T1'";		//Boardroom Volume 0%
									send_command dvVol3,"'P2L0%T1'";		//Boardroom Volume 0%
									send_command dvVol3,"'P3L0%T1'";		//Boardroom Volume 0%
									SEND_STRING dvProjector, "$A9,$17,$2F,$00,$00,$00,$3F,$9A" 	//OFF
									PROJ_POWER = 0
									on[dvRelays,4];		//Screen Up
									wait 150
									off[dvRelays,4];		//Screen Up
									send_command dvLights,"'P1L100%T1'";		//ch 1 100%
									send_command dvLights,"'P2L100%T1'";		//ch 2 100%
									send_command dvLights,"'P3L100%T1'";		//ch 3 100%
									send_command dvLights,"'P4L100%T1'"; 		//ch 4 100%
									PRESENTATION_STATUS = 0
							 }
		}
  }
}

/////////////LIGHTING CONTROLS DEMO ROOM//////////////
button_event[dvTP,37]		//Reception Lights on/off
button_event[dvTP,38]		//Passage on/off
button_event[dvTP,39]		//Room 1 100%
button_event[dvTP,40]		//Room 2 100%
button_event[dvTP,41]		//Room 1 25%
button_event[dvTP,42]		//Room 2 25%
button_event[dvTP,43]		//Zone 4 Up
button_event[dvTP,44]		//Zone 4 Down
button_event[dvTP,45]		//Zone 1 Up
button_event[dvTP,46]		//Zone 1 Down
button_event[dvTP,47]		//All Off
button_event[dvTP,50]		//Door Open

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 37:send_command dvLightsDemo,"'P4L100%T1'";		//Reception Lights On
							KP1_VAR=1;		//Sets variable to 1 for reception dimmer control buttons 7 & 8
							KP1_VAR_REC = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
			case 38:send_command dvLightsDemo,"'P1L100%T1'";		//Passage Lights On
							KP1_VAR=2;		//Sets variable to 2 for passage dimmer control buttons 7 & 8
							KP1_VAR_PAS = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
			case 39:send_command dvLightsDemo,"'P2L100%T1'";		//Demo1 Lights 100%
							KP2_VAR=1;
							KP2_VAR_LFT = 1;		//Sets variable to 1 for left dimmer control buttons 7 & 8
			case 40:send_command dvLightsDemo,"'P3L100%T1'";		//Demo2 Lights 100%
							KP2_VAR=2;
							KP2_VAR_RGT = 1;		//Sets variable to 1 for right dimmer control buttons 7 & 8
			case 41:send_command dvLightsDemo,"'P2L50%T1'";		//Demo1 Lights 50%
							KP2_VAR=1;
							KP2_VAR_LFT = 1;		//Sets variable to 1 for left dimmer control buttons 7 & 8
			case 42:send_command dvLightsDemo,"'P3L50%T1'";		//Demo2 Lights 50%
							KP2_VAR=2;
							KP2_VAR_RGT = 1;		//Sets variable to 1 for right dimmer control buttons 7 & 8
			case 43:to[dvLightsDemo,132];		//Zone 4 Up
							KP1_VAR=1;		//Sets variable to 1 for reception dimmer control buttons 7 & 8
							KP1_VAR_REC = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
			case 44:to[dvLightsDemo,138];		//Zone 4 Down
							KP1_VAR=1;		//Sets variable to 1 for reception dimmer control buttons 7 & 8
							KP1_VAR_REC = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
			case 45:to[dvLightsDemo,129];		//Zone 1 Up
							KP1_VAR=2;		//Sets variable to 2 for passage dimmer control buttons 7 & 8
							KP1_VAR_PAS = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
			case 46:to[dvLightsDemo,135];		//Zone 1 Down
							KP1_VAR=2;		//Sets variable to 2 for passage dimmer control buttons 7 & 8
							KP1_VAR_PAS = 1;		//Sets variable to 1 for dimmer control buttons 7 & 8
			case 47:to[dvLightsDemo,144];		//All Off
							KP1_VAR_REC = 0;		//Sets variable to 0 for volume control buttons 7&8
							KP1_VAR_PAS = 0;		//Sets variable to 0 for volume control buttons 7&8
							KP1_VAR = 0;		//Sets variable to 0 for volume control buttons 7&8
							KP2_VAR = 0;		//Sets variable to 0 for volume control buttons 7&8
			case 50: on[dvRelays,2];		//Door Open
							 wait 100
							 off[dvRelays,2];
		}
  }
}

/////////////////////////Demo Aircon/////////////////////////
button_event[dvTP,48]														//Demoroom Aircon On
button_event[dvTP,49]														//Demoroom aircon Off

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 48:pulse[dvAirconDemo,1];		//Demo On
							AC_DR = 1;
			case 49:pulse[dvAirconDemo,2];		//Demo Off
							AC_DR = 0;
		}
	}
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,32]	= [dvLights,133];
[dvTP,33]	= [dvLights,133];

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)