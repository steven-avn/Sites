PROGRAM_NAME='bedroom1'
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

//-----------------------KEYPAD--------------------------//
BUTTON_EVENT[dvKP_Bedrm1,1]		// BEDROOM 1 LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Bedrm1,2]		// BEDROOM 1 LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Bedrm1,12]	// ON/OFF
{
  PUSH:
  {
			PULSE [dvHDMI_Bedroom1,9]		// Switches Sony TV on/off
			ON [vdvMatrixAudio[2],199];		// MUTE
  }
}

BUTTON_EVENT[dvKP_Bedrm1,9]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI4O3'"		// Input 4(MOVIESERVER) Output 3(BEDROOM 1)
			SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-4'";		// Input 4(MOVIESERVER) Output 2(BEDROOM 1)
			SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm1,7]	// MUSIC SERVER
{
  PUSH:
  {
		CALL 'XivaBedroom1';		// BEDROOM 1
		SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-5'";		// Input 6(iMERGE 2) Output 2(BEDROOM 1)
		SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm1,5]	// HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O3'"		// Input 1(HDPVR1) Output 3(BEDROOM 1)
			SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-2'";		// Input 2(PVR1) Output 2(BEDROOM 1)
			SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm1,6]	// HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O3'"		// Input 2(HDPVR2) Output 3(BEDROOM 1)
			SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-3'";		// Input 3(PVR2) Output 2(BEDROOM 1)
			SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm1,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
  }
}

BUTTON_EVENT[dvKP_Bedrm1,10]	// CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O3'"		// Input 3(CCTV) Output 3(BEDROOM 1)
  }
}

BUTTON_EVENT[dvKP_Bedrm1,11]		// MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[2],199];		// MUTE
  }
}

BUTTON_EVENT[dvKP_Bedrm1,14]		// VOLUME UP
BUTTON_EVENT[dvKP_Bedrm1,13]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_Bedrm1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[2],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[2],24]
							 }
			CASE 13: ON[vdvMatrixAudio[2],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[2],25]
							 }
		}
  }
}

//--------------------------REMOTE------------------------//
BUTTON_EVENT[dvR4_Bedrm1,801]		// BEDROOM 1 LIGHTS ON/OFF
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

BUTTON_EVENT[dvR4_Bedrm1,803]		// BEDROOM 1 LIGHTS ON/OFF
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

BUTTON_EVENT[dvR4_Bedrm1,7]	// ON/OFF
{
  PUSH:
  {
		PULSE [dvHDMI_Bedroom1,9]		// Switches Sony TV on/off
		ON [vdvMatrixAudio[2],199];		// MUTE
  }
}

BUTTON_EVENT[dvR4_Bedrm1,5]	// MOVIESERVER
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI4O3'"		// Input 4(MOVIESERVER) Output 3(BEDROOM 1)
		SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-4'";		// Input 4(MOVIESERVER) Output 2(BEDROOM 1)
		SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm1,4]	// MUSIC SERVER
{
  PUSH:
  {
		CALL 'XivaBedroom1';		// BEDROOM 1
		SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-5'";		// Input 6(iMERGE 2) Output 2(BEDROOM 1)
		SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm1,19]	// HDPVR1
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI1O3'"		// Input 1(HDPVR1) Output 3(BEDROOM 1)
		SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-2'";		// Input 2(PVR1) Output 2(BEDROOM 1)
		SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm1,20]	// HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O3'"		// Input 2(HDPVR2) Output 3(BEDROOM 1)
			SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-3'";		// Input 3(PVR2) Output 2(BEDROOM 1)
			SEND_LEVEL vdvMATRIXAUDIO[2],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm1,6]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
  }
}

BUTTON_EVENT[dvR4_Bedrm1,15]	// CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O3'"		// Input 3(CCTV) Output 3(BEDROOM 1)
  }
}

BUTTON_EVENT[dvR4_Bedrm1,3]		// MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[2],199];		// MUTE
  }
}

BUTTON_EVENT[dvR4_Bedrm1,1]		// VOLUME UP
BUTTON_EVENT[dvR4_Bedrm1,2]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvR4_Bedrm1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 1: ON[vdvMatrixAudio[2],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[2],24]
							 }
			CASE 2: ON[vdvMatrixAudio[2],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[2],25]
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