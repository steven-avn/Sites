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
	CLIENT: POLYTECHNIC HOTEL SCHOOL CONFRENCES
	MASTER (NI-3100) IP: 192.168.10.10
	TP1 Conference 1(NXD-435) IP: 192.168.10.11
	TP2 Conference 2(NXD-435) IP: 192.168.10.12
	TP3 Conference 3(NXD-435) IP: 192.168.10.13
	MATRIX (PTN MVG808A) RS232 PORT 1 DPS: 5001:1:1 (dvMATRIX)
	AUDIO MIXER (TOA N9000) RS232 PORT 2 DPS: 5001:2:1 (dvMIXER)
	PROJECTOR (NEC NP610) RS232 PORT 3 DPS: 5001:3:1 (dvPROJECTOR1)
	PROJECTOR (NEC NP610) RS232 PORT 4 DPS: 5001:4:1 (dvPROJECTOR2)
	PROJECTOR (NEC NP2200) RS232 PORT 5 DPS: 5001:5:1 (dvPROJECTOR3)
	DVD IR PORT 1 DPS: 5001:9:1 (dvDVD)
	SCREEN IR PORT 2 DPS: 5001:10:1 (dvSCREEN1)
	SCREEN IR PORT 2 DPS: 5001:11:1 (dvSCREEN2)
	SCREEN UP RELAY PORT 1 DPS: 5001:8:1 (dvSCREEN3)
	SCREEN DWN RELAY PORT 2 DPS: 5001:8:1 (dvSCREEN3)
	GBS S-BUS IP: (DEFAULT) 192.168.10.250

*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


//////////////////////RS232 DEVICES////////////////////////

dvMATRIX					=		5001:1:1											//PUTRON MVG88 VGA/AUDIO MATRIX
dvMIXER						=		5001:2:1											//TOA M-9000 Mixer
dvPROJECTOR1			=		5001:3:1											//NEC NP-610 Conference 1
dvPROJECTOR2			=		5001:4:1											//NEC NP-610 Conference 2
dvPROJECTOR3			=		5001:5:1											//NEC NP-2200 Conference 3

//////////////////////ETHERNET DEVICES/////////////////////

dvTP1							=		10001:1:1											//TOUCH PANEL IN CONFERENCE 1
dvTP2							=		10002:1:1											//TOUCH PANEL IN CONFERENCE 2
dvTP3							=		10003:1:1											//TOUCH PANEL IN CONFERENCE 3

//////////////////////IR DEVICES///////////////////////////

dvDVD							=		5001:9:1											//DVD/HDD FOR SYSTEM IR PORT 6
dvSCREEN1					=		5001:10:1											//Grandview Screen Conference 1
dvSCREEN2					=		5001:11:1											//Grandview Screen Conference 2

//////////////////////RELAY DEVICES///////////////////////////

dvSCREEN3					=		5001:8:1											//Grandview Screen Conference 1

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//////////////SCREEN CONSTANTS////////////////////////////////
SCR_UP        	=    1 
SCR_DN       		=    3

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER VOL_LEVEL   											  	    	//VOLUME LEVEL FOR BARGRAPH

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

#INCLUDE 'Green Box Systems Wired Initialisation.AXI'
//#INCLUDE 'Green Box Systems Wired Initialisation'
#INCLUDE 'Conference 1'
#INCLUDE 'Conference 2'
#INCLUDE 'Conference 3'
#INCLUDE 'Combine Conference'
#INCLUDE 'DVD'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvMIXER,'SET BAUD,57600,N,8,1'							//TOA N9000 MIXER COMMS SETTINGS
SEND_COMMAND dvMATRIX,'SET BAUD,9600,N,8,1'		 	 				//PUTRON SERIAL COMMS SETTINGS
SEND_COMMAND dvPROJECTOR1, "'SET BAUD,19200,N,8,1'"	 		//NEC PROJ RD-232 SETTINGS
SEND_COMMAND dvPROJECTOR2, "'SET BAUD,19200,N,8,1'"	 		//NEC PROJ RD-232 SETTINGS
SEND_COMMAND dvPROJECTOR3, "'SET BAUD,19200,N,8,1'"	 		//NEC PROJ RD-232 SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

