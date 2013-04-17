PROGRAM_NAME='patio'
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

//-----------------------KEYPAD----------------------//
BUTTON_EVENT[dvKP_Patio,1]		//PATIO LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPatio == 0)
			{
				 CALL 'lightsPatio_On';		//PATIO LIGHTS ON
				 vLightsPatio = 1;
			}
	 ELSE
			{
				 CALL 'lightsPatio_Off';		//PATIO LIGHTS OFF
				 vLightsPatio = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Patio,2]		//POOL PATIO LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPatioPool == 0)
			{
				 CALL 'LightsPoolPatio_On';		//POOL PATIO LIGHTS ON
				 CALL 'LightsUnderPool_On';		//POOL LIGHTS UNDERWATER ON
				 vLightsPatioPool = 1;
			}
	 ELSE
			{
				 CALL 'LightsPoolPatio_Off';		//POOL PATIO LIGHTS OFF
				 CALL 'LightsUnderPool_Off';		//POOL LIGHTS UNDERWATER OFF
				 vLightsPatioPool = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Patio,3]		//FORMAL LOUNGE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Patio,4]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_Patio,12]	//ON/OFF
{
	 PUSH:
	 {
			PULSE [dvHDMI_Kitchen,9]		//Switches Sony TV on/off
			ON [vdvMatrixAudio[11],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_Patio,5]	//HDPVR1
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O7'"		//Input 1(HDPVR1) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-2'";		//Input 10(PVR1) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
	 }
}

BUTTON_EVENT[dvKP_Patio,6]	//HDPVR2
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O7'"		//Input 2(HDPVR2) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-3'";		//Input 11(PVR2) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
	 }
}

BUTTON_EVENT[dvKP_Patio,9]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O7'"		// Input 8(MOVIESERVER) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-4'";		// Input 5(MOVIESERVER) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
  }
}

BUTTON_EVENT[dvKP_Patio,7]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
  }
}

BUTTON_EVENT[dvKP_Patio,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
  }
}

BUTTON_EVENT[dvKP_Patio,10]	//CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O7'"		//Input 3(CCTV) Output 6(KITCHEN)
	 }
}

BUTTON_EVENT[dvKP_Patio,11]		//MUTE
{
  PUSH:
  {
		 ON [vdvMatrixAudio[11],199];		//MUTE
  }
}

BUTTON_EVENT[dvKP_Patio,14]		//VOLUME UP
BUTTON_EVENT[dvKP_Patio,13]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_Patio,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[11],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[11],24]
							 }
			CASE 13: ON[vdvMatrixAudio[11],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[11],25]
							 }
		}
  }
}

//--------------------------TOUCH PANEL---------------------//
BUTTON_EVENT[dvTP,812]	//PATIO LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPatio == 0)
			{
				 CALL 'lightsPatio_On';		//PATIO LIGHTS ON
				 vLightsPatio = 1;
			}
	 ELSE
			{
				 CALL 'lightsPatio_Off';		//PATIO LIGHTS OFF
				 vLightsPatio = 0;
			}
	}
}

BUTTON_EVENT[dvTP,804]		//POOL PATIO LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPatioPool == 0)
			{
				 CALL 'LightsPoolPatio_On';		//POOL PATIO LIGHTS ON
				 CALL 'LightsUnderPool_On';		//POOL LIGHTS UNDERWATER ON
				 vLightsPatioPool = 1;
			}
	 ELSE
			{
				 CALL 'LightsPoolPatio_Off';		//POOL PATIO LIGHTS OFF
				 CALL 'LightsUnderPool_Off';		//POOL LIGHTS UNDERWATER OFF
				 vLightsPatioPool = 0;
			}
	}
}

BUTTON_EVENT[dvTP,808]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvTP,827]		//FORMAL LOUNGE FLOOR LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsLoungeFloor == 0)
			{
				 CALL 'LightsFloorFormalLounge_On'		//FORMAL LOUNGE FLOOR LIGHTS ON
				 vLightsLoungeFloor = 1;
				 ON[dvTP,827]
			}
	 ELSE
			{
				 CALL 'LightsFloorFormalLounge_Off'		//FORMAL LOUNGE FLOOR LIGHTS OFF
				 vLightsLoungeFloor = 0;
				 OFF[dvTP,827]
			}
	}
}

BUTTON_EVENT[dvTP,818]		//OUTSIDE FOUNTAIN LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsFountOutside == 0)
			{
				 CALL 'lightsOutFountain_On';		//OUTSIDE FOUNTAIN LIGHTS ON
				 vLightsFountOutside = 1;
			}
	 ELSE
			{
				 CALL 'lightsOutFountain_Off';		//OUTSIDE FOUNTAIN LIGHTS OFF
				 vLightsFountOutside = 0;
			}
	}
}

BUTTON_EVENT[dvTP,63]	//ON/OFF
{
  PUSH:
  {
			PULSE [dvHDMI_Patio,9]		//Switches Sony TV on/off
			ON [vdvMatrixAudio[11],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,24]	//HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O7'"		//Input 1(HDPVR1) Output 7(PATIO)
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-2'";		//Input 10(HDPVR1) Output 11(PATIO)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
  }
}

BUTTON_EVENT[dvTP,23]	//HDPVR2
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O7'"		//Input 2(HDPVR2) Output 7(PATIO)
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-3'";		//Input 11(HDPVR2) Output 11(PATIO)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
  }
}

BUTTON_EVENT[dvTP,25]	//CCTV
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O7'"		//Input 3(CCTV) Output 7(PATIO)
  }
}

BUTTON_EVENT[dvTP,1]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O7'"		// Input 8(MOVIESERVER) Output 6(KITCHEN)
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-4'";		// Input 5(MOVIESERVER) Output 12(KITCHEN)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
  }
}

BUTTON_EVENT[dvTP,10]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[11],1,178;
  }
}

BUTTON_EVENT[dvTP,2]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
  }
}

//------------------VOLUME CONTROL-----------------//
BUTTON_EVENT[dvTP,34]		//MUTE
{
  PUSH:
  {
		 ON [vdvMatrixAudio[11],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,33]		//VOLUME UP
BUTTON_EVENT[dvTP,35]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 33: ON[vdvMatrixAudio[11],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[11],24]
							 }
			CASE 35: ON[vdvMatrixAudio[11],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[11],25]
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