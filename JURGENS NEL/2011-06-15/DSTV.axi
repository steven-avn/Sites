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

/////////////////Constants for DSTV TV1//////////////////////////
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
integer cdDMX			=		122		
integer cd2ChUp		=		157
integer cd2ChDn		=		158
integer cdPLAY		=		1
integer cdSTOP		=		2
integer cdFFW			=		4
integer cdREW			=		5
integer cdRECORD	=		8
integer cdPVR_MENU			=		131
integer cdSTATUS_BAR		=		130		
integer cdSLOWMO				=		63
integer cdBOOKMARK			=		129
integer cdPLAYLIST			=		60


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

set_pulse_time (1)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

button_event[dvR4_1,100]
button_event[dvR4_1,101]
button_event[dvR4_1,102]
button_event[dvR4_1,103]
button_event[dvR4_1,104]
button_event[dvR4_1,105]
button_event[dvR4_1,106]
button_event[dvR4_1,107]
button_event[dvR4_1,108]
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
button_event[dvR4_1,10]
button_event[dvR4_1,11]
button_event[dvR4_1,12]
button_event[dvR4_1,13]
button_event[dvR4_1,14]
button_event[dvR4_1,15]
button_event[dvR4_1,16]
button_event[dvR4_1,17]
button_event[dvR4_1,41]
button_event[dvR4_1,42]
button_event[dvR4_1,43]
button_event[dvR4_1,44]
button_event[dvR4_1,45]
button_event[dvR4_1,46]
button_event[dvR4_1,47]
button_event[dvR4_1,48]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 100: pulse[dvDSTV,cdMenu]
			case 101: pulse[dvDSTV,cdGuide]
			case 102: pulse[dvDSTV,cdExit]
			case 103: pulse[dvDSTV,cdInfo]
			case 104: pulse[dvDSTV,cdUp]
			case 105: pulse[dvDSTV,cdDwn]
			case 107: pulse[dvDSTV,cdLeft]
			case 106: pulse[dvDSTV,cdRight]
			case 108: pulse[dvDSTV,cdOk]
			case 111: pulse[dvDSTV,cd1]
			case 112: pulse[dvDSTV,cd2]
			case 113: pulse[dvDSTV,cd3]
			case 114: pulse[dvDSTV,cd4]
			case 115: pulse[dvDSTV,cd5]
			case 116: pulse[dvDSTV,cd6]
			case 117: pulse[dvDSTV,cd7]
			case 118: pulse[dvDSTV,cd8]
			case 119: pulse[dvDSTV,cd9]
			case 120: pulse[dvDSTV,cd0]
			case 121: pulse[dvDSTV,cdChUp]
			case 122: pulse[dvDSTV,cdChDn]
						
			CASE 10: 	SEND_COMMAND dvDSTV, "'XCH 201'"									//SS1
			CASE 11: 	SEND_COMMAND dvDSTV, "'XCH 202'"									//SS2
			CASE 12: 	SEND_COMMAND dvDSTV, "'XCH 101'"									//MNET
			CASE 13: 	SEND_COMMAND dvDSTV, "'XCH 103'"									//MM1
			CASE 14: 	SEND_COMMAND dvDSTV, "'XCH 104'"									//MM2
			CASE 15:  SEND_COMMAND dvDSTV, "'XCH 111'"									//KYKNET
			CASE 16:  SEND_COMMAND dvDSTV, "'XCH 302'"									//BOOMERANG
			CASE 17:  SEND_COMMAND dvDSTV, "'XCH 402'"									//SKYNEWS
								
			case 41:	pulse[dvDSTV,cdPLAYLIST]
			case 42:	pulse[dvDSTV,cdRECORD]
			case 43: 	pulse[dvDSTV,cdPVR_MENU]
			case 44: 	pulse[dvDSTV,cdBOOKMARK]
			case 45: 	pulse[dvDSTV,cdPLAY]
			case 46: 	pulse[dvDSTV,cdSTOP]
			case 47: 	pulse[dvDSTV,cdREW]
			case 48: 	pulse[dvDSTV,cdFFW]
		}
  }
}

