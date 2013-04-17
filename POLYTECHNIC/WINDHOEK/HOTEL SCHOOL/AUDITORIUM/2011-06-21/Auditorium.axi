PROGRAM_NAME='Auditorium'
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

dvCLOUD						=		5001:1:0											//CLOUD CX462 AUDIO CONTROLLER

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

INTEGER AC;

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

SEND_COMMAND dvCLOUD,"'SET BAUD,9600,N,8,1'"		 				//CLOUD SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

/////////////////////EVENTS FOR CONFERENCE 1///////////////////////
BUTTON_EVENT[dvTP,58]																		//SINGLE PC
BUTTON_EVENT[dvTP,59]																		//SINGLE DVD
BUTTON_EVENT[dvTP,60]																		//SWITCH OFF
BUTTON_EVENT[dvTP,65]																		//MUTE
BUTTON_EVENT[dvTP,66]																		//UNMUTE

{
  PUSH:
  {
		TO[dvTP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 58:SEND_STRING dvMATRIX, "'2V1.'"																//PC IN2 TO OUT1
								PULSE [dvSCREEN,3]
								SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"						//ON
								SEND_STRING dvCLOUD, "'<MU,SA2/>'"														//POPUP IN2
								SEND_STRING dvCLOUD, "'<MU,LA40/>'"														//POPUP IN2 LEVEL 50%
								SEND_STRING dvCLOUD, "'<MI,LA40/>'"														//MIC LEVEL 50%
				
				CASE 59:SEND_STRING dvMATRIX, "'1V1.'"																//DVD IN1 TO OUT1
								PULSE [dvSCREEN,3]
								SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 				//ON
								SEND_STRING dvCLOUD, "'<MU,SA1/>'"														//DVD IN1
								SEND_STRING dvCLOUD, "'<MU,LA40/>'"														//DVD IN1 LEVEL 50%
								SEND_STRING dvCLOUD, "'<MI,LA40/>'"														//MIC LEVEL 50%
								
				CASE 60:SEND_STRING dvPROJECTOR, "$02,$01,$00,$00,$00,$03"						//OFF
								PULSE [dvSCREEN,1]
								
				CASE 65:SEND_STRING dvCLOUD, '<MU,M/>'															//MAIN MUTE
				
				CASE 66:SEND_STRING dvCLOUD, '<MU,O/>'															//MAIN UNMUTE
			}	
	}
}

//---------------------------------VOLUME CONTROLS---------------------------//
BUTTON_EVENT[dvTP,61]																		//VOL UP
BUTTON_EVENT[dvTP,62]																		//VOL DN	
BUTTON_EVENT[dvTP,63]																		//MIC UP
BUTTON_EVENT[dvTP,64]																		//MIC DN


{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			CASE 61: SEND_STRING dvCLOUD, "'<MU,LU5/>'"				//MAIN VOLUME UP
			CASE 62: SEND_STRING dvCLOUD, "'<MU,LD5/>'"				//MAIN VOLUME DOWN
			CASE 63: SEND_STRING dvCLOUD, "'<MI,LU1/>'"				//MIC VOLUME UP
			CASE 64: SEND_STRING dvCLOUD, "'<MI,LD1/>'"				//MIC VOLUME DOWN
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