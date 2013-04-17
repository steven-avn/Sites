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
	 CLIENT: HOUSE OOSTHUIZEN
	
	 MAIN CONTROLLER: NI-4100 (IP)192.168.1.101
	 MAIN TOUCH PANEL: MVP-5100i (IP)192.168.1.102
	 
	 HDMI 8-WAY MATRIX: PTN UTPRO (IP)192.168.1.103
		### INPUTS ###
			01 - PVR 1
			02 - PVR 2
			03 - CCTV
			04 - APACER DOWNSTAIRS
			05 - iMERGE 1
			06 - iMERGE 2
			07 - iMERGE 3
			08 - APACER UPSTAIRS
		### OUTPUTS ###
			01 - MAIN BEDROOM
			02 - CINEMA ROOM
			03 - BEDROOM 1
			04 - BEDROOM 2
			05 - GYM
			06 - KITCHEN
			07 - PATIO
			08 - FAMILY TV ROOM

	 iMERGE S3000 MEDIA SERVER: (IP) 192.168.1.140
	 
	 INTERCOM (FRONT GATE): (IP) 192.168.1.110 (DPS) 11001
	 INTERCOM (FRONT DOOR): (IP) 192.168.1.111 (DPS) 11002
	 
	 SSID: AMX (IP) 192.168.1.1 User: admin Pass: admin
	 Passphrase: audiovision
	 
	 GBS HYBRID IP INTERFACE (DB2 - KITCHEN): (IP)192.168.1.251 Port:18
	 
	 MEDIA PC: (IP) 192.168.1.150
	 APACER(MAIN BEDROOM): (IP) 192.168.1.151
	 APACER(BEDROOM 1): (IP) 192.168.1.152
	 
	 AMX ZIGBEE BEDROOM 2:(IP)192.168.1.120 (DPS)10100 #A50030
	 AMX ZIGBEE BEDROOM 1:(IP)192.168.1.121 (DPS)10101 #A0065
	 AMX ZIGBEE MIAN BEDROOM:(IP)192.168.1.122 (DPS)10102 #A0086
	 AMX ZIGBEE FAMILY TV ROOM:(IP)192.168.1.123 (DPS)10103 #A10030
	 AMX ZIGBEE GUEST FLAT:(IP)192.168.1.124 (DPS)10104 #A0151
	 
	 AMX R4 BEDROOM 2: (DPS)10200
	 AMX R4 BEDROOM 1: (DPS)10201
	 AMX R4 MIAN BEDROOM: (DPS)10202
	 AMX R4 FAMILY TV ROOM: (DPS)10203
	 AMX R4 GUEST FLAT: (DPS)10204
	 
	 DAS TANGO CONTROLER
		### INPUTS ###
			01 - RADIO
			02 - PVR 1
			03 - PVR 2
			04 - APACER UP
			05 - iMERGE 1
			06 - iMERGE 2
			07 - iMERGE 3
			08 - APACER DOWN
		### OUTPUTS ###
			01 - 
			02 - BEDROOM 1
			03 - BEDROOM 2
			04 - MAIN BEDROOM
			05 - 
			06 - 
			07 - DINING/LOUNGE
			08 - KITCHEN
	 EXPANDER
			09 - GYM
			10 - FAMILY TV ROOM
			11 - PATIO
			12 - ROOF GARDEN
			13 - 
			14 - 
			15 - 
			16 -
	 
	 CISCO SWITCH: (IP)192.168.1.2 User: cisco Pass: amx
	 (1-12 -> POE; 13-24 -> 0V)
	 
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

