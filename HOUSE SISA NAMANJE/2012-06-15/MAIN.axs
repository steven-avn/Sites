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
	CLIENT: HOUSE NAMANJE
	MAIN CONTROLLER: NI-2100 (IP)192.168.1.101
	AMX ZIGBEE MAIN:(IP)192.168.10.120 (DPS)10100
	R4_1 REMOTE MASTER:(DPS)10030
	
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

//////////////////////////REMOTES/////////////////////////////////////
dvR4_1		=		10030:1:0		// Mio-R4 Remote Main Bedroom

//////////////////////RS232 DEVICES///////////////////////////////////
dvBose		=		5001:3:0		// Bose V25 System
dvProjector		=		5001:2:0		// Sony VPL-BW7 Projector
dvProjLift		=		5001:1:0		// S100 Projector Lift															

//////////////////////IR DEVICES//////////////////////////////////////
dvHDPVR1		=		5001:6:0		// 2ND DSTV HD PVR
dvSONY_br		=		5001:5:0		// 1ST SONY BLU-RAY PLAYER

//////////////////////IR DEVICES//////////////////////////////////////
dvScreen		=		5001:4:0		// Relay

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

integer cPower		=		9
integer cScreen_Dn		=		1
integer cScreen_Up		=		2
integer cLift_Dn		=		3
integer cLift_Up		=		4

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

integer BOSE = 0;

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
#INCLUDE 'DSTV'
#INCLUDE 'DVD'
#INCLUDE 'BOSE'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START
SEND_COMMAND dvBose,'SET BAUD,19200,N,8,1'		// BOSE SERIAL COMMS SETTINGS
SEND_COMMAND dvProjector,'SET BAUD,38400,E,8,1,DISABLE'		// Sony SERIAL COMMS SETTINGS
SEND_COMMAND dvProjLift,'SET BAUD,2400,N,8,1'		// Lift SERIAL COMMS SETTINGS


(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvR4_1,23]
BUTTON_EVENT[dvR4_1,24]
BUTTON_EVENT[dvR4_1,25]
BUTTON_EVENT[dvR4_1,26]
BUTTON_EVENT[dvR4_1,27]
BUTTON_EVENT[dvR4_1,28]
BUTTON_EVENT[dvR4_1,29]
BUTTON_EVENT[dvR4_1,30]
BUTTON_EVENT[dvR4_1,31]
BUTTON_EVENT[dvR4_1,32]
BUTTON_EVENT[dvR4_1,33]
{
  PUSH:
  {
	TO[dvR4_1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			//------------------------LIVING ROOM-------------------------//
			// DSTV
				CASE 23:call 'Screen_Dn';
								call 'ProjectorLift_Dn'
								call 'Projector_On'
								call 'Bose_DSTV'
								if(BOSE == 0)
								{
										call 'Bose_On'
										BOSE = 1;
								}

			// DVD	
				CASE 24:call 'Screen_Dn';
								call 'ProjectorLift_Dn'
								call 'Projector_On'
								if(BOSE == 0)
								{
										call 'Bose_On'
										BOSE = 1;
								}
								call 'Bose_DVD'

			// RADIO	
				CASE 25:if(BOSE == 0)
								{
										call 'Bose_On'
										BOSE = 1;
								}
								call 'Bose_Radio'

			// IPOD
				CASE 27:if(BOSE == 0)
								{
										call 'Bose_On'
										BOSE = 1;
								}
								call 'Bose_IPOD'

			// POWER OFF
				CASE 26:call 'Screen_Up';
								call 'ProjectorLift_Up'
								call 'Projector_Off'
								IF(BOSE == 1)
								{
										call 'Bose_Off'
										BOSE = 0;
								}
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