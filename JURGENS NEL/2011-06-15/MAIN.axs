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
	CLIENT: JURGENS NEL
	MAIN CONTROLLER: NI-2100 (IP)192.168.10.101
	HDMI 8-WAY MATRIX: (IP)192.168.10.103
	AMX ZIGBEE MAIN BEDROOM:(IP)192.168.10.120 (DPS)10100
	R4_1 REMOTE MASTER BEDROOM:(DPS)10030
	R4_2 REMOTE MASTER BEDROOM:(DPS)10031
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

//////////////////////////REMOTES/////////////////////////////////////
dvR4_1										=				10030:1:1													//Mio-R4 Remote Bedroom
dvR4_2										=				10031:1:1													//Mio-R4 Remote Bedroom

//////////////////////RS232 DEVICES///////////////////////////////////
dvMatrixAudioSerial				= 			5001:1:1													//Tango Audio Matrix
dvPUTRON									=				5001:2:1													//PTN MCV88 Matrix

//////////////////////IR DEVICES//////////////////////////////////////
dvDSTV										=				5001:5:1													//DSTV PVR
dvDVD											=				5001:6:1													//DVD

//////////////////////AXLINK DEVICES//////////////////////////////////
dvKP1											=				171:1:1														//MAIN BEDROOM
dvKP2											=				182:1:1														//MAIN BATROOM
dvKP3											=				83:1:1														//LOUNGE
dvKP4											=				86:1:1														//KIDS ROOM
dvKP5											=				70:1:1														//GUEST ROOM
dvKP6											=				80:1:1														//BRAAI AREA
	
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

#INCLUDE 'DSTV'
#INCLUDE 'DVD'
#INCLUDE 'AMX_MatrixAudio_MiSeries_MAIN'
#INCLUDE 'KP1'
#INCLUDE 'KP2'
#INCLUDE 'KP3'
#INCLUDE 'KP4'
#INCLUDE 'KP5'
#INCLUDE 'KP6'
#INCLUDE 'R4_Remotes'
#INCLUDE 'RADIO'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvMatrixAudioSerial,'SET BAUD,9600,N,8,1'		 	 				//TANGO SERIAL COMMS SETTINGS
SEND_COMMAND dvPUTRON,'SET BAUD,9600,N,8,1'		 	 //PUTRON SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

//SEND_LEVEL dvTP,1,VOL_LEVEL_LIVINGR     			 											//SHOW VOLUME LEVEL ON BARGRAPH
//SEND_LEVEL dvTP,2,VOL_LEVEL_ENTERTR     			 											//SHOW VOLUME LEVEL ON BARGRAPH
//SEND_LEVEL dvTP,3,VOL_LEVEL_MAINBDR     			 											//SHOW VOLUME LEVEL ON BARGRAPH

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

