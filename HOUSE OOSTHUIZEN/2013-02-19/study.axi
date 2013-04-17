PROGRAM_NAME='study'
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

//--------------------------KEYPAD-----------------------//
BUTTON_EVENT[dvKP_Study,1]		//STUDY LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsStudy == 0)
			{
				 CALL 'LightsStudy_On';		//STUDY LIGHTS ON
				 vLightsStudy = 1;
			}
	 ELSE
			{
				 CALL 'LightsStudy_Off';		//STUDY LIGHTS OFF
				 vLightsStudy = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Study,2]		//BALCONY LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBalcony == 0)
			{
				 CALL 'lightsBalcony_On';		//BALCONY LIGHTS ON
				 vLightsBalcony = 1;
			}
	 ELSE
			{
				 CALL 'lightsBalcony_Off';		//BALCONY LIGHTS OFF
				 vLightsBalcony = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Study,3]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Study,4]		//PASSAGE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassages == 0)
			{
				 CALL 'EntranceLightsOn';
				 vLightsPassages = 1;
			}
	 ELSE
			{
				 CALL 'EntranceLightsOff';
				 vLightsPassages = 0;
			}
	}
}

BUTTON_EVENT[dvTP,801]		//STUDY LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsStudy == 0)
			{
				 CALL 'LightsStudy_On';		//STUDY LIGHTS ON
				 vLightsStudy = 1;
			}
	 ELSE
			{
				 CALL 'LightsStudy_Off';		//STUDY LIGHTS OFF
				 vLightsStudy = 0;
			}
	}
}

BUTTON_EVENT[dvTP,802]		//BALCONY LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBalcony == 0)
			{
				 CALL 'lightsBalcony_On';		//BALCONY LIGHTS ON
				 vLightsBalcony = 1;
			}
	 ELSE
			{
				 CALL 'lightsBalcony_Off';		//BALCONY LIGHTS OFF
				 vLightsBalcony = 0;
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