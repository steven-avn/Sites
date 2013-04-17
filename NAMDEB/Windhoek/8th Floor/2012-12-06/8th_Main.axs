PROGRAM_NAME='8th_Main'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/17/2012  AT: 10:22:29        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: Namdeb 8th Floor
	
	MASTER SYSTEM 0 (DVX-2155HD) IP: 192.168.1.100
  TOUCH PANEL (MVP-5200) IP: 192.168.1.101
	
	HDMI TX: (IP) 192.168.1.20 (DPS) 11001
	HDMI RX: (IP) 192.168.1.21 (DPS) 11002
	HDMI MULTI RX: (IP) 192.168.1.22 (DPS) 11003
	
	POLYCOM ADMIN PASSWORD: BDD2007
	
  *** AMX DVX-2155 PORT LAYOUT ***
      IN 1 - (PTN MATRIX)
			IN 2 - (DSTV)
		  IN 3 - (POPUP 1)
		  IN 4 - (POPUP 2)
			IN 5 - (VC VIA DX-LINK)
			IN 6 - ()

			OUT 3 - (PROJECTOR)
			
		*** PTN 8X8 VGA PORT LAYOUT ***
      IN 1 - (POPUP 1)
			IN 2 - (POPUP 2)
		  IN 3 - (POPUP 3)
		  IN 4 - (POPUP 4)
			IN 5 - (POPUP 5)
			IN 6 - (POPUP 6)
			IN 7 - ()
			IN 8 - ()

			OUT 1 - (DVX-2155 INPUT 1)

*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		 5001:6:0		// DELL PROJECTOR IR RX PORT 3
dvPOLY						=		 5001:7:0		//POLYCOM HDX 7000 IR TX PORT 3
dvTP							=		10001:1:0		// Touch Panel

// DVX 2155
SWITCHER				 	= 	5002:1:0		//AUDIO/VIDEO SWITCHER
AUDIO_INPUT_1			=		5002:1:0		//AUDIO INPUT 1
AUDIO_INPUT_2			=		5002:2:0		//AUDIO INPUT 2
AUDIO_OUTPUT_LINE	=		5002:1:0		//AUDIO LINE OUTPUT PORT 2
AUDIO_OUTPUT			=		5002:2:0		//AUDIO OUTPUT PORT 2
MIC_1							=		5002:7:0   // MIC INPUT 1
MIC_2							=		5002:8:0   // MIC INPUT 2

//VIDEO_INPUT_CHANNEL3	=	5002:3:0	// IN 5 - (DX) PODIUM
//VIDEO_INPUT_CHANNEL4	=	5002:4:0	// IN 6 - (DX) WALL
//VIDEO_INPUT_CHANNEL5	=	5002:5:0	// IN 5 - (DX) PODIUM
//VIDEO_INPUT_CHANNEL6	=	5002:6:0	// IN 6 - (DX) WALL
//
//VIDEO_OUTPUT_CHANNEL3	=	5002:3:0	// OUTPUT ON CHANNEL 3(DX-LINK)

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

VOLATILE INTEGER TPBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,11,12,13,
																		14,15,16,17,18,19,20,21,22,23,
																		24,25,26,27,28,29,30}
VOLATILE INTEGER MUTE = 0
VOLATILE INTEGER VOL_LEVEL1	= 70	//Volume1 level for bargraph1

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
#INCLUDE 'DSTV_HD'
#INCLUDE 'POLYCOM'
#INCLUDE 'MATRIX'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

create_level dvTP,1,VOL_LEVEL1	//Level1 for TPbargraph

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP,TPBUTTONS]
{
  PUSH:
	 {
		TO[dvTP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{

				 CASE 22: CALL 'VCInput'		// VC INPUT SELECT
								  SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 21: CALL 'DSTV'		// DSTV INPUT SELECT
								  SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 5: CALL 'PopupInput1HDMI'		// POPUP 1 HDMI INPUT SELECT
								 SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 7: CALL 'PopupInput2HDMI'		// POPUP 2 HDMI INPUT SELECT
								 SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 8: CALL 'PopupInput1'		// POPUP 1 INPUT SELECT
								 CALL 'PTNInput1'		// INPUT 1 SELECTED
								 SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE
								 
				 CASE 9: CALL 'PopupInput2'		// POPUP 2 INPUT SELECT
								 CALL 'PTNInput2'		// INPUT 2 SELECTED
								 SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 16: CALL 'PopupInput3'		// POPUP 3 INPUT SELECT
								  CALL 'PTNInput3'		// INPUT 3 SELECTED
									SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 18: CALL 'PopupInput4'		// POPUP 4 INPUT SELECT
								  CALL 'PTNInput4'		// INPUT 4 SELECTED
									SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 19: CALL 'PopupInput5'		// POPUP 5 INPUT SELECT
								  CALL 'PTNInput5'		// INPUT 5 SELECTED
									SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE

				 CASE 11: CALL 'PopupInput6'		// POPUP 6 INPUT SELECT
								  CALL 'PTNInput6'		// INPUT 6 SELECTED
									SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE
									
				 CASE 23: CALL 'Projector_On'		// POWER ON

				 CASE 20: CALL 'Projector_Off'		// POWER OFF
								  SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-ENABLE'"		// MUTE

				 CASE 3:IF(MUTE != 1)
								{
										SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-ENABLE'"		// MUTE
										MUTE = 1
								}
								ELSE
								{
										SEND_COMMAND AUDIO_OUTPUT,"'AUDOUT_MUTE-DISABLE'"	// UNMUTE
										MUTE = 0
								}
			}
	 }
}

BUTTON_EVENT[dvTP,1]		// VOLUME UP
BUTTON_EVENT[dvTP,2]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
				 CASE 1: ON[AUDIO_OUTPUT,140]		// VOLUME UP
								 WAIT 10
								 OFF[AUDIO_OUTPUT,140]
								 	 while (VOL_LEVEL1 >= 0 && VOL_LEVEL1 < 99)
									 {
											VOL_LEVEL1 = VOL_LEVEL1 + 2
											send_level dvTP,1,VOL_LEVEL1
									 }

				 CASE 2: ON[AUDIO_OUTPUT,141]		// VOLUME DOWN
								 WAIT 10
								 OFF[AUDIO_OUTPUT,141]
								 	 while (VOL_LEVEL1 >= 0 && VOL_LEVEL1 < 99)
									 {
											VOL_LEVEL1 = VOL_LEVEL1 - 2
											send_level dvTP,1,VOL_LEVEL1
									 }
		}
  }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,3] = MUTE

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)