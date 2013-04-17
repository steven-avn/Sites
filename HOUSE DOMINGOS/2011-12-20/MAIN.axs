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
	CLIENT: HOUSE DOMINGOS
	MAIN CONTROLLER: NI-3100 (IP)192.168.10.101
	MAIN TOUCH PANEL: MVP-5150 (IP)192.168.10.103
	HDMI 8-WAY MATRIX: (IP)192.168.10.102
	D-LINK LONG RANGE ACCESS POINT:(IP) 192.168.10.245 (CH 1)PASSPHRASE: audiovision
	AMX WAP-250G Access Point Pool: 192.168.10.240 (CH11)
	WIN7 MEDIA PC: (IP)192.168.0.150 (HOMEGROUP PASSWORD)EW4Ux9GP25
	XBOX 1:(IP)192.168.10.151 (Main Bedroom)
	XBOX 2:(IP)192.168.10.152 (Entertainmrnt)
	XBOX 3:(IP)192.168.10.153 (Living Room)
	AMX ZIGBEE MAIN BEDROOM:(IP)192.168.10.120 (DPS)10100
	AMX ZIGBEE DAUGHTER'S BEDROOM:(IP)192.168.10.121 (DPS)10101
	AMX ZIGBEE SON'S BEDROOM:(IP)192.168.10.122 (DPS)10102
	AMX ZIGBEE DOWNSTAIRS BEDROOM 1 (RIGHT):(IP)192.168.10.123 (DPS)10103
	AMX ZIGBEE DOWNSTAIRS BEDROOM 2 (RIGHT):(IP)192.168.10.124 (DPS)10104
	R4_1 REMOTE MASTER BEDROOM:(DPS)10030
	R4_RM1 REMOTE DAUGHTER'S BEDROOM:(DPS)10031
	R4_RM2 REMOTE SON'S BEDROOM:(DPS)10032
	R4_RM3 REMOTE DOWNSTAIRS 1 BEDROOM:(DPS)10033
	R4_RM4 REMOTE DOWNSTAIRS 2 BEDROOM:(DPS)10034
	GBS Hybrid IP Interface: (IP)192.168.10.250
	iMERGE S3000 SERVER: (IP) 192.168.10.155
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

//////////////////////////REMOTES/////////////////////////////////////
dvR4_1										=				10030:1:0		//Mio-R4 Remote Main Bedroom
dvR4_RM1									=				10031:1:0		//Mio-R4 Remote Daughter's Bedroom
dvR4_RM2									=				10032:1:0		//Mio-R4 Remote Son's Bedroom
dvR4_RM3									=				10033:1:0		//Mio-R4 Remote Downstairs 1 Bedroom
dvR4_RM4									=				10034:1:0		//Mio-R4 Remote Downstairs 2 Bedroom

//////////////////////RS232 DEVICES///////////////////////////////////
dvBose										=				5001:1:0		//Bose System
dvMatrixAudioSerial				= 			5001:2:0		// DAS Audio Matrix Serial
dvDaughterPA2							=				5001:3:0		//PTN PA2 for Daughter's Bedroom															
dvSonsPA2									=				5001:4:0		//PTN PA2 for Son's Bedroom															
dvDownSt1PA2							=				5001:5:0		//PTN PA2 for Downstairs Bedroom	1													
dvDownSt2PA2							=				5001:6:0		//PTN PA2 for Downstairs Bedroom	2													

/////////////////ETHERNET/WIRELESS DEVICES////////////////////////////
dvTP 											=				10001:1:0		//MVP 5150i Touch Panel
dvUTPRO_HDMI							=				 5500:1:1		//HDMI MATRIX SWITCHER
dvHDMI_Down1							=				 5505:3:0		//HDMI Down1 Bedroom
dvHDMI_Entert							=				 5507:3:0		//HDMI Entertainment Area
dvHDMI_Bed								=				 5508:3:0		//HDMI Master Bedroom

