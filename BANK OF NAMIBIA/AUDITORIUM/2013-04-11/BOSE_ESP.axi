PROGRAM_NAME='BOSE_ESP'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/27/2012  AT: 16:05:01        *)
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

dvESP88		=		05001:1:0		//BOSE ESP-88 DSP(PORT 2)
dvTP_ESP		=		10001:4:0		//Touch Panel ESP-88

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

INTEGER BOSE_BUTTONS[] =  {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
													 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,
													 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,
													 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,
													 64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79
													 }
VOLATILE INTEGER MAIN_MUTE = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER VOL_LEVEL	= 30	//Volume1 level for bargraph1
VOLATILE INTEGER MIC1_MUTE = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER MIC2_MUTE = 0				//Mute2 On=1, Off=2
VOLATILE INTEGER MIC3_MUTE = 0				//Mute3 On=1, Off=2
VOLATILE INTEGER MIC4_MUTE = 0				//Mute4 On=1, Off=2
VOLATILE INTEGER MIC5_MUTE = 0				//Mute5 On=1, Off=2
VOLATILE INTEGER MIC6_MUTE = 0				//Mute6 On=1, Off=2
VOLATILE INTEGER MIC1_LEVEL = 30		//Mic1 level for bargraph1
VOLATILE INTEGER MIC2_LEVEL = 30		//Mic2 level for bargraph1
VOLATILE INTEGER MIC3_LEVEL = 30		//Mic3 level for bargraph1
VOLATILE INTEGER MIC4_LEVEL = 30		//Mic4 level for bargraph1
VOLATILE INTEGER MIC5_LEVEL = 30		//Mic5 level for bargraph1
VOLATILE INTEGER MIC6_LEVEL = 30		//Mic6 level for bargraph1

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


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvESP88,"'SET BAUD,38400,N,8,1,DISABLE'"		//X-Over Cable,BOSE ESP-88 232 SETTINGS

CREATE_LEVEL dvTP_ESP,10,VOL_LEVEL	//Level for TPbargraph
CREATE_LEVEL dvTP_ESP,1,MIC1_LEVEL	//Level for TPbargraph
CREATE_LEVEL dvTP_ESP,2,MIC2_LEVEL	//Level for TPbargraph
CREATE_LEVEL dvTP_ESP,3,MIC3_LEVEL	//Level for TPbargraph
CREATE_LEVEL dvTP_ESP,4,MIC4_LEVEL	//Level for TPbargraph
CREATE_LEVEL dvTP_ESP,5,MIC5_LEVEL	//Level for TPbargraph
CREATE_LEVEL dvTP_ESP,6,MIC6_LEVEL	//Level for TPbargraph

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP_ESP,BOSE_BUTTONS]
{
	 PUSH:
	 {
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 17:	CALL 'fMic1_Mute'		//MIC1 MUTE
				 CASE 18:	CALL 'fMic2_Mute'		//MIC2 MUTE
				 CASE 19:	CALL 'fMic3_Mute'		//MIC3 MUTE
				 CASE 20:	CALL 'fMic4_Mute'		//MIC4 MUTE
				 CASE 21:	CALL 'fMic5_Mute'		//MIC5 MUTE
				 CASE 22:	CALL 'fMic6_Mute'		//MIC6 MUTE
			}
	 }
}

BUTTON_EVENT[dvTP_ESP,BOSE_BUTTONS]
{
	 HOLD[1,REPEAT]:
	 {
		  PULSE[dvTP_ESP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 3:	CALL 'Mic1_Up'		//MIC1 VOLUME UP
				 CASE 4:	CALL 'Mic1_Down'		//MIC1 VOLUME DOWN
				 CASE 5:	CALL 'Mic2_Up'		//MIC2 VOLUME UP
				 CASE 6:	CALL 'Mic2_Down'		//MIC2 VOLUME DOWN
				 CASE 7:	CALL 'Mic3_Up'		//MIC3 VOLUME UP
				 CASE 8:	CALL 'Mic3_Down'		//MIC3 VOLUME DOWN
				 CASE 9:	CALL 'Mic4_Up'		//MIC4 VOLUME UP
				 CASE 10:	CALL 'Mic4_Down'		//MIC4 VOLUME DOWN
				 CASE 11:	CALL 'Mic5_Up'		//MIC5 VOLUME UP
				 CASE 12:	CALL 'Mic5_Down'		//MIC5 VOLUME DOWN
				 CASE 13:	CALL 'Mic6_Up'		//MIC6 VOLUME UP
				 CASE 14:	CALL 'Mic6_Down'		//MIC6 VOLUME DOWN
			}
	 }
}


