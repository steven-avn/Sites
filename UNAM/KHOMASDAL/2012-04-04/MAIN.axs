PROGRAM_NAME='MAIN'
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
	CLIENT: UNAM KHOMASDAL LECTURE HALLS
	
	MASTER (NI-2100) IP: 192.168.1.101
	TP1 (NXD-430) IP: 192.168.1.102
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

///////////////////////RELAY DEVICES/////////////////////
dvSCREENS			=		5001:8:0		//SCREENS

//////////////////////RS232 DEVICES////////////////////////
dvCLOUD1			=		5001:3:0		//CLOUD CX-462 AUDIO MIXER
dvKRAMER			=		5001:4:0		//KRAMER VP-4x4K, 4X4 VGA/XGA & AUDIO MATRIX
dvPROJ1				=		5001:2:0		//3X SONY EX-100 PROJECTORS
dvSMART				=		5001:1:0		//SMART UX60 SMARTBOARD

//////////////////////ETHERNET DEVICES/////////////////////
dvTP1					=		11001:1:0		//TOUCH PANEL IN EXAM

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////SCREEN CONSTANTS///////////////////////////////
SCREEN1_UP     =  	 1		//SCREEN UP
SCREEN1_DOWN   =  	 2		//SCREEN DOWN

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER TPBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
VOLATILE INTEGER MUTE1 = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER MICMUTE1 = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER VOL_LEVEL1	= 70	//Volume1 level for bargraph1
VOLATILE INTEGER MIC_LEVEL1 = 70		//Mic1 level for bargraph1

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

#INCLUDE 'FUNCTIONS'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvKRAMER,'SET BAUD,9600,N,8,1'		//Streight Cable, P2000 Protocol, All Off(RS485 dipswitches)
SEND_COMMAND dvCLOUD1,'SET BAUD,9600,N,8,1'		//Streight Cable,Digital(BackPanel),Local(FrontPanel)
SEND_COMMAND dvPROJ1,"'SET BAUD,38400,E,8,1,DISABLE'"		//SONY EX-100 232 SETTINGS HALL 1
SEND_COMMAND dvSMART,"'SET BAUD,19200,N,8,1'"		//SMART UX60 SMARTBOARD

CREATE_LEVEL dvTP1,1,VOL_LEVEL1	//Level for TPbargraph

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//-------------------- HALL 1 -------------------------//
BUTTON_EVENT[dvTP1,TPBUTTONS]
{
	 PUSH:
	 {
			TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 case 2:	SEND_STRING dvKRAMER, "$01,$81,$81,$81"		//IN1 TO OUT1 (SMARTBOARD1)
									CALL 'Projector1_On'
									CALL 'SmartBoard_On'
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//POPUP IN2
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1
				 case 3:	CALL 'Projector1_Off'		//PROJECTOR OFF
									CALL 'SmartBoard_Off'
				 case 4:	IF (MUTE1 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
										 MUTE1 = 1
										 ON [dvTP1,4]
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
										 MUTE1 = 0
										 OFF [dvTP1,4]
									}
			}
	 }
}

BUTTON_EVENT[dvTP1,TPBUTTONS]
{
	 HOLD[1,REPEAT]:
	 {
			PULSE[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 10:	CALL 'Main1_VolUp'		//MAIN HALL VOLUME UP
				 CASE 11:	CALL 'Main1_VolDown'		//MAIN HALL VOLUME DOWN
				 CASE 12:	CALL 'Main1_MicUp'		//MAIN HALL MIC UP
				 CASE 13:	CALL 'Main1_MicDown'		//MAIN HALL MIC DOWN
			}
	 }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP1,4] = MUTE1

/*
IF (TIME = '21:45:00')
{
	 CALL 'Projector1_Off'		//PROJECTOR OFF
	 CALL 'Projector2_Off'		//PROJECTOR OFF
}
*/
(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)