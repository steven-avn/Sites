PROGRAM_NAME='KP5'
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

INTEGER DVD5 = 0
INTEGER TUNER5 = 0
INTEGER DSTV5 = 0

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

//--------------------GUEST ROOM ZONE 5---------------//
button_event[dvKP5,1]
button_event[dvKP5,2]
button_event[dvKP5,3]
button_event[dvKP5,4]
button_event[dvKP5,5]
button_event[dvKP5,6]
button_event[dvKP5,7]
button_event[dvKP5,8]
button_event[dvKP5,9]
button_event[dvKP5,10]
button_event[dvKP5,11]

{
  push:
  {
	to[dvKP5,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 2:	SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUTSELECT-4'";		//Input 4(DVD) Output 5(GUEST ROOM)
							SEND_STRING dvPUTRON, "'3V3.'"			 //DVD IN3 TO OUT3 (GUESTROOM)
							DVD5 = 1;
							TUNER5 = 0;
							DSTV5 = 0;
							off [vdvMatrixAudio[5],199]
							send_level vdvMATRIXAUDIO[5],1,128;
			case 1: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUT-INTERNAL TUNER,1'";
							TUNER5 = 1;
							DVD5 = 0;
							DSTV5 = 0;
							off [vdvMatrixAudio[5],199]
							send_level vdvMATRIXAUDIO[5],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[5],"'INPUTSELECT-5'";		//Input 3(DSTV) Output 5(GUEST ROOM)
							SEND_STRING dvPUTRON, "'2V3.'"			 //DVD IN2 TO OUT3 (GUESTROOM)
							DSTV5 = 1;
							DVD5 = 0;
							TUNER5 = 0;
							off [vdvMatrixAudio[5],199]
							send_level vdvMATRIXAUDIO[5],1,128;
			case 7: IF (DVD5 = 1)
							{
								PULSE [dvDVD,cPlay];
							}
							ELSE IF (DSTV5 = 1)
							{
								PULSE [dvDSTV,cd2ChUp];
							}
							ELSE IF (TUNER5 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							}
			case 8: IF (DVD5 = 1)
							{
								PULSE [dvDVD,cStop];
							}
							ELSE IF (DSTV5 = 1)
							{
								PULSE [dvDSTV,cd2ChDn];
							}
							ELSE IF (TUNER5 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							}
			case 9: IF (DVD5 = 1)
							{
								PULSE [dvDVD,cPrev];
							}
							ELSE IF (TUNER5 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							}
			case 10:IF (DVD5 = 1)
							{
								PULSE [dvDVD,cNext];
							}
							ELSE IF (TUNER5 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
							}
			case 11:PULSE[vdvMatrixAudio[5],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvKP5,12]																								//GUEST ROOM VOL UP
button_event[dvKP5,13]																								//GUEST ROOM VOL DN

{
  hold[1,repeat]:
  {
	to[dvKP5,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 12:on[vdvMatrixAudio[5],24]
							wait 5
							{
								off[vdvMatrixAudio[5],24]
							}
			case 13:on[vdvMatrixAudio[5],25]
							wait 5
							{
								off[vdvMatrixAudio[5],25]
							}
		}
  }
}
 
LEVEL_EVENT[dvKP5,2]
{
	VOLUME = level.value
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvKP5,1,VOLUME


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

