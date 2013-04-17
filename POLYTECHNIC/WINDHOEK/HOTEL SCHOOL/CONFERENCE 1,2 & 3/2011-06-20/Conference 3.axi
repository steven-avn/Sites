PROGRAM_NAME='Conference 3'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*

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

//integer cDVD			=		22

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

/////////////////////EVENTS FOR CONFERENCE 1///////////////////////
BUTTON_EVENT[dvTP3,58]																		//SINGLE PC3
BUTTON_EVENT[dvTP3,59]																		//SINGLE DVD3
BUTTON_EVENT[dvTP3,60]																		//SWITCH OFF
BUTTON_EVENT[dvTP3,65]																		//MUTE
BUTTON_EVENT[dvTP3,66]																		//UNMUTE

{
  PUSH:
  {
		TO[dvTP3,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 58:SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$02,$00"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$02,$00"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$02,$00"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$02,$00"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$02,$00"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$02,$51"						//IN3(MIC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$02,$47"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								PULSE[dvDVD,cDVD]
								
								SEND_STRING dvMATRIX, "'3V3.'"																//PC3 IN3 TO OUT3
								PULSE [dvSCREEN3,1]
								SEND_STRING dvPROJECTOR3, "$02,$00,$00,$00,$00,$02"						//ON
				
				CASE 59:SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$02,$00"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$02,$00"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$02,$00"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$02,$00"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$02,$00"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$02,$51"						//IN3(MIC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$02,$47"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								
								SEND_STRING dvMATRIX, "'4V3.'"																//DVD IN4 TO OUT3
								PULSE [dvSCREEN3,1]
								SEND_STRING dvPROJECTOR3, "$02,$00,$00,$00,$00,$02"		 				//ON
								
				CASE 60:SEND_STRING dvPROJECTOR3, "$02,$01,$00,$00,$00,$03"						//OFF
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$02,$00"						//IN6(PC3) TO OUT3 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$02,$00"						//IN7(DVD) TO OUT3 0dB(AUDIO)
								PULSE [dvSCREEN3,2]
								
				CASE 65:SEND_STRING dvMIXER, "$92,$03,$01,$02,$00"										//OUT3 OFF (MUTE)
				
				CASE 66:SEND_STRING dvMIXER, "$92,$03,$01,$02,$01"										//OUT3 ON (UNMUTE)
			}	
	}
}

//---------------------------------VOLUME CONTROLS---------------------------//
BUTTON_EVENT[dvTP3,61]																		//PC3 VOL UP
BUTTON_EVENT[dvTP3,62]																		//PC3 VOL DN	
BUTTON_EVENT[dvTP3,73]																		//DVD VOL UP
BUTTON_EVENT[dvTP3,74]																		//DVD VOL DN	

{
  hold[1,repeat]:
  {
	to[dvTP3,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 61: SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$02,$71"		//PC3 VOL UP
			case 62: SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$02,$61"		//PC3 VOL DN
			case 73: SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$02,$71"		//DVD VOL UP
			case 74: SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$02,$61"		//DVD VOL DN
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