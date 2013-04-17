(*********************************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/27/2012  AT: 13:16:33        *)
(***********************************************************)
(*  AMX Corporation                                                  *)
(*  Copyright (c) 2004-2006 AMX Corporation. All rights reserved.    *)
(*********************************************************************)
(* Copyright Notice :                                                *)
(* Copyright, AMX, Inc., 2004-2007                                   *)
(*    Private, proprietary information, the sole property of AMX.    *)
(*    The contents, ideas, and concepts expressed herein are not to  *)
(*    be disclosed except within the confines of a confidential      *)
(*    relationship and only then on a need to know basis.            *)
(*********************************************************************)
PROGRAM_NAME = 'Bose ESP88 Audio Mixer Main'
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 6/4/2007 2:36:15 PM                    *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvTPMain = 10001:4:0 // This should be the touch panel's main port

//vdvBoseESP88 = 41001:1:0  // The COMM module should use this as its duet device
dvBoseESP88 = 5001:1:0 // This device should be used as the physical device by the COMM module
dvBoseESP88Tp = 10001:13:0 // This port should match the assigned touch panel device port

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvDev[] = {vdvBoseESP88}

VOLATILE CHAR cCOMMAND[10][100]

VOLATILE INTEGER CURRENT_INPUT = 0
VOLATILE INTEGER STD_MIXER_INPUT = 0
VOLATILE INTEGER STD_MIXER_OUTPUT = 0
VOLATILE INTEGER MATRIX_MIXER_SIZE = 0

VOLATILE INTEGER blockNameMixer = 0
VOLATILE INTEGER blockNameStMixer = 0
VOLATILE INTEGER blockNameToneEQ = 0
VOLATILE INTEGER blockNameGain = 0
VOLATILE INTEGER blockNameSelector = 0

VOLATILE INTEGER LOW_RANGE_EQ
VOLATILE INTEGER MID_RANGE_EQ
VOLATILE INTEGER HIGH_RANGE_EQ

VOLATILE INTEGER LOW_RANGE_BYPASS
VOLATILE INTEGER MID_RANGE_BYPASS
VOLATILE INTEGER HIGH_RANGE_BYPASS

VOLATILE INTEGER SLOT_NUMBER = 0
VOLATILE INTEGER CHANNEL_NUMBER = 0
VOLATILE INTEGER SLOT_CHANNEL_VOLUME = 0
VOLATILE INTEGER SLOT_CHANNEL_VOLUME_MUTE = 0
VOLATILE INTEGER SELECTOR = 0

// ----------------------------------------------------------
// CURRENT DEVICE NUMBER ON TP NAVIGATION BAR
INTEGER nAudioMixer = 1

// ----------------------------------------------------------
// DEFINE THE PAGES THAT YOUR COMPONENTS ARE USING IN THE
// SUB NAVIGATION BAR HERE
INTEGER nAudioMixerPages[] = { 1,2 }
INTEGER nSwitcherPages[] = { 3 }
INTEGER nGainPages[] = { 4 }
INTEGER nVolumePages[] = { 5 }
INTEGER nModulePages[] = { 6 }

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
DEFINE_FUNCTION FLOAT fnScale_Range(FLOAT Num_In, FLOAT Min_In, FLOAT Max_In, FLOAT Min_Out, FLOAT Max_Out)
{
    STACK_VAR
    FLOAT Val_In
    FLOAT Range_In
    FLOAT Range_Out
    FLOAT Whole_Num
    FLOAT Num_Out

    Val_In = Num_In                 // Get input value
    IF(Val_In == Min_In)            // Handle endpoints
        {Num_Out = Min_Out}
    ELSE IF(Val_In == Max_In)
        {Num_Out = Max_Out}
    ELSE                            // Otherwise scale...
    {
        Range_In = Max_In - Min_In      // Establish input range
        Range_Out = Max_Out - Min_Out   // Establish output range
        Val_In = Val_In - Min_In        // Remove input offset
        Num_Out = Val_In * Range_Out    // Multiply by output range
        Num_Out = Num_Out / Range_In    // Then divide by input range
        Num_Out = Num_Out + Min_Out     // Add in minimum output value
        Whole_Num = TYPE_CAST(Num_Out)  // Store the whole number only of the result
//		IF (Num_Out >= 0 AND (((Num_Out - Whole_Num)* 100.0) >= 50.0)) { Num_Out++ }    // round up
//      ELSE IF (Num_Out < 0 AND (((Num_Out - Whole_Num) * 100.0) <= -50.0)) { Num_Out-- }    // round down
    }
    Return TYPE_CAST(Num_Out)
}