//////////////////////IR DEVICES//////////////////////////////////////
dvHDPVR1									=				5001:9:0		//1ST DSTV HD PVR
dvTPA											=				5001:10:0		//2ND TPA FREE2AIR DECODER ECHOSTAR
dvSAM_TV									=				5001:11:0		//3RD SAMSUNG TV LIVING ROOM
dvSONY_br									=				5001:12:0		//4TH SONY BLU-RAY PLAYER LIVING ROOM
//dvSONY_DVD								=				5001:13:0		//5TH SONY DVD PLAYER LIVING ROOM
//dvWD_Live_LR							=				5001:14:0		//6TH Western Digital TV Live (LIVINGROOM)
//dvWD_Live_ER							=				5001:15:0		//7TH Western Digital TV Live (ENTERTAINMENT)
//dvWD_Live_BR							=				5001:16:0		//8TH Western Digital TV Live (BEDROOM)

//// The panel devices - up to 16 currently but more possible
//// Device numbers can be according to you own scheme
dvXiVAPanel_01	= 10001:2:0;	// G4
dvXiVAPanel_02	= 10030:2:0;	// G4
//dvXiVAPanel_03	= 10031:2:0;	// G4
//dvXiVAPanel_04	= 10032:2:0;	// G4
dvXiVAPanel_05	= 10033:2:0;	// G4
//dvXiVAPanel_06	= 10034:2:0;	// G4
//dvXiVAPanel_07	= 00128:1:0;	// G3 <- Devices 1-255 will be treated as G3 by the module.
//dvXiVAPanel_08	= 11008:2:0;	// MIO-DMS
//dvXiVAPanel_09	= 10009:2:0;	// Spare Devs
dvXiVAPanel_10	= 10031:2:0;
dvXiVAPanel_11	= 10032:2:0;
dvXiVAPanel_12	= 10034:2:0;
//dvXiVAPanel_13	= 10013:2:0;
//dvXiVAPanel_14	= 10014:2:0;
//dvXiVAPanel_15	= 10015:2:0;
//dvXiVAPanel_16	=	10016:2:0;

vdvXIVAModule	= 33001:1:0;	// virtual device for the module itself
dvXIVALinkPri	= 0:2:0; // Main XiVALink IP Connection
dvXIVALinkSec	= 0:3:0; // Supplimentary XiVALink IP Connection
dvDebug	= 0:0:0; // Debug output device

///////////////////////////////////////////////////////////////////////////////

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

INTEGER cPower		=		9

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER RFID_ALARM;
VOLATILE INTEGER LED_LIGHTS_ON;
INTEGER TV_LIVINGRM_POWER = 0;

char serverip[] = '192.168.10.155';	// S3000 4 Output

