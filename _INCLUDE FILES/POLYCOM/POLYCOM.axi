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

dvPOLY		=	05001:7:		//POLYCOM HDX 7000
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

VOLATILE INTEGER TPBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,
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

BUTTON_EVENT[dvTP_POLY,TPBUTTONS]
{
		push:
		{
				to[dvTP_POLY,BUTTON.INPUT.CHANNEL]
				
				switch(BUTTON.INPUT.CHANNEL)
				{
						case 1: pulse[dvPOLY,polyBACK]		//BACK
						case 2: pulse[dvPOLY,polyHOME]		//HOME
						case 3: pulse[dvPOLY,polyDIRECTORY]		//DIRECTORY
						case 4: pulse[dvPOLY,polyCALL]		//CALL
						case 5: pulse[dvPOLY,polyCALL_END]		//END CALL
						case 6:	pulse[dvPOLY,polyMUTE]		//MUTE
						case 7:	pulse[dvPOLY,polyOK]		//OK
						case 8: pulse[dvPOLY,polyStar]		//*
						case 9: pulse[dvPOLY,polyHash]		//#
						case 10: pulse[dvPOLY,poly0]		//0
						case 11: pulse[dvPOLY,poly1]		//1
						case 12: pulse[dvPOLY,poly2]		//2
						case 13: pulse[dvPOLY,poly3]		//3
						case 14: pulse[dvPOLY,poly4]		//4
						case 15: pulse[dvPOLY,poly5]		//5
						case 16: pulse[dvPOLY,poly6]		//6
						case 17: pulse[dvPOLY,poly7]		//7
						case 18: pulse[dvPOLY,poly8]		//8
						case 19: pulse[dvPOLY,poly9]		//9
				}
		}
}

BUTTON_EVENT[dvTP_POLY,TPBUTTONS]
{
		hold[1,repeat]:
		{
				to[dvTP_POLY,BUTTON.INPUT.CHANNEL]
				
				switch(BUTTON.INPUT.CHANNEL)
				{
						case 20:	TO[dvPOLY,polyVOL_UP]		//VOL UP
						case 21:	TO[dvPOLY,polyVOL_DN]		//VOL DN
						case 22:	TO[dvPOLY,polyZOOM_UP]		//ZOOM UP
						case 23:	TO[dvPOLY,polyZOOM_DN]		//ZOOM DN
						case 24:	TO[dvPOLY,polyUP]		//UP
						case 25:	TO[dvPOLY,polyRIGHT]		//RIGHT
						case 26:	TO[dvPOLY,polyDOWN]		//DOWN
						case 27:	TO[dvPOLY,polyLEFT]		//LEFT
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