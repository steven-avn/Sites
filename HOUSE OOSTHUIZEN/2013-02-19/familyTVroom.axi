PROGRAM_NAME='familyTVroom'
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
BUTTON_EVENT[dvKP_FamTvRm,1]		// FAMILY TV ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsFamTvRm == 0)
			{
				 CALL 'LightsFamTvRm_On';		// FAMILY TV ROOM LIGHTS ON
				 vLightsFamTvRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsFamTvRm_Off';		// FAMILY TV ROOM LIGHTS OFF
				 vLightsFamTvRm = 0;
			}
	}
}

BUTTON_EVENT[dvKP_FamTvRm,2]		// FAMILY TV ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsFamTvRm == 0)
			{
				 CALL 'LightsFamTvRm_On';		// FAMILY TV ROOM LIGHTS ON
				 vLightsFamTvRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsFamTvRm_Off';		// FAMILY TV ROOM LIGHTS OFF
				 vLightsFamTvRm = 0;
			}
	}
}

BUTTON_EVENT[dvKP_FamTvRm,12]	// ON/OFF
{
  PUSH:
  {
			PULSE [dvHDMI_Bedroom1,9]		// Switches Sony TV on/off
			ON [vdvMatrixAudio[10],199];		// MUTE
  }
}

BUTTON_EVENT[dvKP_FamTvRm,9]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI4O8'"		// Input 4(MOVIESERVER) Output 8(FAMILY TV ROOM)
			SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-4'";		// Input 4(MOVIESERVER) Output 10(FAMILY TV ROOM)
			SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvKP_FamTvRm,7]	// MUSIC SERVER
{
  PUSH:
  {
		CALL 'XivaBedroom1';		// FAMILY TV ROOM
		SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-5'";		// Input 6(iMERGE 2) Output 10(FAMILY TV ROOM)
		SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvKP_FamTvRm,5]	// HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O8'"		// Input 1(HDPVR1) Output 8(FAMILY TV ROOM)
			SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-2'";		// Input 2(PVR1) Output 10(FAMILY TV ROOM)
			SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvKP_FamTvRm,6]	// HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O8'"		// Input 2(HDPVR2) Output 8(FAMILY TV ROOM)
			SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-3'";		// Input 3(PVR2) Output 10(FAMILY TV ROOM)
			SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvKP_FamTvRm,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
  }
}

BUTTON_EVENT[dvKP_FamTvRm,10]	// CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O8'"		// Input 3(CCTV) Output 8(FAMILY TV ROOM)
  }
}

BUTTON_EVENT[dvKP_FamTvRm,11]		// MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[10],199];		// MUTE
  }
}

BUTTON_EVENT[dvKP_FamTvRm,14]		// VOLUME UP
BUTTON_EVENT[dvKP_FamTvRm,13]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_FamTvRm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[10],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[10],24]
							 }
			CASE 13: ON[vdvMatrixAudio[10],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[10],25]
							 }
		}
  }
}

//--------------------------REMOTE------------------------//
BUTTON_EVENT[dvR4_FamTvRm,801]		// FAMILY TV ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsFamTvRm == 0)
			{
				 CALL 'LightsFamTvRm_On';		// FAMILY TV ROOM LIGHTS ON
				 vLightsFamTvRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsFamTvRm_Off';		// FAMILY TV ROOM LIGHTS OFF
				 vLightsFamTvRm = 0;
			}
	}
}

BUTTON_EVENT[dvR4_FamTvRm,803]		// FAMILY TV ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsFamTvRm == 0)
			{
				 CALL 'LightsFamTvRm_On';		// FAMILY TV ROOM LIGHTS ON
				 vLightsFamTvRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsFamTvRm_Off';		// FAMILY TV ROOM LIGHTS OFF
				 vLightsFamTvRm = 0;
			}
	}
}

BUTTON_EVENT[dvR4_FamTvRm,7]	// ON/OFF
{
  PUSH:
  {
		PULSE [dvHDMI_FamTV,9]		// Switches Samsung TV on/off
		ON [vdvMatrixAudio[10],199];		// MUTE
  }
}

BUTTON_EVENT[dvR4_FamTvRm,5]	// MOVIESERVER
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI4O8'"		// Input 4(MOVIESERVER) Output 8(FAMILY TV ROOM)
		SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-4'";		// Input 4(MOVIESERVER) Output 10(FAMILY TV ROOM)
		SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvR4_FamTvRm,4]	// MUSIC SERVER
{
  PUSH:
  {
		CALL 'XivaMainBedroom';		// FAMILY TV ROOM
		SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-5'";		// Input 6(iMERGE 2) Output 10(FAMILY TV ROOM)
		SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvR4_FamTvRm,19]	// HDPVR1
{
  PUSH:
  {
		SEND_COMMAND dvUTPRO_HDMI,"'CI1O8'"		// Input 1(HDPVR1) Output 8(FAMILY TV ROOM)
		SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-2'";		// Input 2(PVR1) Output 10(FAMILY TV ROOM)
		SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvR4_FamTvRm,20]	// HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O8'"		// Input 2(HDPVR2) Output 8(FAMILY TV ROOM)
			SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUTSELECT-3'";		// Input 3(PVR2) Output 10(FAMILY TV ROOM)
			SEND_LEVEL vdvMATRIXAUDIO[10],1,178;
  }
}

BUTTON_EVENT[dvR4_FamTvRm,6]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
  }
}

BUTTON_EVENT[dvR4_FamTvRm,15]	// CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O8'"		// Input 3(CCTV) Output 8(FAMILY TV ROOM)
  }
}

BUTTON_EVENT[dvR4_FamTvRm,3]		// MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[10],199];		// MUTE
  }
}

BUTTON_EVENT[dvR4_FamTvRm,1]		// VOLUME UP
BUTTON_EVENT[dvR4_FamTvRm,2]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvR4_FamTvRm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 1: ON[vdvMatrixAudio[10],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[10],24]
							 }
			CASE 2: ON[vdvMatrixAudio[10],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[10],25]
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