//// List of Panels that will be controlling the XiVA Server
//// Only enter the actual panels you need.
dev dvXiVAPanels[] = 
{ 
	dvXiVAPanel_01,
	dvXiVAPanel_02,
	//dvXiVAPanel_03,
	//dvXiVAPanel_04,
	dvXiVAPanel_05,
	//dvXiVAPanel_06
	//dvXiVAPanel_07,
	//dvXiVAPanel_08
//	dvXiVAPanel_09,
	dvXiVAPanel_10,
	dvXiVAPanel_11,
	dvXiVAPanel_12
//	dvXiVAPanel_13,
//	dvXiVAPanel_14,
//	dvXiVAPanel_15,
//	dvXiVAPanel_16
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

Define_Module 'XIVA Link v2 Driver' mdlXIVA(vdvXIVAModule, dvXIVALinkPri,dvXIVALinkSec,serverip,  dvXiVAPanels, dvDebug);

#INCLUDE 'Green Box Systems Wired Initialisation.AXI'
#INCLUDE 'DSTV'
#INCLUDE 'DVD'
#INCLUDE 'DVD_2'
#INCLUDE 'TPA'
#INCLUDE 'Camera'
#INCLUDE 'BOSE'
#INCLUDE 'AMX_MatrixAudio_MiSeries_MAIN'
#INCLUDE 'WD TV Live'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START
/*
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,1,dvTP,1)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,2,dvTP,2)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,3,dvTP,3)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,4,dvTP,4)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,1,dvTP,1)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,2,dvTP,2)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,3,dvTP,3)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,4,dvTP,4)
*/
SEND_COMMAND dvUTPRO_HDMI,'SET BAUD,9600,N,8,1'		//UTPRO-HDMI SERIAL COMMS SETTINGS
SEND_COMMAND dvBose,'SET BAUD,19200,N,8,1'		//BOSE SERIAL COMMS SETTINGS
SEND_COMMAND dvMatrixAudioSerial,'SET BAUD,9600,N,8,1'		//TANGO SERIAL COMMS SETTINGS
SEND_COMMAND dvDaughterPA2,'SET BAUD,9600,N,8,1'		//Daughter's B/room PA2 SERIAL COMMS SETTINGS
SEND_COMMAND dvSonsPA2,'SET BAUD,9600,N,8,1'		//Son's B/room PA2 SERIAL COMMS SETTINGS
SEND_COMMAND dvDownSt1PA2,'SET BAUD,9600,N,8,1'		//Downstairs B/room 1 SERIAL COMMS SETTINGS
SEND_COMMAND dvDownSt2PA2,'SET BAUD,9600,N,8,1'		//Downstairs B/room 2 SERIAL COMMS SETTINGS


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP,1]
BUTTON_EVENT[dvTP,2]
BUTTON_EVENT[dvTP,3]
BUTTON_EVENT[dvTP,9]
BUTTON_EVENT[dvTP,12]
BUTTON_EVENT[dvTP,13]
BUTTON_EVENT[dvTP,14]
BUTTON_EVENT[dvTP,17]
BUTTON_EVENT[dvTP,19]
BUTTON_EVENT[dvTP,48]
BUTTON_EVENT[dvTP,49]
BUTTON_EVENT[dvTP,87]
BUTTON_EVENT[dvTP,89]
BUTTON_EVENT[dvTP,90]
BUTTON_EVENT[dvTP,435]
BUTTON_EVENT[dvTP,436]
BUTTON_EVENT[dvTP,525]
BUTTON_EVENT[dvTP,526]
BUTTON_EVENT[dvTP,446]
BUTTON_EVENT[dvTP,447]
BUTTON_EVENT[dvTP,448]
BUTTON_EVENT[dvTP,449]
BUTTON_EVENT[dvTP,450]
{
  PUSH:
  {
	TO[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			//------------------------LIVING ROOM-------------------------//
			CASE 1:		PULSE[dvSAM_TV,cPower]
								SEND_STRING dvBose,  "$0b,$00,$01,$04,$4c,$01,$2c,$01,$00,$00,$6e"	//Living rm On/Off
			CASE 2: 	SEND_COMMAND dvUTPRO_HDMI,"'CI1O1'"		//Input 1(DSTV) Output 1(LivingRm)
								SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			CASE 48:	SEND_COMMAND dvUTPRO_HDMI,"'CI3O1'"		//Input 3(TPA) Output 1(LivingRm)
								SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			CASE 3: 	SEND_COMMAND dvUTPRO_HDMI,"'CI2O1'"		//Input 2(DVD) Output 1(LivingRm)
								SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			CASE 9: 	SEND_COMMAND dvUTPRO_HDMI,"'CI6O1'"		//Input 6(WD1) Output 1(LivingRm)
								SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			CASE 436:	SEND_COMMAND dvUTPRO_HDMI,"'CI8O1'"		//Input 8(DVR) Output 1(LivingRm)
							  SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			
			//------------------------ENTERTAINMENT AREA------------------//
			CASE 12:	PULSE [dvHDMI_Entert,9]		//Switches Panasonic TV on
								OFF [vdvMatrixAudio[4],199]
								SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
			CASE 17:	ON [vdvMatrixAudio[4],199]
								PULSE [dvHDMI_Entert,9]		//Switches Panasonic TV off
			CASE 13:	SEND_COMMAND dvUTPRO_HDMI,"'CI1O7'"		//Input 1(DSTV) Output 6(EntertRm)
								SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-5'";		//Input 5(DSTV) Output 4(EntertRm)
								SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
			CASE 525:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-3'";		//Input 3(iMERGE) Output 4(EntertRm)
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 49:	SEND_COMMAND dvUTPRO_HDMI,"'CI3O7'"		//Input 3(TPA) Output 6(EntertRm)
								SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-6'";		//Input 2(TPA) Output 4(EntertRm)
								SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
			CASE 14:	SEND_COMMAND dvUTPRO_HDMI,"'CI5O7'"		//Input 5(WD2) Output 6(EntertRm)
								SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-4'";		//Input 4(WD2) Output 4(EntertRm)
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 19:	SEND_COMMAND dvUTPRO_HDMI,"'CI7O7'"		//Input 7(DVD2) Output 6(EntertRm)
								SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-7'";		//Input 7(DVD2) Output 4(EntertRm)
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 526:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";								
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 446:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 447:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 448:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 449:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.9'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 450:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-107.9'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			CASE 435:	SEND_COMMAND dvUTPRO_HDMI,"'CI8O7'"		//Input 8(DVR) Output 6(EntertRm)
		}
  }
}

