PROGRAM_NAME='BankOfNamibia_Main'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/15/2012  AT: 16:04:46        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: Bank of Namibia
	MASTER SYSTEM 0 (DVX-2155HD) IP: 192.168.1.100
	GBS HYBRID IP: 192.168.1.250
	Sony PCS-XG80 VC IP: 192.168.1.110
	DX-LINK TX (Podium) IP: 192.168.1.20
	DX-LINK TX (Wall) IP: 192.168.1.21
	DX-LINK RX (Projector) IP: 192.168.1.22

  *** AMX DVX-2155 PORT LAYOUT ***
      IN 1 - (DVI) PC
			IN 2 - (DVI) VC
		  IN 3 - (HDMI) PVR
			IN 5 - (DX) PODIUM
			IN 6 - (DX) WALL

			OUT 3 - (DX) PROJECTOR
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		05001:2:0		//SONY PROJECTOR RS-232(PORT 2)
dvPROJ_LIFT 			=		05001:4:0		//SONY PROJECTOR LIFT (Relay 1 = Up, 2 = Down)
dvTP							=		10001:2:0		//Touch Panel
dvKP							=		00085:1:0		//KeyPad
dvHDPVR1					=		05001:5:0		//MULTICHOICE HDPVR IR(PORT 1)

dvTX_Podium				=		15201:8:0		// DX-LINK TX FRONT PODIUM
dvTX_Wall					=		15202:8:0		// DX-LINK TX FRONT WALL OUTLET
dvRX_Projector		=		15203:6:0		// DX-LINK RX PROJECTOR IN ROOF

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
																		14,15,16,17,18,19,20,21,22,
																		23,24,25,26,27,28,29,30,31}

VOLATILE INTEGER KPBUTTONS[]	=	 {1,2,3,4,5,6,7,8}

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

#INCLUDE 'Green Box Systems Wired Initialisation'
#INCLUDE 'Sony_PCS_XG80_MAIN'
#INCLUDE 'AdvancedChannelDefinitions'
#INCLUDE 'FUNCTIONS'
#INCLUDE 'DSTV'
#INCLUDE 'BOSE_ESP'
#INCLUDE 'Bose ESP88 Audio Mixer Main'

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

				 CASE  1: SEND_COMMAND SWITCHER,"'CI1O2'"		//PC VIDEO IN1 TO OUT ALL

				 CASE  9: SEND_COMMAND SWITCHER,"'CI6O2'"		//WALLPLATE VIDEO IN6 TO OUT ALL

				 CASE  2: SEND_COMMAND SWITCHER,"'CI5O2'"		//PODIUM AUDIO/VIDEO IN5 TO OUT ALL

				 CASE  3: CALL 'PodiumInput'		//PODIUM INPUT SELECT
								  CALL 'Projector_On'		//PROJECTOR ON\
									CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON

				 CASE  4: CALL 'WallPlateInput'		//WALLPLATE INPUT SELECT
								  CALL 'Projector_On'		//PROJECTOR ON\
									CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON

				 CASE  5: CALL 'PCInput'		//PC INPUT SELECT
								  CALL 'Projector_On'		//PROJECTOR ON
									CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON

				 CASE  6: CALL 'VCInput'		//VIDEO CONFERENCING INPUT SELECT
								  CALL 'Projector_On'		//PROJECTOR ON\
									CALL 'VCLights_On'		//PRESENTATION LIGHTS ON

				 CASE  7: CALL 'DSTVInput'		//DSTV INPUT SELECT
								  CALL 'Projector_On'		//PROJECTOR ON\
									CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON

				 CASE  8: CALL 'Projector_Off'		//PROJECTOR OFF

			   CASE  10: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{
										 CALL 'AllLights_On'		//ALL LIGHTS SWITCH ON SELECT
										SEND_COMMAND 0,'All Lights on Button Pressed';
									}
									ELSE
									{
										 CALL 'AllLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
										SEND_COMMAND 0,'All Lights off Button Pressed';
								  }

				 CASE  11: CALL 'PresentationLights_On'
								   SEND_COMMAND 0,'Presentation Button Pressed';

			   CASE  12: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{
										 CALL 'StageLights_On'		//ALL LIGHTS SWITCH ON SELECT
									}
									ELSE
									{
										 CALL 'StageLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
									}
			   CASE  13: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{
										 CALL 'AudienceLights_On'		//ALL LIGHTS SWITCH ON SELECT
									}
									ELSE
									{
										 CALL 'AudienceLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
									}

			   CASE  14: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{
										 CALL 'SideLights_On'		//ALL LIGHTS SWITCH ON SELECT
									}
									ELSE
									{
										 CALL 'SideLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
									}
			   CASE  15: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{
										 CALL 'SpotLights_On'		//ALL LIGHTS SWITCH ON SELECT
									}
									ELSE
									{
										 CALL 'SpotLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
									}

			   CASE  16: CALL 'PresenterLights_On'		//ALL LIGHTS SWITCH ON SELECT

			}
	 }
}

BUTTON_EVENT[dvKP,KPBUTTONS]
{
  PUSH:
	 {
		TO[dvKP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			   CASE  1: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{
										 CALL 'AllLights_On'		//ALL LIGHTS SWITCH ON SELECT
									}
									ELSE
									{
										 CALL 'AllLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
									}

				 CASE  5: CALL 'PresenterLights_On'
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

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)