//
// Function : fnPARSE()
// Purpose  : STRING PARSING USING A DELIMITER
// Params   : CHAR cDELIMITER[], CHAR cSTRING[], CHAR cNEW_STRING[][]
// Return   : nCOUNTER
// Notes    : THIS FUNCTION PARSES A STRING USING A DELIMITER PASSED BY THE USER.
//            MAXIMUM OF 10 PARAMETERS OF LENGTH 50 EACH- DELIMITER CAN HAVE LENGTH 1 OR 2.
//            THIS FUNCTION RETURNS THE NUMBER OF PARAMETERES PARSED. cNEW_STRING CONTAINS THE PARSED INFO.
DEFINE_FUNCTION INTEGER fnPARSE(CHAR cDELIMITER[2], CHAR cSTRING[500], CHAR cNEW_STRING[10][100])
{
	STACK_VAR INTEGER nCOUNTER
	nCOUNTER=0
	WHILE(nCOUNTER<=10)
	{
		IF(FIND_STRING(cSTRING,"cDELIMITER",1))
		{
			cNEW_STRING[nCOUNTER+1]=REMOVE_STRING(cSTRING,"cDELIMITER",1)
			SET_LENGTH_STRING(cNEW_STRING[nCOUNTER+1],LENGTH_STRING(cNEW_STRING[nCOUNTER+1])-LENGTH_STRING(cDELIMITER))
			nCOUNTER++
		}
		ELSE
		{
			cNEW_STRING[nCOUNTER+1]=cSTRING
			IF(LENGTH_STRING(cSTRING))
				nCOUNTER++
			BREAK
		}
	}
	RETURN nCOUNTER
}
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

CREATE_LEVEL dvBoseESP88Tp, 201, LOW_RANGE_EQ
CREATE_LEVEL dvBoseESP88Tp, 202, MID_RANGE_EQ
CREATE_LEVEL dvBoseESP88Tp, 203, HIGH_RANGE_EQ
CREATE_LEVEL dvBoseESP88Tp, 204, SLOT_CHANNEL_VOLUME


// ----------------------------------------------------------
// DEVICE MODULE GROUPS SHOULD ALL HAVE THE SAME DEVICE NUMBER
DEFINE_MODULE 'Bose ESP88 AudioMixerComponent' audiomixer(vdvDev, dvBoseESP88Tp, dvTPMain, nAudioMixer, nAudioMixerPages)
DEFINE_MODULE 'Bose ESP88 GainComponent' gain(vdvDev, dvBoseESP88Tp, dvTPMain, nAudioMixer, nGainPages)
DEFINE_MODULE 'Bose ESP88 ModuleComponent' module(vdvDev, dvBoseESP88Tp, dvTPMain, nAudioMixer, nModulePages)
DEFINE_MODULE 'Bose ESP88 SwitcherComponent' switcher(vdvDev, dvBoseESP88Tp, dvTPMain, nAudioMixer, nSwitcherPages)
DEFINE_MODULE 'Bose ESP88 VolumeComponent' volume(vdvDev, dvBoseESP88Tp, dvTPMain, nAudioMixer, nVolumePages)

// Define your communications module here like so:
DEFINE_MODULE 'Bose_ESP88_Comm_dr1_0_0' comm(vdvBoseESP88, dvBoseESP88)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[vdvBoseESP88]
{
	ONLINE:
	{
		WAIT 10
		{
			SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameMixer,#Mixer'"
			blockNameMixer = 1
			SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameStMixer,#StdMixer'"
			blockNameStMixer = 1
			SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameToneEQ,#ToneEQ'"
			blockNameToneEQ = 1
			SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameGain,#Gain1'"
			blockNameGain = 1
			SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameSelector,#Selector1'"
			blockNameSelector = 1
		}
	}
}