BUTTON_EVENT[dvTP,15]		//Entert Rm Volume Up
BUTTON_EVENT[dvTP,16]		//Entert Rm Volume Down
{
  HOLD[1,REPEAT]:
  {
	TO[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 15: ON[vdvMatrixAudio[4],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[4],24]
							 }
			CASE 16: ON[vdvMatrixAudio[4],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[4],25]
							 }
		}
  }
}
 

//------------------------DAUGHTER'S BEDROOM------------------------//
BUTTON_EVENT[dvR4_RM1,301]
BUTTON_EVENT[dvR4_RM1,302]
BUTTON_EVENT[dvR4_RM1,303]
BUTTON_EVENT[dvR4_RM1,304]
BUTTON_EVENT[dvR4_RM1,305]
BUTTON_EVENT[dvR4_RM1,306]
BUTTON_EVENT[dvR4_RM1,307]
BUTTON_EVENT[dvR4_RM1,308]
BUTTON_EVENT[dvR4_RM1,309]
BUTTON_EVENT[dvR4_RM1,310]
BUTTON_EVENT[dvR4_RM1,311]
BUTTON_EVENT[dvR4_RM1,347]
BUTTON_EVENT[dvR4_RM1,454]
BUTTON_EVENT[dvR4_RM1,455]
{
  PUSH:
  {
	TO[dvR4_RM1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 301: 
			CASE 302: 
			CASE 303: 
			CASE 304: 
			CASE 305: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-3'";		//Input 3(iMERGE) Output 2(DaughterBrm)
								OFF [vdvMatrixAudio[2],199]
								SEND_LEVEL vdvMATRIXAUDIO[2],1,128;
			CASE 306: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
			CASE 307: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
								OFF [vdvMatrixAudio[2],199]
								SEND_LEVEL vdvMATRIXAUDIO[2],1,128;
			CASE 308: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
								OFF [vdvMatrixAudio[2],199]
								SEND_LEVEL vdvMATRIXAUDIO[2],1,128;
			CASE 309: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								OFF [vdvMatrixAudio[2],199]
								SEND_LEVEL vdvMATRIXAUDIO[2],1,128;
			CASE 454: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.9'";
								OFF [vdvMatrixAudio[2],199]
								SEND_LEVEL vdvMATRIXAUDIO[2],1,128;
			CASE 455: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-107.9'";
								OFF [vdvMatrixAudio[2],199]
								SEND_LEVEL vdvMATRIXAUDIO[2],1,128;
			CASE 310: 
			CASE 311: 
			CASE 347:	ON [vdvMatrixAudio[2],199];		//MUTE / POWER OFF
		}
  }
}

BUTTON_EVENT[dvR4_RM1,345]
BUTTON_EVENT[dvR4_RM1,346]
{
  HOLD[1,REPEAT]:
  {
	TO[dvR4_RM1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 345: ON[vdvMatrixAudio[2],24]
								WAIT 2
								{
									OFF[vdvMatrixAudio[2],24]
								}
			CASE 346: ON[vdvMatrixAudio[2],25]
								WAIT 2
								{
									OFF[vdvMatrixAudio[2],25]
								}
		}
  }
}
 
