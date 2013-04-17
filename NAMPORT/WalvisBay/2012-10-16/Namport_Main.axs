PROGRAM_NAME='BankOfNamibia_Main'
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
	CLIENT: Namport WalvisBay
	MASTER SYSTEM 0 (DVX-2155HD) IP: 192.168.1.100

  *** AMX DVX-2155 PORT LAYOUT ***
      IN 1 - (DVI)
			IN 2 - (DVI)
		  IN 3 - (HDMI)
		  IN 4 - (HDMI)
			IN 5 - (HDMI)
			IN 6 - (HDMI)

			OUT 1 - (HDMI)
			OUT 2 - (HDMI)
			OUT 3 - (DX)
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		05001:1:0		// SONY PROJECTOR RS-232(PORT 2)
dvCLOUD						=		05001:2:0		// CLOUD 462 MIXER
dvTP							=		10001:1:0		// Touch Panel

// DVX 2155
SWITCHER				 	= 	5002:1:0		//AUDIO/VIDEO SWITCHER
AUDIO_INPUT_1			=		5002:1:0		//AUDIO INPUT 1
AUDIO_INPUT_2			=		5002:2:0		//AUDIO INPUT 2
AUDIO_OUTPUT_LINE	=		5002:2:1		//AUDIO LINE OUTPUT PORT 2
AUDIO_OUTPUT			=		5002:1:1		//AUDIO OUTPUT PORT 1
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
																		14,15,16,17,18,19,20}
VOLATILE INTEGER MUTE = 0

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

SEND_COMMAND dvCLOUD,"'SET BAUD,9600,N,8,1'"		//Streight Cable,Digital(BackPanel),Local(FrontPanel)

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

				 CASE 10: CALL 'VCInput'		//PC INPUT SELECT

				 CASE 11: CALL 'PopupInput'		//PC INPUT SELECT

				 CASE 12: CALL 'PCInput'		//PC INPUT SELECT

				 CASE 20: CALL 'PowerOff'		// POWER OFF

				 CASE 3:IF(MUTE != 1)
								{
										SEND_STRING dvCLOUD, '<MU,M/>'	//MAIN MUTE
										MUTE = 1
								}
								ELSE
								{
										SEND_STRING dvCLOUD, '<MU,O/>'	//MAIN UNMUTE
										MUTE = 0
								}
			}
	 }
}

BUTTON_EVENT[dvTP,TPBUTTONS]
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 1: SEND_STRING dvCLOUD, "'<MU,LU5/>'"				//MAIN VOLUME UP
			CASE 2: SEND_STRING dvCLOUD, "'<MU,LD5/>'"				//MAIN VOLUME DOWN
		}
  }
}

//DATA_EVENT[SWITCHER]
//{
//   COMMAND:
//  {
//    SEND_STRING 0, DATA.TEXT;
//  }
//   ONLINE:
//  {
//    SEND_STRING 0, 'Switcher Online';
//		SEND_COMMAND SWITCHER,"'VIDOUT_ON-ON'"
//		SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'DXLINK_IN_ETH-auto'"
//		SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'DXLINK_IN_ETH-auto'"
//		SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'DXLINK_ETH-auto'"
//		SEND_COMMAND dvTX_Podium,"'VIDIN_AUTO_SELECT-ENABLE'";
//		SEND_COMMAND dvTX_Wall,"'VIDIN_AUTO_SELECT-ENABLE'";
//		SEND_COMMAND dvRX_Projector,"'VIDIN_AUTO_SELECT-ENABLE'";
//		SEND_COMMAND dvRX_Projector, "'ICSLAN-ENABLE'";
//		SEND_COMMAND dvTX_Podium, "'ICSLAN-ENABLE'";
//		SEND_COMMAND dvTX_Wall, "'ICSLAN-ENABLE'";
//  }
//}
//
//
//
//DATA_EVENT [VIDEO_INPUT_CHANNEL3]		//
//{
//   COMMAND:
//  {
//    SEND_STRING 0, DATA.TEXT;
//  }
//}
//
//DATA_EVENT [VIDEO_INPUT_CHANNEL4]		//
//{
//   COMMAND:
//  {
//    SEND_STRING 0, DATA.TEXT;
//  }
//}
//
//DATA_EVENT [VIDEO_INPUT_CHANNEL5]		//
//{
//   COMMAND:
//  {
//    SEND_STRING 0, DATA.TEXT;
//  }
//}
//
//DATA_EVENT [VIDEO_INPUT_CHANNEL6]		//
//{
//   COMMAND:
//  {
//    SEND_STRING 0, DATA.TEXT;
//  }
//}
//
//DATA_EVENT [VIDEO_OUTPUT_CHANNEL3]		//
//{
//   COMMAND:
//  {
//    SEND_STRING 0, DATA.TEXT;
//  }
//}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,3] = MUTE

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)