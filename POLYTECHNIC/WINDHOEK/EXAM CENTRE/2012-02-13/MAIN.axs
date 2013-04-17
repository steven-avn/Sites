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
	CLIENT: POLYTECHNIC EXAM CENTRE
	
	MASTER (NI-2100) IP: 192.168.1.101
	TP1 (NXD-430) IP: 192.168.1.102
	TP2 (NXD-430) IP: 192.168.1.103
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

///////////////////////RELAY DEVICES/////////////////////
dvSCREENS			=		5001:8:0		//SCREENS HALL 1 & 2

//////////////////////RS232 DEVICES////////////////////////
dvCLOUD1			=		5001:1:0		//CLOUD CX-462 AUDIO MIXER HALL 1
dvKRAMER			=		5001:2:0		//KRAMER VP-4x4K, 4X4 VGA/XGA & AUDIO MATRIX
dvCLOUD2			=		5001:3:0		//CLOUD CX-462 AUDIO MIXER HALL 2
dvPROJ1				=		5001:4:0		//3X SONY EX-100 PROJECTORS HALL 1
dvPROJ2				=		5001:5:0		//3X SONY EX-100 PROJECTORS HALL 2

//////////////////////ETHERNET DEVICES/////////////////////
dvTP1					=		11001:1:0		//TOUCH PANEL IN EXAM HALL 1
dvTP2					=		11002:1:0		//TOUCH PANEL IN EXAM HALL 1

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////SCREEN CONSTANTS///////////////////////////////
SCREEN1_UP     =  	 1		//SCREEN UP HALL 1
SCREEN1_DOWN   =  	 2		//SCREEN DOWN HALL 1
SCREEN2_UP     =  	 4		//SCREEN UP HALL 2        
SCREEN2_DOWN   =  	 3		//SCREEN DOWN HALL 2

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
VOLATILE INTEGER MUTE2 = 0				//Mute2 On=1, Off=2
VOLATILE INTEGER MICMUTE1 = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER MICMUTE2 = 0				//Mute2 On=1, Off=2
VOLATILE INTEGER VOL_LEVEL1	= 70	//Volume1 level for bargraph1
VOLATILE INTEGER MIC_LEVEL1 = 70		//Mic1 level for bargraph1
VOLATILE INTEGER VOL_LEVEL2 = 70		//Volume2 level for bargraph2
VOLATILE INTEGER MIC_LEVEL2 = 70		//Mic2 level for bargraph2

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
SEND_COMMAND dvCLOUD1,'SET BAUD,9600,N,8,1'		//Streight Cable,Digital(BackPanel),Remote(FrontPanel)
SEND_COMMAND dvCLOUD2,'SET BAUD,9600,N,8,1'		//Streight Cable,Digital(BackPanel),Remote(FrontPanel)
SEND_COMMAND dvPROJ1,"'SET BAUD,38400,E,8,1,DISABLE'"		//SONY EX-100 232 SETTINGS HALL 1
SEND_COMMAND dvPROJ2,"'SET BAUD,38400,E,8,1,DISABLE'"		//SONY EX-100 232 SETTINGS HALL 2

CREATE_LEVEL dvTP1,1,VOL_LEVEL1	//Level for TPbargraph
CREATE_LEVEL dvTP2,1,VOL_LEVEL2	//Level for TPbargraph

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//--------------------EXAM HALL 1-------------------------//
BUTTON_EVENT[dvTP1,TPBUTTONS]
{
	 PUSH:
	 {
			TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 1:	SEND_STRING dvKRAMER, "$01,$81,$81,$81"		//IN1 TO OUT1 (SMARTBOARD1)
									CALL 'Projector1_On'
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1
				 CASE 2:	SEND_STRING dvKRAMER, "$01,$82,$81,$81"		//IN2 TO OUT1 (POPUP1)
									CALL 'Projector1_On'
									SEND_STRING dvCLOUD1, '<MU,SA2/>'		//POPUP IN2
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1
				 CASE 3:	CALL 'Projector1_Off'		//PROJECTOR OFF
				 CASE 4:	IF (MUTE1 == 0)
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

//--------------------COMBINED HALL----------------------//
				 CASE 16:	SEND_STRING dvKRAMER, "$01,$81,$81,$81"		//IN1 TO OUT1 (SMARTBOARD1)
									SEND_STRING dvKRAMER, "$01,$81,$82,$81"		//IN1 TO OUT2 (SMARTBOARD1)
									CALL 'Projector1_On'
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1
									CALL 'Projector2_On'
									SEND_STRING dvCLOUD2, '<MU,SA3/>'		//SMARTBOARD IN3 (COMBINED)
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP2,1,VOL_LEVEL1
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP2,2,MIC_LEVEL1
									
				 CASE 17:	SEND_STRING dvKRAMER, "$01,$82,$81,$81"		//IN2 TO OUT1 (POPUP1)
									SEND_STRING dvKRAMER, "$01,$82,$82,$81"		//IN2 TO OUT2 (POPUP1)
									CALL 'Projector1_On'
									SEND_STRING dvCLOUD1, '<MU,SA2/>'		//POPUP IN2
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1
									CALL 'Projector2_On'
									SEND_STRING dvCLOUD2, '<MU,SA3/>'		//POPUP IN4
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP2,1,VOL_LEVEL1
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP2,2,MIC_LEVEL1
									
				 CASE 18:	CALL 'Projector1_Off'		//PROJECTOR OFF
									CALL 'Projector2_Off'		//PROJECTOR OFF									
				 CASE 8:	IF (MUTE1 == 0 || MUTE2 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
										 MUTE1 = 1
										 ON [dvTP1,8]
										 SEND_STRING dvCLOUD2, '<MU,M/>'		//MAIN MUTE
										 MUTE2 = 1
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
										 MUTE1 = 0
										 OFF [dvTP1,8]
										 SEND_STRING dvCLOUD2, '<MU,O/>'		//MAIN UNMUTE
										 MUTE2 = 0
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

				 CASE 6:	CALL 'Main1_VolUp'		//MAIN HALL VOLUME UP
									CALL 'Hall2_VolUp'		//SMALL HALL VOLUME UP
				 CASE 7:	CALL 'Main1_VolDown'		//MAIN HALL VOLUME DOWN
									CALL 'Hall2_VolDown'		//SMALL HALL VOLUME DOWN
				 CASE 14:	CALL 'Main1_MicUp'		//MAIN HALL MIC UP
									CALL 'Hall2_MicUp'		//SMALL HALL MIC UP
				 CASE 15:	CALL 'Main1_MicDown'		//MAIN HALL MIC DOWN
									CALL 'Hall2_MicDown'		//SMALL HALL MIC DOWN
			}
	 }
}

