PROGRAM_NAME='KP4'
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

INTEGER DVD4 = 0
INTEGER TUNER4 = 0
INTEGER DSTV4 = 0
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

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


//--------------------KIDS ROOM ZONE 6---------------//
button_event[dvKP4,1]
button_event[dvKP4,2]
button_event[dvKP4,3]
button_event[dvKP4,4]
button_event[dvKP4,5]
button_event[dvKP4,6]
button_event[dvKP4,7]
button_event[dvKP4,8]
button_event[dvKP4,9]
button_event[dvKP4,10]
button_event[dvKP4,11]

{
  push:
  {
	to[dvKP4,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 2:	SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUTSELECT-4'";		//Input 4(DVD) Output 6(KIDS ROOM)
							SEND_STRING dvPUTRON, "'3V2.'"			 //DVD IN3 TO OUT2 (KIDSROOM)
							DVD4 = 1;
							TUNER4 = 0;
							DSTV4 = 0;
							off [vdvMatrixAudio[6],199]
							send_level vdvMATRIXAUDIO[6],1,128;
			case 1: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUT-INTERNAL TUNER,1'";
							TUNER4 = 1;
							DVD4 = 0;
							DSTV4 = 0;
							off [vdvMatrixAudio[6],199]
							send_level vdvMATRIXAUDIO[6],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[6],"'INPUTSELECT-5'";		//Input 3(DSTV) Output 6(KIDS ROOM)
							SEND_STRING dvPUTRON, "'2V2.'"			 //DSTV2 IN2 TO OUT2 (KIDSROOM)
							DSTV4 = 1;
							DVD4 = 0;
							TUNER4 = 0;
							off [vdvMatrixAudio[6],199]
							send_level vdvMATRIXAUDIO[6],1,128;
			case 7: IF (DVD4 = 1)
							{
								PULSE [dvDVD,cPlay];
							}
							ELSE IF (DSTV4 = 1)
							{
								PULSE [dvDSTV,cd2ChUp];
							}
							ELSE IF (TUNER4 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							}
			case 8: IF (DVD4 = 1)
							{
								PULSE [dvDVD,cStop];
							}
							ELSE IF (DSTV4 = 1)
							{
								PULSE [dvDSTV,cd2ChDn];
							}
							ELSE IF (TUNER4 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							}
			case 9: IF (DVD4 = 1)
							{
								PULSE [dvDVD,cPrev];
							}
							ELSE IF (TUNER4 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							}
			case 10:IF (DVD4 = 1)
							{
								PULSE [dvDVD,cNext];
							}
							ELSE IF (TUNER4 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
							}
			case 11:PULSE[vdvMatrixAudio[6],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvKP4,12]																								//KIDS ROOM VOL UP
button_event[dvKP4,13]																								//KIDS ROOM VOL DN

{
  hold[1,repeat]:
  {
	to[dvKP4,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 12:on[vdvMatrixAudio[6],24]
							wait 5
							{
								off[vdvMatrixAudio[6],24]
							}

			case 13:on[vdvMatrixAudio[6],25]
							wait 5
							{
								off[vdvMatrixAudio[6],25]
							}
		}
  }
}
 
LEVEL_EVENT[dvKP4,2]
{
VOLUME = level.value
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvKP4,1,VOLUME


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

