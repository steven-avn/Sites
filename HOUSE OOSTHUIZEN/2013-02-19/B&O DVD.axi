PROGRAM_NAME='B&O DVD'
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

/////////////////Constants for DVD//////////////////////////
INTEGER cMenu		=		8
INTEGER cOk			=		36
INTEGER cUp			=		32
INTEGER cDwn		= 	33
INTEGER cLeft		=		34
INTEGER cRight	=		35
INTEGER c1			=		11
INTEGER c2			=		12
INTEGER c3			=		13
INTEGER c4			=		14
INTEGER c5			=		15
INTEGER c6			=		16
INTEGER c7			=		17
INTEGER c8			=		18
INTEGER c9			=		19
INTEGER c0			=		10
INTEGER cPlay		=		45
INTEGER cStop		=		46
INTEGER cFF			=		22
INTEGER cRew		=		24
INTEGER cBack		=		26

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER DVD_BUTTONS[] =  {100,101,102,103,104,105,
														106,107,108,109,110,111,
														112,113,114,115,
													 116,117,118,119,120,121
												 }

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

//--------------------------TOUCH PANEL------------------//
BUTTON_EVENT[dvTP_DVD,DVD_BUTTONS]
{
  PUSH:
	 {
			TO[dvTP_DVD,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 100: PULSE[dvHDMI_Cinema,cMenu];
				 CASE 101: PULSE[dvHDMI_Cinema,cMenu];
				 CASE 102: PULSE[dvHDMI_Cinema,cUp];
				 CASE 103: PULSE[dvHDMI_Cinema,cDwn];
				 CASE 104: PULSE[dvHDMI_Cinema,cRight];
				 CASE 105: PULSE[dvHDMI_Cinema,cLeft];
				 CASE 106: PULSE[dvHDMI_Cinema,cOk];
				 CASE 107: PULSE[dvHDMI_Cinema,cBack];
				 CASE 108: PULSE[dvHDMI_Cinema,c1];
				 CASE 109: PULSE[dvHDMI_Cinema,c2];
				 CASE 110: PULSE[dvHDMI_Cinema,c3];
				 CASE 111: PULSE[dvHDMI_Cinema,c4];
				 CASE 112: PULSE[dvHDMI_Cinema,c5];
				 CASE 113: PULSE[dvHDMI_Cinema,c6];
				 CASE 114: PULSE[dvHDMI_Cinema,c7];
				 CASE 115: PULSE[dvHDMI_Cinema,c8];
				 CASE 116: PULSE[dvHDMI_Cinema,c9];
				 CASE 117: PULSE[dvHDMI_Cinema,c0];
				 CASE 118: PULSE[dvHDMI_Cinema,cPlay];
				 CASE 119: PULSE[dvHDMI_Cinema,cStop];
				 CASE 120: PULSE[dvHDMI_Cinema,cFF];
				 CASE 121: PULSE[dvHDMI_Cinema,cRew];
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