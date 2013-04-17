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
}

DEFINE_CALL 'Projector_Off'		//PROJECTOR OFF
{
	 PULSE[dvPROJECTOR,10]		 //OFF
	 WAIT 20
	 PULSE[dvPROJECTOR,10]		 //OFF
	 PROJECTOR_POWER = 0
 	 CALL 'AllLights_On'		//SWITCH ALL LIGHTS ON
}

DEFINE_CALL 'PCInput_On'		//PC INPUT
{
	 SEND_COMMAND SWITCHER,"'CLALLI1O2'"		//PC AUDIO/VIDEO IN1 TO OUT1
	 InputSelected = 1
	 //SEND_COMMAND VIDEO_SWITCHER,"'AI1O2'"		//PC AUDIO IN1 TO OUT2
	 //SEND_COMMAND AUDIO_OUTPUT_LINE,"'VOLUME-0'"		//VOLUME 0dB
	 //SEND_COMMAND MIC_1,"'AUDMIC_MIXER-50'"		//MIC1 VOLUME 50
	 //SEND_COMMAND MIC_1,"'AUDMIC_STEREO-DISABLE'"		//MIC1 MONO
	 //SEND_COMMAND MIC_2,"'AUDMIC_MIXER-50'"		//MIC2 VOLUME 50
	 //SEND_COMMAND MIC_2,"'AUDMIC_STEREO-DISABLE'"		//MIC2 MONO
	 //SEND_COMMAND AUDIO_INPUT_1,"'AUDIN_STEREO-DISABLE'"		//AUDIO IN1 MONO
}

DEFINE_CALL 'LaptopInput_On'		//LAPTOP INPUT
{
	 SEND_COMMAND SWITCHER,"'CLALLI2O2'"		//LAPTOP VIDEO IN2 TO OUT1
	 InputSelected = 2
	 //SEND_COMMAND VIDEO_SWITCHER,"'AI2O2'"		//LAPTOP AUDIO IN2 TO OUT2
	 //SEND_COMMAND AUDIO_OUTPUT_LINE,"'VOLUME-0'"		//VOLUME 0dB
	 //SEND_COMMAND MIC_1,"'AUDMIC_MIXER-50'"		//MIC1 VOLUME 50
	 //SEND_COMMAND MIC_1,"'AUDMIC_STEREO-DISABLE'"		//MIC1 MONO
	 //SEND_COMMAND MIC_2,"'AUDMIC_MIXER-50'"		//MIC2 VOLUME 50
	 //SEND_COMMAND MIC_2,"'AUDMIC_STEREO-DISABLE'"		//MIC2 MONO
	 //SEND_COMMAND AUDIO_INPUT_2,"'AUDIN_STEREO-DISABLE'"		//AUDIO IN2 MONO
}

DEFINE_CALL 'AllLights_On'		//SWITCH ALL LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[5]:',ITOA(100)";		 //ON
	 LIGHTS_POWER = 1
}

DEFINE_CALL 'AllLights_Off'		//SWITCH ALL LIGHTS OFF
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //OFF
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //OFF
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(0)";		 //OFF
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(0)";		 //OFF
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[5]:',ITOA(0)";		 //OFF
	 LIGHTS_POWER = 0
}

DEFINE_CALL 'PresentationLights_On'		//PRESENTATION LIGHTS ON
{
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(0)";		 //ON
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)";		 //OFF
	 SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[5]:',ITOA(100)";		 //OFF
	 LIGHTS_POWER = 3
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