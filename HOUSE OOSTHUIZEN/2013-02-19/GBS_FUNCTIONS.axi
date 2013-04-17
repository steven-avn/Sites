PROGRAM_NAME='GBS_FUNCTIONS'
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

//---------------------------------------------------1ST DIMMER KITCHEN-----------------------------------------------//
DEFINE_CALL 'lightsFormLounge_On'		//FORMAL LOUNGE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";
	 ON [dvTP,805];
}
DEFINE_CALL 'lightsFormLounge_Off'		//FORMAL LOUNGE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";
	 OFF [dvTP,805];
}

DEFINE_CALL 'lightsDiningRm_On'		//DINING ROOM LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";
	 ON [dvTP,807];
}
DEFINE_CALL 'lightsDiningRm_Off'		//DINING ROOM LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";
	 OFF [dvTP,807];
}

DEFINE_CALL 'LightsEntertStar_On'		//ENTERTAINMENT STARLIGHTS LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)";
	 ON [dvTP,803];
}
DEFINE_CALL 'LightsEntertStar_Off'		//ENTERTAINMENT STARLIGHTS LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(0)";
	 OFF [dvTP,803];
}

//---------------------------------------------------1ST KITCHEN RELAY-----------------------------------------------//
DEFINE_CALL 'lightsOutside_On'		//OUTSIDE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";
	 ON [dvTP,808];
}
DEFINE_CALL 'lightsOutside_Off'		//OUTSIDE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)";
	 OFF [dvTP,808];
}

DEFINE_CALL 'lightsWineCellar_On'		//WINE CELLAR LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)";
	 ON [dvTP,809];
}
DEFINE_CALL 'lightsWineCellar_Off'		//WINE CELLAR LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)";
	 OFF [dvTP,809];
}

DEFINE_CALL 'lightsKitchen_On'		//KITCHEN LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(100)";
	 ON [dvTP,810];
}
DEFINE_CALL 'lightsKitchen_Off'		//KITCHEN LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(0)";
	 OFF [dvTP,810];
}

DEFINE_CALL 'lightsPassage_On'		//PASSAGE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(100)";
}
DEFINE_CALL 'lightsPassage_Off'		//PASSAGE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(0)";
}

DEFINE_CALL 'lightsBalcony_On'		//BALCONY AT STUDY LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[5]:',ITOA(100)";
	 ON [dvTP,802];
}
DEFINE_CALL 'lightsBalcony_Off'		//BALCONY AT STUDY LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[5]:',ITOA(0)";
	 OFF [dvTP,802];
}

DEFINE_CALL 'lightsPatio_On'		//PATIO LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[6]:',ITOA(100)";
	 ON [dvTP,812];
}
DEFINE_CALL 'lightsPatio_Off'		//PATIO LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[6]:',ITOA(0)";
	 OFF [dvTP,812];
}

DEFINE_CALL 'lightsEntranceOn'		//ENTRANCE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[7]:',ITOA(100)";
	 ON [dvTP,26];
}
DEFINE_CALL 'lightsEntranceOff'		//ENTRANCE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[7]:',ITOA(0)";
	 OFF [dvTP,26];
}

DEFINE_CALL 'lightsMaidRm_On'		//MAID ROOM LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[8]:',ITOA(100)";
}
DEFINE_CALL 'lightsMaidRm_Off'		//MAID ROOM LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[8]:',ITOA(0)";
}

//---------------------------------------------------2ND RELAY KITCHEN-----------------------------------------------//
DEFINE_CALL 'lightsScullary_On'		//SCULLARY LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";
	 ON [dvTP,815];
}
DEFINE_CALL 'lightsScullary_Off'		//SCULLARY LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";
	 OFF [dvTP,815];
}

DEFINE_CALL 'lightsKitchCorn_On'		//KITCHEN CORNER LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";
	 ON [dvTP,810];
}
DEFINE_CALL 'lightsKitchCorn_Off'		//KITCHEN CORNER LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";
	 OFF [dvTP,810];
}

DEFINE_CALL 'lightsKitchFloor_On'		//KITCHEN FLOOR LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";
	 ON [dvTP,810];
}
DEFINE_CALL 'lightsKitchFloor_Off'		//KITCHEN FLOOR LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";
	 OFF [dvTP,810];
}

DEFINE_CALL 'lightsOutFountain_On'		//OUTSIDE FOUNTAIN LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)";
	 ON [dvTP,818];
}
DEFINE_CALL 'lightsOutFountain_Off'		//OUTSIDE FOUNTAIN LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(0)";
	 OFF [dvTP,818];
}

