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

//dvPUTRON		=		5001:1:0												//PUTRON MVG88 VGA/AUDIO MATRIX
dvKRAMER					=		 5001:1:0		// KRAMER 4X4 MATRIX

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

//SEND_COMMAND dvPUTRON,'SET BAUD,9600,N,8,1'		 	 //PUTRON SERIAL COMMS SETTINGS
SEND_COMMAND dvKRAMER,'SET BAUD,9600,N,8,1'			 //KRAMER SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DEFINE_CALL 'Input1'		// INPUT 1 SELECTED
{
	 SEND_STRING dvKRAMER, "$01,$81,$81,$81"	//COMBINE PRESEN(VIDEO)
}

DEFINE_CALL 'Input2'		// INPUT 2 SELECTED
{
	 SEND_STRING dvKRAMER, "$01,$82,$81,$81"	//COMBINE PRESEN(VIDEO)
}

DEFINE_CALL 'VCInput'		// INPUT 3 SELECTED
{
	 SEND_STRING dvKRAMER, "$01,$83,$81,$81"	//VIDEO IN3 TO OUT1
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

