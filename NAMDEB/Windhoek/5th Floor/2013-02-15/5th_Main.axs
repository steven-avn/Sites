PROGRAM_NAME='5th_Main'
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

dvPROJECTOR				=		 5001:3:0		// DELL PROJECTOR IR RX PORT 2
dvPOLY						=		 5001:2:0		//POLYCOM HDX 7000 IR TX PORT 1
dvTP							=		10001:1:0		// Touch Panel

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
				 CASE 8: CALL 'Input1'		// POPUP 1 INPUT SELECT
				 CASE 9: CALL 'Input2'		// POPUP 2 INPUT SELECT
				 CASE 23: CALL 'Projector_On'		// POWER ON
				 CASE 20: CALL 'Projector_Off'		// POWER OFF
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