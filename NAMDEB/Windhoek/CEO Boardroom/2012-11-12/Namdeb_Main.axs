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
	CLIENT: Namdeb Windhoek (CEO Boardroom)
	MASTER SYSTEM 0 (DVX-3155HD) IP: 192.168.1.100

  *** AMX DVX-3155 PORT LAYOUT ***
      IN 1 - (DVI - REAR-VGA-L)
			IN 2 - (DVI - REAR-VGA-R)
		  IN 3 - (HDMI)
		  IN 4 - (HDMI)
			IN 5 - (HDMI)
			IN 6 - (HDMI)

			OUT 1 - (HDMI)
			OUT 2 - (HDMI)
			OUT 3 - (DX - VGA&HDMI-L&R)
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		05001:9:0		// IR Port 1
dvTP							=		10001:1:0		// Touch Panel
dvTP_POLY					=		10001:7:0		//POLYCOM TOUCH PANEL
// POLYCOM IR
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

VOLATILE INTEGER TPBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,
																  11,12,13,14,15,16,17,18,19,20,
																  21,22,23,24,25,26,27,28,29,30}
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
#INCLUDE 'POLYCOM'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

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

//				CASE 1: CALL 'PopupInput1'		//POPUP FRONT LEFT
//				CASE 2: CALL 'PopupInput2'		//POPUP FRONT RIGHT
//				CASE 3: CALL 'PopupInput3'		//POPUP REAR LEFT
//				CASE 4: CALL 'PopupInput4'		//POPUP REAR RIGHT
//				CASE 5: CALL 'VC'		//POLYCOM VIDEO CONFERENCE
//				
				CASE 6: CALL 'PowerOff'		// POWER OFF

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
//				 CASE 10: ON[MIC_1,140]		//MIC1 VOLUME UP
//								 WAIT 10
//								 OFF[MIC_1,140]
//				 CASE 11: ON[MIC_1,141]		//MIC2 VOLUME DOWN
//								 WAIT 10
//								 OFF[MIC_1,141]
				 CASE 12: IF (InputSelected == 1)
									{
										 ON[AUDIO_OUTPUT,140]		//MAIN VOLUME 1 UP
										 WAIT 10
										 OFF[AUDIO_OUTPUT,140]
									}
									ELSE
									{
										 ON[AUDIO_OUTPUT_LINE,140]		//MAIN VOLUME 2 UP
										 WAIT 10
										 OFF[AUDIO_OUTPUT_LINE,140]
									}
				 CASE 13: IF (InputSelected == 1)
									{
										 ON[AUDIO_OUTPUT,141]		//MAIN VOLUME 1 DOWN
										 WAIT 10
										 OFF[AUDIO_OUTPUT,141]
									}
									ELSE
									{
										 ON[AUDIO_OUTPUT_LINE,141]		//MAIN VOLUME 2 DOWN
										 WAIT 10
										 OFF[AUDIO_OUTPUT_LINE,141]
									}
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