//--------------------EXAM HALL 2-------------------------//
BUTTON_EVENT[dvTP2,TPBUTTONS]
{
	 PUSH:
	 {
			TO[dvTP2,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 1:	SEND_STRING dvKRAMER, "$01,$83,$82,$81"		//IN3 TO OUT2 (SMARTBOARD1)
									CALL 'Projector2_On'		//PROJECTOR ON									SEND_STRING dvCLOUD2, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD2, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//SMARTBOARD IN1 LEVEL 50%
									SEND_LEVEL dvTP2,1,VOL_LEVEL2
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP2,2,MIC_LEVEL2
				 CASE 2:	SEND_STRING dvKRAMER, "$01,$84,$82,$81"		//IN4 TO OUT2 (POPUP1)
									CALL 'Projector2_On'		//PROJECTOR ON									SEND_STRING dvCLOUD2, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD2, '<MU,SA2/>'		//POPUP IN2
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP2,1,VOL_LEVEL2
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP2,2,MIC_LEVEL2
				 CASE 3:	CALL 'Projector2_Off'		//PROJECTOR OFF
				 CASE 4:	IF (MUTE2 == 0)
									{
										 SEND_STRING dvCLOUD2, '<MU,M/>'		//MAIN MUTE
										 MUTE2 = 1
										 ON [dvTP2,4]
									}
									ELSE
									{
										 SEND_STRING dvCLOUD2, '<MU,O/>'		//MAIN UNMUTE
										 MUTE2 = 0
										 OFF [dvTP2,4]
									}
			}	
	 }
}

BUTTON_EVENT[dvTP2,TPBUTTONS]
{
	 HOLD[1,REPEAT]:
	 {
			PULSE[dvTP2,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 10: CALL 'Hall2_VolUp'		//SMALL HALL VOLUME UP
				 CASE 11: CALL 'Hall2_VolDown'		//SMALL HALL VOLUME DOWN
				 CASE 12: CALL 'Hall2_MicUp'		//SMALL HALL MIC UP
				 CASE 13: CALL 'Hall2_MicDown'		//SMALL HALL MIC DOWN
			}
	 }
}


/*
//-------------------------VOLUME LEVELS-------------------------//
DATA_EVENT [dvCLOUD1]		//MAIN VOLUME 1
{
	STRING:
	{
			SEND_STRING 0, DATA.TEXT
			IF(FIND_STRING(DATA.TEXT,'<mu,la',1))		//ONLY IF STRING WITH 'mu,la' IS FOUND
			{
						NEW_STRING1 = REMOVE_STRING(DATA.TEXT, '<mu,1a',1)
						NEW_STRING2 = REMOVE_STRING(NEW_STRING1, '/>',1)
						//VolLev1 = MID_STRING(NEW_STRING, 1, 3)
						//VolLev1 = MID_STRING(DATA.TEXT, 7, 3)
						//NEW_STRING = LENGTH_STRING(VolLev1) - 7
						SEND_STRING 0, NEW_STRING2
						//SEND_LEVEL dvTP1, 1, NEW_STRING
			}
	}
}
*/
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP2,4] = MUTE2
[dvTP1,4] = MUTE1
[dvTP1,8] = MUTE1

IF (TIME = '21:45:00')
{
	 CALL 'Projector1_Off'		//PROJECTOR OFF
	 CALL 'Projector2_Off'		//PROJECTOR OFF
}
(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)