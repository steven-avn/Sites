PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/11/2012  AT: 12:02:50        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: MINISTRY OF GENDER WINDHOEK 5TH & 6TH FLOOR

	MASTER (NI-2100) IP: 192.168.1.101
	TP1 (NXD-700i) IP: 192.168.1.102
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

volatile integer mainLights = 0;
volatile integer mainLightsPresentation = 0;

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

DEFINE_CALL 'Projector1_On'		//PROJECTOR ON
{
	 PULSE [dvSCREENS,SCREEN1_DOWN]
	 SEND_STRING dvPROJ1, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
}

DEFINE_CALL 'Projector1_Off'		//PROJECTOR OFF
{
	 PULSE [dvSCREENS,SCREEN1_UP]
	 SEND_STRING dvPROJ1, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
	 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
}

DEFINE_CALL 'Main1_VolUp'		//MAIN VOLUME UP
{
	 if (VOL_LEVEL1 == 100)
	 {
	 }
	 else
	 {
			SEND_STRING dvCLOUD1,'<MU,LU1/>'		//MAIN VOLUME UP
			VOL_LEVEL1 = VOL_LEVEL1 + 1
			send_level dvTP1,1,VOL_LEVEL1
	 }
}

DEFINE_CALL 'Main1_VolDown'		//MAIN VOLUME DOWN
{
	 if (VOL_LEVEL1 == 0)
	 {
	 }
	 else
	 {
			SEND_STRING dvCLOUD1,'<MU,LD1/>'		//MAIN VOLUME DOWN
			VOL_LEVEL1 = VOL_LEVEL1 - 1
			send_level dvTP1,1,VOL_LEVEL1
	 }
}

DEFINE_CALL 'Main1_MicUp'		//MAIN MIC UP
{
	 SEND_STRING dvCLOUD1,'<MI,LU1/>'		//MAIN MIC UP
	 if (MIC_LEVEL1 == 100)
	 {
	 }
	 else
	 {
			MIC_LEVEL1 = MIC_LEVEL1 + 1
			send_level dvTP1,2,MIC_LEVEL1
	 }
}

DEFINE_CALL 'Main1_MicDown'		//MAIN MIC DOWN
{
	 SEND_STRING dvCLOUD1,'<MI,LD1/>'		//MAIN MIC DOWN
	 if (MIC_LEVEL1 == 0)
	 {
	 }
	 else
	 {
			MIC_LEVEL1 = MIC_LEVEL1 - 1
			send_level dvTP1,2,MIC_LEVEL1
	 }
}

define_call 'mainLightsOn/Off'	//switches main lights on/off depending on the state of the variable
{
	 if(mainLights == 0)
	 {
			call 'mainLights100%'
	 }
	 else
	 {
			call 'mainLights0%'
	 }
}

define_call 'mainLights5%'	//Dims Main Lights 5%
{
	 send_string dvLUTRON, "'#DEVICE,4,401,7,6',$0D,$0A"	//LOOP 1 SCENE 6 5%
	 send_string dvLUTRON, "'#DEVICE,4,402,7,1',$0D,$0A"	//LOOP 2 SCENE 1 0%
	 pulse [dvCAB_LIGHTS,CAB_LIGHTS_OFF];
	 LIGHT_LEVEL1 = 5
	 send_level dvTP1,3,LIGHT_LEVEL1
	 mainLightsPresentation = 1;
	 mainLights = 0;
}

define_call 'mainLights25%'	//Dims Main Lights 5%
{
	 send_string dvLUTRON, "'#DEVICE,4,401,7,2',$0D,$0A"	//LOOP 1 SCENE 2 25%
	 send_string dvLUTRON, "'#DEVICE,4,402,7,1',$0D,$0A"	//LOOP 2 SCENE 1 0%
	 pulse [dvCAB_LIGHTS,CAB_LIGHTS_OFF];
	 LIGHT_LEVEL1 = 25
	 send_level dvTP1,3,LIGHT_LEVEL1
	 mainLightsPresentation = 1;
	 mainLights = 0;
}

define_call 'mainLights100%'	//Dims Main Lights 100%
{
	 send_string dvLUTRON, "'#DEVICE,4,401,7,5',$0D,$0A"	//SCENE 5 100%
	 send_string dvLUTRON, "'#DEVICE,4,402,7,5',$0D,$0A"	//LOOP 2 SCENE 5 100%
	 pulse [dvCAB_LIGHTS,CAB_LIGHTS_ON];
	 LIGHT_LEVEL1 = 100
	 send_level dvTP1,3,LIGHT_LEVEL1
	 mainLights = 1;
	 mainLightsPresentation = 0;
}

define_call 'mainLights0%'	//Dims Main Lights 0%
{
	 send_string dvLUTRON, "'#DEVICE,4,401,7,1',$0D,$0A"	//SCENE 1 0%
	 send_string dvLUTRON, "'#DEVICE,4,402,7,1',$0D,$0A"	//LOOP 2 SCENE 1 0%
	 pulse [dvCAB_LIGHTS,CAB_LIGHTS_OFF];
	 LIGHT_LEVEL1 = 0
	 send_level dvTP1,3,LIGHT_LEVEL1
	 mainLights = 0;
	 mainLightsPresentation = 0;
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