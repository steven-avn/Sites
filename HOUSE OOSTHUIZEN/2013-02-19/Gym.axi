PROGRAM_NAME='Gym'
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

//---------------------------KEYPAD------------------------//
BUTTON_EVENT[dvKP_Gym,1]		//MULTI PURPOSE ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsMultiPurpRm == 0)
			{
				 CALL 'LightsMultiPurpRm_On';		//MULTI PURPOSE ROOM LIGHTS ON
				 vLightsMultiPurpRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsMultiPurpRm_Off';		//MULTI PURPOSE ROOM LIGHTS OFF
				 vLightsMultiPurpRm = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Gym,12]	//ON/OFF
{
  PUSH:
  {
			PULSE [dvHDMI_MultiPurp,9]		//Switches Sony TV on/off
			ON [vdvMatrixAudio[9],199];		//MUTE
  }
}

BUTTON_EVENT[dvKP_Gym,5]	//HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O5'"		//Input 1(HDPVR1) Output 5(GYM)
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-2'";		//Input 2(HDPVR1) Output 4(GYM)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvKP_Gym,6]	//HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O5'"		//Input 2(HDPVR2) Output 5(GYM)
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-3'";		//Input 3(HDPVR2) Output 4(GYM)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvKP_Gym,10]	//CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O5'"		//Input 3(CCTV) Output 5(GYM)
  }
}

BUTTON_EVENT[dvKP_Gym,9]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI4O5'"		// Input 4(MOVIESERVER) Output 5(gym)
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-4'";		// Input 12(MOVIESERVER) Output 9(gym)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvKP_Gym,7]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvKP_Gym,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
  }
}

BUTTON_EVENT[dvKP_Gym,11]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[9],199];		//MUTE
  }
}

BUTTON_EVENT[dvKP_Gym,14]		//VOLUME UP
BUTTON_EVENT[dvKP_Gym,13]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_MainBedrm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[9],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[9],24]
							 }
			CASE 13: ON[vdvMatrixAudio[9],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[9],25]
							 }
		}
  }
}

//--------------------------TOUCH PANEL---------------------//
BUTTON_EVENT[dvTP,822]		//MULTI PURPOSE ROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsMultiPurpRm == 0)
			{
				 CALL 'LightsMultiPurpRm_On';		//MULTI PURPOSE ROOM LIGHTS ON
				 vLightsMultiPurpRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsMultiPurpRm_Off';		//MULTI PURPOSE ROOM LIGHTS OFF
				 vLightsMultiPurpRm = 0;
			}
	}
}

BUTTON_EVENT[dvTP,59]	//ON/OFF
{
  PUSH:
  {
			PULSE [dvHDMI_MultiPurp,9]		//Switches Sony TV on/off
			ON [vdvMatrixAudio[9],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,51]	//HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O5'"		//Input 1(HDPVR1) Output 5(GYM)
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-2'";		//Input 2(HDPVR1) Output 4(GYM)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvTP,52]	//HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O5'"		//Input 2(HDPVR2) Output 5(GYM)
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-3'";		//Input 3(HDPVR2) Output 4(GYM)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvTP,13]	//CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O5'"		//Input 3(CCTV) Output 5(GYM)
  }
}

BUTTON_EVENT[dvTP,14]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI4O5'"		// Input 4(MOVIESERVER) Output 5(gym)
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-4'";		// Input 12(MOVIESERVER) Output 9(gym)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvTP,15]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[9],1,178;
  }
}

BUTTON_EVENT[dvTP,3]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
  }
}

BUTTON_EVENT[dvTP,8]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[9],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,7]		//VOLUME UP
BUTTON_EVENT[dvTP,43]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 7: ON[vdvMatrixAudio[9],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[9],24]
							 }
			CASE 43: ON[vdvMatrixAudio[9],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[9],25]
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