DATA_EVENT[vdvBoseESP88]
{
	COMMAND:
	{
		STACK_VAR CHAR DATUM[30]
        DATUM  = remove_string(data.text, '-', 1)

        SWITCH(DATUM)
		{
			// FIND MATCHING STRING AND PARSE REST OF MESSAGE. PROVIDE FEEDBACK TO THE
			// TOUCH PANEL.
			CASE 'LOW_BYPASS-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)

				IF(cCOMMAND[1] == 'ON')
				{
					LOW_RANGE_BYPASS = 1
				}
				ELSE IF(cCOMMAND[1] == 'OFF')
				{
					LOW_RANGE_BYPASS = 0
				}
			}
			CASE 'MID_BYPASS-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)

				IF(cCOMMAND[1] == 'ON')
				{
					MID_RANGE_BYPASS = 1
				}
				ELSE IF(cCOMMAND[1] == 'OFF')
				{
					MID_RANGE_BYPASS = 0
				}
			}
			CASE 'HIGH_BYPASS-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)

				IF(cCOMMAND[1] == 'ON')
				{
					HIGH_RANGE_BYPASS = 1
				}
				ELSE IF(cCOMMAND[1] == 'OFF')
				{
					HIGH_RANGE_BYPASS = 0
				}
			}
			CASE 'SLOT_CHANNEL_VOLUME_MUTE-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)

				IF(cCOMMAND[1] == 'M')
				{
					SLOT_CHANNEL_VOLUME_MUTE = 1
				}
				ELSE IF(cCOMMAND[1] == 'U')
				{
					SLOT_CHANNEL_VOLUME_MUTE = 0
				}
			}
			CASE 'CHANNEL_NUMBER-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)
				CHANNEL_NUMBER = ATOI(cCOMMAND[1])
			}
			CASE 'SLOT_NUMBER-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)
				SLOT_NUMBER = ATOI(cCOMMAND[1])
			}
			CASE 'SELECTOR-':
			{
				fnPARSE('-',DATA.TEXT,cCOMMAND)
				SELECTOR = ATOI(cCOMMAND[1])
			}
		}// END SWITCH(datum)
	}// END COMMAND
}// END DATA_EVENT[vdvDEVICE]

LEVEL_EVENT[vdvBoseESP88, 201]//low EQ feedback
{
	SEND_LEVEL dvBoseESP88Tp, 201, LEVEL.VALUE
	SEND_COMMAND dvBoseESP88Tp, "'^TXT-201,0,', FORMAT('%3.1f',(fnScale_Range(LEVEL.VALUE, 0.0, 255.0, -15.0, 15.0)))"
}
LEVEL_EVENT[vdvBoseESP88, 202]//mid EQ feedback
{
	SEND_LEVEL dvBoseESP88Tp, 202, LEVEL.VALUE
	SEND_COMMAND dvBoseESP88Tp, "'^TXT-202,0,', FORMAT('%3.1f',(fnScale_Range(LEVEL.VALUE, 0.0, 255.0, -15.0, 15.0)))"
}
LEVEL_EVENT[vdvBoseESP88, 203]//high EQ feedback
{
	SEND_LEVEL dvBoseESP88Tp, 203, LEVEL.VALUE
	SEND_COMMAND dvBoseESP88Tp, "'^TXT-203,0,', FORMAT('%3.1f',(fnScale_Range(LEVEL.VALUE, 0.0, 255.0, -15.0, 15.0)))"
}
LEVEL_EVENT[vdvBoseESP88, 204]//slot channel volume
{
	SEND_LEVEL dvBoseESP88Tp, 204, LEVEL.VALUE
	SEND_COMMAND dvBoseESP88Tp, "'^TXT-204,0,', FORMAT('%3.1f',(fnScale_Range(LEVEL.VALUE, 0.0, 255.0, -60.0, 12.0)))"
}

