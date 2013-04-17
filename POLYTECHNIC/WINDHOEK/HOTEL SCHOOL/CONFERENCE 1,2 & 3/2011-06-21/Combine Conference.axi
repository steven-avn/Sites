PROGRAM_NAME='Combine Conference'
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

/////////////////////EVENTS FOR CONFERENCE 1///////////////////////
BUTTON_EVENT[dvTP1,42]		//SINGLE PC
BUTTON_EVENT[dvTP1,43]		//SINGLE DVD
BUTTON_EVENT[dvTP1,44]		//SWITCH OFF
BUTTON_EVENT[dvTP1,40]		//MUTE
BUTTON_EVENT[dvTP1,41]		//UNMUTE

{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 42:SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$00,$00"		//IN3(MIC3) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$00,$00"		//IN6(PC3) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$00"		//IN7(DVD) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$51"		//IN1(MIC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$47"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$00"		//IN2(MIC2) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$00,$00"		//IN5(PC2) TO OUT1(AUDIO)
								PULSE[dvDVD,cDVD]
								
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$01,$00"		//IN3(MIC3) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$01,$00"		//IN6(PC3) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$00"		//IN7(DVD) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$01,$51"		//IN1(MIC1) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$47"		//IN4(PC1) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$00"		//IN2(MIC2) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$00"		//IN5(PC2) TO OUT2(AUDIO)
								
								SEND_STRING dvMATRIX, "'1V1.'"		//PC IN1 TO OUT1
								SEND_STRING dvMATRIX, "'1V2.'"		//PC IN1 TO OUT2
								PULSE [dvSCREEN1,3]
								PULSE [dvSCREEN2,3]
								SEND_STRING dvPROJECTOR1, "$02,$00,$00,$00,$00,$02"		//ON
								SEND_STRING dvPROJECTOR2, "$02,$00,$00,$00,$00,$02"		//ON
				
				CASE 43:SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$00,$00"		//IN3(MIC3) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$00"		//IN4(PC1) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$00,$00"		//IN5(PC2) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$00,$00"		//IN6(PC3) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$51"		//IN1(MIC1) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$47"		//IN7(DVD) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$00"		//IN2(MIC2) TO OUT1(AUDIO)
								
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$01,$00"		//IN3(MIC3) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$00"		//IN4(PC1) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$00"		//IN5(PC2) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$01,$00"		//IN6(PC3) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$01,$51"		//IN1(MIC1) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$47"		//IN7(DVD) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$00"		//IN2(MIC2) TO OUT2(AUDIO)
								
								SEND_STRING dvMATRIX, "'4V1.'"		//DVD IN4 TO OUT1
								SEND_STRING dvMATRIX, "'4V2.'"		//DVD IN4 TO OUT2
								PULSE [dvSCREEN1,3]
								PULSE [dvSCREEN2,3]
								SEND_STRING dvPROJECTOR1, "$02,$00,$00,$00,$00,$02"		//ON
								SEND_STRING dvPROJECTOR2, "$02,$00,$00,$00,$00,$02"		//ON
								
				CASE 44:SEND_STRING dvPROJECTOR1, "$02,$01,$00,$00,$00,$03"		//OFF
								SEND_STRING dvPROJECTOR2, "$02,$01,$00,$00,$00,$03"		//OFF
								PULSE [dvSCREEN1,1]
								PULSE [dvSCREEN2,1]
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$00,$00"		//IN3(MIC3) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$00,$00"		//IN6(PC3) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$00"		//IN7(DVD) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$00"		//IN1(MIC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$00"		//IN4(PC1) TO OUT1 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$00,$00"		//IN2(MIC2) TO OUT1(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$00,$00"		//IN5(PC2) TO OUT1(AUDIO)
								
								SEND_STRING dvMIXER, "$95,$05,$00,$02,$01,$01,$00"		//IN3(MIC3) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$05,$01,$01,$00"		//IN6(PC3) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$00"		//IN7(DVD) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$01,$00"		//IN1(MIC1) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$00"		//IN4(PC1) TO OUT2 0dB(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$00"		//IN2(MIC2) TO OUT2(AUDIO)
								SEND_STRING dvMIXER, "$95,$05,$00,$04,$01,$01,$00"		//IN5(PC2) TO OUT2(AUDIO)
								
				CASE 40:SEND_STRING dvMIXER, "$92,$03,$01,$00,$00"		//OUT1 OFF (MUTE)
								SEND_STRING dvMIXER, "$92,$03,$01,$01,$00"		//OUT2 OFF (MUTE)
				
				CASE 41:SEND_STRING dvMIXER, "$92,$03,$01,$00,$01"		//OUT1 ON (UNMUTE)
								SEND_STRING dvMIXER, "$92,$03,$01,$01,$01"		//OUT2 ON (UNMUTE)
								
			}	
	}
}

//---------------------------------VOLUME CONTROLS---------------------------//
BUTTON_EVENT[dvTP1,36]		//PC VOL UP
BUTTON_EVENT[dvTP1,37]		//PC VOL DN	
BUTTON_EVENT[dvTP1,75]		//DVD VOL UP
BUTTON_EVENT[dvTP1,76]		//DVD VOL DN	
BUTTON_EVENT[dvTP1,38]		//MIC VOL UP
BUTTON_EVENT[dvTP1,39]		//MIC VOL DN	

{
  hold[1,repeat]:
  {
	to[dvTP1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 36: SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$71"		//PC1 VOL UP
							 SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$71"		//PC2 VOL UP
			case 37: SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$00,$61"		//PC1 VOL DN
							 SEND_STRING dvMIXER, "$95,$05,$00,$03,$01,$01,$61"		//PC2 VOL DN
			case 75: SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$71"		//DVD VOL1 UP
							 SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$71"		//DVD VOL2 UP
			case 76: SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$00,$61"		//DVD VOL1 DN
							 SEND_STRING dvMIXER, "$95,$05,$00,$06,$01,$01,$61"		//DVD VOL2 DN
			case 38: SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$71"		//MIC VOL1 UP
							 SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$71"		//MIC VOL2 UP
			case 39: SEND_STRING dvMIXER, "$95,$05,$00,$00,$01,$00,$61"		//MIC VOL1 DN
							 SEND_STRING dvMIXER, "$95,$05,$00,$01,$01,$01,$61"		//MIC VOL2 DN
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