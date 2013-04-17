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
VOLATILE CHAR VolLev1		//CHAR ARRAY TO HOLD LEVEL1 VALUE
VOLATILE CHAR MicLev1		//CHAR ARRAY TO HOLD MICROPHONE1 VALUE
VOLATILE CHAR VolLev2		//CHAR ARRAY TO HOLD LEVEL2 VALUE
VOLATILE CHAR MicLev2		//CHAR ARRAY TO HOLD MICROPHONE2 VALUE
VOLATILE INTEGER VOL_LEVEL1		//Volume1 level for bargraph1
VOLATILE INTEGER MIC_LEVEL1		//Mic1 level for bargraph1
VOLATILE INTEGER VOL_LEVEL2		//Volume2 level for bargraph2
VOLATILE INTEGER MIC_LEVEL2		//Mic2 level for bargraph2

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
SEND_COMMAND dvCLOUD2,'SET BAUD,9600,N,8,1'		//Streight Cable,Digital(BackPanel),Local(FrontPanel)
SEND_COMMAND dvPROJ1,"'SET BAUD,38400,E,8,1,DISABLE'"		//SONY EX-100 232 SETTINGS HALL 1
SEND_COMMAND dvPROJ2,"'SET BAUD,38400,E,8,1,DISABLE'"		//SONY EX-100 232 SETTINGS HALL 2

CREATE_LEVEL dvTP1,1,VOL_LEVEL1	//Level for TPbargraph
CREATE_LEVEL dvTP1,1,MIC_LEVEL1	//Level for TPbargraph
CREATE_LEVEL dvTP2,1,VOL_LEVEL2	//Level for TPbargraph
CREATE_LEVEL dvTP2,1,MIC_LEVEL2	//Level for TPbargraph

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
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
				 CASE 2:	SEND_STRING dvKRAMER, "$01,$82,$81,$81"		//IN2 TO OUT1 (POPUP1)
									CALL 'Projector1_On'
									SEND_STRING dvCLOUD1, '<MU,SA2/>'		//POPUP IN2
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
				 CASE 3:	CALL 'Projector1_Off'		//PROJECTOR OFF
				 CASE 4:	IF (MUTE1 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
										 MUTE1 = 1
										 SEND_LEVEL dvTP1, 1, 180
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
										 MUTE1 = 0
										 SEND_LEVEL dvTP1, 1, VOL_LEVEL1
									}
				 CASE 5:	IF (MICMUTE1 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MI,M/>'		//MAIN MUTE
										 MICMUTE1 = 1
										 SEND_LEVEL dvTP1, 2, 180
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MI,O/>'		//MAIN UNMUTE
										 MICMUTE1 = 0
										 SEND_LEVEL dvTP1, 2, MicLev1
									}

