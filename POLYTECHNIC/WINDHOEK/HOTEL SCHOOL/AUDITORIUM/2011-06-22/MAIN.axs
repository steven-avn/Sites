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
	CLIENT: POLYTECHNIC HOTEL SCHOOL AUDITORIUM
	MASTER (NI-2100) IP: 192.168.10.10
	TP1 Auditorium (NXD-435) IP: 192.168.10.11
	AUDIO MIXER (CLOUD CX462) RS232 PORT 1 DPS: 5001:1:1 (dvMIXER)
	MATRIX (PTN MVG44A) RS232 PORT 2 DPS: 5001:2:1 (dvMATRIX)
	PROJECTOR (NEC NP2200) RS232 PORT 3 DPS: 5001:3:1 (dvPROJECTOR)
	DVD IR PORT 1 DPS: 5001:5:1 (dvDVD)
	SCREEN IR PORT 2 DPS: 5001:6:1 (dvSCREEN)
	GBS S-BUS IP: (DEFAULT) 192.168.10.250
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


//////////////////////RS232 DEVICES////////////////////////

dvMATRIX					=		5001:2:0											//PUTRON MVG44 VGA/AUDIO MATRIX
//dvCLOUD						=		5001:1:0											//CLOUD CX462 AUDIO CONTROLLER
dvPROJECTOR				=		5001:3:1											//NEC NP-610 

//////////////////////ETHERNET DEVICES/////////////////////

dvTP							=		10001:1:1											//TOUCH PANEL IN AUDITORIUM

//////////////////////IR DEVICES///////////////////////////

dvDVD							=		5001:5:1											//DVD/HDD FOR SYSTEM IR PORT 6
dvSCREEN					=		5001:6:1											//Grandview Screen Conference 1

//////////////////////RELAY DEVICES///////////////////////////

dvAIRCON					=		5001:4:1											//Aircon Conference 1

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
#INCLUDE 'Auditorium'
#INCLUDE 'test'
#INCLUDE 'DVD'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

//SEND_COMMAND dvCLOUD,"'SET BAUD,9600,N,8,1'"		 				//CLOUD SERIAL COMMS SETTINGS
SEND_COMMAND dvMATRIX,"'SET BAUD,9600,N,8,1'"		 	 				//PUTRON SERIAL COMMS SETTINGS
SEND_COMMAND dvPROJECTOR, "'SET BAUD,19200,N,8,1'"	 		//NEC PROJ RD-232 SETTINGS

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