BUTTON_EVENT[dvBoseESP88Tp, 3301]
BUTTON_EVENT[dvBoseESP88Tp, 3302]
BUTTON_EVENT[dvBoseESP88Tp, 3303]
BUTTON_EVENT[dvBoseESP88Tp, 3304]
BUTTON_EVENT[dvBoseESP88Tp, 3305]
BUTTON_EVENT[dvBoseESP88Tp, 3306]
BUTTON_EVENT[dvBoseESP88Tp, 3307]
BUTTON_EVENT[dvBoseESP88Tp, 3308]
BUTTON_EVENT[dvBoseESP88Tp, 3309]
BUTTON_EVENT[dvBoseESP88Tp, 3310]
BUTTON_EVENT[dvBoseESP88Tp, 3311]
BUTTON_EVENT[dvBoseESP88Tp, 3312]
BUTTON_EVENT[dvBoseESP88Tp, 3313]
BUTTON_EVENT[dvBoseESP88Tp, 3314]
BUTTON_EVENT[dvBoseESP88Tp, 3315]
BUTTON_EVENT[dvBoseESP88Tp, 3316]
{
	PUSH:
	{
		CURRENT_INPUT = BUTTON.INPUT.CHANNEL - 3300
		SEND_COMMAND vdvBoseESP88, "'SOURCE_SELECT-', ITOA(CURRENT_INPUT)"
	}
}
//Matrix Mixer Module block name select (3410 - 3419)
BUTTON_EVENT[dvBoseESP88Tp, 3410]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameMixer,#Mixer'"
		blockNameMixer = 1
	}
}
//add more here



//Standard Mixer Module block name select (3420 - 3429)
BUTTON_EVENT[dvBoseESP88Tp, 3420]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameStMixer,#StdMixer'"
		blockNameStMixer = 1
	}
}
//add more here


//Tone Control Module block name select (3430 - 3439)
BUTTON_EVENT[dvBoseESP88Tp, 3430]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameToneEQ,#ToneEQ'"
		blockNameToneEQ = 1
	}
}
//add more here



//Gain Module block name select (3440 - 3449)
BUTTON_EVENT[dvBoseESP88Tp, 3440]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameGain,#Gain1'"
		blockNameGain = 1
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3441]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameGain,#Gain2'"
		blockNameGain = 2
	}
}
//add more here



//Gain Module block name select (3450 - 3459)
BUTTON_EVENT[dvBoseESP88Tp, 3450]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameSelector,#Selector1'"
		blockNameSelector = 1
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3451]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'PROPERTY-blockNameSelector,#Selector2'"
		blockNameSelector = 2
	}
}
//add more here

BUTTON_EVENT[dvBoseESP88Tp, 3501]
BUTTON_EVENT[dvBoseESP88Tp, 3502]
BUTTON_EVENT[dvBoseESP88Tp, 3503]
BUTTON_EVENT[dvBoseESP88Tp, 3504]
BUTTON_EVENT[dvBoseESP88Tp, 3505]
BUTTON_EVENT[dvBoseESP88Tp, 3506]
BUTTON_EVENT[dvBoseESP88Tp, 3507]
BUTTON_EVENT[dvBoseESP88Tp, 3508]
BUTTON_EVENT[dvBoseESP88Tp, 3509]
BUTTON_EVENT[dvBoseESP88Tp, 3510]
BUTTON_EVENT[dvBoseESP88Tp, 3511]
BUTTON_EVENT[dvBoseESP88Tp, 3512]
BUTTON_EVENT[dvBoseESP88Tp, 3513]
BUTTON_EVENT[dvBoseESP88Tp, 3514]
BUTTON_EVENT[dvBoseESP88Tp, 3515]
BUTTON_EVENT[dvBoseESP88Tp, 3516]
BUTTON_EVENT[dvBoseESP88Tp, 3517]
BUTTON_EVENT[dvBoseESP88Tp, 3518]
BUTTON_EVENT[dvBoseESP88Tp, 3519]
BUTTON_EVENT[dvBoseESP88Tp, 3520]
{
	PUSH:
	{
		STD_MIXER_INPUT = BUTTON.INPUT.CHANNEL - 3500
	}
}


