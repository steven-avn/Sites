PROGRAM_NAME='KP3'
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

INTEGER DVD3 = 0
INTEGER TUNER3 = 0
INTEGER DSTV3 = 0
INTEGER STATION = 0
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


//--------------------LOUNGE ZONE 2---------------//
button_event[dvKP3,1]
button_event[dvKP3,2]
button_event[dvKP3,3]
button_event[dvKP3,4]
button_event[dvKP3,5]
button_event[dvKP3,6]
button_event[dvKP3,7]
button_event[dvKP3,8]
button_event[dvKP3,9]
button_event[dvKP3,10]
button_event[dvKP3,11]

{
  push:
  {
	to[dvKP3,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 2:	SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-4'";		//Input 4(DVD) Output 2(LOUNGE)
							DVD3 = 1;
							TUNER3 = 0;
							DSTV3 = 0;
							//off [vdvMatrixAudio[2],199]
							send_level vdvMATRIXAUDIO[2],1,128;
			case 1: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
							TUNER3 = 1;
							DVD3 = 0;
							DSTV3 = 0;
							//off [vdvMatrixAudio[2],199]
							send_level vdvMATRIXAUDIO[2],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUTSELECT-3'";		//Input 3(DSTV) Output 2(LOUNGE)
							DSTV3 = 1;
							DVD3 = 0;
							TUNER3 = 0;
							//off [vdvMatrixAudio[2],199]
							send_level vdvMATRIXAUDIO[2],1,128;
			case 7: IF (DVD3 = 1)
							{
								PULSE [dvDVD,cPlay];
							}
							ELSE IF (DSTV3 = 1)
							{
								PULSE [dvDSTV,cdChUp];
							}
							ELSE IF (TUNER3 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							}
			case 8: IF (DVD3 = 1)
							{
								PULSE [dvDVD,cStop];
							}
							ELSE IF (DSTV3 = 1)
							{
								PULSE [dvDSTV,cdChDn];
							}
							ELSE IF (TUNER3 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							}
			case 9: IF (DVD3 = 1)
							{
								PULSE [dvDVD,cPrev];
							}
							ELSE IF (TUNER3 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							}
			case 10:IF (DVD3 = 1)
							{
								PULSE [dvDVD,cNext];
							}
							ELSE IF (TUNER3 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
							}
			case 11:PULSE[vdvMatrixAudio[2],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvKP3,12]																								//LOUNGE VOL UP
button_event[dvKP3,13]																								//LOUNGE VOL DN

{
  hold[1,repeat]:
  {
	to[dvKP3,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 12:on[vdvMatrixAudio[2],24]
							wait 5
							{
								off[vdvMatrixAudio[2],24]
							}
							
			case 13:on[vdvMatrixAudio[2],25]
							wait 5
							{
								off[vdvMatrixAudio[2],25]
							}
		}
  }
}
 
LEVEL_EVENT[dvKP3,2]
{
VOLUME = level.value
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvKP3,1,VOLUME

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

