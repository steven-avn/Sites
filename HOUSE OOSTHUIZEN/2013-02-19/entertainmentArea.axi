PROGRAM_NAME='entertainmentArea'
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
/*
 * ALL STANDBY --> 0C
 * DTV (TV ON) -->
 * DVD -->
 * CINEMA ON / CINEMA OFF / FORMAT O --> 2A WAIT 5 $00
 * VOLUME UP, VOLUME DOWN, MUTE
 * FUNCTION SPEAKER 3/5 --> 5.1 / 2.1 
*/
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

VOLATILE INTEGER CINEMACURTAINS = 0;

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

DEFINE_START

(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//------------------------KEYPAD SCROLLWHEEL--------------------------//
BUTTON_EVENT[dvKP_EntertArea1,2]		//ENTERTAINMENT LIGHTS FLOOR ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntertRm == 0)
			{
				 CALL 'LightsEntertFloor_On';		//ENTERTAINMENT LIGHTS ON
				 vLightsEntertRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsEntertFloor_Off';		//ENTERTAINMENT LIGHTS OFF
				 vLightsEntertRm = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntertArea1,1]		//ENTERTAINMENT LIGHTS STARLIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntertRmStar == 0)
			{
				 CALL 'LightsEntertStar_On';		//ENTERTAINMENT STAR LIGHTS ON
				 vLightsEntertRmStar = 1;
			}
	 ELSE
			{
				 CALL 'LightsEntertStar_Off';		//ENTERTAINMENT STAR LIGHTS OFF
				 vLightsEntertRmStar = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntertArea1,3]	// TV HDPVR1
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O2'"		//Input 1(HDPVR1) Output
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on			
	 }
}

BUTTON_EVENT[dvKP_EntertArea1,4]	// TV HDPVR2
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O2'"		//Input 2(HDPVR2) Output 
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on
  	}
}

BUTTON_EVENT[dvKP_EntertArea1,5]	// TV CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O2'"		//Input 3(CCTV) Output 
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on
		}
}

BUTTON_EVENT[dvKP_EntertArea1,6]	// TV MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O2'"		// Input 8(MOVIESERVER) Output
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on			
  }
}

BUTTON_EVENT[dvKP_EntertArea1,11]	// ALL STANDBY
{
	 PUSH:
	 {
			PULSE [dvHDMI_Cinema,9]		// Switches B&O TV OFF
	 }
}

BUTTON_EVENT[dvKP_EntertArea1,12]		// VOLUME UP
BUTTON_EVENT[dvKP_EntertArea1,13]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_EntertArea1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 12: PULSE [dvHDMI_Cinema,30]		// VOL UP
			CASE 13: PULSE [dvHDMI_Cinema,31]		// VOL DN
		}
  }
}

//------------------------KEYPAD--------------------------//
BUTTON_EVENT[dvKP_EntertArea,2]		//ENTERTAINMENT LIGHTS FLOOR ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntertRm == 0)
			{
				 CALL 'LightsEntertFloor_On';		//ENTERTAINMENT LIGHTS ON
				 vLightsEntertRm = 1;
			}
	 ELSE
			{
				 CALL 'LightsEntertFloor_Off';		//ENTERTAINMENT LIGHTS OFF
				 vLightsEntertRm = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntertArea,1]		//ENTERTAINMENT LIGHTS STARLIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntertRmStar == 0)
			{
				 CALL 'LightsEntertStar_On';		//ENTERTAINMENT STAR LIGHTS ON
				 vLightsEntertRmStar = 1;
			}
	 ELSE
			{
				 CALL 'LightsEntertStar_Off';		//ENTERTAINMENT STAR LIGHTS OFF
				 vLightsEntertRmStar = 0;
			}
	}
}

BUTTON_EVENT[dvKP_EntertArea,5]	// TV HDPVR1
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O2'"		//Input 1(HDPVR1) Output
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on			
	 }
}

