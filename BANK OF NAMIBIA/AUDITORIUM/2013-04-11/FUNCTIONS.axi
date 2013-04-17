PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/15/2012  AT: 15:34:24        *)
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
	 CALL 'LiftDown'
}

DEFINE_CALL 'Projector_Off'		//PROJECTOR OFF
{
	 SEND_COMMAND SWITCHER,"'AI8O1,2,3'"		// AUDIO IN8 (UNUSED) TO OUT ALL

	 CALL 'FirstLights_Off'

	 SEND_COMMAND dvPROJECTOR,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJECTOR, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
	 PROJECTOR_POWER = 0
	 WAIT 600
	 CALL 'LiftUp'

}

DEFINE_CALL 'LiftDown'		//PROJECTOR LIFT DOWN
{
	 PULSE [dvPROJ_LIFT,ProjLiftDown];
}

DEFINE_CALL 'LiftUp'		//PROJECTOR LIFT UP
{
	 PULSE [dvPROJ_LIFT,ProjLiftUp];
	 wait 600
	 CALL 'FinalLights_Off'
}

DEFINE_CALL 'PodiumInput'		//PODIUM INPUT
{
	 SEND_COMMAND SWITCHER,"'VI5O2,3'"		//PODIUM AUDIO/VIDEO IN5 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI5O1'"		//PODIUM AUDIO/VIDEO IN5 TO OUT ALL

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

DEFINE_CALL 'WallPlateInput'		//WALLPLATE INPUT
{
	 SEND_COMMAND SWITCHER,"'VI6O2,3'"		//WALLPLATE VIDEO IN6 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI6O1'"		//WALLPLATE VIDEO IN6 TO OUT ALL

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

DEFINE_CALL 'VCInput'		//VC INPUT
{
	 SEND_COMMAND SWITCHER,"'VI2O2,3'"		//VC VIDEO IN2 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI2O1'"		//VC VIDEO IN2 TO OUT ALL

//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'VIDIN_EDID_AUTO-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'VIDIN_HDCP-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_ASPECT_RATIO-STRETCH'"
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_RES_REF-1920x1080p,60'"
//
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_NAME'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_STATUS'"
//	 SEND_COMMAND SWITCHER,"'?VIDOUT_ON'"
//	 SEND_COMMAND SWITCHER,"'?INPUT-VIDEO,1'"
//	 SEND_COMMAND SWITCHER,"'?OUTPUT-AUDIO,1'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_EDID_AUTO'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_PREF_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_FORMAT'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_RES_REF'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL4,"'?VIDIN_HDCP'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_ASPECT_RATIO'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES_REF'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_SCALE'"
}

DEFINE_CALL 'DSTVInput'		//DSTV INPUT
{
	 SEND_COMMAND SWITCHER,"'VI3O2,3'"		//DSTV VIDEO IN3 TO OUT ALL
	 SEND_COMMAND SWITCHER,"'AI3O1'"		//DSTV VIDEO IN3 TO OUT ALL

//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'VIDIN_EDID_AUTO-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'VIDIN_HDCP-ENABLE'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'VIDIN_RES_AUTO-ENABLE'"
//
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_ASPECT_RATIO-STRETCH'"
//	 SEND_COMMAND dvRX_Projector,"'VIDOUT_RES_REF-1920x1080p,60'"
//
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_NAME'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_STATUS'"
//	 SEND_COMMAND SWITCHER,"'?VIDOUT_ON'"
//	 SEND_COMMAND SWITCHER,"'?INPUT-VIDEO,1'"
//	 SEND_COMMAND SWITCHER,"'?OUTPUT-AUDIO,1'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_EDID_AUTO'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_PREF_EDID'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_FORMAT'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_RES_REF'"
//	 SEND_COMMAND VIDEO_INPUT_CHANNEL3,"'?VIDIN_HDCP'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_ASPECT_RATIO'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_RES_REF'"
//	 SEND_COMMAND VIDEO_OUTPUT_CHANNEL3,"'?VIDOUT_SCALE'"
}

DEFINE_CALL 'AllLights_On'		//SWITCH ALL LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		 //SPOT OFF
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[8]:',ITOA(100)";		 //ON
	 SEND_STRING 0,'All Lights On Called';
	 LIGHTS_POWER = 1
		PRESENTATION_MODE = 0
		PRESENTER_MODE = 0
}

DEFINE_CALL 'AllLights_Off'		//SWITCH ALL LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[8]:',ITOA(0)";		 //Off
	 SEND_STRING 0,'All Lights Off Called';
	 LIGHTS_POWER = 0
		PRESENTATION_MODE = 0
		PRESENTER_MODE = 0
}

DEFINE_CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(20)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(20)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		 //Spot Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)";		 // Floor on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[8]:',ITOA(0)";		 //Off
   SEND_STRING 0,'Presentation Lights Called';
   LIGHTS_POWER = 3
	 PRESENTATION_MODE = 1
	 PRESENTER_MODE = 0
}

DEFINE_CALL 'PresenterLights_On'		//PRESENTATION LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";		 //Front off
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(20)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(20)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		 //Spot on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)";		 // Floor on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[8]:',ITOA(0)";		 //Off
   SEND_STRING 0,'Presenter Lights Called';
   LIGHTS_POWER = 3
	 PRESENTER_MODE = 1
	 PRESENTATION_MODE = 0
}

DEFINE_CALL 'VCLights_On'		//PRESENTATION LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //Front off
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(20)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(20)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";		 //Spot on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)";		 // Floor on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[8]:',ITOA(0)";		 //Off
   SEND_STRING 0,'Presenter Lights Called';
   LIGHTS_POWER = 3
	 PRESENTER_MODE = 1
	 PRESENTATION_MODE = 0
}

DEFINE_CALL 'StageLights_On'		//SWITCH STAGE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";		 // STAGE ON
	 LIGHTS_POWER = 1
}

DEFINE_CALL 'StageLights_Off'		//SWITCH STAGE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 // STAGE Off
	 LIGHTS_POWER = 0
}

DEFINE_CALL 'AudienceLights_On'		//SWITCH AUDIENCE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";		 // ON
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)";		 //ON
	 LIGHTS_POWER = 1
}

DEFINE_CALL 'AudienceLights_Off'		//SWITCH AUDIENCE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)";		 //Off
	 LIGHTS_POWER = 0
}

DEFINE_CALL 'SideLights_On'		//SWITCH SIDE LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		 //ON
	 LIGHTS_POWER = 1
}

DEFINE_CALL 'SideLights_Off'		//SWITCH SIDE LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		 //Off
	 LIGHTS_POWER = 0
}

DEFINE_CALL 'SpotLights_On'		//SWITCH ALL LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";		 //ON
	 LIGHTS_POWER = 1
}

DEFINE_CALL 'SpotLights_Off'		//SWITCH ALL LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		 //Off
	 LIGHTS_POWER = 0
}

DEFINE_CALL 'FirstLights_Off'		//SWITCH ALL LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)";		 //Dimmed
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		 //LED on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		 //Spot Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)";		 // Floor on
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[5]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[6]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[7]:',ITOA(0)";		 //Off
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[8]:',ITOA(0)";		 //Off
}

DEFINE_CALL 'FinalLights_Off'		//SWITCH ALL LIGHTS OFF
{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //Front off
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //off
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)";		 //off
	 SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)";		 //off
	 wait 600
	 SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(0)";		 // Floor off
	 LIGHTS_POWER = 0
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

[dvTP,11] = PRESENTATION_MODE
[dvTP,10] = LIGHTS_POWER
[dvTP,16] = PRESENTER_MODE

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)