BUTTON_EVENT[dvBoseESP88Tp, 3601]
BUTTON_EVENT[dvBoseESP88Tp, 3602]
BUTTON_EVENT[dvBoseESP88Tp, 3603]
BUTTON_EVENT[dvBoseESP88Tp, 3604]
BUTTON_EVENT[dvBoseESP88Tp, 3605]
BUTTON_EVENT[dvBoseESP88Tp, 3606]
BUTTON_EVENT[dvBoseESP88Tp, 3607]
BUTTON_EVENT[dvBoseESP88Tp, 3608]
BUTTON_EVENT[dvBoseESP88Tp, 3609]
BUTTON_EVENT[dvBoseESP88Tp, 3610]
BUTTON_EVENT[dvBoseESP88Tp, 3611]
BUTTON_EVENT[dvBoseESP88Tp, 3612]
BUTTON_EVENT[dvBoseESP88Tp, 3613]
BUTTON_EVENT[dvBoseESP88Tp, 3614]
BUTTON_EVENT[dvBoseESP88Tp, 3615]
BUTTON_EVENT[dvBoseESP88Tp, 3616]
BUTTON_EVENT[dvBoseESP88Tp, 3617]
BUTTON_EVENT[dvBoseESP88Tp, 3618]
BUTTON_EVENT[dvBoseESP88Tp, 3619]
BUTTON_EVENT[dvBoseESP88Tp, 3620]
{
	PUSH:
	{
		STD_MIXER_OUTPUT = BUTTON.INPUT.CHANNEL - 3600
	}
}

LEVEL_EVENT[dvBoseESP88Tp, 100]//STD MIXER INPUT
{
	SEND_COMMAND vdvBoseESP88, "'STD_MIXER_INPUT_LEVEL-', ITOA(STD_MIXER_INPUT), ',', ITOA(LEVEL.VALUE)"
}

LEVEL_EVENT[dvBoseESP88Tp, 101]//STD MIXER OUTPUT
{
	SEND_COMMAND vdvBoseESP88, "'STD_MIXER_OUTPUT_LEVEL-', ITOA(STD_MIXER_OUTPUT), ',', ITOA(LEVEL.VALUE)"
}

BUTTON_EVENT[dvBoseESP88Tp, 3701]//TOGGLE MUTE STD MIXER INPUT
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'STD_MIXER_INPUT_MUTE-', ITOA(STD_MIXER_INPUT)"
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3702]//TOGGLE MUTE STD MIXER OUPUT
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'STD_MIXER_OUTPUT_MUTE-', ITOA(STD_MIXER_OUTPUT)"
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3703]//TOGGLE ON/OFF MATRIX MIXER
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'STD_MIXER-', ITOA(STD_MIXER_INPUT), ',', ITOA(STD_MIXER_OUTPUT)"
	}
}


