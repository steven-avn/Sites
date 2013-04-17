PROGRAM_NAME='DSTV_HD'
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

/////////////////////Constants for DSTV////////////////////////
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

VOLATILE INTEGER TPBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,
																  11,12,13,14,15,16,17,18,19,20,
																  21,22,23,24,25,26,27,28,29,30}

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

SET_PULSE_TIME (2)

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
						CASE 1: PULSE[dvHDPVR1,cdMenu]
						CASE 2: PULSE[dvHDPVR1,cdInfo]
						CASE 3: PULSE[dvHDPVR1,cdUp]
						CASE 4: PULSE[dvHDPVR1,cdDwn]
						CASE 5: PULSE[dvHDPVR1,cdLeft]
						CASE 6: PULSE[dvHDPVR1,cdRight]
						CASE 7: PULSE[dvHDPVR1,cdOk]
						CASE 8: PULSE[dvHDPVR1,cdExit]
						CASE 9: PULSE[dvHDPVR1,cdRecall]
						CASE 10:PULSE[dvHDPVR1,cd1]
						CASE 11:PULSE[dvHDPVR1,cd2]
						CASE 12:PULSE[dvHDPVR1,cd3]
						CASE 13:PULSE[dvHDPVR1,cd4]
						CASE 14:PULSE[dvHDPVR1,cd5]
						CASE 15:PULSE[dvHDPVR1,cd6]
						CASE 16:PULSE[dvHDPVR1,cd7]
						CASE 17:PULSE[dvHDPVR1,cd8]
						CASE 18:PULSE[dvHDPVR1,cd9]
						CASE 19:PULSE[dvHDPVR1,cd0]
						CASE 20:PULSE[dvHDPVR1,cdChUp]
						CASE 21:PULSE[dvHDPVR1,cdChDn]
						
						CASE 22:PULSE[dvHDPVR1,cd5]
										wait 4
										PULSE[dvHDPVR1,cd1]
										wait 7
										PULSE[dvHDPVR1,cd0]
						CASE 23:PULSE[dvHDPVR1,cd5]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd1]
						CASE 24:PULSE[dvHDPVR1,cd5]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd2]
						CASE 25:PULSE[dvHDPVR1,cd1]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd1]
						CASE 26:PULSE[dvHDPVR1,cd1]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd3]
						CASE 27:PULSE[dvHDPVR1,cd1]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd4]
						CASE 28:PULSE[dvHDPVR1,cd1]
										wait 4
										PULSE[dvHDPVR1,cd2]
										wait 7
										PULSE[dvHDPVR1,cd1]
						CASE 29:PULSE[dvHDPVR1,cd1]
										wait 4
										PULSE[dvHDPVR1,cd7]
										wait 7
										PULSE[dvHDPVR1,cd5]
						CASE 30:PULSE[dvHDPVR1,cd1]
										wait 4
										PULSE[dvHDPVR1,cd7]
										wait 7
										PULSE[dvHDPVR1,cd4]
						CASE 30:PULSE[dvHDPVR1,cd2]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd1]
						CASE 30:PULSE[dvHDPVR1,cd2]
										wait 4
										PULSE[dvHDPVR1,cd0]
										wait 7
										PULSE[dvHDPVR1,cd2]
						CASE 30:PULSE[dvHDPVR1,cd2]
										wait 4
										PULSE[dvHDPVR1,cd6]
										wait 7
										PULSE[dvHDPVR1,cd0]
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