BUTTON_EVENT[dvKP_EntertArea,6]	// TV HDPVR2
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O2'"		//Input 2(HDPVR2) Output 
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on
  	}
}

BUTTON_EVENT[dvKP_EntertArea,10]	// TV CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O2'"		//Input 3(CCTV) Output 
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on
		}
}

BUTTON_EVENT[dvKP_EntertArea,9]	// TV MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O2'"		// Input 8(MOVIESERVER) Output
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on			
  }
}

BUTTON_EVENT[dvKP_EntertArea,12]	// ALL STANDBY
{
	 PUSH:
	 {
			PULSE [dvHDMI_Cinema,9]		// Switches B&O TV OFF
	 }
}

BUTTON_EVENT[dvKP_EntertArea,14]		// VOLUME UP
BUTTON_EVENT[dvKP_EntertArea,13]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvKP_EntertArea,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 14: PULSE [dvHDMI_Cinema,30]		// VOL UP
			CASE 13: PULSE [dvHDMI_Cinema,31]		// VOL DN
		}
  }
}

//--------------------------TOUCH PANEL----------------------------//
BUTTON_EVENT[dvTP,803]		//ENTERTAINMENT LIGHTS STARLIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsEntertRmStar == 0)
			{
				 CALL 'LightsEntertStar_On';		//ENTERTAINMENT STAR LIGHTS ON
				 vLightsEntertRmStar = 1;
			}
	 ELSE
			{
				 CALL 'LightsEntertStar_Off';		//ENTERTAINMENT STAR LIGHTS OFF
				 vLightsEntertRmStar = 0;
			}
	}
}

BUTTON_EVENT[dvTP_CINEMA,40]	// ALL STANDBY
{
	 PUSH:
	 {
			PULSE [dvHDMI_Cinema,9]		// Switches B&O TV OFF
	 }
}

BUTTON_EVENT[dvTP_CINEMA,32]	// DVD
{
	 PUSH:
	 {
			PULSE [dvHDMI_Cinema,3]		// Switches B&O DVD
	 }
}

//-----------------------TV---------------------------------//

BUTTON_EVENT[dvTP_CINEMA,28]	// TV HDPVR1
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI1O2'"		//Input 1(HDPVR1) Output
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on			
	 }
}

BUTTON_EVENT[dvTP_CINEMA,29]	// TV HDPVR2
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI2O2'"		//Input 2(HDPVR2) Output 
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on
  	}
}

BUTTON_EVENT[dvTP_CINEMA,30]	// TV CCTV
{
	 PUSH:
	 {
			SEND_COMMAND dvUTPRO_HDMI,"'CI3O2'"		//Input 3(CCTV) Output 
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on
		}
}

BUTTON_EVENT[dvTP_CINEMA,31]	// TV MOVIESERVER
{
  PUSH:
  {
			SEND_COMMAND dvUTPRO_HDMI,"'CI8O2'"		// Input 8(MOVIESERVER) Output
		  PULSE [dvHDMI_Cinema,1]		// Switches B&O TV on			
  }
}


//-----------------------CINEMA---------------------------------//

BUTTON_EVENT[dvTP_CINEMA,50]	// SHOWTIME
{
  PUSH:
  {
			PULSE [dvHDMI_Cinema,2]		// FORMAT
  }
}

BUTTON_EVENT[dvTP_CINEMA,51]	// SHOWTIME
{
  PUSH:
  {
			PULSE [dvHDMI_Cinema,10]		// 0
  }
}


//------------------------------------------------------------//

BUTTON_EVENT[dvTP_CINEMA,41]		// VOLUME UP
BUTTON_EVENT[dvTP_CINEMA,42]		// VOLUME DOWN
{
  HOLD[1,REPEAT]:
  {
	PULSE[dvTP_CINEMA,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 41: PULSE [dvHDMI_Cinema,30]		// VOL UP
			CASE 42: PULSE [dvHDMI_Cinema,31]		// VOL DN
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