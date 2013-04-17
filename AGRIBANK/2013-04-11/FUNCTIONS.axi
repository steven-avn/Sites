PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*

*) 
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

kScreenUp = 1;
kScreenDn = 2;

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


DEFINE_CALL 'Projector_On'		//PROJECTOR ON
{
	 PULSE[dvPROJECTOR,9]		 //ON
	 PROJECTOR_POWER = 1
	 CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON
	 PULSE [dvScreen, kScreenDn];
}

DEFINE_CALL 'Projector_Off'		//PROJECTOR OFF
{
	 PULSE[dvPROJECTOR,10]		 //OFF
	 WAIT 20
	 PULSE[dvPROJECTOR,10]		 //OFF
	 PROJECTOR_POWER = 0
 	 CALL 'AllLights_On'		//SWITCH ALL LIGHTS ON
	 PULSE [dvScreen, kScreenUp];
}

DEFINE_CALL 'VGA1Input_On'		//VGA INPUT
{
	 SEND_COMMAND SWITCHER,"'CLALLI1O1,2,3'"		//VGA 1 AUDIO/VIDEO IN1 TO OUT1
	 InputSelected = 1
}

DEFINE_CALL 'HDMI1Input_On'		//HDMI INPUT
{
	 SEND_COMMAND SWITCHER,"'CLALLI3O1,2,3'"		//HDMI 1 VIDEO IN2 TO OUT1
	 InputSelected = 2
}

DEFINE_CALL 'VGA2Input_On'		//VGA INPUT
{
	 SEND_COMMAND SWITCHER,"'CLALLI2O1,2,3'"		//VGA 2 AUDIO/VIDEO IN1 TO OUT1
	 InputSelected = 3
}

DEFINE_CALL 'HDMI2Input_On'		//HDMI INPUT
{
	 SEND_COMMAND SWITCHER,"'CLALLI4O1,2,3'"		//HDMI 2 VIDEO IN2 TO OUT1
	 InputSelected = 4
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