PROGRAM_NAME='KP1'
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

INTEGER DVD1 = 0
INTEGER TUNER1 = 0
INTEGER DSTV1 = 0
INTEGER volume

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


//--------------------MAIN BEDROOM ZONE 3---------------//
button_event[dvKP1,1]
button_event[dvKP1,2]
button_event[dvKP1,3]
button_event[dvKP1,4]
button_event[dvKP1,5]
button_event[dvKP1,6]
button_event[dvKP1,7]
button_event[dvKP1,8]
button_event[dvKP1,9]
button_event[dvKP1,10]
button_event[dvKP1,11]

{
  push:
  {
	to[dvKP1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 2:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-4'";		//Input 4(DVD) Output 3(MAIN BEDROOM)
							SEND_STRING dvPUTRON, "'3V1.'"			 //DVD IN3 TO OUT1 (MAINBEDROOM)
							DVD1 = 1;
							TUNER1 = 0;
							DSTV1 = 0;
							//off [vdvMatrixAudio[3],199]
							send_level vdvMATRIXAUDIO[3],1,128;
			case 1: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
							TUNER1 = 1;
							DVD1 = 0;
							DSTV1 = 0;
							//off [vdvMatrixAudio[3],199]
							send_level vdvMATRIXAUDIO[3],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-3'";		//Input 3(DSTV) Output 2(MAIN BEDROOM)
							SEND_STRING dvPUTRON, "'1V1.'"			 //DSTV IN1 TO OUT1 (MAINBEDROOM)
							DSTV1 = 1;
							DVD1 = 0;
							TUNER1 = 0;
							//off [vdvMatrixAudio[3],199]
							send_level vdvMATRIXAUDIO[3],1,128;
			case 7: IF (DVD1 = 1)
							{
								PULSE [dvDVD,cPlay];
							}
							ELSE IF (DSTV1 = 1)
							{
								PULSE [dvDSTV,cdChUp];
							}
							ELSE IF (TUNER1 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							}
			case 8: IF (DVD1 = 1)
							{
								PULSE [dvDVD,cStop];
							}
							ELSE IF (DSTV1 = 1)
							{
								PULSE [dvDSTV,cdChDn];
							}
							ELSE IF (TUNER1 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							}
			case 9: IF (DVD1 = 1)
							{
								PULSE [dvDVD,cPrev];
							}
							ELSE IF (TUNER1 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							}
			case 10:IF (DVD1 = 1)
							{
								PULSE [dvDVD,cNext];
							}
							ELSE IF (TUNER1 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
							}
			case 11:PULSE[vdvMatrixAudio[3],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvKP1,12]																								//MAIN BEDROOM VOL UP
button_event[dvKP1,13]																								//MAIN BEDROOM VOL DN

{
  hold[1,repeat]:
  {
	to[dvKP1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 12:on[vdvMatrixAudio[3],24]
							wait 5
							{
								off[vdvMatrixAudio[3],24]
							}
			case 13:on[vdvMatrixAudio[3],25]
							wait 5
							{
								off[vdvMatrixAudio[3],25]
							}
		}
  }
}
 
LEVEL_EVENT[dvKP1,2]
{
VOLUME = level.value
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvKP1,1,VOLUME


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