DEFINE_CALL 'Mic1_Up'		// HANDHELD MIC1 UP
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"		//HANDHELD MIC1 UP
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,10'"
	 if (MIC1_LEVEL == 10)
	 {
	 }
	 else
	 {
			MIC1_LEVEL = MIC1_LEVEL + 1
			send_level dvTP_ESP,1,MIC1_LEVEL
	 }
}

DEFINE_CALL 'Mic1_Down'		//HANDHELD MIC1 DOWN
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"		//HANDHELD MIC1 DOWN
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,10'"
	 if (MIC1_LEVEL == 0)
	 {
	 }
	 else
	 {
			MIC1_LEVEL = MIC1_LEVEL - 1
			send_level dvTP_ESP,1,MIC1_LEVEL
	 }
}

DEFINE_CALL 'Mic2_Up'		// HANDHELD MIC2 UP
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,10'"
	 if (MIC2_LEVEL == 10)
	 {
	 }
	 else
	 {
			MIC2_LEVEL = MIC2_LEVEL + 1
			send_level dvTP_ESP,2,MIC2_LEVEL
	 }
}

DEFINE_CALL 'Mic2_Down'		//HANDHELD MIC2 DOWN
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,10'"
	 if (MIC2_LEVEL == 0)
	 {
	 }
	 else
	 {
			MIC2_LEVEL = MIC2_LEVEL - 1
			send_level dvTP_ESP,2,MIC2_LEVEL
	 }
}

DEFINE_CALL 'Mic3_Up'		// HANDHELD MIC3 UP
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,10'"
	 if (MIC3_LEVEL == 10)
	 {
	 }
	 else
	 {
			MIC3_LEVEL = MIC3_LEVEL + 1
			send_level dvTP_ESP,3,MIC3_LEVEL
	 }
}

DEFINE_CALL 'Mic3_Down'		//HANDHELD MIC3 DOWN
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,10'"
	 if (MIC3_LEVEL == 0)
	 {
	 }
	 else
	 {
			MIC3_LEVEL = MIC3_LEVEL - 1
			send_level dvTP_ESP,3,MIC3_LEVEL
	 }
}

DEFINE_CALL 'Mic4_Up'		// HANDHELD MIC4 UP
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,10'"
	 if (MIC4_LEVEL == 10)
	 {
	 }
	 else
	 {
			MIC4_LEVEL = MIC4_LEVEL + 1
			send_level dvTP_ESP,4,MIC4_LEVEL
	 }
}

DEFINE_CALL 'Mic4_Down'		//HANDHELD MIC4 DOWN
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,10'"
	 if (MIC4_LEVEL == 0)
	 {
	 }
	 else
	 {
			MIC4_LEVEL = MIC4_LEVEL - 1
			send_level dvTP_ESP,4,MIC4_LEVEL
	 }
}

DEFINE_CALL 'Mic5_Up'		// HEADSET MIC5 UP
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,10'"
	 if (MIC5_LEVEL == 10)
	 {
	 }
	 else
	 {
			MIC5_LEVEL = MIC5_LEVEL + 1
			send_level dvTP_ESP,5,MIC5_LEVEL
	 }
}

DEFINE_CALL 'Mic5_Down'		//HEADSET MIC5 DOWN
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,10'"
	 if (MIC5_LEVEL == 0)
	 {
	 }
	 else
	 {
			MIC5_LEVEL = MIC5_LEVEL - 1
			send_level dvTP_ESP,5,MIC5_LEVEL;
	 }
}

DEFINE_CALL 'Mic6_Up'		// HEADSET MIC6 UP
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-U,10'"
	 if (MIC6_LEVEL == 10)
	 {
	 }
	 else
	 {
			MIC6_LEVEL = MIC6_LEVEL + 1
			send_level dvTP_ESP,6,MIC6_LEVEL
	 }
}

DEFINE_CALL 'Mic6_Down'		//HEADSET MIC6 DOWN
{
	 SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
	 SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
	 SEND_COMMAND vdvBoseESP88, "'RAMP_SLOT_CHANNEL_VOLUME-D,10'"
	 if (MIC6_LEVEL == 0)
	 {
	 }
	 else
	 {
			MIC6_LEVEL = MIC6_LEVEL - 1
			send_level dvTP_ESP,6,MIC6_LEVEL
	 }
}