///////////////////////AXLINK DEVICES/////////////////////
dvKP_MainBedrm			=		0215:1:0		// MAIN BEDROOM KEYPAD
dvKP_Bedrm2					=		0085:1:0		// BEDROOM 2 KEYPAD BOYS
dvKP_Bedrm1					=		0086:1:0		// BEDROOM 1 KEYPAD GIRLS
dvKP_Gym						=		0087:1:0		// GYM ROOM KEYPAD
dvKP_FamTvRm				=		0088:1:0		// FAMILY TV ROOM KEYPAD
dvKP_EntrLobby1			=		0089:1:0		// ENTRANCE LOBBY KEYPAD STAIRS
dvKP_EntrLobby2			=		0090:1:0		// ENTRANCE LOBBY KEYPAD LOBBY
dvKP_DinningRm			=		0064:1:0		// DINING ROOM KEYPAD (BROKEN) (91)
dvKP_Scullary				=		0092:1:0		// SCULLARY KEYPAD
dvKP_Patio					=		0093:1:0		// PATIO KEYPAD
dvKP_Kitchen				=		0067:1:0		// KITCHEN KEYPAD	(67)
dvKP_EntertArea1		=		0171:1:0		// ENTERTAINMENT AREA KEYPAD WITH WHEEL
dvKP_EntertArea			=		0095:1:0		// ENTERTAINMENT AREA KEYPAD
dvKP_Study					=		0128:1:0		// STUDY KEYPAD (96)
dvKP_Jacuzi					=		0007:1:0		// ROOF GARDEN KEYPAD (7)
dvKP_GuestLounge		=		0098:1:0		// GUEST FLAT LOUNGE KEYPAD
dvKP_GuestBedRm1		=		0100:1:0		// GUEST FLAT BEDROOM 1 KEYPAD REGS
dvKP_GuestBedRm2		=		0099:1:0		// GUEST FLAT BEDROOM 2 KEYPAD LINKS
dvKP_WineCellar			=		0103:1:0		// WINE CELLAR KEYPAD
dvKP_MaidRoom				=		0084:1:0		// MAID ROOM KEYPAD

//////////////////////RS232 DEVICES////////////////////////
dvMatrixAudioSerial = 	5001:1:0 // Serial device...COMMENT OUT IF USING IP
dvProjMainBedRm			=		5001:3:0		// SONY VPL-BW7 PROJECTOR MAIN BEDROOM
dvProjCinemaRoom		=		5001:6:0		// PROJECTOR CINEMA ROOM

//////////////////////ETHERNET DEVICES/////////////////////
dvTP								=		10001:7:0		// AMX MVP-5200i TOUCH PANEL
dvTP_DVD  					=		10001:8:0		// AMX MVP-5200i TOUCH PANEL
dvTP_CINEMA					=		10001:9:0		// AMX MVP-5200i TOUCH PANEL
dvTP_DSTV						=		10001:6:0		// AMX MVP-5200i TOUCH PANEL FOR DSTV
dvTP_PVR						=		10001:3:0		// SAMSUNG SHR-7160 DVR
dvTP_RADIO					=		10001:4:0		// TANGO RADIO
dvTP_APACER					=		10001:5:0		// APACER VIDEO PLAYER
dvUTPRO_HDMI				=		 5500:1:1		// HDMI MATRIX SWITCHER
dvHDMI_FamTV				=		 5508:3:0		// HDMI Family TV Room
dvHDMI_MainBedRm		=		 5501:3:0		// HDMI Main Bedroom
dvHDMI_Bedroom1			=		 5503:3:0		// HDMI Bedroom1
dvHDMI_Bedroom2			=		 5504:3:0		// HDMI Bedroom2
dvHDMI_MultiPurp		=		 5505:3:0		// HDMI Gym
dvHDMI_Kitchen			=		 5506:3:0		// HDMI Kitchen
dvHDMI_Patio				=		 5507:3:0		// HDMI Patio
dvIntercomFrontDoorRelay	=	11002:3:0		// Metreau Intercom Relay for Front Door
dvIntercomFrontDoor		=	11001:1:0		 //Metreau Intercom Front Door
dvIntercomGate			=	11002:1:0		 //Metreau Intercom Front Door

//////////////////////IR DEVICES///////////////////////////
dvHDPVR1						=		 5001:9:0		// 1ST DSTV HD PVR
dvHDPVR2						=		 5001:10:0		// 2ND DSTV HD PVR
dvCameraPVR					=		 5001:11:0		// 3RD SAMSUNG SHR-7160 DVR
dvApacerDown				=		 5001:12:0		// 1st Apacer IR4
dvApacerUp					=		 5001:13:0		// 2nd Apacer IR5
dvHDMI_Cinema				=		 5001:14:0		// HDMI B&O SYSTEM CINEMA ROOM

//////////////////////RELAY DEVICES///////////////////////////
dvProjLiftMainBedRm	=		 5001:8:0		// RELAY DEVICES 1-UP, 2-DOWN
dvScreenMainBedRm		=		 5001:8:0		// RELAY DEVICES 3-UP, 4-DOWN
dvCurtainOutMainBedRm	=		5001:8:0		// RELAY DEVICES 5-CLOSE, 6-OPEN
dvCurtainInMainBedRm	=		5001:8:0		// RELAY DEVICES 7-CLOSE, 8-OPEN
dvRELAY10CARD	=		 2017:1:0		// RELAY CARD RELAY 1

