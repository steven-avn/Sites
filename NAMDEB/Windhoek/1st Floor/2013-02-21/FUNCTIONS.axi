PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/17/2012  AT: 10:22:29        *)
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

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER PROJECTOR_POWER = 0		//0=OFF, 1=ON

VOLATILE INTEGER InputPopup1 = 0
VOLATILE INTEGER InputPopup2 = 0
VOLATILE INTEGER InputPopup3 = 0
VOLATILE INTEGER InputPopup4 = 0
VOLATILE INTEGER InputPopup5 = 0
VOLATILE INTEGER InputPopup6 = 0
VOLATILE INTEGER InputDSTV = 0
VOLATILE INTEGER InputPOLY = 0
VOLATILE INTEGER InputPopup1HDMI = 0
VOLATILE INTEGER InputPopup2HDMI = 0

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

define_call 'Projector_On'		//Projector On
{
	 if(PROJECTOR_POWER == 0)
	 {
			pulse [dvPROJECTOR,9]
			PROJECTOR_POWER = 1
	 }
}

define_call 'Projector_Off'		//Projector Off
{
	 if(PROJECTOR_POWER == 1)
	 {
			pulse [dvPROJECTOR,9]
			wait 10
			pulse [dvPROJECTOR,9]
			PROJECTOR_POWER = 0
	 }
}

DEFINE_CALL 'VCInput'		// VIDEO CONFERENCE INPUT SELECT
{
	 SEND_COMMAND SWITCHER,"'VI9O1'"		// VC AUDIO/VIDEO IN5 (DX) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI9O1'"		// VC AUDIO/VIDEO IN5 TO OUT ALL
}

DEFINE_CALL 'PopupInput1HDMI'		// POPUP INPUT 1 SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI5O1'"		// PTN VIDEO IN3(HDMI) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI5O1'"		// POPUP 3 AUDIO IN1 TO OUT ALL
}

DEFINE_CALL 'PopupInput2HDMI'		// POPUP INPUT 2 SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI6O1'"		// PTN VIDEO IN4(HDMI) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI6O1'"		// POPUP 4 AUDIO IN1 TO OUT ALL
}

DEFINE_CALL 'PopupInput1'		// POPUP INPUT 1 SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI1O1'"		// PTN VIDEO IN1(DVI) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI1O1'"		// POPUP 1 AUDIO IN1 TO OUT ALL
}

DEFINE_CALL 'PopupInput2'		// POPUP INPUT 2 SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI2O1'"		// PTN VIDEO IN1(DVI) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI2O1'"		// POPUP 1 AUDIO IN1 TO OUT ALL
}

DEFINE_CALL 'PopupInput3'		// POPUP INPUT 3 SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI3O1'"		// PTN VIDEO IN1(DVI) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI3O1'"		// POPUP 1 AUDIO IN1 TO OUT ALL
}

DEFINE_CALL 'PopupInput4'		// POPUP INPUT 4 SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI4O1'"		// PTN VIDEO IN1(DVI) TO OUT 3
	 SEND_COMMAND SWITCHER,"'AI4O1'"		// POPUP 1 AUDIO IN1 TO OUT ALL
}

DEFINE_CALL 'LightsAllOn'		// ALL LIGHTS ON
{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";
}

DEFINE_CALL 'LightsAllOff'		// ALL LIGHTS OFF
{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)";
}

DEFINE_CALL 'LightsPresentation'		// PRESENTATION MODE
{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(75)";
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)";
}

DEFINE_CALL 'ScreenDown'		// PROJECTOR SCREEN DOWN
{
		ON[dvScreen,1]
		WAIT 150
		OFF[dvScreen,1]
}

DEFINE_CALL 'ScreenUp'		// PROJECTOR SCREEN UP
{
		ON[dvScreen,2]
		WAIT 150
		OFF[dvScreen,2]
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