DEFINE_CALL 'LightsStudy_On'		//STUDY LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(100)";
	 ON [dvTP,801];
}
DEFINE_CALL 'LightsStudy_Off'		//STUDY LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(0)";
	 OFF [dvTP,801];
}

DEFINE_CALL 'LightsEntertFloor_On'		//ENTERTAINMENT FLOOR LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(100)";
	 //ON [dvTP,814];
}
DEFINE_CALL 'LightsEntertFloor_Off'		//ENTERTAINMENT FLOOR LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(0)";
	 //OFF [dvTP,814];
}

DEFINE_CALL 'LightsEntrStrip_On'		//ENTRANCE STRIP LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(100)";
	 //ON [dvTP,814];
}
DEFINE_CALL 'LightsEntrStrip_Off'		//ENTRANCE STRIP LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(0)";
	 //OFF [dvTP,814];
}

//---------------------------------------------------SWIMMING POOL PUMP RELAY1-----------------------------------------------//
DEFINE_CALL 'LightsUnderPool_On'		//POOL LIGHTS UNDERWATER ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[4],"'L:[1]:',ITOA(100)";
}
DEFINE_CALL 'LightsUnderPool_Off'		//POOL LIGHTS UNDERWATER OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[4],"'L:[1]:',ITOA(0)";
}

//---------------------------------------------------1st PLANTROOM DIMMER-----------------------------------------------//
DEFINE_CALL 'LightsMainBedRm_Bath_On'		//MAIN BEDROOM BATHROOM LIGHTS ZONE 1 ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[1]:',ITOA(100)";
	 ON [dvTP,816];
}
DEFINE_CALL 'LightsMainBedRm_Bath_Off'		//MAIN BEDROOM BATHROOM LIGHTS ZONE 1 OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[1]:',ITOA(0)";
	 OFF [dvTP,816];
}

DEFINE_CALL 'LightsMainBedRm_Room_On'		//MAIN BEDROOM LIGHTS ZONE 2 ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[2]:',ITOA(100)";
	 ON [dvTP,817];
}
DEFINE_CALL 'LightsMainBedRm_Room_Off'		//MAIN BEDROOM LIGHTS ZONE 2 OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[2]:',ITOA(0)";
	 OFF [dvTP,817];
}

DEFINE_CALL 'LightsMainBedRm_Z3_On'		//MAIN BEDROOM LIGHTS ZONE 3 ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[3]:',ITOA(100)";
}
DEFINE_CALL 'LightsMainBedRm_Z3_Off'		//MAIN BEDROOM LIGHTS ZONE 3 OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[3]:',ITOA(0)";
}

DEFINE_CALL 'LightsBedRm1Lamp_On'		//BEDROOM 1 LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[4]:',ITOA(100)";
	 ON [dvTP,819];
}
DEFINE_CALL 'LightsBedRm1Lamp_Off'		//BEDROOM 1 LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[5],"'L:[4]:',ITOA(0)";
	 OFF [dvTP,819];
}

//---------------------------------------------------2ND DIMMER PLANTROOM-----------------------------------------------//
DEFINE_CALL 'LightsBedRm2Lamp_On'		//BEDROOM 2 LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[1]:',ITOA(100)";
	 ON [dvTP,820];
}
DEFINE_CALL 'LightsBedRm2Lamp_Off'		//BEDROOM 2 LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[1]:',ITOA(0)";
	 OFF [dvTP,820];
}

DEFINE_CALL 'LightsBedRm1Down_On'		//BEDROOM 1 LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[2]:',ITOA(100)";
	 ON [dvTP,819];
}
DEFINE_CALL 'LightsBedRm1Down_Off'		//BEDROOM 1 LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[2]:',ITOA(0)";
	 OFF [dvTP,819];
}

DEFINE_CALL 'LightsBedRm2Down_On'		//BEDROOM 2 LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[3]:',ITOA(100)";
	 ON [dvTP,820];
}
DEFINE_CALL 'LightsBedRm2Down_Off'		//BEDROOM 2 LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[3]:',ITOA(0)";
	 OFF [dvTP,820];
}

DEFINE_CALL 'LightsFamTvRm_On'		//FAMILY TV ROOM LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[4]:',ITOA(100)";
	 ON [dvTP,821];
}
DEFINE_CALL 'LightsFamTvRm_Off'		//FAMILY TV ROOM LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[6],"'L:[4]:',ITOA(0)";
	 OFF [dvTP,821];
}