button_event[dvR4_2,100]
button_event[dvR4_2,101]
button_event[dvR4_2,102]
button_event[dvR4_2,103]
button_event[dvR4_2,104]
button_event[dvR4_2,105]
button_event[dvR4_2,106]
button_event[dvR4_2,107]
button_event[dvR4_2,108]
button_event[dvR4_2,111]
button_event[dvR4_2,112]
button_event[dvR4_2,113]
button_event[dvR4_2,114]
button_event[dvR4_2,115]
button_event[dvR4_2,116]
button_event[dvR4_2,117]
button_event[dvR4_2,118]
button_event[dvR4_2,119]
button_event[dvR4_2,120]
button_event[dvR4_2,121]
button_event[dvR4_2,122]
button_event[dvR4_2,10]
button_event[dvR4_2,11]
button_event[dvR4_2,12]
button_event[dvR4_2,13]
button_event[dvR4_2,14]
button_event[dvR4_2,15]
button_event[dvR4_2,16]
button_event[dvR4_2,17]
button_event[dvR4_1,41]
button_event[dvR4_1,42]
button_event[dvR4_1,43]
button_event[dvR4_1,44]
button_event[dvR4_1,45]
button_event[dvR4_1,46]
button_event[dvR4_1,47]
button_event[dvR4_1,48]

{
  push:
  {
	to[dvR4_2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 100: pulse[dvDSTV,cdMenu]
			case 101: pulse[dvDSTV,cdGuide]
			case 102: pulse[dvDSTV,cdExit]
			case 103: pulse[dvDSTV,cdInfo]
			case 104: pulse[dvDSTV,cdUp]
			case 105: pulse[dvDSTV,cdDwn]
			case 107: pulse[dvDSTV,cdLeft]
			case 106: pulse[dvDSTV,cdRight]
			case 108: pulse[dvDSTV,cdOk]
			case 111: pulse[dvDSTV,cd1]
			case 112: pulse[dvDSTV,cd2]
			case 113: pulse[dvDSTV,cd3]
			case 114: pulse[dvDSTV,cd4]
			case 115: pulse[dvDSTV,cd5]
			case 116: pulse[dvDSTV,cd6]
			case 117: pulse[dvDSTV,cd7]
			case 118: pulse[dvDSTV,cd8]
			case 119: pulse[dvDSTV,cd9]
			case 120: pulse[dvDSTV,cd0]
			case 121: pulse[dvDSTV,cdChUp]
			case 122: pulse[dvDSTV,cdChDn]
						
			CASE 10: 	SEND_COMMAND dvDSTV, "'XCH 201'"									//SS1
			CASE 11: 	SEND_COMMAND dvDSTV, "'XCH 202'"									//SS2
			CASE 12: 	SEND_COMMAND dvDSTV, "'XCH 101'"									//MNET
			CASE 13: 	SEND_COMMAND dvDSTV, "'XCH 103'"									//MM1
			CASE 14: 	SEND_COMMAND dvDSTV, "'XCH 104'"									//MM2
			CASE 15:  SEND_COMMAND dvDSTV, "'XCH 111'"									//KYKNET
			CASE 16:  SEND_COMMAND dvDSTV, "'XCH 302'"									//BOOMERANG
			CASE 17:  SEND_COMMAND dvDSTV, "'XCH 402'"									//SKYNEWS
								
			case 41:	pulse[dvDSTV,cdPLAYLIST]
			case 42:	pulse[dvDSTV,cdRECORD]
			case 43: 	pulse[dvDSTV,cdPVR_MENU]
			case 44: 	pulse[dvDSTV,cdBOOKMARK]
			case 45: 	pulse[dvDSTV,cdPLAY]
			case 46: 	pulse[dvDSTV,cdSTOP]
			case 47: 	pulse[dvDSTV,cdREW]
			case 48: 	pulse[dvDSTV,cdFFW]
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