//-----------------------SON'S BEDROOM-----------------------------//
BUTTON_EVENT[dvR4_RM2,312]
BUTTON_EVENT[dvR4_RM2,313]
BUTTON_EVENT[dvR4_RM2,314]
BUTTON_EVENT[dvR4_RM2,315]
BUTTON_EVENT[dvR4_RM2,316]
BUTTON_EVENT[dvR4_RM2,317]
BUTTON_EVENT[dvR4_RM2,318]
BUTTON_EVENT[dvR4_RM2,319]
BUTTON_EVENT[dvR4_RM2,320]
BUTTON_EVENT[dvR4_RM2,321]
BUTTON_EVENT[dvR4_RM2,322]
BUTTON_EVENT[dvR4_RM2,350]
BUTTON_EVENT[dvR4_RM2,456]
BUTTON_EVENT[dvR4_RM2,457]
{
  PUSH:
  {
	TO[dvR4_RM2,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 312:
			CASE 313:
			CASE 314: 
			CASE 315: 
			CASE 316: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-3'";		//Input 3(iMERGE) Output 3(SonBrm)
								OFF [vdvMatrixAudio[3],199]
								SEND_LEVEL vdvMATRIXAUDIO[3],1,128;
			CASE 317: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
			CASE 318: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
								OFF [vdvMatrixAudio[3],199]
								SEND_LEVEL vdvMATRIXAUDIO[3],1,128;
			CASE 319: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
								OFF [vdvMatrixAudio[3],199]
								SEND_LEVEL vdvMATRIXAUDIO[3],1,128;
			CASE 320: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								OFF [vdvMatrixAudio[3],199]
								SEND_LEVEL vdvMATRIXAUDIO[3],1,128;
			CASE 456: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.9'";
								OFF [vdvMatrixAudio[3],199]
								SEND_LEVEL vdvMATRIXAUDIO[3],1,128;
			CASE 457: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-107.9'";
								OFF [vdvMatrixAudio[3],199]
								SEND_LEVEL vdvMATRIXAUDIO[3],1,128;
			CASE 321:
			CASE 322: 
			CASE 350:	ON [vdvMatrixAudio[3],199]		//MUTE / POWER OFF
		}
  }
}

BUTTON_EVENT[dvR4_RM2,348]
BUTTON_EVENT[dvR4_RM2,349]
{
  HOLD[1,REPEAT]:
  {
	TO[dvR4_RM2,BUTTON.INPUT.CHANNEL]
	 SWITCH(BUTTON.INPUT.CHANNEL)
	 {
			CASE 348: ON[vdvMatrixAudio[3],24]
								WAIT 2
								{
									OFF[vdvMatrixAudio[3],24]
								}
			CASE 349: ON[vdvMatrixAudio[3],25]
								WAIT 2
								{
									OFF[vdvMatrixAudio[3],25]
								}
	 }
  }
}

 
//----------------------DOWNST 1 BEDROOM----------------------------//
BUTTON_EVENT[dvR4_RM3,323]
BUTTON_EVENT[dvR4_RM3,324]
BUTTON_EVENT[dvR4_RM3,325]
BUTTON_EVENT[dvR4_RM3,326]
BUTTON_EVENT[dvR4_RM3,327]
BUTTON_EVENT[dvR4_RM3,328]
BUTTON_EVENT[dvR4_RM3,329]
BUTTON_EVENT[dvR4_RM3,330]
BUTTON_EVENT[dvR4_RM3,331]
BUTTON_EVENT[dvR4_RM3,332]
BUTTON_EVENT[dvR4_RM3,333]
BUTTON_EVENT[dvR4_RM3,353]
BUTTON_EVENT[dvR4_RM3,458]
BUTTON_EVENT[dvR4_RM3,459]
{
  PUSH:
  {
	TO[dvR4_RM3,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 323: 
			CASE 324:
			CASE 325: 
			CASE 326: PULSE [dvHDMI_Down1,9]		//Switches Sony TV on/off
							  ON [vdvMatrixAudio[6],199]		//MUTE / POWER OFF
			CASE 327: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUTSELECT-3'";		//Input 3(iMERGE) Output 6(Down1)
								OFF [vdvMatrixAudio[6],199]
								SEND_LEVEL vdvMATRIXAUDIO[6],1,148;
			CASE 328: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 329: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
								OFF [vdvMatrixAudio[6],199]
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 330: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
								OFF [vdvMatrixAudio[6],199]
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 331: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								OFF [vdvMatrixAudio[6],199]
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 458: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.9'";
								OFF [vdvMatrixAudio[6],199]
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 459: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-107.9'";
								OFF [vdvMatrixAudio[6],199]
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 353:	ON [vdvMatrixAudio[6],199]		//MUTE / POWER OFF
			CASE 332: SEND_COMMAND dvUTPRO_HDMI,"'CI1O5'"		//Input 1(DSTV) Output 5(Down1)
								SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUTSELECT-5'";		//Input 5(DSTV) Output 6(Down1)
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
			CASE 333:	SEND_COMMAND dvUTPRO_HDMI,"'CI3O5'"		//Input 3(TPA) Output 5(Down1)
								SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUTSELECT-6'";		//Input 2(TPA) Output 6(Down1)
								SEND_LEVEL vdvMATRIXAUDIO[6],1,128;
		}
  }
}

