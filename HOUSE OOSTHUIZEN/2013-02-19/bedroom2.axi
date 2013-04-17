PROGRAM_NAME='bedroom2'
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

//-----------------------KEYPAD-------------------------//

BUTTON_EVENT[dvKP_Bedrm2,1]		// BEDROOM 2 LIGHTS ON/OFF
{
  PUSH:
  {
		IF (vLightsBedRm2Down == 0)
		{
			CALL 'LightsBedRm2Down_On';		// BEDROOM 2 LIGHTS ON
			vLightsBedRm2Down = 1
		}
		ELSE
		{
			CALL 'LightsBedRm2Down_Off';		// BEDROOM 2 LIGHTS OFF
			vLightsBedRm2Down = 0
		}
	}
}

BUTTON_EVENT[dvKP_Bedrm2,2]		// BEDROOM 2 LIGHTS ON/OFF
{
  PUSH:
  {
	IF (vLightsBedRm2Lamp == 0)
		{
			CALL 'LightsBedRm2Lamp_On';		// BEDROOM 2 LIGHTS ON
			vLightsBedRm2Lamp = 1
		}
	ELSE
		{
			CALL 'LightsBedRm2Lamp_Off';		// BEDROOM 2 LIGHTS OFF
			vLightsBedRm2Lamp = 0
		}
	}
}

BUTTON_EVENT[dvKP_Bedrm2,12]	// ON/OFF
{
  PUSH:
  {
		PULSE [dvHDMI_Bedroom2,9]		// Switches Sony TV on/off
		ON [vdvMatrixAudio[3],199];		// MUTE
  }
}

BUTTON_EVENT[dvKP_Bedrm2,5]	// HDPVR1
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI1O4'"		// Input 1(HDPVR1) Output 4(BEDROOM 2)
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-2'";		// Input 2(PVR1) Output 3(BEDROOM 2)
		SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm2,6]	// HDPVR2
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI2O4'"		// Input 2(HDPVR2) Output 4(BEDROOM 2)
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-3'";		// Input 3(PVR2) Output 3(BEDROOM 2)
		SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm2,10]	// CCTV
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI3O4'"		// Input 3(CCTV) Output 4(BEDROOM 2)
  }
}

BUTTON_EVENT[dvKP_Bedrm2,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
  }
}

BUTTON_EVENT[dvKP_Bedrm2,9]	// MOVIESERVER
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI4O4'"		// Input 4(MOVIESERVER) Output 4(BEDROOM 2)
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-4'";		// Input 4(MOVIESERVER) Output 3(BEDROOM 2)
		SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm2,7]	// MUSIC SERVER
{
  PUSH:
  {
		CALL 'XivaBedroom2';		// BEDROOM 2
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-5'";		// Input 5(iMERGE 3) Output 3(BEDROOM 2)
		SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvKP_Bedrm2,11]		// MUTE
{
  PUSH:
  {
		ON [vdvMatrixAudio[3],199];		// MUTE
  }
}

BUTTON_EVENT[dvKP_Bedrm2,14]		// VOLUME UP
BUTTON_EVENT[dvKP_Bedrm2,13]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_Bedrm2,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[3],24]
							 WAIT 2
							{
								OFF[vdvMatrixAudio[3],24]
							}
			CASE 13: ON[vdvMatrixAudio[3],25]
							 WAIT 2
							{
								OFF[vdvMatrixAudio[3],25]
							}
		}
  }
}

//--------------------------REMOTE------------------------//
BUTTON_EVENT[dvR4_Bedrm2,801]		// BEDROOM 2 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRm2Down == 0)
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

BUTTON_EVENT[dvR4_Bedrm2,803]		// BEDROOM 2 LIGHTS ON/OFF
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

BUTTON_EVENT[dvR4_Bedrm2,7]	// ON/OFF
{
  PUSH:
  {
			PULSE [dvHDMI_Bedroom2,9]		// Switches Sony TV on/off
			ON [vdvMatrixAudio[3],199];		// MUTE
  }
}

BUTTON_EVENT[dvR4_Bedrm2,19]	// HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O4'"		// Input 1(HDPVR1) Output 4(BEDROOM 2)
			SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-2'";		// Input 2(PVR1) Output 3(BEDROOM 2)
			SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm2,20]	// HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O4'"		// Input 2(HDPVR2) Output 4(BEDROOM 2)
			SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-3'";		// Input 3(PVR2) Output 3(BEDROOM 2)
			SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm2,15]	// CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O4'"		// Input 3(CCTV) Output 4(BEDROOM 2)
  }
}

BUTTON_EVENT[dvR4_Bedrm2,6]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
  }
}

BUTTON_EVENT[dvR4_Bedrm2,5]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI4O4'"		// Input 4(MOVIESERVER) Output 4(BEDROOM 2)
			SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-4'";		// Input 4(MOVIESERVER) Output 3(BEDROOM 2)
			SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm2,4]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaBedroom2';		// BEDROOM 2
		SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-5'";		// Input 5(iMERGE 3) Output 3(BEDROOM 2)
			SEND_LEVEL vdvMATRIXAUDIO[3],1,178;
  }
}

BUTTON_EVENT[dvR4_Bedrm2,3]		// MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[3],199];		// MUTE
  }
}

BUTTON_EVENT[dvR4_Bedrm2,1]		// VOLUME UP
BUTTON_EVENT[dvR4_Bedrm2,2]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvR4_Bedrm2,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 1: ON[vdvMatrixAudio[3],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[3],24]
							 }
			CASE 2: ON[vdvMatrixAudio[3],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[3],25]
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