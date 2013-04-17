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
	GBS HYBRID IP: 192.168.10.111
*) 
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvPROJECTOR				=		5001:5:0		//NEC PROJECTOR IR 1(PORT 5)
dvKP							=		0086:1:0		//NOVARA KEYPAD

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
VOLATILE INTEGER InputSelected = 0		//0=NONE, 1=PC, 2=LAPTOP

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
				 CASE  3: CALL 'PCInput_On'		//PC INPUT SELECT
				 CASE  4: CALL 'LaptopInput_On'		//LAPTOP INPUT SELECT
			}
	 }
}

BUTTON_EVENT[dvKP,KPBUTTONS]
{
  HOLD[1,REPEAT]:
	 {
		TO[dvKP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 5:	ON[MIC_1,140]		//MIC1 VOLUME UP
								 WAIT 10
								 OFF[MIC_1,140]
				 CASE 6: ON[MIC_1,141]		//MIC2 VOLUME DOWN
								 WAIT 10
								 OFF[MIC_1,141]
				 CASE 7: IF (InputSelected == 1)
									{
										 ON[AUDIO_OUTPUT,140]		//MAIN VOLUME 1 UP
										 WAIT 10
										 OFF[AUDIO_OUTPUT,140]
									}
									ELSE
									{
										 ON[AUDIO_OUTPUT_LINE,140]		//MAIN VOLUME 2 UP
										 WAIT 10
										 OFF[AUDIO_OUTPUT_LINE,140]
									}
				 CASE 8: IF (InputSelected == 1)
									{
										 ON[AUDIO_OUTPUT,141]		//MAIN VOLUME 1 DOWN
										 WAIT 10
										 OFF[AUDIO_OUTPUT,141]
									}
									ELSE
									{
										 ON[AUDIO_OUTPUT_LINE,141]		//MAIN VOLUME 2 DOWN
										 WAIT 10
										 OFF[AUDIO_OUTPUT_LINE,141]
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