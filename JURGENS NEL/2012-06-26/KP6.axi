PROGRAM_NAME='KP6'
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

INTEGER DVD6 = 0
INTEGER TUNER6 = 0
INTEGER DSTV6 = 0
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


//--------------------BRAAI AREA ZONE 1---------------//
button_event[dvKP6,1]
button_event[dvKP6,2]
button_event[dvKP6,3]
button_event[dvKP6,4]
button_event[dvKP6,5]
button_event[dvKP6,6]
button_event[dvKP6,7]
button_event[dvKP6,8]
button_event[dvKP6,9]
button_event[dvKP6,10]
button_event[dvKP6,11]

{
  push:
  {
	to[dvKP6,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 2:	SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-4'";		//Input 4(DVD) Output 1(BRAAI AREA)
							DVD6 = 1;
							TUNER6 = 0;
							DSTV6 = 0;
							off [vdvMatrixAudio[1],199]
							send_level vdvMATRIXAUDIO[1],1,128;
			case 1: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
							TUNER6 = 1;
							DVD6 = 0;
							DSTV6 = 0;
							off [vdvMatrixAudio[1],199]
							send_level vdvMATRIXAUDIO[1],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-3'";		//Input 3(DSTV) Output 1(BRAAI AREA)
							DSTV6 = 1;
							DVD6 = 0;
							TUNER6 = 0;
							off [vdvMatrixAudio[1],199]
							send_level vdvMATRIXAUDIO[1],1,128;
			case 7: IF (DVD6 = 1)
							{
								PULSE [dvDVD,cPlay];
							}
							ELSE IF (DSTV6 = 1)
							{
								PULSE [dvDSTV,cdChUp];
							}
							ELSE IF (TUNER6 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							}
			case 8: IF (DVD6 = 1)
							{
								PULSE [dvDVD,cStop];
							}
							ELSE IF (DSTV6 = 1)
							{
								PULSE [dvDSTV,cdChDn];
							}
							ELSE IF (TUNER6 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							}
			case 9: IF (DVD6 = 1)
							{
								PULSE [dvDVD,cPrev];
							}
							ELSE IF (TUNER6 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							}
			case 10:IF (DVD6 = 1)
							{
								PULSE [dvDVD,cNext];
							}
							ELSE IF (TUNER6 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
							}
			case 11:PULSE[vdvMatrixAudio[1],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvKP6,12]																								//BRAAI AREA VOL UP
button_event[dvKP6,13]																								//BRAAI AREA VOL DN

{
  hold[1,repeat]:
  {
	to[dvKP6,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 12:on[vdvMatrixAudio[1],24]
							wait 5
							{
								off[vdvMatrixAudio[1],24]
							}
			case 13:on[vdvMatrixAudio[1],25]
							wait 5
							{
								off[vdvMatrixAudio[1],25]
							}
		}
  }
}
 
LEVEL_EVENT[dvKP6,2]
{
VOLUME = level.value
}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvKP6,1,VOLUME

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