BUTTON_EVENT[dvR4_RM3,351]
BUTTON_EVENT[dvR4_RM3,352]
{
  HOLD[1,REPEAT]:
  {
	TO[dvR4_RM3,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 351: ON[vdvMatrixAudio[6],24]
									 WAIT 2
									 {
										 OFF[vdvMatrixAudio[6],24]
									 }
				 CASE 352: ON[vdvMatrixAudio[6],25]
									 WAIT 2
									 {
										 OFF[vdvMatrixAudio[6],25]
									 }
			}
	 }
}
 
//-------------------------DOWNST 2 BEDROOM-------------------------//
BUTTON_EVENT[dvR4_RM4,334]
BUTTON_EVENT[dvR4_RM4,335]
BUTTON_EVENT[dvR4_RM4,336]
BUTTON_EVENT[dvR4_RM4,337]
BUTTON_EVENT[dvR4_RM4,338]
BUTTON_EVENT[dvR4_RM4,339]
BUTTON_EVENT[dvR4_RM4,340]
BUTTON_EVENT[dvR4_RM4,341]
BUTTON_EVENT[dvR4_RM4,342]
BUTTON_EVENT[dvR4_RM4,343]
BUTTON_EVENT[dvR4_RM4,344]
BUTTON_EVENT[dvR4_RM4,356]
BUTTON_EVENT[dvR4_RM4,460]
BUTTON_EVENT[dvR4_RM4,461]
{
  PUSH:
  {
	TO[dvR4_RM4,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 334: 
			CASE 335: 
			CASE 336: 
			CASE 337: 
			CASE 338: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUTSELECT-3'";		//Input 3(iMERGE) Output 5(Down2)
								OFF [vdvMatrixAudio[5],199]
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 339: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 340: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
								OFF [vdvMatrixAudio[5],199]
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 341: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
								OFF [vdvMatrixAudio[5],199]
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 342: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								OFF [vdvMatrixAudio[5],199]
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 460: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.9'";
								OFF [vdvMatrixAudio[5],199]
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 461: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-107.9'";
								OFF [vdvMatrixAudio[5],199]
								SEND_LEVEL vdvMATRIXAUDIO[5],1,128;
			CASE 343: 
			CASE 344: 
			CASE 356:	ON [vdvMatrixAudio[5],199]		//MUTE / POWER OFF
		}
  }
}

