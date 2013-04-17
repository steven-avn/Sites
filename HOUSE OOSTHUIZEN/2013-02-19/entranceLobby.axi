PROGRAM_NAME='entranceLobby'
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
BUTTON_EVENT[dvKP_EntrLobby1,1]		//PASSAGE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,2]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,3]		//PASSAGE 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassage1 == 0)
			{
				 CALL 'LightsPassage2Main_On';		//PASSAGE LIGHTS ON
				 vLightsPassage1 = 1;
			}
	 ELSE
			{
				 CALL 'LightsPassage2Main_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassage1 = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntrLobby1,4]		//PASSAGE 2 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassage2 == 0)
			{
				 CALL 'LightsPassage2Tv_On';		//PASSAGE LIGHTS ON
				 vLightsPassage2 = 1;
			}
	 ELSE
			{
				 CALL 'LightsPassage2Tv_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassage2 = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntrLobby1,5]		//DINING ROOM LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,6]		//KITCHEN LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,7]		//FAMILY TV ROOM LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,8]		//FORMAL LOUNGE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,9]		//PATIO LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,10]		//POOL PATIO LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby1,11]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[5],199];		//MUTE
 }
}

BUTTON_EVENT[dvKP_EntrLobby1,14]		//VOLUME UP
BUTTON_EVENT[dvKP_EntrLobby1,13]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_EntrLobby1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[5],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[5],24]
							 }
			CASE 13: ON[vdvMatrixAudio[5],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[5],25]
							 }
		}
  }
}


BUTTON_EVENT[dvKP_EntrLobby2,1]		//PASSAGE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,2]		//OUTSIDE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,3]		//PASSAGE 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassage1 == 0)
			{
				 CALL 'LightsPassage2Main_On';		//PASSAGE LIGHTS ON
				 vLightsPassage1 = 1;
			}
	 ELSE
			{
				 CALL 'LightsPassage2Main_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassage1 = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntrLobby2,4]		//PASSAGE 2 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassage2 == 0)
			{
				 CALL 'LightsPassage2Tv_On';		//PASSAGE LIGHTS ON
				 vLightsPassage2 = 1;
			}
	 ELSE
			{
				 CALL 'LightsPassage2Tv_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassage2 = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntrLobby2,5]		//DINING ROOM LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,6]		//KITCHEN LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,7]		//FAMILY TV ROOM LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,8]		//FORMAL LOUNGE LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,9]		//PATIO LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,10]		//POOL PATIO LIGHTS ON/OFF
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

BUTTON_EVENT[dvKP_EntrLobby2,11]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[5],199];		//MUTE
  }
}


BUTTON_EVENT[dvKP_EntrLobby2,14]		//VOLUME UP
BUTTON_EVENT[dvKP_EntrLobby2,13]		//VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_EntrLobby1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: ON[vdvMatrixAudio[5],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[5],24]
							 }
			CASE 13: ON[vdvMatrixAudio[5],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[5],25]
							 }
		}
  }
}

//-------------------------TOUCH PANEL-----------------------//
BUTTON_EVENT[dvTP,26]		//PASSAGE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntrance == 0)
			{
				 CALL 'EntranceLightsOn';
				 vLightsEntrance = 1;
				 ON[dvTP,26]
			}
	 ELSE
			{
				 CALL 'EntranceLightsOff';
				 vLightsEntrance = 0;
				 OFF[dvTP,26]	
			}
	}
}


BUTTON_EVENT[dvTP,27]		//PASSAGE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassage1 == 0)
			{
				 CALL 'LightsPassage2Main_On';		//PASSAGE LIGHTS ON
				 vLightsPassage1 = 1;
				 ON[dvTP,27]
			}
	 ELSE
			{
				 CALL 'LightsPassage2Main_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassage1 = 0;
				 OFF[dvTP,27]
			}
	}
}

BUTTON_EVENT[dvTP,28]		//PASSAGE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsPassage2 == 0)
			{
				 CALL 'LightsPassage2Tv_On';		//PASSAGE LIGHTS ON
				 vLightsPassage2 = 1;
				 ON[dvTP,28]
			}
	 ELSE
			{
				 CALL 'LightsPassage2Tv_Off';		//PASSAGE LIGHTS OFF
				 vLightsPassage2 = 0;
				 OFF[dvTP,28]
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