PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/17/2012  AT: 10:22:29        *)
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

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER PROJECTOR_POWER = 0		//0=OFF, 1=ON
VOLATILE INTEGER PROJECTOR_INPUT = 0		//0=VGA, 1=HDMI

VOLATILE INTEGER InputPopup1 = 0
VOLATILE INTEGER InputPopup2 = 0
VOLATILE INTEGER InputPopup3 = 0
VOLATILE INTEGER InputPopup4 = 0
VOLATILE INTEGER InputPopup5 = 0
VOLATILE INTEGER InputPopup6 = 0
VOLATILE INTEGER InputDSTV = 0
VOLATILE INTEGER InputPOLY = 0
VOLATILE INTEGER InputPopup1HDMI = 0
VOLATILE INTEGER InputPopup2HDMI = 0

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

define_call 'Projector_On'		//Projector On
{
	 if(PROJECTOR_POWER == 0)
	 {
			pulse [dvPROJECTOR,9]
			PROJECTOR_POWER = 1
	 }
}

define_call 'Projector_Off'		//Projector Off
{
	 if(PROJECTOR_POWER == 1)
	 {
			pulse [dvPROJECTOR,9]
			wait 10
			pulse [dvPROJECTOR,9]
			PROJECTOR_POWER = 0
	 }
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

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