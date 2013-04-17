PROGRAM_NAME='Conference 2'
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

/////////////////////EVENTS FOR CONFERENCE 2///////////////////////
BUTTON_EVENT[dvTP2,47]		//SINGLE PC2
BUTTON_EVENT[dvTP2,48]		//SINGLE DVD
BUTTON_EVENT[dvTP2,49]		//SWITCH OFF
BUTTON_EVENT[dvTP2,54]		//MUTE
BUTTON_EVENT[dvTP2,55]		//UNMUTE
BUTTON_EVENT[dvTP2,50]		//VOL UP
BUTTON_EVENT[dvTP2,51]		//VOL DN

{
  PUSH:
  {
		TO[dvTP2,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 47:SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$01,$00"		//IN7(DVD) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$01,$00"		//IN7(DVD) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$00"		//IN7(DVD) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$01,$00"		//IN7(DVD) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$00"		//IN7(DVD) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$51"		//IN2(MIC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$47"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								PULSE[dvDVD,cDVD]
								
								SEND_STRING dvMATRIX, "'2V2.'"		//PC2 IN2 TO OUT2
								PULSE [dvSCREEN2,3]
								SEND_STRING dvPROJECTOR2, "$02,$00,$00,$00,$00,$02"		//ON
				
				CASE 48:SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$01,$00"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$01,$00"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$00"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$00"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$01,$00"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$51"		//IN2(MIC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$47"		//IN7(DVD) TO OUT2 0dB(AUDIO)
				
								SEND_STRING dvMATRIX, "'4V2.'"		//DVD IN4 TO OUT2
								PULSE [dvSCREEN2,3]
								SEND_STRING dvPROJECTOR2, "$02,$00,$00,$00,$00,$02"		//ON
								
				CASE 49:SEND_STRING dvPROJECTOR2, "$02,$01,$00,$00,$00,$03"		//OFF
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$00"		//IN5(PC2) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$00"		//IN7(DVD) TO OUT2 0dB(AUDIO)
								PULSE [dvSCREEN2,1]
								
				CASE 54:SEND_STRING dvMIXER, "$92,$03,$01,$01,$00"		//OUT2 OFF (MUTE)
				
				CASE 55:SEND_STRING dvMIXER, "$92,$03,$01,$01,$01"		//OUT2 ON (UNMUTE)
				
			}	
	}
}

//---------------------------------VOLUME CONTROLS---------------------------//
BUTTON_EVENT[dvTP2,50]		//PC2 VOL UP
BUTTON_EVENT[dvTP2,51]		//PC2 VOL DN	
BUTTON_EVENT[dvTP2,71]		//DVD VOL UP
BUTTON_EVENT[dvTP2,72]		//DVD VOL DN	
BUTTON_EVENT[dvTP2,52]		//MIC VOL UP
BUTTON_EVENT[dvTP2,53]		//MIC VOL DN	

{
  hold[1,repeat]:
  {
	to[dvTP2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 50:SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$71"		//PC2 VOL UP
			case 51:SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$61"		//PC2 VOL DN
			case 71:SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$71"		//DVD VOL UP
			case 72:SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$61"		//DVD VOL DN
			case 52:SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$71"		//MIC VOL UP
			case 53:SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$61"		//MIC VOL DN
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