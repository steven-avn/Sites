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
integer cPlay			=		19
integer cPause		=		15
integer cStop			=		16
integer cPrev			=		23
integer cNext			=		22
integer cPower		=		1
integer cMenu			=		3
integer cEnter		= 	11
integer cExit			= 	4
integer cUp				=		7
integer cDwn			= 	10
integer cLeft			=		8
integer cRight		=		9

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

button_event[dvR4_1,50]
button_event[dvR4_1,53]
button_event[dvR4_1,54]
button_event[dvR4_1,55]
button_event[dvR4_1,56]
button_event[dvR4_1,57]
button_event[dvR4_1,58]
button_event[dvR4_1,59]
button_event[dvR4_1,60]
button_event[dvR4_1,61]
button_event[dvR4_1,62]
button_event[dvR4_1,63]
button_event[dvR4_1,64]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 50: pulse[dvDVD,cMenu]
			case 53: pulse[dvDVD,cExit]
			case 54: pulse[dvDVD,cUp]
			case 55: pulse[dvDVD,cDwn]
			case 56: pulse[dvDVD,cLeft]
			case 57: pulse[dvDVD,cRight]
			case 58: pulse[dvDVD,cEnter]
			case 59: pulse[dvDVD,cPlay]
			case 60: pulse[dvDVD,cPower]
			case 61: pulse[dvDVD,cPause]
			case 62: pulse[dvDVD,cStop]
			case 63: pulse[dvDVD,cPrev]
			case 64: pulse[dvDVD,cNext]
		}
  }
}

button_event[dvR4_2,50]
button_event[dvR4_2,53]
button_event[dvR4_2,54]
button_event[dvR4_2,55]
button_event[dvR4_2,56]
button_event[dvR4_2,57]
button_event[dvR4_2,58]
button_event[dvR4_2,59]
button_event[dvR4_2,60]
button_event[dvR4_2,61]
button_event[dvR4_2,62]
button_event[dvR4_2,63]
button_event[dvR4_2,64]

{
  push:
  {
	to[dvR4_2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 50: pulse[dvDVD,cMenu]
			case 53: pulse[dvDVD,cExit]
			case 54: pulse[dvDVD,cUp]
			case 55: pulse[dvDVD,cDwn]
			case 56: pulse[dvDVD,cLeft]
			case 57: pulse[dvDVD,cRight]
			case 58: pulse[dvDVD,cEnter]
			case 59: pulse[dvDVD,cPlay]
			case 60: pulse[dvDVD,cPower]
			case 61: pulse[dvDVD,cPause]
			case 62: pulse[dvDVD,cStop]
			case 63: pulse[dvDVD,cPrev]
			case 64: pulse[dvDVD,cNext]
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

