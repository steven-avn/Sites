PROGRAM_NAME='Lights'
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

volatile integer vLightsBedRMmain = 0;
volatile integer vLightsBedRMmainBath = 0;
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

BUTTON_EVENT[dvTP,819]		// BEDROOM 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRm1Down == 0)
			{
				 CALL 'LightsBedRm1Down_On';		// BEDROOM 1 LIGHTS ON
				 vLightsBedRm1Down = 1;
			}
	 ELSE
			{
				 CALL 'LightsBedRm1Down_Off';		// BEDROOM 1 LIGHTS OFF
				 vLightsBedRm1Down = 0;
			}
	}
}

BUTTON_EVENT[dvTP,819]		// BEDROOM 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRm1Lamp == 0)
			{
				 CALL 'LightsBedRm1Lamp_On';		// BEDROOM 1 LIGHTS ON
				 vLightsBedRm1Lamp = 1;
			}
	 ELSE
			{
				 CALL 'LightsBedRm1Lamp_Off';		// BEDROOM 1 LIGHTS OFF
				 vLightsBedRm1Lamp = 0;
			}
	}
}

BUTTON_EVENT[dvTP,820]		// BEDROOM 2 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRm1Down == 0)
			{
				 CALL 'LightsBedRm2Down_On';		// BEDROOM 2 LIGHTS ON
				 vLightsBedRm2Down = 1;
			}
	 ELSE
			{
				 CALL 'LightsBedRm2Down_Off';		// BEDROOM 2 LIGHTS OFF
				 vLightsBedRm2Down = 0;
			}
	}
}

BUTTON_EVENT[dvTP,820]		// BEDROOM 2 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRm2Lamp == 0)
			{
				 CALL 'LightsBedRm2Lamp_On';		// BEDROOM 2 LIGHTS ON
				 vLightsBedRm2Lamp = 1;
			}
	 ELSE
			{
				 CALL 'LightsBedRm2Lamp_Off';		// BEDROOM 2 LIGHTS OFF
				 vLightsBedRm2Lamp = 0;
			}
	}
}

BUTTON_EVENT[dvTP,817]		// MAIN BEDROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRMmain == 0)
			{
				 CALL 'LightsMainBedRm_Room_On';		// MAIN BEDROOM LIGHTS ON
				 CALL 'LightsMainBedRm_Z3_On';		// MAIN BEDROOM LIGHTS ON
				 vLightsBedRMmain = 1;
			}
	 ELSE
			{
				 CALL 'LightsMainBedRm_Room_Off';		// MAIN BEDROOM LIGHTS ON
				 CALL 'LightsMainBedRm_Z3_Off';		// MAIN BEDROOM LIGHTS ON
				 vLightsBedRMmain = 0;
			}
	}
}

BUTTON_EVENT[dvTP,816]		// MAIN BEDROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRMmainBath == 0)
			{
				 CALL 'LightsMainBedRm_Bath_On';		// MAIN BEDROOM LIGHTS ON
				 vLightsBedRMmainBath = 1;
			}
	 ELSE
			{
				 CALL 'LightsMainBedRm_Bath_Off';		// MAIN BEDROOM LIGHTS ON
				   vLightsBedRMmainBath = 0;
			}
	}
}

BUTTON_EVENT[dvTP,809]		//WINE CELLAR LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsWineCellar == 0)
			{
				 CALL 'lightsWineCellar_On';		//WINE CELLAR LIGHTS ON
				 vLightsWineCellar = 1;
			}
	 ELSE
			{
				 CALL 'lightsWineCellar_Off';		//WINE CELLAR LIGHTS OFF
				 vLightsWineCellar = 0;
			}
	}
}

BUTTON_EVENT[dvTP,821]		//FAMILY TV ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsFamTvRm == 0)
			{
				 CALL 'LightsFamTvRm_On';		//FAMILY TV ROOM LIGHTS ON
				 vLightsFamTvRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsFamTvRm_Off';		//FAMILY TV ROOM LIGHTS OFF
				 vLightsFamTvRm = 0;
			}
	}
}

BUTTON_EVENT[dvTP,815]		//SCULLARY LIGHTS ON/OFF
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

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)