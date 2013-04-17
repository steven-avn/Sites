PROGRAM_NAME='MATRIX'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
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

dvPUTRON		=		5001:1:0												//PUTRON MVG88 VGA/AUDIO MATRIX

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

SEND_COMMAND dvPUTRON,'SET BAUD,9600,N,8,1'		 	 //PUTRON SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DEFINE_CALL 'PTNInput1'		// INPUT 1 SELECTED
{
	 SEND_STRING dvPUTRON, "'1V1.'"
	 SEND_STRING dvPUTRON, "'1A1.'"
}

DEFINE_CALL 'PTNInput2'		// INPUT 2 SELECTED
{
	 SEND_STRING dvPUTRON, "'2V1.'"
	 SEND_STRING dvPUTRON, "'2A1.'"
}

DEFINE_CALL 'PTNInput3'		// INPUT 3 SELECTED
{
	 SEND_STRING dvPUTRON, "'3V1.'"
	 SEND_STRING dvPUTRON, "'3A1.'"
}

DEFINE_CALL 'PTNInput4'		// INPUT 4 SELECTED
{
	 SEND_STRING dvPUTRON, "'4V1.'"
	 SEND_STRING dvPUTRON, "'4A1.'"
}

DEFINE_CALL 'PTNInput5'		// INPUT 5 SELECTED
{
	 SEND_STRING dvPUTRON, "'5V1.'"
	 SEND_STRING dvPUTRON, "'5A1.'"
}

DEFINE_CALL 'PTNInput6'		// INPUT 6 SELECTED
{
	 SEND_STRING dvPUTRON, "'6V1.'"
	 SEND_STRING dvPUTRON, "'6A1.'"
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