///////////////////////ZIGBEE DEVICES/////////////////////
dvR4_MainBedrm			=		10200:1:0		// MAIN BEDROOM R4
dvR4_Bedrm2					=		10201:1:0		// BEDROOM 2 R4
dvR4_Bedrm1					=		10202:1:0		// BEDROOM 1 R4
dvR4_FamTvRm				=		10203:1:0		// FAMILY TV ROOM R4
dvR4_Study					=		10204:1:0		// STUDY R4
dvR4_Flat						=		10205:1:0		// GUEST FLAT R4

dvR4_Radio_MainBedrm	=		10200:3:0		// MAIN BEDROOM R4
dvR4_Radio_Bedrm2			=		10201:3:0		// BEDROOM 2 R4
dvR4_Radio_Bedrm1			=		10202:3:0		// BEDROOM 1 R4
dvR4_Radio_FamTvRm		=		10203:3:0		// FAMILY TV ROOM R4
dvR4_Radio_Study			=		10204:3:0		// STUDY R4

//////////////////////iMERGE S3000///////////////////////////
//// The panel devices - up to 16 currently but more possible
//// Device numbers can be according to you own scheme
dvXiVAPanel_01	= 10001:2:0;	// G4	MAIN TOUCH PANEL
dvXiVAPanel_02	= 10200:2:0;	// G4 MASTER BEDROOM
dvXiVAPanel_03	= 10202:2:0;	// G4	BEDROOM 1
dvXiVAPanel_04	= 10201:2:0;	// G4	BEDROOM 2
dvXiVAPanel_05	= 10203:2:0;	// G4 FAMILY TV ROOM
//dvXiVAPanel_06	= 10006:2:0;	// G4
//dvXiVAPanel_07	= 00128:1:0;	// G3 <- Devices 1-255 will be treated as G3 by the module.
//dvXiVAPanel_08	= 11008:2:0;	// MIO-DMS
//dvXiVAPanel_09	= 10009:2:0;	// Spare Devs
//dvXiVAPanel_10	= 10010:2:0;
//dvXiVAPanel_11	= 10011:2:0;
//dvXiVAPanel_12	= 10012:2:0;
//dvXiVAPanel_13	= 10013:2:0;
//dvXiVAPanel_14	= 10014:2:0;
//dvXiVAPanel_15	= 10015:2:0;
//dvXiVAPanel_16	= 10016:2:0;

vdvXIVAModule	= 33001:1:0;	// virtual device for the module itself
dvXIVALinkPri	= 0:2:0; // Main XiVALink IP Connection
dvXIVALinkSec	= 0:3:0; // Supplimentary XiVALink IP Connection
dvDebug = 0:0:0; // Debug output device

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


DEFINE_COMBINE

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nZoneCount    =   192	// Number of zones on NX-8E

VOLATILE INTEGER VOL_LEVEL		// VOLUME LEVEL FOR BARGRAPH

char serverip[] = '192.168.1.140';	// S3000 4 Output

//// List of Panels that will be controlling the XiVA Server
//// Only enter the actual panels you need.
dev dvXiVAPanels[] = 
{ 
	dvXiVAPanel_01,
	dvXiVAPanel_02,
	dvXiVAPanel_03,
	dvXiVAPanel_04
//	dvXiVAPanel_05
//	dvXiVAPanel_06,
//	dvXiVAPanel_07,
//	dvXiVAPanel_08
//	dvXiVAPanel_09,
//	dvXiVAPanel_10,
//	dvXiVAPanel_11,
//	dvXiVAPanel_12,
//	dvXiVAPanel_13,
//	dvXiVAPanel_14,
//	dvXiVAPanel_15,
//	dvXiVAPanel_16
}

VOLATILE INTEGER vLightsMainBedRmBath = 0
VOLATILE INTEGER vLightsMainBedRmRoom = 0

VOLATILE INTEGER vLightsBedRm1Lamp = 0
VOLATILE INTEGER vLightsBedRm1Down = 0

VOLATILE INTEGER vLightsBedRm2Lamp = 0
VOLATILE INTEGER vLightsBedRm2Down = 0

VOLATILE INTEGER vLightsDining = 0

VOLATILE INTEGER vLightsEntertRm = 0
VOLATILE INTEGER vLightsEntertRmStar = 0

VOLATILE INTEGER vLightsPassages = 0

VOLATILE INTEGER vLightsFamTvRm = 0

