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

button_event[dvR4_1,100]
button_event[dvR4_1,103]
button_event[dvR4_1,104]
button_event[dvR4_1,105]
button_event[dvR4_1,106]
button_event[dvR4_1,107]
button_event[dvR4_1,108]
button_event[dvR4_1,109]
button_event[dvR4_1,110]
button_event[dvR4_1,111]
button_event[dvR4_1,112]
button_event[dvR4_1,113]
button_event[dvR4_1,114]
button_event[dvR4_1,115]
button_event[dvR4_1,116]
button_event[dvR4_1,117]
button_event[dvR4_1,118]
button_event[dvR4_1,119]
button_event[dvR4_1,120]
button_event[dvR4_1,121]
button_event[dvR4_1,122]
button_event[dvR4_1,99]
button_event[dvR4_1,101]
button_event[dvR4_1,102]
button_event[dvR4_1,124]
button_event[dvR4_1,123]
button_event[dvR4_1,126]
button_event[dvR4_1,127]
button_event[dvR4_1,128]
button_event[dvR4_1,125]
button_event[dvR4_1,96]
button_event[dvR4_1,97]
button_event[dvR4_1,98]


{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
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
			case 109: pulse[dvHDPVR1,cdRecall]
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
						
			case 96: 	pulse[dvHDPVR1,cd5]
								wait 4
								pulse[dvHDPVR1,cd1]
								wait 7
								pulse[dvHDPVR1,cd0]
			case 97: 	pulse[dvHDPVR1,cd5]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd1]
			case 98:	pulse[dvHDPVR1,cd5]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd2]
			case 99: 	pulse[dvHDPVR1,cd1]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd1]
			case 101: pulse[dvHDPVR1,cd1]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd3]
			case 102: pulse[dvHDPVR1,cd1]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd4]
			case 124: pulse[dvHDPVR1,cd1]
								wait 4
								pulse[dvHDPVR1,cd2]
								wait 7
								pulse[dvHDPVR1,cd1]
			case 123: pulse[dvHDPVR1,cd1]
								wait 4
								pulse[dvHDPVR1,cd7]
								wait 7
								pulse[dvHDPVR1,cd5]
			case 126: pulse[dvHDPVR1,cd1]
								wait 4
								pulse[dvHDPVR1,cd7]
								wait 7
								pulse[dvHDPVR1,cd4]
			case 127: pulse[dvHDPVR1,cd2]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd1]
			case 128: pulse[dvHDPVR1,cd2]
								wait 4
								pulse[dvHDPVR1,cd0]
								wait 7
								pulse[dvHDPVR1,cd2]
			case 125: pulse[dvHDPVR1,cd2]
								wait 4
								pulse[dvHDPVR1,cd6]
								wait 7
								pulse[dvHDPVR1,cd0]
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