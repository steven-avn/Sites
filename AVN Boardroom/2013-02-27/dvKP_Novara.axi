 PROGRAM_NAME='dvKP_Novara'
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

////////////////////BOARDROOM CONTROLS/////////////////////
button_event[dvKP3,1]		//Lights On/Off
button_event[dvKP3,2]		//Projector On/Off
button_event[dvKP3,3]		//DSTV Input
button_event[dvKP3,4]		//DVD Input
button_event[dvKP3,5]		//PC Input
button_event[dvKP3,6]		//Aircon on/off
button_event[dvKP3,7]		//Vol +
button_event[dvKP3,8]		//Vol -

{
  push:
  {
	to[dvKP3,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 1: if (LIGHTS_STATUS == 0) {
									pulse[dvLights,143];		//All Lights On
									LIGHTS_STATUS = 1
							 } else {
									pulse[dvLights,144];		//All Lights Off
									LIGHTS_STATUS = 0
							 }
			case 2:	if (PRESENTATION_STATUS == 0) {
									pulse[dvLights,144];		//All lights off
									send_command dvVol3,"'P1L50%T1'";		//Boardroom Volume 50%
									send_command dvVol3,"'P2L50%T1'";		//Boardroom Volume 50%
									send_command dvVol3,"'P3L50%T1'";		//Boardroom Volume 50%
									SEND_STRING dvProjector, "$A9,$17,$2E,$00,$00,$00,$3F,$9A" 		//ON
									PROJ_POWER = 1
									on [dvRelays,3];		//Screen Dn
									wait 150
									off [dvRelays,3];		//Screen Dn
									send_command dvLights,"'P1L0%T1'";		//ch 1 0% in 5sec
									send_command dvLights,"'P2L0%T1'";		//ch 2 0% in 5sec
									send_command dvLights,"'P3L0%T1'";		//ch 3 0% in 5sec
									send_command dvLights,"'P4L100%T1'"; 		//ch 4 100% in 5sec
									PRESENTATION_STATUS = 1
						  } else {
									pulse[dvLights,133];		//Display lights on
									pulse[dvLights,134];		//Display lights on
									send_command dvVol3,"'P1L0%T1'";		//Boardroom Volume 0%
									send_command dvVol3,"'P2L0%T1'";		//Boardroom Volume 0%
									send_command dvVol3,"'P3L0%T1'";		//Boardroom Volume 0%
									SEND_STRING dvProjector, "$A9,$17,$2F,$00,$00,$00,$3F,$9A" 		//OFF
									PROJ_POWER = 0
									on[dvRelays,4];		//Screen Up
									wait 150
									off[dvRelays,4];		//Screen Up
									send_command dvLights,"'P1L100%T1'";		//ch 1 100% in 5sec
									send_command dvLights,"'P2L100%T1'";		//ch 2 100% in 5sec
									send_command dvLights,"'P3L100%T1'";		//ch 3 100% in 5sec
									send_command dvLights,"'P4L100%T1'"; 		//ch 4 100% in 5sec
									PRESENTATION_STATUS = 0
							 }
							 
			case 3:	if (PRESENTATION_STATUS == 1) {
									SEND_STRING dvProjector, "$A9,$00,$01,$00,$00,$00,$01,$9A" 		//DSTV Input
									if (DSTV_POWER == 0) {
										 pulse[dvDVD_Sony_IR,cPower];		//DVD Power 
										 pulse[dvDSTV_Echo_IR,cdPower];		//DSTV Power
										 DVD_POWER = 0
										 DSTV_POWER = 1
									}
							 }
			case 4:	if (PRESENTATION_STATUS == 1) {
									SEND_STRING dvProjector, "$A9,$00,$01,$00,$00,$03,$03,$9A" 	//DVD Input
									if (DVD_POWER == 0) {
										 pulse[dvDVD_Sony_IR,cPower];		//DVD Power 
										 pulse[dvDSTV_Echo_IR,cdPower];		//DSTV Power
										 DVD_POWER = 1
										 DSTV_POWER = 0
									}
							 }
			case 5: if (PRESENTATION_STATUS == 1) {
									SEND_STRING dvProjector, "$A9,$00,$01,$00,$00,$02,$03,$9A" //PC Input
							 }
			case 6: if (AC_BR == 0)	{
								 pulse[dvAircon,1];		//Switches Aircon on
								 AC_BR = 1;
							 }	else	{
								 pulse[dvAircon,2];		//Switches Aircon off
								 AC_BR = 0;
							 }
			case 7:	to[dvVol3,1];		//Board Volume Up
			case 8:	to[dvVol3,2];		//Board Volume Down
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