VOLATILE INTEGER vLightsLounge = 0
VOLATILE INTEGER vLightsLoungeFloor = 0

VOLATILE INTEGER vLightsGuestLounge = 0
VOLATILE INTEGER vLightsGuestBedRm1 = 0
VOLATILE INTEGER vLightsGuestBedRm2 = 0

VOLATILE INTEGER vLightsMultiPurpRm = 0

VOLATILE INTEGER vLightsKitchen = 0

VOLATILE INTEGER vLightsPatio = 0;
VOLATILE INTEGER vLightsPatioPool = 0;
VOLATILE INTEGER vLightsOutside = 0;
VOLATILE INTEGER vLightsFountOutside = 0;
VOLATILE INTEGER vPumpFountInside = 0;
VOLATILE INTEGER vPumpFountOutside = 0;

VOLATILE INTEGER vLightsJacuzi = 0

VOLATILE INTEGER vLightsScullary = 0

VOLATILE INTEGER vLightsMaidRm = 0

VOLATILE INTEGER vLightsStudy = 0
VOLATILE INTEGER vLightsBalcony = 0

VOLATILE INTEGER vLightsWineCellar = 0

VOLATILE INTEGER vAlarmState = 0

VOLATILE INTEGER vUnderFloorHeating = 0

VOLATILE INTEGER vButtkicker = 0

VOLATILE INTEGER vCurtainOpen = 1
VOLATILE INTEGER vCurtainClose = 0
VOLATILE INTEGER vCurtainTV = 0
VOLATILE INTEGER vCurtainCinema = 0

VOLATILE INTEGER vLightsPassage1 = 0;
VOLATILE INTEGER vLightsPassage2 = 0;
VOLATILE INTEGER vLightsEntrance = 0;

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

Define_Module 'XIVA Link v2 Driver' mdlXIVA(vdvXIVAModule, dvXIVALinkPri,dvXIVALinkSec,serverip,  dvXiVAPanels, dvDebug);

#INCLUDE 'Green Box Systems Wired Initialisation.AXI'
#INCLUDE 'AMX_MatrixAudio_MiSeries_MAIN'
#INCLUDE 'FUNCTIONS'
#INCLUDE 'GBS_FUNCTIONS'
#INCLUDE 'DSTV'
#INCLUDE 'Camera'
#INCLUDE 'Radio'
#INCLUDE 'Apacer'
#INCLUDE 'Lights'
#INCLUDE 'Alarm'
#INCLUDE 'AMX_Intercom_Main'
#INCLUDE 'mainBedroom'
#INCLUDE 'bedroom1'
#INCLUDE 'bedroom2'
#INCLUDE 'jacuzi'
#INCLUDE 'Gym'
#INCLUDE 'familyTVroom'
#INCLUDE 'entranceLobby'
#INCLUDE 'diningLounge'
#INCLUDE 'patio'
#INCLUDE 'kitchen'
#INCLUDE 'entertainmentArea'
#INCLUDE 'study'
#INCLUDE 'guestFlat'
#INCLUDE 'wineCellar'
#INCLUDE 'servantRoom'
#INCLUDE 'scullary'
#INCLUDE 'B&O DVD'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvUTPRO_HDMI,'SET BAUD,9600,N,8,1'		//UTPRO-HDMI SERIAL COMMS SETTINGS
SEND_COMMAND dvMatrixAudioSerial,'SET BAUD,9600,N,8,1'		//TANGO 1 SERIAL COMMS SETTINGS
SEND_COMMAND dvProjMainBedRm,'SET BAUD,38400,E,8,1,DISABLE'		//SONY VPL-BW7 PROJECTOR SERIAL COMMS SETTINGS
SEND_COMMAND dvProjCinemaRoom,'SET BAUD,19200,N,8,1,DISABLE'		// NERO 3D PROJECTOR CINEMA ROOM

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


BUTTON_EVENT[dvIntercomGate,1]	// FRONT DOOR RELAY
{
  PUSH:
  {
		ON [dvRELAY10CARD,3];
		WAIT 20
		OFF [dvRELAY10CARD,3];
  }
}

BUTTON_EVENT[dvIntercomFrontDoor,1]	// FRONT DOOR RELAY
{
  PUSH:
  {
		ON [dvRELAY10CARD,3];
		WAIT 20
		OFF [dvRELAY10CARD,3];
  }
}

BUTTON_EVENT[dvTP,21]	// FRONT DOOR RELAY
{
  PUSH:
  {
		ON [dvRELAY10CARD,2];
		WAIT 50
		OFF [dvRELAY10CARD,2];
  }
}