BUTTON_EVENT[dvR4_RM4,354]
BUTTON_EVENT[dvR4_RM4,355]
{
  HOLD[1,REPEAT]:
  {
	TO[dvR4_RM4,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 354: ON[vdvMatrixAudio[5],24]
									 WAIT 2
									 {
										 OFF[vdvMatrixAudio[5],24]
									 }
				 CASE 355: ON[vdvMatrixAudio[5],25]
									 WAIT 2
									 {
										 OFF[vdvMatrixAudio[5],25]
									 }
			}
  }
}
 
 
//---------------------------MASTER BEDROOM-------------------------//
BUTTON_EVENT[dvR4_1,366]
BUTTON_EVENT[dvR4_1,367]
BUTTON_EVENT[dvR4_1,368]
BUTTON_EVENT[dvR4_1,369]
BUTTON_EVENT[dvR4_1,370]
BUTTON_EVENT[dvR4_1,371]
BUTTON_EVENT[dvR4_1,372]
BUTTON_EVENT[dvR4_1,373]
BUTTON_EVENT[dvR4_1,374]
BUTTON_EVENT[dvR4_1,375]
BUTTON_EVENT[dvR4_1,376]
BUTTON_EVENT[dvR4_1,379]
BUTTON_EVENT[dvR4_1,23]
BUTTON_EVENT[dvR4_1,24]
BUTTON_EVENT[dvR4_1,25]
BUTTON_EVENT[dvR4_1,26]
BUTTON_EVENT[dvR4_1,27]
BUTTON_EVENT[dvR4_1,28]
BUTTON_EVENT[dvR4_1,50]
BUTTON_EVENT[dvR4_1,751]
BUTTON_EVENT[dvR4_1,451]
BUTTON_EVENT[dvR4_1,452]
{
  PUSH:
  {
	TO[dvR4_1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 366: 
			CASE 367: 
			CASE 368:
			CASE 369: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 370: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-3'";		//Input 3(iMERGE) Output 1(MasterBRM)
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 371: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 372: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 373: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 374: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 451: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.9'";
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 452: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-107.9'";
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 375: 
			CASE 376:	ON [vdvMatrixAudio[1],199]		//MUTE / POWER OFF
			CASE 751:	SEND_COMMAND dvUTPRO_HDMI,"'CI4O8'"		//Input 4(WD3) Output 8(MasterBRM)
								SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-8'";		//Input 8(WD3) Output 1(MasterBRM)
								OFF [vdvMatrixAudio[1],199]
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 379:	PULSE [dvHDMI_Bed,9]		//Switches Sony TV on/off
								ON [vdvMatrixAudio[1],199]		//MUTE / POWER OFF
			CASE 24: 	SEND_COMMAND dvUTPRO_HDMI,"'CI1O8'"		//Input 1(DSTV) Output 8(MasterBRM)
								SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-5'";		//Input 5(DSTV) Output 1(MasterBRM)
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 50:	SEND_COMMAND dvUTPRO_HDMI,"'CI3O8'"		//Input 3(TPA) Output 8(MasterBRM)
								SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-6'";		//Input 2(TPA) Output 1(MasterBRM)
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
			CASE 28:	SEND_COMMAND dvUTPRO_HDMI,"'CI8O8'"		//Input 8(DVR) Output 8(MasterBRM)
			CASE 25:	SEND_COMMAND dvUTPRO_HDMI,"'CI7O8'"		//Input 7(DVD2) Output 8(MasterBRM)
								SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-7'";		//Input 7(DVD) Output 1(MasterBRM)
								SEND_LEVEL vdvMATRIXAUDIO[1],1,128;
		}
  }
}

BUTTON_EVENT[dvR4_1,377]
BUTTON_EVENT[dvR4_1,378]
{
  HOLD[1,REPEAT]:
  {
	TO[dvR4_1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 377: ON[vdvMatrixAudio[1],24]
									 WAIT 2
									 {
										 OFF[vdvMatrixAudio[1],24]
									 }
				 CASE 378: ON[vdvMatrixAudio[1],25]
									 WAIT 2
									 {
										 OFF[vdvMatrixAudio[1],25]
									 }
			}
	 }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

//SEND_LEVEL dvTP,1,VOL_LEVEL_LIVINGR		//SHOW VOLUME LEVEL ON BARGRAPH
//SEND_LEVEL dvTP,2,VOL_LEVEL_ENTERTR		//SHOW VOLUME LEVEL ON BARGRAPH
//SEND_LEVEL dvTP,3,VOL_LEVEL_MAINBDR		//SHOW VOLUME LEVEL ON BARGRAPH

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)