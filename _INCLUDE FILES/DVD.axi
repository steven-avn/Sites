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

dvDVD							=		5001:6:1											//DVD/HDD FOR SYSTEM IR PORT 6

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
integer cHDD			=		24
integer cDVD			=		25
integer cREC			=		26
integer cREC_Stop	=		26

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

button_event[dvTP,34]
button_event[dvTP,35]
button_event[dvTP,36]
button_event[dvTP,37]
button_event[dvTP,39]
button_event[dvTP,38]
button_event[dvTP,40]
button_event[dvTP,41]
button_event[dvTP,42]
button_event[dvTP,43]
button_event[dvTP,44]
button_event[dvTP,45]

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 34: pulse[dvSONY_br,cMenu]
			case 35: pulse[dvSONY_br,cPower]
			case 36: pulse[dvSONY_br,cUp]
			case 37: pulse[dvSONY_br,cDwn]
			case 39: pulse[dvSONY_br,cLeft]
			case 38: pulse[dvSONY_br,cRight]
			case 40: pulse[dvSONY_br,cEnter]
			case 41: pulse[dvSONY_br,cPlay]
			case 42: pulse[dvSONY_br,cPause]
			case 43: pulse[dvSONY_br,cStop]
			case 44: pulse[dvSONY_br,cPrev]
			case 45: pulse[dvSONY_br,cNext]
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