BUTTON_EVENT[dvTP_CINEMA,1]	// CINEMA ROOM CURTAINS OPEN
{
  PUSH:
  {
		PULSE [dvRELAY10CARD,5];
		vCurtainOpen = 1
		vCurtainClose = 0
		vCurtainCinema = 0
		vCurtainTV = 0
  }
}

BUTTON_EVENT[dvTP_CINEMA,2]	// CINEMA ROOM CURTAINS CLOSE
{
  PUSH:
  {
		PULSE [dvRELAY10CARD,4];
		vCurtainOpen = 0
		vCurtainClose = 1
		vCurtainCinema = 0
		vCurtainTV = 0
  }
}

BUTTON_EVENT[dvTP_CINEMA,3]	// CINEMA ROOM CURTAINS TV
{
  PUSH:
  {
		IF(vCurtainOpen == 1)
		{
			PULSE [dvRELAY10CARD,4];
			WAIT 45
			PULSE [dvRELAY10CARD,5];
		}
		ELSE IF(vCurtainClose == 1)
		{
			PULSE [dvRELAY10CARD,5];
			WAIT 33
			PULSE [dvRELAY10CARD,4];
		}
		ELSE IF(vCurtainCinema == 1)
		{
			PULSE [dvRELAY10CARD,4];
			WAIT 25
			PULSE [dvRELAY10CARD,5];
		}
		vCurtainOpen = 0
		vCurtainClose = 0
		vCurtainCinema = 0
		vCurtainTV = 1
  }
}

BUTTON_EVENT[dvTP_CINEMA,4]	// CINEMA ROOM CURTAINS CINEMA
{
  PUSH:
  {
		IF(vCurtainOpen == 1)
		{
			PULSE [dvRELAY10CARD,4];
			WAIT 25
			PULSE [dvRELAY10CARD,5];
		}
		ELSE IF(vCurtainClose == 1)
		{
			PULSE [dvRELAY10CARD,5];
			WAIT 55
			PULSE [dvRELAY10CARD,4];
		}
		ELSE IF(vCurtainTV == 1)
		{
			PULSE [dvRELAY10CARD,5];
			WAIT 20
			PULSE [dvRELAY10CARD,4];
		}
		vCurtainOpen = 0
		vCurtainClose = 0
		vCurtainCinema = 1
		vCurtainTV = 0
  }
}

BUTTON_EVENT[dvTP,77]	// MAIN BEDROOM
{
  PUSH:
  {
		CALL 'XivaMainBedroom';		// MAIN BEDROOM
	}
}

BUTTON_EVENT[dvTP,77]	// MAIN BEDROOM
{
  PUSH:
  {
		CALL 'XivaMainBedroom';		// MAIN BEDROOM
	}
}

BUTTON_EVENT[dvTP,42]	// BEDROOM 1
{
  PUSH:
  {
		CALL 'XivaBedroom1';		// BEDROOM 1
	}
}

BUTTON_EVENT[dvTP,76]	// BEDROOM 2
{
  PUSH:
  {
		CALL 'XivaBedroom2';		// BEDROOM 2
	}
}

BUTTON_EVENT[dvTP,829]		// UNDERFLOOR HEATING ON/OFF
{
  PUSH:
  {
		IF (vUnderFloorHeating == 0)
		{
			CALL 'UnderFloorHeating_On';		// ALL ON
			vUnderFloorHeating = 1
		}
		ELSE
		{
			CALL 'UnderFloorHeating_Off';	 //ALL OFF
			OFF[dvTP,829]
			vUnderFloorHeating = 0
		}
	}
}

BUTTON_EVENT[dvTP,823]		// INSIDE FOUNTAIN ON/OFF
{
  PUSH:
  {
		IF (vPumpFountInside == 0)
		{
			CALL 'PumpFountainInside_On';		// ON
			vPumpFountInside = 1
		}
		ELSE
		{
			CALL 'PumpFountainInside_Off';	 // OFF
			vPumpFountInside = 0
		}
	}
}

BUTTON_EVENT[dvTP,826]		// OUTSIDE FOUNTAIN ON/OFF
{
  PUSH:
  {
		IF (vPumpFountOutside == 0)
		{
			CALL 'PumpFountainOutside_On';		// ON
			vPumpFountOutside = 1
		}
		ELSE
		{
			CALL 'PumpFountainOutside_Off';	 // OFF
			vPumpFountOutside = 0
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