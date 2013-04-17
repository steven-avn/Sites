PROGRAM_NAME='mainBedroom'
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

BUTTON_EVENT[dvKP_MainBedrm,1]		// BEDROOM 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRMmain == 0)
			{
				 CALL 'LightsMainBedRm_Room_On';		// BEDROOM 1 LIGHTS ON
				 CALL 'LightsMainBedRm_Z3_On';		// BEDROOM 1 LIGHTS ON
				 vLightsBedRMmain = 1;
			}
	 ELSE
			{
				 CALL 'LightsMainBedRm_Room_Off';		// BEDROOM 1 LIGHTS ON
				 CALL 'LightsMainBedRm_Z3_Off';		// BEDROOM 1 LIGHTS ON
				 vLightsBedRMmain = 0;
			}
	}
}

BUTTON_EVENT[dvKP_MainBedrm,2]		// BEDROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRMmainBath == 0)
			{
				 CALL 'LightsMainBedRm_Bath_On';		// BEDROOM LIGHTS ON

				 vLightsBedRMmainBath = 1;
			}
	 ELSE
			{
				 CALL 'LightsMainBedRm_Bath_Off';		// BEDROOM LIGHTS ON
				 vLightsBedRMmainBath = 0;
			}
	}
}

BUTTON_EVENT[dvKP_MainBedrm,3]	// 	CURTAINS OPEN
{
  PUSH:
  {
		CALL 'CurtainOutOpen'
		CALL 'CurtainInOpen'	
  }
}

BUTTON_EVENT[dvKP_MainBedrm,4]	// CURTAINS CLOSE
{
  PUSH:
  {
		CALL 'CurtainOutClose'
		CALL 'CurtainInClose'
  }
}

BUTTON_EVENT[dvKP_MainBedrm,9]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_MainBedrm,5]		//PASSAGE 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassages == 0)
			{
				 CALL 'LightsPassage2Main_On';		//PASSAGE LIGHTS ON
				 vLightsPassages = 1;
			}
	 ELSE
			{
				 CALL 'LightsPassage2Main_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassages = 0;
			}
	}
}


BUTTON_EVENT[dvKP_MainBedrm,8]		//DINING ROOM LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_MainBedrm,7]		//KITCHEN LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_MainBedrm,6]		//PASSAGE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntrance == 0)
			{
				 CALL 'EntranceLightsOn';
				 vLightsEntrance = 1;
			}
	 ELSE
			{
				 CALL 'EntranceLightsOff';
				 vLightsEntrance = 0;
			}
	}
}

BUTTON_EVENT[dvKP_MainBedrm,10]		//PATIO LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_MainBedrm,12]		//VIDEO OFF
{
	 PUSH:
	 {
			CALL 'Projector1_Off'		//PROJECTOR OFF
		  SEND_COMMAND dvKP_MainBedrm,'@BRT-0,0'
			ON [vdvMatrixAudio[4],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_MainBedrm,11]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[4],199];		//MUTE
  }
}

BUTTON_EVENT[dvKP_MainBedrm,14]		//VOLUME UP
BUTTON_EVENT[dvKP_MainBedrm,13]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_MainBedrm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[4],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[4],24]
							 }
			CASE 13: ON[vdvMatrixAudio[4],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[4],25]
							 }
		}
  }
}

//------------------------------REMOTE----------------------------//

BUTTON_EVENT[dvR4_MainBedrm,801]		// BEDROOM 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRMmain == 0)
			{
				 CALL 'LightsMainBedRm_Room_On';		// BEDROOM 1 LIGHTS ON
				 CALL 'LightsMainBedRm_Z3_On';		// BEDROOM 1 LIGHTS ON
				 vLightsBedRMmain = 1;
			}
	 ELSE
			{
				 CALL 'LightsMainBedRm_Room_Off';		// BEDROOM 1 LIGHTS ON
				 CALL 'LightsMainBedRm_Z3_Off';		// BEDROOM 1 LIGHTS ON
				 vLightsBedRMmain = 0;
			}
	}
}

