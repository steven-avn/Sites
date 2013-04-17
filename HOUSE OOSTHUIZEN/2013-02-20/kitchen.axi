PROGRAM_NAME='kitchen'
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
BUTTON_EVENT[dvKP_Kitchen,1]		//KITCHEN LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Kitchen,2]		//SCULLARY LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Kitchen,3]		//DINING ROOM LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Kitchen,4]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Kitchen,12]	//ON/OFF
{
	 PUSH:
	 {
			PULSE [dvHDMI_Kitchen,9]		//Switches Sony TV on/off
			ON [vdvMatrixAudio[8],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_Kitchen,5]	//HDPVR1
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O6'"		//Input 1(HDPVR1) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-2'";		//Input 10(PVR1) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
	 }
}

BUTTON_EVENT[dvKP_Kitchen,6]	//HDPVR2
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O6'"		//Input 2(HDPVR2) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-3'";		//Input 11(PVR2) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
	 }
}

BUTTON_EVENT[dvKP_Kitchen,9]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O6'"		// Input 5(MOVIESERVER) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-5'";		// Input 5(MOVIESERVER) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
  }
}

BUTTON_EVENT[dvKP_Kitchen,7]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
  }
}

BUTTON_EVENT[dvKP_Kitchen,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
  }
}

BUTTON_EVENT[dvKP_Kitchen,10]	//CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O6'"		//Input 3(CCTV) Output 6(KITCHEN)
	 }
}

BUTTON_EVENT[dvKP_Kitchen,11]		//MUTE
{
	 PUSH:
	 {
			ON[vdvMatrixAudio[8],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_Kitchen,14]		//VOLUME UP
BUTTON_EVENT[dvKP_Kitchen,13]		//VOLUME DOWN
{
	 HOLD[1,REPEAT]:
	 {
	 PULSE[dvKP_Kitchen,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 14: ON[vdvMatrixAudio[8],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[8],24]
							 }
			CASE 13: ON[vdvMatrixAudio[8],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[8],25]
							 }
			}
	 }
}

//--------------------------TOUCH PANEL-----------------------------//
BUTTON_EVENT[dvTP,810]		//KITCHEN LIGHTS ON/OFF
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

BUTTON_EVENT[dvTP,60]	//ON/OFF
{
	 PUSH:
	 {
			PULSE [dvHDMI_Kitchen,9]		//Switches Sony TV on/off
			ON [vdvMatrixAudio[8],199];		//MUTE
	 }
}

BUTTON_EVENT[dvTP,61]	//HDPVR1
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O6'"		//Input 1(HDPVR1) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-2'";		//Input 10(PVR1) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
	 }
}

BUTTON_EVENT[dvTP,62]	//HDPVR2
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O6'"		//Input 2(HDPVR2) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-3'";		//Input 11(PVR2) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
	 }
}

BUTTON_EVENT[dvTP,19]	//CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O6'"		//Input 3(CCTV) Output 6(KITCHEN)
	 }
}

BUTTON_EVENT[dvTP,17]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O6'"		// Input 5(MOVIESERVER) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-5'";		// Input 5(MOVIESERVER) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
  }
}

BUTTON_EVENT[dvTP,16]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[8],1,178;
  }
}

BUTTON_EVENT[dvTP,18]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
  }
}

//------------------VOLUME CONTROL-----------------//
BUTTON_EVENT[dvTP,37]		//MUTE
{
  PUSH:
  {
		ON[vdvMatrixAudio[8],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,36]		//VOLUME UP
BUTTON_EVENT[dvTP,38]		//VOLUME DOWN
{
	 HOLD[1,REPEAT]:
	 {
	 PULSE[dvTP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 36: ON[vdvMatrixAudio[8],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[8],24]
							 }
			CASE 38: ON[vdvMatrixAudio[8],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[8],25]
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