//--------------------COMBINED HALL----------------------//
				 CASE 16:	SEND_STRING dvKRAMER, "$01,$81,$81,$81"		//IN1 TO OUT1 (SMARTBOARD1)
									SEND_STRING dvKRAMER, "$01,$81,$82,$81"		//IN1 TO OUT2 (SMARTBOARD1)
									CALL 'Projector1_On'
									SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									WAIT 50
									SEND_STRING dvPROJ1, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									
									SEND_STRING dvCLOUD2, '<MU,SA3/>'		//SMARTBOARD IN3 (COMBINED)
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									
				 CASE 17:	SEND_STRING dvKRAMER, "$01,$82,$81,$81"		//IN2 TO OUT1 (POPUP1)
									SEND_STRING dvKRAMER, "$01,$82,$82,$81"		//IN2 TO OUT2 (POPUP1)
									SEND_COMMAND dvPROJ1,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ1, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									PULSE [dvSCREENS,SCREEN2_DOWN]
									PULSE [dvSCREENS,SCREEN1_DOWN]
									SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									SEND_STRING dvCLOUD1, '<MU,SA2/>'		//POPUP IN2
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									WAIT 50
									SEND_STRING dvPROJ1, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									
									SEND_STRING dvCLOUD2, '<MU,SA4/>'		//POPUP IN4
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									
				 CASE 18:	SEND_COMMAND dvPROJ1,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ1, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
									PULSE [dvSCREENS,SCREEN1_UP]
									
									SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
									PULSE [dvSCREENS,SCREEN2_UP]
									
				 CASE 8:	IF (MUTE1 == 0 || MUTE2 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
										 MUTE1 = 1
										 SEND_STRING dvCLOUD2, '<MU,M/>'		//MAIN MUTE
										 MUTE2 = 1
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
										 MUTE2 = 0
										 SEND_STRING dvCLOUD2, '<MU,O/>'		//MAIN UNMUTE
										 MUTE2 = 0
									}
				 CASE 9:	IF (MICMUTE1 == 0 || MICMUTE2 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MI,M/>'		//MAIN MUTE
										 MICMUTE1 = 1
										 SEND_STRING dvCLOUD2, '<MI,M/>'		//MAIN MUTE
										 MICMUTE2 = 1
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MI,O/>'		//MAIN UNMUTE
										 MICMUTE2 = 0
										 SEND_STRING dvCLOUD2, '<MI,O/>'		//MAIN UNMUTE
										 MICMUTE2 = 0
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
				 CASE 10:	SEND_STRING dvCLOUD1,'<MU,LU5/>'		//MAIN VOLUME UP
				 CASE 11:	SEND_STRING dvCLOUD1,'<MU,LD5/>'		//MAIN VOLUME DOWN
				 CASE 12:	SEND_STRING dvCLOUD1,'<MI,LU1/>'		//MIC VOLUME UP
				 CASE 13:	SEND_STRING dvCLOUD1,'<MI,LD1/>'		//MIC VOLUME DOWN

				 CASE 6:	SEND_STRING dvCLOUD1,'<MU,LU5/>'		//MAIN VOLUME UP
									SEND_STRING dvCLOUD2,'<MU,LU5/>'		//MAIN VOLUME UP
				 CASE 7:	SEND_STRING dvCLOUD1,'<MU,LD5/>'		//MAIN VOLUME DOWN
									SEND_STRING dvCLOUD2,'<MU,LD5/>'		//MAIN VOLUME DOWN
				 CASE 14:	SEND_STRING dvCLOUD1,'<MI,LU1/>'		//MIC VOLUME UP
									SEND_STRING dvCLOUD2,'<MI,LU1/>'		//MIC VOLUME UP
				 CASE 15:	SEND_STRING dvCLOUD1,'<MI,LD1/>'		//MIC VOLUME DOWN
									SEND_STRING dvCLOUD2,'<MI,LD1/>'		//MIC VOLUME DOWN
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
									SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									PULSE [dvSCREENS,SCREEN2_DOWN]
									SEND_STRING dvCLOUD2, '<MU,SA1/>'		//SMARTBOARD IN1
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
				 CASE 2:	SEND_STRING dvKRAMER, "$01,$84,$82,$81"		//IN4 TO OUT2 (POPUP1)
									SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
									PULSE [dvSCREENS,SCREEN2_DOWN]
									SEND_STRING dvCLOUD2, '<MU,SA2/>'		//POPUP IN2
									SEND_STRING dvCLOUD2, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_STRING dvCLOUD2, '<MI,LA40/>'		//MIC LEVEL 50%
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
				 CASE 3:	SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'  //SONY EX-100
									WAIT 50
									SEND_STRING dvPROJ2, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
									PULSE [dvSCREENS,SCREEN2_UP]
				 CASE 4:	IF (MUTE2 == 0)
									{
										 SEND_STRING dvCLOUD2, '<MU,M/>'		//MAIN MUTE
										 MUTE2 = 1
										 SEND_LEVEL dvTP2, 1, 180
									}
									ELSE
									{
										 SEND_STRING dvCLOUD2, '<MU,O/>'		//MAIN UNMUTE
										 MUTE2 = 0
										 SEND_LEVEL dvTP2, 1, VolLev2
									}
				 CASE 5:	IF (MICMUTE2 == 0)
									{
										 SEND_STRING dvCLOUD2, '<MI,M/>'		//MAIN MUTE
										 MICMUTE2 = 1
										 SEND_LEVEL dvTP2, 2, 180
									}
									ELSE
									{
										 SEND_STRING dvCLOUD2, '<MI,O/>'		//MAIN UNMUTE
										 MICMUTE2 = 0
										 SEND_LEVEL dvTP2, 2, MicLev2
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
				 CASE 10: SEND_STRING dvCLOUD2, '<MU,LU5/>'		//MAIN VOLUME UP
				 CASE 11: SEND_STRING dvCLOUD2, '<MU,LD5/>'		//MAIN VOLUME DOWN
				 CASE 12: SEND_STRING dvCLOUD2, '<MI,LU1/>'		//MIC VOLUME UP
				 CASE 13: SEND_STRING dvCLOUD2, '<MI,LD1/>'		//MIC VOLUME DOWN
			}
	 }
}

//-------------------------VOLUME LEVELS-------------------------//
DATA_EVENT [dvCLOUD1]		//MAIN VOLUME 1
{
	STRING:
	{
		SEND_STRING 0, DATA.TEXT
	  IF(FIND_STRING(DATA.TEXT,'<mu,la',1))		//ONLY IF STRING WITH 'mu,la' IS FOUND
		{
			VolLev1 = MID_STRING(DATA.TEXT, 7, 2)
			VOL_LEVEL1 = ATOI(VolLev1)
			SEND_LEVEL dvTP1, 1, VOL_LEVEL1
		}
	}
}

DATA_EVENT [dvCLOUD1]		//MICROPHONE VOLUME 1
{
	STRING:
	{
		SEND_STRING 0, DATA.TEXT
	  IF(FIND_STRING(DATA.TEXT,'<mi,la',1))		//ONLY IF STRING WITH 'mi,la' IS FOUND
		{
			MicLev1 = MID_STRING(DATA.TEXT, 7, 2)
			SEND_LEVEL dvTP1, 2, MicLev1
		}
	}
}

DATA_EVENT [dvCLOUD2]		//MAIN VOLUME 2
{
	STRING:
	{
		SEND_STRING 0, DATA.TEXT
	  IF(FIND_STRING(DATA.TEXT,'<mu,la',1))		//ONLY IF STRING WITH 'mu,la' IS FOUND
		{
			VolLev2 = MID_STRING(DATA.TEXT, 7, 2)
			SEND_LEVEL dvTP2, 1, VolLev2
		}
	}
}

DATA_EVENT [dvCLOUD2]		//MICROPHONE VOLUME 2
{
	STRING:
	{
		SEND_STRING 0, DATA.TEXT
	  IF(FIND_STRING(DATA.TEXT,'<mi,la',1))		//ONLY IF STRING WITH 'mi,la' IS FOUND
		{
			MicLev2 = MID_STRING(DATA.TEXT, 7, 2)
			SEND_LEVEL dvTP2, 2, MicLev2
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