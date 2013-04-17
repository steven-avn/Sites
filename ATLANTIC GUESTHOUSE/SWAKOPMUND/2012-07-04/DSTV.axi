PROGRAM_NAME='DSTV'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////Constants for DSTV//////////////////////////
integer cdExit		=		50
integer cdGuide		=		56
integer cdInfo		=		69
integer cdPower		=		9
integer cdMenu		=		44
integer cdOk			=		49
integer cdUp			=		45
integer cdDwn			= 	46
integer cdLeft		=		47
integer cdRight		=		48
integer cd1				=		11
integer cd2				=		12
integer cd3				=		13
integer cd4				=		14
integer cd5				=		15
integer cd6				=		16
integer cd7				=		17
integer cd8				=		18
integer cd9				=		19
integer cd0				=		10
integer cdRecall	=		55
integer cdChUp		=		22
integer cdChDn		=		23
integer cdTV			=		121
integer cdDMX			=		127		


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

volatile integer DSTVBUTTONS[]	=	 {100,101,102,103,104,105,106,107,108,109,
																		110,111,112,113,114,115,116,117,118,119,
																		120,121,122,123,124,125,126,127,128,129}

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


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

set_pulse_time (2)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

button_event[dvTP,DSTVBUTTONS]
{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 100: pulse[dvHDPVR1,cdMenu]
			case 103: pulse[dvHDPVR1,cdInfo]
			case 104: pulse[dvHDPVR1,cdUp]
			case 105: pulse[dvHDPVR1,cdDwn]
			case 107: pulse[dvHDPVR1,cdLeft]
			case 106: pulse[dvHDPVR1,cdRight]
			case 108: pulse[dvHDPVR1,cdOk]
			case 110: pulse[dvHDPVR1,cdExit]
			case 109: pulse[dvHDPVR1,cdGuide]
			case 111: pulse[dvHDPVR1,cd1]
			case 112: pulse[dvHDPVR1,cd2]
			case 113: pulse[dvHDPVR1,cd3]
			case 114: pulse[dvHDPVR1,cd4]
			case 115: pulse[dvHDPVR1,cd5]
			case 116: pulse[dvHDPVR1,cd6]
			case 117: pulse[dvHDPVR1,cd7]
			case 118: pulse[dvHDPVR1,cd8]
			case 119: pulse[dvHDPVR1,cd9]
			case 120: pulse[dvHDPVR1,cd0]
			case 121: pulse[dvHDPVR1,cdChUp]
			case 122: pulse[dvHDPVR1,cdChDn]
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