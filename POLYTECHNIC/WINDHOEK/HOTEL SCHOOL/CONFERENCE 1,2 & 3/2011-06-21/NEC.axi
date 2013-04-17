PROGRAM_NAME='NEC'
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

dvPROJECTOR					=		5001:1:1											//NEC PROJECTOR

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

SEND_COMMAND dvPROJECTOR, "'SET BAUD,38400,N,8,1'"	 //NEC PROJ RS-232 SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP1,1]																		//PROJECTOR ON - VIDEO INPUT
BUTTON_EVENT[dvTP1,2]																		//PROJECTOR ON - VGA INPUT 1
BUTTON_EVENT[dvTP1,3]																		//PROJECTOR ON - VGA INPUT 2
BUTTON_EVENT[dvTP1,4]																		//PROJECTOR OFF
BUTTON_EVENT[dvTP1,5]																		//PROJECTOR ON

{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE  1: SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
							 WAIT 240
							 {
								SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$06,$0E"	//VIDEO INPUT
							 }
							 
			CASE  2: SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
							 WAIT 240
							 {
								SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$01,$09"	//VGA INPUT 1
							 }
							 
			CASE  3: SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
							 WAIT 240
							 {
								SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$02,$0A"	//VGA INPUT 2
							 }
							 
			CASE  4: SEND_STRING dvPROJECTOR, "$02,$01,$00,$00,$00,$03"		//OFF
							 
			CASE 	5: SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
								
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