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

vdvBoseESP88 = 41101:1:0  // The COMM module should use this as its duet device

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
VOLATILE INTEGER LIGHTS_POWER = 0		//0=OFF, 1=ON, 2=PRESENTATION
VOLATILE INTEGER InputSelected = 0		//0=NONE, 1=PC, 2=LAPTOP, 3=WALLPLATE 4=Podium
volatile integer ProjLiftUp = 1;
volatile integer ProjLiftDown = 2;
VOLATILE INTEGER PRESENTATION_MODE = 0
VOLATILE INTEGER PRESENTER_MODE = 0

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
	 SEND_COMMAND dvPROJECTOR,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJECTOR, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 WAIT 50
	 SEND_STRING dvPROJECTOR, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 PROJECTOR_POWER = 1
}

DEFINE_CALL 'Projector_Off'		//PROJECTOR OFF
{
	 SEND_COMMAND SWITCHER,"'AI8O1,2,3'"		// AUDIO IN8 (UNUSED) TO OUT ALL

	 SEND_COMMAND dvPROJECTOR,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJECTOR, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
	 PROJECTOR_POWER = 0
}

DEFINE_CALL 'PowerOff'		// SWITCHES SYSTEM POWER OFF
{
		CALL 'Projector_Off'
}

DEFINE_CALL 'VCInput'		// VIDEO CONFERENCE INPUT SELECT
{
	 SEND_COMMAND SWITCHER,"'VI5O2,3'"		//PODIUM AUDIO/VIDEO IN5 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI5O1'"		//PODIUM AUDIO/VIDEO IN5 TO OUT ALL

	 CALL 'Projector_On'

//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'VIDIN_EDID_AUTO-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'VIDIN_HDCP-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvTX_Podium,"'VIDIN_AUTO_SELECT-ENABLE'"
//	 SEND_COMMAND dvTX_Podium,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_ASPECT_RATIO-STRETCH'"
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_RES_REF-1920x1080p,60'"
//
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_NAME'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_STATUS'"
//	 SEND_COMMAND SWITCHER,"'?VIDOUT_ON'"
//	 SEND_COMMAND SWITCHER,"'?INPUT-VIDEO,1'"
//	 SEND_COMMAND SWITCHER,"'?OUTPUT-AUDIO,1'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_EDID_AUTO'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_PREF_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_FORMAT'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_RES_REF'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'?VIDIN_HDCP'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_ASPECT_RATIO'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES_REF'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_SCALE'"
}

DEFINE_CALL 'PopupInput'		// POPUP INPUT SELECTED
{
	 SEND_COMMAND SWITCHER,"'VI6O2,3'"		//WALLPLATE VIDEO IN6 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI6O1'"		//WALLPLATE VIDEO IN6 TO OUT ALL

	 CALL 'Projector_On'

//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'VIDIN_EDID_AUTO-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'VIDIN_HDCP-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvTX_Wall,"'VIDIN_AUTO_SELECT-ENABLE'"
//	 SEND_COMMAND dvTX_Wall,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_ASPECT_RATIO-STRETCH'"
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_RES_REF-1920x1080p,60'"
//
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_NAME'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_STATUS'"
//	 SEND_COMMAND SWITCHER,"'?VIDOUT_ON'"
//	 SEND_COMMAND SWITCHER,"'?INPUT-VIDEO,1'"
//	 SEND_COMMAND SWITCHER,"'?OUTPUT-AUDIO,1'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_EDID_AUTO'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_PREF_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_FORMAT'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_RES_REF'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL6,"'?VIDIN_HDCP'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_ASPECT_RATIO'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES_REF'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_SCALE'"
}

DEFINE_CALL 'PCInput'		//PC INPUT
{
	 SEND_COMMAND SWITCHER,"'VI1O2,3'"		//PC VIDEO IN1 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI1O1'"		//PC VIDEO IN1 TO OUT ALL

	 CALL 'Projector_On'

//   SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'VIDIN_EDID_AUTO-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'VIDIN_HDCP-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL5,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvTX_Podium,"'VIDIN_AUTO_SELECT-ENABLE'"
//	 SEND_COMMAND dvTX_Podium,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_ASPECT_RATIO-STRETCH'"
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_RES_REF-1920x1080p,60'"
//
//	 SEND_COMMAND SWITCHER,"'?VIDIN_NAME'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_STATUS'"
//	 SEND_COMMAND SWITCHER,"'?VIDOUT_ON'"
//	 SEND_COMMAND SWITCHER,"'?INPUT-VIDEO,1'"
//	 SEND_COMMAND SWITCHER,"'?OUTPUT-AUDIO,1'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_EDID'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_EDID_AUTO'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_PREF_EDID'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_FORMAT'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_RES_REF'"
//	 SEND_COMMAND SWITCHER,"'?VIDIN_HDCP'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_ASPECT_RATIO'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES_REF'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_SCALE'"
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