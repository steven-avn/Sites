PROGRAM_NAME='Main'
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
																									 SSID:AMX2 Passphrase: Admin19882
		TP(Galaxy Pad): (IP)192.168.1.101 (DPS)10001
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvTV_Left		=	05001:5:0		//Proline TV on IR1 Left Side
dvTV_Right	=	05001:6:0		//Proline TV on IR2 Right Side

dvTP				=	11001:1:0		//Galaxy Pad with TPControl
dvPOLY			=	05001:7:0		//POLYCOM HDX 7000 on IR3

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

INTEGER TpButtons[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
												16,17,18,19,20,21,22,23,24,25,26,27,
												28,29,30,110,111,112,113,114,115,116,
												117,118,119,120,121,122,123,124,125,126
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

//SET_PULSE_TIME (1)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP,TpButtons]
{
  PUSH:
	 {
      TO[dvTP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
	    {
				 CASE 30:	 PULSE[dvTV_Left,1]		//Switches TV_Left on
									 PULSE[dvTV_Right,1]		//Switches TV_Right on
									 SEND_STRING 0, 'TVs switched on';
				 CASE 29:	 PULSE[dvTV_Left,2]		//Switches TV_Left off
									 PULSE[dvTV_Right,2]		//Switches TV_Right off
									 SEND_STRING 0, 'TVs switched off';
				 CASE 1: 	 PULSE[dvPOLY,83]		//BACK
				 CASE 2: 	 PULSE[dvPOLY,82]		//HOME
				 CASE 3: 	 PULSE[dvPOLY,81]		//DIRECTORY
				 CASE 4: 	 PULSE[dvPOLY,81]		//CALL
				 CASE 5: 	 PULSE[dvPOLY,55]		//END CALL
				 CASE 13:	 PULSE[dvPOLY,26]		//MUTE
				 CASE 25:	 PULSE[dvPOLY,94]		//OK
				 CASE 111: PULSE[dvPOLY,11]		//1
				 CASE 112: PULSE[dvPOLY,12]		//2
				 CASE 113: PULSE[dvPOLY,13]		//3
				 CASE 114: PULSE[dvPOLY,14]		//4
				 CASE 115: PULSE[dvPOLY,15]		//5
				 CASE 116: PULSE[dvPOLY,16]		//6
				 CASE 117: PULSE[dvPOLY,17]		//7
				 CASE 118: PULSE[dvPOLY,18]		//8
				 CASE 119: PULSE[dvPOLY,19]		//9
				 CASE 120: PULSE[dvPOLY,10]		//0
				 CASE 121: PULSE[dvPOLY,93]		//*
				 CASE 122: PULSE[dvPOLY,92]		//#
			}
	 }
}

BUTTON_EVENT[dvTP,TpButtons]
{
  HOLD[1,REPEAT]:
	 {
			PULSE[dvTP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 12:	PULSE[dvPOLY,24]		//VOL UP
				 CASE 14:	PULSE[dvPOLY,25]		//VOL DN
				 CASE 15:	PULSE[dvPOLY,49]		//ZOOM UP
				 CASE 16:	PULSE[dvPOLY,50]		//ZOOM DN
				 CASE 21:	PULSE[dvPOLY,45]		//UP
				 CASE 22:	PULSE[dvPOLY,48]		//RIGHT
				 CASE 23:	PULSE[dvPOLY,46]		//DOWN
				 CASE 24:	PULSE[dvPOLY,47]		//LEFT
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