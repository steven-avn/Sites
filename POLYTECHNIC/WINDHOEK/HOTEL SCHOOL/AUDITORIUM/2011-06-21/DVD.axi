PROGRAM_NAME='DVD'
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

/////////////////Constants for DVD Player///////////////////
integer cPlay			=		1
integer cStop			=		2
integer cHDD			=		21
integer cDVD			=		22
integer cPrev			=		5
integer cNext			=		4
integer cPause		=		3
integer cEnter		= 	49
integer cUp				=		45
integer cDwn			= 	46
integer cLeft			=		47
integer cRight		=		48
integer cREC			=		24
integer cREC_STOP	=		25
integer cCH_UP		=		27
integer cCH_DN		=		28

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

button_event[dvTP,21]
button_event[dvTP,29]
button_event[dvTP,30]
button_event[dvTP,33]
button_event[dvTP,34]
button_event[dvTP,32]
button_event[dvTP,35]
button_event[dvTP,18]
button_event[dvTP,19]
button_event[dvTP,10]
button_event[dvTP,11]
button_event[dvTP,15]
button_event[dvTP,16]
button_event[dvTP,17]
button_event[dvTP,81]
button_event[dvTP,82]

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 21: pulse[dvDVD,cDVD]
			case 29: pulse[dvDVD,cHDD]
			case 30: pulse[dvDVD,cUp]
			case 33: pulse[dvDVD,cDwn]
			case 34: pulse[dvDVD,cLeft]
			case 32: pulse[dvDVD,cRight]
			case 35: pulse[dvDVD,cEnter]
			case 18: pulse[dvDVD,cREC]
			case 19: pulse[dvDVD,cREC_STOP]
			case 10: pulse[dvDVD,cPlay]
			case 11: pulse[dvDVD,cStop]
			case 15: pulse[dvDVD,cPause]
			case 16: pulse[dvDVD,cNext]
			case 17: pulse[dvDVD,cPrev]
			case 81: pulse[dvDVD,cCH_UP]
			case 82: pulse[dvDVD,cCH_DN]
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

