PROGRAM_NAME='FUNCTIONS'
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

DEFINE_CALL 'Projector_On'		//PROJECTOR ON
{
	 SEND_STRING dvProjector, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"
}

DEFINE_CALL 'Projector_Off'		//PROJECTOR OFF
{
	 SEND_STRING dvProjector, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"
}

DEFINE_CALL 'Screen_Dn'		//SCREEN DOWN
{
	 PULSE [dvScreen,cScreen_Dn]
}

DEFINE_CALL 'Screen_Up'		//SCREEN UP
{
	 PULSE [dvScreen,cScreen_Up]
}

DEFINE_CALL 'ProjectorLift_Dn'		//PROJECTOR LIFT DOWN
{
	 SEND_STRING dvProjLift, "$FF,$10,$11,$00,$EE"
}

DEFINE_CALL 'ProjectorLift_Up'		//PROJECTOR LIFT UP
{
	 SEND_STRING dvProjLift, "$FF,$10,$11,$00,$DD"
}

DEFINE_CALL 'Bose_On'		//BOSE ON
{
		SEND_STRING dvBose,  "$0b,$00,$01,$04,$4c,$01,$2c,$01,$00,$00,$6e"
}

DEFINE_CALL 'Bose_Off'		//BOSE OFF
{
	 SEND_STRING dvBose,  "$0b,$00,$01,$04,$4c,$01,$2c,$01,$00,$00,$6e"
}

DEFINE_CALL 'Bose_DSTV'		//BOSE DSTV
{
	 SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"
}

DEFINE_CALL 'Bose_DVD'		//BOSE DVD
{
	 SEND_STRING dvBose,  "$0b,$00,$01,$04,$13,$01,$2c,$01,$00,$00,$31"
}

DEFINE_CALL 'Bose_IPOD'		//BOSE iPOD
{
	 SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"
}

DEFINE_CALL 'Bose_Radio'		//BOSE Radio
{
	 SEND_STRING dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"
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