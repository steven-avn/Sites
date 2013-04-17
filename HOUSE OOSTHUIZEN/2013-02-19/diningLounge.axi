PROGRAM_NAME='diningLounge'
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
BUTTON_EVENT[dvKP_DinningRm,1]		//KITCHEN LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsKitchen == 0)
			{
				 CALL 'lightsKitchen_On';		//KITCHEN LIGHTS ON
				 CALL 'lightsKitchCorn_On';		//KITCHEN CORNER LIGHTS ON
				 CALL 'lightsKitchFloor_On';		//KITCHEN FLOOR LIGHTS ON
				 vLightsKitchen = 1
			}
	 ELSE
			{
				 CALL 'lightsKitchen_Off';	 //KITCHEN LIGHTS OFF
				 CALL 'lightsKitchCorn_Off';		//KITCHEN CORNER LIGHTS OFF
				 CALL 'lightsKitchFloor_Off';		//KITCHEN FLOOR LIGHTS OFF
				 vLightsKitchen = 0
			}
	}
}

BUTTON_EVENT[dvKP_DinningRm,2]		//SCULLARY LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsScullary == 0)
			{
				 CALL 'lightsScullary_On';		//SCULLARY LIGHTS ON
				 vLightsScullary = 1
			}
	 ELSE
			{
				 CALL 'lightsScullary_Off';		//SCULLARY LIGHTS OFF
				 vLightsScullary = 0
			}
	}
}

BUTTON_EVENT[dvKP_DinningRm,3]		//DINING ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsDining == 0)
			{
				 CALL 'lightsDiningRm_On';		//DINING ROOM LIGHTS ON
				 vLightsDining = 1;
			}
	 ELSE
			{
				 CALL 'lightsDiningRm_Off';		//DINING ROOM LIGHTS OFF
				 vLightsDining = 0;
			}
	}
}

BUTTON_EVENT[dvKP_DinningRm,4]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_DinningRm,7]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[7],1,178;
  }
}

BUTTON_EVENT[dvKP_DinningRm,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
  }
}

BUTTON_EVENT[dvKP_DinningRm,11]		//MUTE
{
	 PUSH:
	 {
			ON[vdvMatrixAudio[7],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_DinningRm,14]		//VOLUME UP
BUTTON_EVENT[dvKP_DinningRm,13]		//VOLUME DOWN
{
	 HOLD[1,REPEAT]:
	 {
	 PULSE[dvKP_DinningRm,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 14: ON[vdvMatrixAudio[7],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[7],24]
							 }
			CASE 13: ON[vdvMatrixAudio[7],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[7],25]
							 }
			}
	 }
}

//---------------------------TOUCH PANEL------------------------//
BUTTON_EVENT[dvTP,807]		//DINING ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsDining == 0)
			{
				 CALL 'lightsDiningRm_On';		//DINING ROOM LIGHTS ON
				 vLightsDining = 1;
			}
	 ELSE
			{
				 CALL 'lightsDiningRm_Off';		//DINING ROOM LIGHTS OFF
				 vLightsDining = 0;
			}
	}
}

BUTTON_EVENT[dvTP,805]		//FORMAL LOUNGE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsLounge == 0)
			{
				 CALL 'lightsFormLounge_On';		//FORMAL LOUNGE LIGHTS ON
				 vLightsLounge = 1;
			}
	 ELSE
			{
				 CALL 'lightsFormLounge_Off';		//FORMAL LOUNGE LIGHTS OFF
				 vLightsLounge = 0;
			}
	}
}

BUTTON_EVENT[dvTP,75]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[7],1,178;
  }
}

BUTTON_EVENT[dvTP,48]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
  }
}

BUTTON_EVENT[dvTP,45]		//MUTE
{
  PUSH:
  {
		ON[vdvMatrixAudio[7],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,44]		//VOLUME UP
BUTTON_EVENT[dvTP,46]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 44: ON[vdvMatrixAudio[7],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[7],24]
							 }
			CASE 46: ON[vdvMatrixAudio[7],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[7],25]
							 }
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