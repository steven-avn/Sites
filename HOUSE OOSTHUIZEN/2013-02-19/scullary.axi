PROGRAM_NAME='scullary'
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

//----------------------------KEYPAD--------------------------//
BUTTON_EVENT[dvKP_Scullary,1]		//SCULLARY LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsScullary == 0)
			{
				 CALL 'lightsScullary_On';		//SCULLARY LIGHTS ON
				 vLightsScullary = 1;
			}
	 ELSE
			{
				 CALL 'lightsScullary_Off';		//SCULLARY LIGHTS OFF
				 vLightsScullary = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Scullary,2]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Scullary,3]		//KITCHEN LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsKitchen == 0)
			{
				 CALL 'lightsKitchen_On';		//KITCHEN LIGHTS ON
				 CALL 'lightsKitchCorn_On';		//KITCHEN CORNER LIGHTS ON
				 CALL 'lightsKitchFloor_On';		//KITCHEN FLOOR LIGHTS ON
				 vLightsKitchen = 1;
			}
	 ELSE
			{
				 CALL 'lightsKitchen_Off';	 //KITCHEN LIGHTS OFF
				 CALL 'lightsKitchCorn_Off';		//KITCHEN CORNER LIGHTS OFF
				 CALL 'lightsKitchFloor_Off';		//KITCHEN FLOOR LIGHTS OFF
				 vLightsKitchen = 0;
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