BUTTON_EVENT[dvR4_MainBedrm,8]		// BEDROOM MAIN OUTSIDE CURTAINS OPEN
{
  PUSH:
  {
		 CALL 'CurtainOutOpen';
	}
}

BUTTON_EVENT[dvR4_MainBedrm,9]		// BEDROOM MAIN OUTSIED CURTAINS CLOSE
{
  PUSH:
  {
		 CALL 'CurtainOutClose';
	}
}

BUTTON_EVENT[dvR4_MainBedrm,24]		// BEDROOM MAIN INSIDE CURTAINS OPEN
{
  PUSH:
  {
		 CALL 'CurtainInOpen';
	}
}

BUTTON_EVENT[dvR4_MainBedrm,25]		// BEDROOM MAIN INSIDE CURTAINS CLOSE
{
  PUSH:
  {
		 CALL 'CurtainInClose';
	}
}


BUTTON_EVENT[dvR4_MainBedrm,803]		// BEDROOM LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsBedRMmainBath == 0)
			{
				 CALL 'LightsMainBedRm_Bath_On';		// BEDROOM LIGHTS ON

				 vLightsBedRMmainBath = 1;
			}
	 ELSE
			{
				 CALL 'LightsMainBedRm_Bath_Off';		// BEDROOM LIGHTS ON
				 vLightsBedRMmainBath = 0;
			}
	}
}

BUTTON_EVENT[dvR4_MainBedrm,19]		//HDPVR1
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O1'"		//Input 1(HDPVR1) Output 2(MAIN BEDRM)
			SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-2'";		//Input 2(PVR1) Output 1(MAIN BEDRM)
			SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
			CALL 'Projector1_On'		//PROJECTOR ON  
  }
}

BUTTON_EVENT[dvR4_MainBedrm,20]		//HDPVR2
{
  PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O1'"		//Input 2(HDPVR2) Output 2(MAIN BEDRM)
			SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-3'";		//Input 3(PVR2) Output 1(MAIN BEDRM)
			SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
			CALL 'Projector1_On'		//PROJECTOR ON  
	 }
}

BUTTON_EVENT[dvR4_MainBedrm,5]	// MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI4O1'"		// Input 4(MOVIESERVER) Output 2(main BEDROOM)
			SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-4'";		// Input 5(MOVIESERVER) Output 2(BEDROOM 1)
			SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
			CALL 'Projector1_On'		//PROJECTOR ON  
  }
}

BUTTON_EVENT[dvR4_MainBedrm,4]	// MUSIC SERVER
{
  PUSH:
  {
		  CALL 'XivaMainBedroom';		// MAIN BEDROOM
		  SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[4],1,178;
  }
}

BUTTON_EVENT[dvR4_MainBedrm,6]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[4],1,179;
  }
}

BUTTON_EVENT[dvR4_MainBedrm,15]		//CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O1'"		//Input 3(CCTV) Output 2(MAIN BEDRM)
			CALL 'Projector1_On'		//PROJECTOR ON 			
	 }
}

BUTTON_EVENT[dvR4_MainBedrm,7]		//VIDEO OFF
{
	 PUSH:
	 {
			CALL 'Projector1_Off'		//PROJECTOR OFF
			ON [vdvMatrixAudio[4],199];		//MUTE
		  SEND_COMMAND dvKP_MainBedrm,'@BRT-0,0'
		}
}

BUTTON_EVENT[dvR4_MainBedrm,3]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[4],199];		//MUTE
  }
}

BUTTON_EVENT[dvR4_MainBedrm,1]		//VOLUME UP
BUTTON_EVENT[dvR4_MainBedrm,2]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvR4_MainBedrm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 1: ON[vdvMatrixAudio[4],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[4],24]
							 }
			CASE 2: ON[vdvMatrixAudio[4],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[4],25]
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