PROGRAM_NAME='servantRoom'
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

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//--------------------------KEYPAD------------------------//
BUTTON_EVENT[dvKP_MaidRoom,1]		//MAID ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsMaidRm == 0)
			{
				 CALL 'lightsMaidRm_On';		//MAID ROOM LIGHTS ON
				 vLightsMaidRm = 1;
			}
	 ELSE
			{
				 CALL 'lightsMaidRm_Off';		//MAID ROOM LIGHTS OFF
				 vLightsMaidRm = 0;
			}
	}
}

BUTTON_EVENT[dvKP_MaidRoom,2]		//OUTSIDE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsOutside == 0)
			{
				 CALL 'lightsOutside_On';		//OUTSIDE LIGHTS ON
				 vLightsOutside = 1;
			}
	 ELSE
			{
				 CALL 'lightsOutside_Off';		//OUTSIDE LIGHTS OFF
				 vLightsOutside = 0;
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