//---------------------------------------------------1st PLANTROOM RELAY-----------------------------------------------//
DEFINE_CALL 'LightsMultiPurpRm_On'		//MULTI PURPOSE ROOM LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[1]:',ITOA(100)";
	 ON [dvTP,822];
}
DEFINE_CALL 'LightsMultiPurpRm_Off'		//MULTI PURPOSE ROOM LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[1]:',ITOA(0)";
	 OFF [dvTP,822];
}

DEFINE_CALL 'LightsPassage2Main_On'		//PASSAGE DOWNLIGHTS TO MAIN LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[2]:',ITOA(100)";
	 ON [dvTP,27];
}
DEFINE_CALL 'LightsPassage2Main_Off'		//PASSAGE DOWNLIGHTS TO MAIN LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[2]:',ITOA(0)";
	 OFF [dvTP,27];
}

DEFINE_CALL 'LightsPassage2Tv_On'		//PASSAGE DOWNLIGHTS TO TV ROOM LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[3]:',ITOA(100)";
	 ON [dvTP,28];
}
DEFINE_CALL 'LightsPassage2Tv_Off'		//PASSAGE DOWNLIGHTS TO TV ROOM LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[3]:',ITOA(0)";
	 OFF [dvTP,28];
}

DEFINE_CALL 'LightsFloorFormalLounge_On'		//FLOOR LIGHTS  FORMAL LOUNGE ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[4]:',ITOA(100)";
	 ON [dvTP,827];
}
DEFINE_CALL 'LightsFloorFormalLounge_Off'		//FLOOR LIGHTS  FORMAL LOUNGE OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[4]:',ITOA(0)";
	 OFF [dvTP,827];
}

DEFINE_CALL 'LightsPoolPatio_On'		//POOL AND PATIO LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[5]:',ITOA(100)";
	 ON [dvTP,804];
}
DEFINE_CALL 'LightsPoolPatio_Off'		//POOL AND PATIO LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[5]:',ITOA(0)";
	 OFF [dvTP,804];
}

DEFINE_CALL 'LightsRoofGarden_On'		// JACUZI LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[6]:',ITOA(100)";
		ON[dvTP,824]
}
DEFINE_CALL 'LightsRoofGarden_Off'		// JACUZI LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[6]:',ITOA(0)";
		OFF[dvTP,824]
}

DEFINE_CALL 'PumpFountainInside_On'		//FOUNTAIN PUMP INSIDE ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[7]:',ITOA(100)";
		ON[dvTP,823]
}
DEFINE_CALL 'PumpFountainInside_Off'		//FOUNTAIN PUMP INSIDE OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[7]:',ITOA(0)";
		OFF[dvTP,823]
}

DEFINE_CALL 'PumpFountainOutside_On'		//FOUNTAIN PUMP OUTSIDE ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[8]:',ITOA(100)";
		ON[dvTP,826]
}
DEFINE_CALL 'PumpFountainOutside_Off'		//FOUNTAIN PUMP OUTSIDE OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[7],"'L:[8]:',ITOA(0)";
		ON[dvTP,826]
}

//---------------------------------------------------2ND PLANTROOM RELAY-----------------------------------------------//
DEFINE_CALL 'UnderFloorHeating_On'		// ALL UNDER-FLOOR HEATING ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[1]:',ITOA(100)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[2]:',ITOA(100)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[3]:',ITOA(100)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[4]:',ITOA(100)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[5]:',ITOA(100)";
		ON[dvTP,829]
}

DEFINE_CALL 'UnderFloorHeating_Off'		// ALL UNDER-FLOOR HEATING OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[1]:',ITOA(0)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[2]:',ITOA(0)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[3]:',ITOA(0)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[4]:',ITOA(0)";
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[5]:',ITOA(0)";
		OFF[dvTP,829]
}

DEFINE_CALL 'lightsFlatLounge_On'		//FLAT LOUNGE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[8]:',ITOA(100)";
}
DEFINE_CALL 'lightsFlatLounge_Off'		//FLAT LOUNGE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[8]:',ITOA(0)";
}

DEFINE_CALL 'lightsFlatBedRm1_On'		//FLAT BEDROOM 1 LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[6]:',ITOA(100)";
}
DEFINE_CALL 'lightsFlatBedRm1_Off'		//FLAT BEDROOM 1 LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[6]:',ITOA(0)";
}

DEFINE_CALL 'lightsFlatBedRm2_On'		//FLAT BEDROOM 2 LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[7]:',ITOA(100)";
}
DEFINE_CALL 'lightsFlatBedRm2_Off'		//FLAT BEDROOM 2 LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[8],"'L:[7]:',ITOA(0)";
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)