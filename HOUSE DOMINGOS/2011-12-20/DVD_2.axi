PROGRAM_NAME='DVD_2'
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

dvSONY_DVD		=				5001:13:0						//5TH SONY DVD PLAYER LIVING ROOM

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////Constants for DVD Player///////////////////
integer cPlay			=		1
integer cStop			=		2
integer cFFW			=		6
integer cRew			=		7
integer cPrev			=		5
integer cNext			=		4
integer cPause		=		3
integer cPower		=		9
integer cMenu			=		44
integer cEnter		= 	49
integer cUp				=		45
integer cDwn			= 	46
integer cLeft			=		47
integer cRight		=		48
integer cExit			=		54
integer cDisplay	=		58

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

//---------------ENTERTAINMENT AREA---------------//
button_event[dvTP,21]
button_event[dvTP,22]
button_event[dvTP,23]
button_event[dvTP,46]
button_event[dvTP,47]
button_event[dvTP,26]
button_event[dvTP,27]
button_event[dvTP,51]
button_event[dvTP,30]
button_event[dvTP,31]
button_event[dvTP,32]
button_event[dvTP,33]
button_event[dvTP,52]

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 26: pulse[dvSONY_DVD,cMenu]
			case 27: pulse[dvSONY_DVD,cPower]
			case 21: pulse[dvSONY_DVD,cUp]
			case 23: pulse[dvSONY_DVD,cDwn]
			case 46: pulse[dvSONY_DVD,cLeft]
			case 22: pulse[dvSONY_DVD,cRight]
			case 47: pulse[dvSONY_DVD,cEnter]
			case 51: pulse[dvSONY_DVD,cPlay]
			case 30: pulse[dvSONY_DVD,cPause]
			case 31: pulse[dvSONY_DVD,cStop]
			case 32: pulse[dvSONY_DVD,cPrev]
			case 33: pulse[dvSONY_DVD,cNext]
			case 52: pulse[dvSONY_DVD,cDisplay]
		}
  }
}

//---------------------MAIN BEDROOM------------------//
button_event[dvR4_1,21]
button_event[dvR4_1,22]
button_event[dvR4_1,23]
button_event[dvR4_1,46]
button_event[dvR4_1,47]
button_event[dvR4_1,26]
button_event[dvR4_1,27]
button_event[dvR4_1,51]
button_event[dvR4_1,30]
button_event[dvR4_1,31]
button_event[dvR4_1,32]
button_event[dvR4_1,33]
button_event[dvR4_1,52]

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 26: pulse[dvSONY_DVD,cMenu]
			case 27: pulse[dvSONY_DVD,cPower]
			case 21: pulse[dvSONY_DVD,cUp]
			case 23: pulse[dvSONY_DVD,cDwn]
			case 46: pulse[dvSONY_DVD,cLeft]
			case 22: pulse[dvSONY_DVD,cRight]
			case 47: pulse[dvSONY_DVD,cEnter]
			case 51: pulse[dvSONY_DVD,cPlay]
			case 30: pulse[dvSONY_DVD,cPause]
			case 31: pulse[dvSONY_DVD,cStop]
			case 32: pulse[dvSONY_DVD,cPrev]
			case 33: pulse[dvSONY_DVD,cNext]
			case 52: pulse[dvSONY_DVD,cDisplay]
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