BUTTON_EVENT[dvBoseESP88Tp, 3801]//Select 4X4 matrix mixer
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'MATRIX_MIXER_SIZE-4'"
		MATRIX_MIXER_SIZE = 4
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3802]//Select 8X8 matrix mixer
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'MATRIX_MIXER_SIZE-8'"

		MATRIX_MIXER_SIZE = 8
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3803]//Select 16X16 matrix mixer
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'MATRIX_MIXER_SIZE-16'"
		MATRIX_MIXER_SIZE = 16
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3201]
{
	RELEASE:
	{
		SEND_LEVEL vdvBoseESP88, 201, LOW_RANGE_EQ
		SEND_COMMAND vdvBoseESP88, "'TONE_EQ_LOW-', ITOA(LOW_RANGE_EQ)"
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3202]
{
	RELEASE:
	{
		SEND_LEVEL vdvBoseESP88, 202, MID_RANGE_EQ
		SEND_COMMAND vdvBoseESP88, "'TONE_EQ_MID-', ITOA(MID_RANGE_EQ)"
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3203]
{
	RELEASE:
	{
		SEND_LEVEL vdvBoseESP88, 203, HIGH_RANGE_EQ
		SEND_COMMAND vdvBoseESP88, "'TONE_EQ_HIGH-', ITOA(HIGH_RANGE_EQ)"
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3204]
{
	RELEASE:
	{
		SEND_LEVEL vdvBoseESP88, 204, SLOT_CHANNEL_VOLUME
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_VOLUME-', ITOA(SLOT_CHANNEL_VOLUME)"
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3205]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3206]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3207]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,6'"//6 means 6 * 0.5 db = 3dB, you can change it
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3208]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,6'"//6 means 6 * 0.5 db = 3dB, you can change it
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3704]//TOGGLE ON/OFF L-Bypass
{
	PUSH:
	{
		PULSE[vdvBoseESP88,300]
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3705]//TOGGLE ON/OFF M-Bypass
{
	PUSH:
	{
		PULSE[vdvBoseESP88,301]
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3706]//TOGGLE ON/OFF H-Bypass
{
	PUSH:
	{
		PULSE[vdvBoseESP88,302]
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3901]
BUTTON_EVENT[dvBoseESP88Tp, 3902]
BUTTON_EVENT[dvBoseESP88Tp, 3903]
BUTTON_EVENT[dvBoseESP88Tp, 3904]
BUTTON_EVENT[dvBoseESP88Tp, 3905]
BUTTON_EVENT[dvBoseESP88Tp, 3906]
BUTTON_EVENT[dvBoseESP88Tp, 3907]
BUTTON_EVENT[dvBoseESP88Tp, 3908]
{
	PUSH:
	{
		SLOT_NUMBER = BUTTON.INPUT.CHANNEL - 3900
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-', ITOA(SLOT_NUMBER)"
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3909]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'?SLOT_NUMBER'"
	}
}

BUTTON_EVENT[dvBoseESP88Tp, 3911]
BUTTON_EVENT[dvBoseESP88Tp, 3912]
BUTTON_EVENT[dvBoseESP88Tp, 3913]
BUTTON_EVENT[dvBoseESP88Tp, 3914]
BUTTON_EVENT[dvBoseESP88Tp, 3915]
BUTTON_EVENT[dvBoseESP88Tp, 3916]
BUTTON_EVENT[dvBoseESP88Tp, 3917]
BUTTON_EVENT[dvBoseESP88Tp, 3918]
{
	PUSH:
	{
		CHANNEL_NUMBER = BUTTON.INPUT.CHANNEL - 3910
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-', ITOA(CHANNEL_NUMBER)"
	}
}
BUTTON_EVENT[dvBoseESP88Tp, 3919]
{
	PUSH:
	{
		SEND_COMMAND vdvBoseESP88, "'?CHANNEL_NUMBER'"
	}
}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvBoseESP88Tp, 3301] = SELECTOR = 1
[dvBoseESP88Tp, 3302] = SELECTOR = 2
[dvBoseESP88Tp, 3303] = SELECTOR = 3
[dvBoseESP88Tp, 3304] = SELECTOR = 4
[dvBoseESP88Tp, 3305] = SELECTOR = 5
[dvBoseESP88Tp, 3306] = SELECTOR = 6
[dvBoseESP88Tp, 3307] = SELECTOR = 7
[dvBoseESP88Tp, 3308] = SELECTOR = 8
[dvBoseESP88Tp, 3309] = SELECTOR = 9
[dvBoseESP88Tp, 3310] = SELECTOR = 10
[dvBoseESP88Tp, 3311] = SELECTOR = 11
[dvBoseESP88Tp, 3312] = SELECTOR = 12
[dvBoseESP88Tp, 3313] = SELECTOR = 13
[dvBoseESP88Tp, 3314] = SELECTOR = 14
[dvBoseESP88Tp, 3315] = SELECTOR = 15
[dvBoseESP88Tp, 3316] = SELECTOR = 16

[dvBoseESP88Tp, 3410] = blockNameMixer = 1
[dvBoseESP88Tp, 3411] = blockNameMixer = 2
[dvBoseESP88Tp, 3412] = blockNameMixer = 3
[dvBoseESP88Tp, 3413] = blockNameMixer = 4
[dvBoseESP88Tp, 3414] = blockNameMixer = 5
[dvBoseESP88Tp, 3415] = blockNameMixer = 6
[dvBoseESP88Tp, 3416] = blockNameMixer = 7
[dvBoseESP88Tp, 3417] = blockNameMixer = 8
[dvBoseESP88Tp, 3418] = blockNameMixer = 9
[dvBoseESP88Tp, 3419] = blockNameMixer = 10

[dvBoseESP88Tp, 3420] = blockNameStMixer = 1
[dvBoseESP88Tp, 3421] = blockNameStMixer = 2
[dvBoseESP88Tp, 3422] = blockNameStMixer = 3
[dvBoseESP88Tp, 3423] = blockNameStMixer = 4
[dvBoseESP88Tp, 3424] = blockNameStMixer = 5
[dvBoseESP88Tp, 3425] = blockNameStMixer = 6
[dvBoseESP88Tp, 3426] = blockNameStMixer = 7
[dvBoseESP88Tp, 3427] = blockNameStMixer = 8
[dvBoseESP88Tp, 3428] = blockNameStMixer = 9
[dvBoseESP88Tp, 3429] = blockNameStMixer = 10

[dvBoseESP88Tp, 3430] = blockNameToneEQ = 1
[dvBoseESP88Tp, 3431] = blockNameToneEQ = 2
[dvBoseESP88Tp, 3432] = blockNameToneEQ = 3
[dvBoseESP88Tp, 3433] = blockNameToneEQ = 4
[dvBoseESP88Tp, 3434] = blockNameToneEQ = 5
[dvBoseESP88Tp, 3435] = blockNameToneEQ = 6
[dvBoseESP88Tp, 3436] = blockNameToneEQ = 7
[dvBoseESP88Tp, 3437] = blockNameToneEQ = 8
[dvBoseESP88Tp, 3438] = blockNameToneEQ = 9
[dvBoseESP88Tp, 3439] = blockNameToneEQ = 10

[dvBoseESP88Tp, 3440] = blockNameGain = 1
[dvBoseESP88Tp, 3441] = blockNameGain = 2
[dvBoseESP88Tp, 3442] = blockNameGain = 3
[dvBoseESP88Tp, 3443] = blockNameGain = 4
[dvBoseESP88Tp, 3444] = blockNameGain = 5
[dvBoseESP88Tp, 3445] = blockNameGain = 6
[dvBoseESP88Tp, 3446] = blockNameGain = 7
[dvBoseESP88Tp, 3447] = blockNameGain = 8
[dvBoseESP88Tp, 3448] = blockNameGain = 9
[dvBoseESP88Tp, 3449] = blockNameGain = 10

[dvBoseESP88Tp, 3450] = blockNameSelector = 1
[dvBoseESP88Tp, 3451] = blockNameSelector = 2
[dvBoseESP88Tp, 3452] = blockNameSelector = 3
[dvBoseESP88Tp, 3453] = blockNameSelector = 4
[dvBoseESP88Tp, 3454] = blockNameSelector = 5
[dvBoseESP88Tp, 3455] = blockNameSelector = 6
[dvBoseESP88Tp, 3456] = blockNameSelector = 7
[dvBoseESP88Tp, 3457] = blockNameSelector = 8
[dvBoseESP88Tp, 3458] = blockNameSelector = 9
[dvBoseESP88Tp, 3459] = blockNameSelector = 10

[dvBoseESP88Tp, 3501] = STD_MIXER_INPUT = 1
[dvBoseESP88Tp, 3502] = STD_MIXER_INPUT = 2
[dvBoseESP88Tp, 3503] = STD_MIXER_INPUT = 3
[dvBoseESP88Tp, 3504] = STD_MIXER_INPUT = 4
[dvBoseESP88Tp, 3505] = STD_MIXER_INPUT = 5
[dvBoseESP88Tp, 3506] = STD_MIXER_INPUT = 6
[dvBoseESP88Tp, 3507] = STD_MIXER_INPUT = 7
[dvBoseESP88Tp, 3508] = STD_MIXER_INPUT = 8
[dvBoseESP88Tp, 3509] = STD_MIXER_INPUT = 9
[dvBoseESP88Tp, 3510] = STD_MIXER_INPUT = 10
[dvBoseESP88Tp, 3511] = STD_MIXER_INPUT = 11
[dvBoseESP88Tp, 3512] = STD_MIXER_INPUT = 12
[dvBoseESP88Tp, 3513] = STD_MIXER_INPUT = 13
[dvBoseESP88Tp, 3514] = STD_MIXER_INPUT = 14
[dvBoseESP88Tp, 3515] = STD_MIXER_INPUT = 15
[dvBoseESP88Tp, 3516] = STD_MIXER_INPUT = 16
[dvBoseESP88Tp, 3517] = STD_MIXER_INPUT = 17
[dvBoseESP88Tp, 3518] = STD_MIXER_INPUT = 18
[dvBoseESP88Tp, 3519] = STD_MIXER_INPUT = 19
[dvBoseESP88Tp, 3520] = STD_MIXER_INPUT = 20

[dvBoseESP88Tp, 3601] = STD_MIXER_OUTPUT = 1
[dvBoseESP88Tp, 3602] = STD_MIXER_OUTPUT = 2
[dvBoseESP88Tp, 3603] = STD_MIXER_OUTPUT = 3
[dvBoseESP88Tp, 3604] = STD_MIXER_OUTPUT = 4
[dvBoseESP88Tp, 3605] = STD_MIXER_OUTPUT = 5
[dvBoseESP88Tp, 3606] = STD_MIXER_OUTPUT = 6
[dvBoseESP88Tp, 3607] = STD_MIXER_OUTPUT = 7
[dvBoseESP88Tp, 3608] = STD_MIXER_OUTPUT = 8
[dvBoseESP88Tp, 3609] = STD_MIXER_OUTPUT = 9
[dvBoseESP88Tp, 3610] = STD_MIXER_OUTPUT = 10
[dvBoseESP88Tp, 3611] = STD_MIXER_OUTPUT = 11
[dvBoseESP88Tp, 3612] = STD_MIXER_OUTPUT = 12
[dvBoseESP88Tp, 3613] = STD_MIXER_OUTPUT = 13
[dvBoseESP88Tp, 3614] = STD_MIXER_OUTPUT = 14
[dvBoseESP88Tp, 3615] = STD_MIXER_OUTPUT = 15
[dvBoseESP88Tp, 3616] = STD_MIXER_OUTPUT = 16
[dvBoseESP88Tp, 3617] = STD_MIXER_OUTPUT = 17
[dvBoseESP88Tp, 3618] = STD_MIXER_OUTPUT = 18
[dvBoseESP88Tp, 3619] = STD_MIXER_OUTPUT = 19
[dvBoseESP88Tp, 3620] = STD_MIXER_OUTPUT = 20

[dvBoseESP88Tp, 3704] = LOW_RANGE_BYPASS = 1
[dvBoseESP88Tp, 3705] = MID_RANGE_BYPASS = 1
[dvBoseESP88Tp, 3706] = HIGH_RANGE_BYPASS = 1

[dvBoseESP88Tp, 3801] = MATRIX_MIXER_SIZE = 4
[dvBoseESP88Tp, 3802] = MATRIX_MIXER_SIZE = 8
[dvBoseESP88Tp, 3803] = MATRIX_MIXER_SIZE = 16

[dvBoseESP88Tp, 3901] = SLOT_NUMBER = 1
[dvBoseESP88Tp, 3902] = SLOT_NUMBER = 2
[dvBoseESP88Tp, 3903] = SLOT_NUMBER = 3
[dvBoseESP88Tp, 3904] = SLOT_NUMBER = 4
[dvBoseESP88Tp, 3905] = SLOT_NUMBER = 5
[dvBoseESP88Tp, 3906] = SLOT_NUMBER = 6
[dvBoseESP88Tp, 3907] = SLOT_NUMBER = 7
[dvBoseESP88Tp, 3908] = SLOT_NUMBER = 8

[dvBoseESP88Tp, 3911] = CHANNEL_NUMBER = 1
[dvBoseESP88Tp, 3912] = CHANNEL_NUMBER = 2
[dvBoseESP88Tp, 3913] = CHANNEL_NUMBER = 3
[dvBoseESP88Tp, 3914] = CHANNEL_NUMBER = 4
[dvBoseESP88Tp, 3915] = CHANNEL_NUMBER = 5
[dvBoseESP88Tp, 3916] = CHANNEL_NUMBER = 6
[dvBoseESP88Tp, 3917] = CHANNEL_NUMBER = 7
[dvBoseESP88Tp, 3918] = CHANNEL_NUMBER = 8

[dvBoseESP88Tp, 3205] = SLOT_CHANNEL_VOLUME_MUTE = 1
[dvBoseESP88Tp, 3206] = SLOT_CHANNEL_VOLUME_MUTE = 0
(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

