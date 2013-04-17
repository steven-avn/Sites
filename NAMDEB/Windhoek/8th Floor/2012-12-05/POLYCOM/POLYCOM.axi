PROGRAM_NAME='POLYCOM'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    PROGRAMMER: Steven Grobler
		NI-2100: (IP)192.168.1.100 (DPS)5001
		WAP250: (IP)192.168.1.240 User:Admin Pass:1988 SSID:AMX Passphrase: Admin1988
		TP1: (IP)192.168.1.101 (DPS)10001
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

//dvPOLY		=	5001:6:0		//POLYCOM HDX 7000
dvTP_POLY		=	10001:7:0		//POLYCOM TOUCH PANEL

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER polyBACK = 1
INTEGER polyHOME = 2	
INTEGER polyDIRECTORY = 3
INTEGER polyCALL = 4
INTEGER polyCALL_END = 5
INTEGER polyMUTE = 6
INTEGER polyOK = 7
INTEGER polyStar = 8
INTEGER polyHash = 9	
INTEGER poly0 = 10	
INTEGER poly1 = 11
INTEGER poly2 = 12	
INTEGER poly3 = 13
INTEGER poly4 = 14
INTEGER poly5 = 15
INTEGER poly6 = 16
INTEGER poly7 = 17
INTEGER poly8 = 18
INTEGER poly9 = 19

INTEGER polyVOL_UP = 24	
INTEGER polyVOL_DN = 25
INTEGER polyZOOM_UP = 49	
INTEGER polyZOOM_DN = 50
INTEGER polyUP = 45
INTEGER polyRIGHT = 48
INTEGER polyDOWN = 46
INTEGER polyLEFT = 47

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER TPPOLYBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,
																  11,12,13,14,15,16,17,18,19,20,
																  21,22,23,24,25,26,27,28,29,30}

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

SET_PULSE_TIME (1)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP_POLY,TPPOLYBUTTONS]
{
		PUSH:
		{
				TO[dvTP_POLY,BUTTON.INPUT.CHANNEL]
				SWITCH(BUTTON.INPUT.CHANNEL)
				{
						CASE 1: PULSE[dvPOLY,polyBACK]		//BACK
						CASE 2: PULSE[dvPOLY,polyHOME]		//HOME
						CASE 3: PULSE[dvPOLY,polyDIRECTORY]		//DIRECTORY
						CASE 4: PULSE[dvPOLY,polyCALL]		//CALL
						CASE 5: PULSE[dvPOLY,polyCALL_END]		//END CALL
						CASE 6:	PULSE[dvPOLY,polyMUTE]		//MUTE
						CASE 7:	PULSE[dvPOLY,polyOK]		//OK
						CASE 8: PULSE[dvPOLY,polyStar]		//*
						CASE 9: PULSE[dvPOLY,polyHash]		//#
						CASE 10: PULSE[dvPOLY,poly0]		//0
						CASE 11: PULSE[dvPOLY,poly1]		//1
						CASE 12: PULSE[dvPOLY,poly2]		//2
						CASE 13: PULSE[dvPOLY,poly3]		//3
						CASE 14: PULSE[dvPOLY,poly4]		//4
						CASE 15: PULSE[dvPOLY,poly5]		//5
						CASE 16: PULSE[dvPOLY,poly6]		//6
						CASE 17: PULSE[dvPOLY,poly7]		//7
						CASE 18: PULSE[dvPOLY,poly8]		//8
						CASE 19: PULSE[dvPOLY,poly9]		//9
				}
		}
}

BUTTON_EVENT[dvTP_POLY,TPPOLYBUTTONS]
{
		HOLD[1,REPEAT]:
		{
				PULSE[dvTP_POLY,BUTTON.INPUT.CHANNEL]
				
				SWITCH(BUTTON.INPUT.CHANNEL)
				{
						CASE 20:PULSE[dvPOLY,polyVOL_UP]		//VOL UP
						CASE 21:PULSE[dvPOLY,polyVOL_DN]		//VOL DN
						CASE 22:PULSE[dvPOLY,polyZOOM_UP]		//ZOOM UP
						CASE 23:PULSE[dvPOLY,polyZOOM_DN]		//ZOOM DN
						CASE 24:PULSE[dvPOLY,polyUP]		//UP
						CASE 25:PULSE[dvPOLY,polyRIGHT]		//RIGHT
						CASE 26:PULSE[dvPOLY,polyDOWN]		//DOWN
						CASE 27:PULSE[dvPOLY,polyLEFT]		//LEFT
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