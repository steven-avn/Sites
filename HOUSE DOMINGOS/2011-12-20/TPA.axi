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
integer ctExit		=		52
integer ctGuide		=		45
integer ctInfo		=		51
integer ctPower		=		9
integer ctMenu		=		44
integer ctOk			=		50
integer ctUp			=		46
integer ctDwn			= 	47
integer ctLeft		=		49
integer ctRight		=		48
integer ct1				=		11
integer ct2				=		12
integer ct3				=		13
integer ct4				=		14
integer ct5				=		15
integer ct6				=		16
integer ct7				=		17
integer ct8				=		18
integer ct9				=		19
integer ct0				=		10
integer ctRecall	=		55
integer ctChUp		=		22
integer ctChDn		=		23


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

button_event[dvTP,200]
button_event[dvTP,201]
button_event[dvTP,202]
button_event[dvTP,203]
button_event[dvTP,204]
button_event[dvTP,205]
button_event[dvTP,206]
button_event[dvTP,207]
button_event[dvTP,208]
button_event[dvTP,209]
button_event[dvTP,210]
button_event[dvTP,211]
button_event[dvTP,212]
button_event[dvTP,213]
button_event[dvTP,214]
button_event[dvTP,215]
button_event[dvTP,216]
button_event[dvTP,217]
button_event[dvTP,218]
button_event[dvTP,219]
button_event[dvTP,220]
button_event[dvTP,221]
button_event[dvTP,222]
button_event[dvTP,85]
button_event[dvTP,95]
{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 200: pulse[dvTPA,ctMenu]
			case 201: pulse[dvTPA,ctPower]
			case 202: pulse[dvTPA,ctGuide]
			case 203: pulse[dvTPA,ctInfo]
			case 204: pulse[dvTPA,ctUp]
			case 205: pulse[dvTPA,ctDwn]
			case 207: pulse[dvTPA,ctLeft]
			case 206: pulse[dvTPA,ctRight]
			case 208: pulse[dvTPA,ctOk]
			case 210: pulse[dvTPA,ctExit]
			case 209: pulse[dvTPA,ctRecall]
			case 211: pulse[dvTPA,ct1]
			case 212: pulse[dvTPA,ct2]
			case 213: pulse[dvTPA,ct3]
			case 214: pulse[dvTPA,ct4]
			case 215: pulse[dvTPA,ct5]
			case 216: pulse[dvTPA,ct6]
			case 217: pulse[dvTPA,ct7]
			case 218: pulse[dvTPA,ct8]
			case 219: pulse[dvTPA,ct9]
			case 220: pulse[dvTPA,ct0]
			case 221: pulse[dvTPA,ctChUp]
			case 222: pulse[dvTPA,ctChDn]
			case 85: 	pulse[dvTPA,ct1]
			case 95: 	pulse[dvTPA,ct2]
		}
  }
}

button_event[dvR4_1,200]
button_event[dvR4_1,201]
button_event[dvR4_1,202]
button_event[dvR4_1,203]
button_event[dvR4_1,204]
button_event[dvR4_1,205]
button_event[dvR4_1,206]
button_event[dvR4_1,207]
button_event[dvR4_1,208]
button_event[dvR4_1,209]
button_event[dvR4_1,210]
button_event[dvR4_1,211]
button_event[dvR4_1,212]
button_event[dvR4_1,213]
button_event[dvR4_1,214]
button_event[dvR4_1,215]
button_event[dvR4_1,216]
button_event[dvR4_1,217]
button_event[dvR4_1,218]
button_event[dvR4_1,219]
button_event[dvR4_1,220]
button_event[dvR4_1,221]
button_event[dvR4_1,222]
button_event[dvR4_1,85]
button_event[dvR4_1,95]
{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 200: pulse[dvTPA,ctMenu]
			case 201: pulse[dvTPA,ctPower]
			case 202: pulse[dvTPA,ctGuide]
			case 203: pulse[dvTPA,ctInfo]
			case 204: pulse[dvTPA,ctUp]
			case 205: pulse[dvTPA,ctDwn]
			case 207: pulse[dvTPA,ctLeft]
			case 206: pulse[dvTPA,ctRight]
			case 208: pulse[dvTPA,ctOk]
			case 210: pulse[dvTPA,ctExit]
			case 209: pulse[dvTPA,ctRecall]
			case 211: pulse[dvTPA,ct1]
			case 212: pulse[dvTPA,ct2]
			case 213: pulse[dvTPA,ct3]
			case 214: pulse[dvTPA,ct4]
			case 215: pulse[dvTPA,ct5]
			case 216: pulse[dvTPA,ct6]
			case 217: pulse[dvTPA,ct7]
			case 218: pulse[dvTPA,ct8]
			case 219: pulse[dvTPA,ct9]
			case 220: pulse[dvTPA,ct0]
			case 221: pulse[dvTPA,ctChUp]
			case 222: pulse[dvTPA,ctChDn]
			case 85: 	pulse[dvTPA,ct1]
			case 95: 	pulse[dvTPA,ct2]
		}
  }
}


button_event[dvR4_RM3,200]
button_event[dvR4_RM3,201]
button_event[dvR4_RM3,202]
button_event[dvR4_RM3,203]
button_event[dvR4_RM3,204]
button_event[dvR4_RM3,205]
button_event[dvR4_RM3,206]
button_event[dvR4_RM3,207]
button_event[dvR4_RM3,208]
button_event[dvR4_RM3,209]
button_event[dvR4_RM3,210]
button_event[dvR4_RM3,211]
button_event[dvR4_RM3,212]
button_event[dvR4_RM3,213]
button_event[dvR4_RM3,214]
button_event[dvR4_RM3,215]
button_event[dvR4_RM3,216]
button_event[dvR4_RM3,217]
button_event[dvR4_RM3,218]
button_event[dvR4_RM3,219]
button_event[dvR4_RM3,220]
button_event[dvR4_RM3,221]
button_event[dvR4_RM3,222]
button_event[dvR4_RM3,85]
button_event[dvR4_RM3,95]
{
  push:
  {
	to[dvR4_RM3,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 200: pulse[dvTPA,ctMenu]
			case 201: pulse[dvTPA,ctPower]
			case 202: pulse[dvTPA,ctGuide]
			case 203: pulse[dvTPA,ctInfo]
			case 204: pulse[dvTPA,ctUp]
			case 205: pulse[dvTPA,ctDwn]
			case 207: pulse[dvTPA,ctLeft]
			case 206: pulse[dvTPA,ctRight]
			case 208: pulse[dvTPA,ctOk]
			case 210: pulse[dvTPA,ctExit]
			case 209: pulse[dvTPA,ctRecall]
			case 211: pulse[dvTPA,ct1]
			case 212: pulse[dvTPA,ct2]
			case 213: pulse[dvTPA,ct3]
			case 214: pulse[dvTPA,ct4]
			case 215: pulse[dvTPA,ct5]
			case 216: pulse[dvTPA,ct6]
			case 217: pulse[dvTPA,ct7]
			case 218: pulse[dvTPA,ct8]
			case 219: pulse[dvTPA,ct9]
			case 220: pulse[dvTPA,ct0]
			case 221: pulse[dvTPA,ctChUp]
			case 222: pulse[dvTPA,ctChDn]
			case 85: 	pulse[dvTPA,ct1]
			case 95: 	pulse[dvTPA,ct2]
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