PROGRAM_NAME='Conference 1'
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

integer cDVD			=		22

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
BUTTON_EVENT[dvTP1,1]		//SINGLE PC1
BUTTON_EVENT[dvTP1,2]		//SINGLE DVD1
BUTTON_EVENT[dvTP1,4]		//SWITCH OFF
BUTTON_EVENT[dvTP1,9]		//MUTE
BUTTON_EVENT[dvTP1,13]		//UNMUTE

{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE  1:SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$00"		//IN7(DVD) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$00,$00"		//IN7(DVD) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$00,$00"		//IN7(DVD) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$00,$00"		//IN7(DVD) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$00"		//IN7(DVD) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$51"		//IN1(MIC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$47"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								PULSE[dvDVD,cDVD]

								SEND_STRING dvMATRIX, "'1V1.'"		//PC1 IN1 TO OUT1
								PULSE [dvSCREEN1,3]
								SEND_STRING dvPROJECTOR1, "$02,$00,$00,$00,$00,$02"		//ON
				
				CASE  2:SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$51"		//IN1(MIC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$47"		//IN7(DVD) TO OUT1 0dB(AUDIO)

								SEND_STRING dvMATRIX, "'4V1.'"		//DVD IN4 TO OUT1
								PULSE [dvSCREEN1,3]
								SEND_STRING dvPROJECTOR1, "$02,$00,$00,$00,$00,$02"		//ON
								
				CASE  4:SEND_STRING dvPROJECTOR1, "$02,$01,$00,$00,$00,$03"		//OFF
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$00"		//IN7(DVD) TO OUT1 0dB(AUDIO)
								PULSE [dvSCREEN1,1]
								
				CASE  9:SEND_STRING dvMIXER, "$92,$03,$01,$00,$00"		//OUT1 OFF (MUTE)
				
				CASE 13:SEND_STRING dvMIXER, "$92,$03,$01,$00,$01"		//OUT1 ON (UNMUTE)
			}	
	}
}

//---------------------------------VOLUME CONTROLS---------------------------//
BUTTON_EVENT[dvTP1,5]		//PC1 VOL UP
BUTTON_EVENT[dvTP1,6]		//PC1 VOL DN	
BUTTON_EVENT[dvTP1,69]		//DVD1 VOL UP
BUTTON_EVENT[dvTP1,70]		//DVD1 VOL DN	
BUTTON_EVENT[dvTP1,7]		//MIC VOL UP
BUTTON_EVENT[dvTP1,8]		//MIC VOL DN	

{
  hold[1,repeat]:
  {
	to[dvTP1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case  5: SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$71"		//PC1 VOL UP
			case  6: SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$61"		//PC1 VOL DN
			case 69: SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$71"		//DVD1 VOL UP
			case 70: SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$61"		//DVD1 VOL DN
			case  7: SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$71"		//MIC VOL UP
			case  8: SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$61"		//MIC VOL DN
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