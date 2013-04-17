PROGRAM_NAME='MAIN'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: Polytechnic
	MASTER SYSTEM 0 (DVX-2100HD) IP: 192.168.10.100
	GBS HYBRID IP: 192.168.10.250
*) 
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		5001:5:0		//NEC PROJECTOR IR 1(PORT 5)
dvKP							=		0086:1:0		//NOVARA KEYPAD

VIDEO_SWITCHER	 	= 	5002:1:0		//AUDIO/VIDEO SWITCHER
AUDIO_INPUT_1			=		5002:1:0		//AUDIO INPUT 1
AUDIO_INPUT_2			=		5002:2:0		//AUDIO INPUT 2
AUDIO_OUTPUT_LINE	=		5002:2:0		//AUDIO LINE OUTPUT PORT 2
MIC_1							=		5002:7:0   // MIC INPUT 1
MIC_2							=		5002:8:0   // MIC INPUT 2

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

VOLATILE INTEGER KPBUTTONS[]	=	 {1,2,3,4,5,6,7,8}
VOLATILE INTEGER PROJECTOR_POWER = 0
VOLATILE INTEGER LIGHTS_POWER = 0

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

#INCLUDE 'Green Box Systems Wired Initialisation.AXI'
#INCLUDE 'FUNCTIONS'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvKP,KPBUTTONS]
{
  PUSH:
	 {
		TO[dvKP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE  1: IF (PROJECTOR_POWER == 0)		//PC
							 {			
									CALL 'PCInput_On'		//PC INPUT SELECT
							 }
							 ELSE
							 {
									CALL 'System_Off'		//SYSTEM SWITCH OFF SELECT
							 }
			CASE  2: IF (PROJECTOR_POWER == 0)		//LAPTOP
							 {			
									CALL 'LaptopInput_On'		//LAPTOP INPUT SELECT
							 }
							 ELSE
							 {
									CALL 'System_Off'		//SYSTEM SWITCH OFF SELECT
							 }
			CASE  3: IF (PROJECTOR_POWER == 0)		//CAMERA
							 {			
									CALL 'CameraInput_On'		//CAMERA INPUT SELECT
							 }
							 ELSE
							 {
									CALL 'System_Off'		//SYSTEM SWITCH OFF SELECT
							 }
			CASE  4: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
							 {			
									CALL 'AllLights_On'		//ALL LIGHTS SWITCH ON SELECT
							 }
							 ELSE
							 {
									CALL 'AllLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
							 }
			}
	 }
}

BUTTON_EVENT[dvKP,KPBUTTONS]
{
  HOLD[1,REPEAT]:
  {
		PULSE[dvKP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 5:	PULSE[MIC_1,24]		//MIC1 VOLUME UP
							PULSE[MIC_2,24]		//MIC2 VOLUME UP
			CASE 6: PULSE[MIC_1,25]		//MIC2 VOLUME DOWN
							PULSE[MIC_2,25]		//MIC2 VOLUME DOWN
			CASE 7: PULSE[AUDIO_OUTPUT_LINE,24]		//MAIN VOLUME UP
			CASE 8: PULSE[AUDIO_OUTPUT_LINE,25]		//MAIN VOLUME DOWN
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