DEFINE_CALL 'fMic1_Mute'		//HEADSET MIC1 MUTE
{
	 IF (MIC1_MUTE == 0)
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//HEADSET MIC1 MUTE
				MIC1_MUTE = 1
				ON [dvTP_ESP,17]
		}
		ELSE
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//HEADSET MIC1 UNMUTE
				MIC1_MUTE = 0
				OFF [dvTP_ESP,17]
		}
}

DEFINE_CALL 'fMic2_Mute'		//HEADSET MIC2 MUTE
{
	 IF (MIC2_MUTE == 0)
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//HEADSET MIC2 MUTE
				MIC2_MUTE = 1
				ON [dvTP_ESP,18]
		}
		ELSE
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//HEADSET MIC2 UNMUTE
				MIC2_MUTE = 0
				OFF [dvTP_ESP,18]
		}
}

DEFINE_CALL 'fMic3_Mute'		//HEADSET MIC3 MUTE
{
	 IF (MIC3_MUTE == 0)
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//HEADSET MIC3 MUTE
				MIC3_MUTE = 1
				ON [dvTP_ESP,19]
		}
		ELSE
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//HEADSET MIC3 UNMUTE
				MIC3_MUTE = 0
				OFF [dvTP_ESP,19]
		}
}

DEFINE_CALL 'fMic4_Mute'		//HEADSET MIC4 MUTE
{
	 IF (MIC4_MUTE == 0)
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//HEADSET MIC4 MUTE
				MIC4_MUTE = 1
				ON [dvTP_ESP,20]
		}
		ELSE
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//HEADSET MIC4 UNMUTE
				MIC4_MUTE = 0
				OFF [dvTP_ESP,20]
		}
}

DEFINE_CALL 'fMic5_Mute'		//HEADSET MIC5 MUTE
{
	 IF (MIC5_MUTE == 0)
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//HEADSET MIC5 MUTE
				MIC5_MUTE = 1
				ON [dvTP_ESP,21]
		}
		ELSE
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//HEADSET MIC5 UNMUTE
				MIC5_MUTE = 0
				OFF [dvTP_ESP,21]
		}
}

DEFINE_CALL 'fMic6_Mute'		//HEADSET MIC6 MUTE
{
	 IF (MIC6_MUTE == 0)
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//HEADSET MIC6 MUTE
				MIC6_MUTE = 1
				ON [dvTP_ESP,22]
		}
		ELSE
		{
				SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
				SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-2'"
				SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//HEADSET MIC6 UNMUTE
				MIC6_MUTE = 0
				OFF [dvTP_ESP,22]
		}
}

/*
DEFINE_CALL 'podiumAudio'		// Podium Audio
{
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//PODIUM MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//WALL MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		send_string 0, 'Audio for podium'
}

DEFINE_CALL 'wallAudio'		// WALL Audio
{
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PODIUM MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//WALL MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		send_string 0, 'Audio for wall'
}

DEFINE_CALL 'pcAudio'		// PC Audio
{
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PODIUM MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//WALL MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//PC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		send_string 0, 'Audio for pc'
}

DEFINE_CALL 'dstvAudio'		// DSTV Audio
{
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PODIUM MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//WALL MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//VC MUTE
		send_string 0, 'Audio for dstv'
}

DEFINE_CALL 'vcAudio'		// VC Audio
{
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PODIUM MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-1'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//WALL MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-M'"		//PC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-3'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//VC MUTE
		wait 10
		SEND_COMMAND vdvBoseESP88, "'SLOT_NUMBER-5'"
		SEND_COMMAND vdvBoseESP88, "'CHANNEL_NUMBER-4'"
		SEND_COMMAND vdvBoseESP88, "'SLOT_CHANNEL_MUTE-U'"		//VC MUTE
		send_string 0, 'Audio for vc'
}
*/
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP_ESP,17] = MIC1_MUTE
[dvTP_ESP,18] = MIC2_MUTE
[dvTP_ESP,19] = MIC3_MUTE
[dvTP_ESP,20] = MIC4_MUTE
[dvTP_ESP,21] = MIC5_MUTE
[dvTP_ESP,22] = MIC6_MUTE

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)