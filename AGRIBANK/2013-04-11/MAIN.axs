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
	CLIENT: Agri Bank 9th Floor
	MASTER SYSTEM 0 (DVX-2155HD) IP: 192.168.1.100
	GBS HYBRID IP: 192.168.1.111
*) 
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		5001:1:0		//SONY PROJECTOR RS232 PORT 1
dvKP							=		0085:1:0		//NOVARA KEYPAD
dvScreen					=		5001:4:0		//SCREEN ON RELAY PORT

SWITCHER				 	= 	5002:1:0		//AUDIO/VIDEO SWITCHER
AUDIO_INPUT_1			=		5002:1:0		//AUDIO INPUT 1
AUDIO_INPUT_2			=		5002:2:0		//AUDIO INPUT 2
AUDIO_OUTPUT_LINE	=		5002:2:1		//AUDIO LINE OUTPUT PORT 2
AUDIO_OUTPUT			=		5002:1:1		//AUDIO OUTPUT PORT 1
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
VOLATILE INTEGER InputSelected = 0		//0=NONE, 1=VGA1, 2=HDMI1, 3=VGA2, 4=HDMI2

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
				 CASE  1: IF (LIGHTS_POWER == 0 || LIGHTS_POWER == 3)		//LIGHTS ON/OFF
									{			
										 CALL 'AllLights_On'		//ALL LIGHTS SWITCH ON SELECT
									}
									ELSE
									{
										 CALL 'AllLights_Off'		//ALL LIGHTS SWITCH OFF SELECT
									}
				 CASE  2: IF (PROJECTOR_POWER == 0)		//PROJECTOR ON/OFF
									{			
										 CALL 'Projector_On'		//PROJECTOR ON
									}
									ELSE
									{
										 CALL 'Projector_Off'		//PROJECTOR OFF
									}
				 CASE  3: CALL 'VGA1Input_On'		//VGA 1 INPUT SELECT
				 CASE  4: CALL 'HDMI1Input_On'		//HDMI 1 INPUT SELECT
				 CASE  5: CALL 'VGA2Input_On'		//VGA 2 INPUT SELECT
				 CASE  6: CALL 'HDMI2Input_On'		//HDMI 2 INPUT SELECT
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
				 CASE 7: ON[AUDIO_OUTPUT,140]		//MAIN VOLUME UP
								 WAIT 10
								 OFF[AUDIO_OUTPUT,140]
				 CASE 8: ON[AUDIO_OUTPUT,141]		//MAIN VOLUME DOWN
								 WAIT 10
								 OFF[AUDIO_OUTPUT,141]
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