PROGRAM_NAME='KP2'
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

INTEGER DVD2 = 0
INTEGER TUNER2 = 0
INTEGER DSTV2 = 0
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


//--------------------MAIN BATHROOM ZONE 4---------------//
button_event[dvKP2,1]
button_event[dvKP2,2]
button_event[dvKP2,3]
button_event[dvKP2,4]
button_event[dvKP2,5]
button_event[dvKP2,6]
button_event[dvKP2,7]
button_event[dvKP2,8]
button_event[dvKP2,9]
button_event[dvKP2,10]
button_event[dvKP2,11]

{
  push:
  {
	to[dvKP2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 2:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-4'";		//Input 4(DVD) Output 4(MAIN BATHROOM)
							DVD2 = 1;
							TUNER2 = 0;
							DSTV2 = 0;
							//off [vdvMatrixAudio[4],199]
							send_level vdvMATRIXAUDIO[4],1,128;
			case 1: SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							TUNER2 = 1;
							DVD2 = 0;
							DSTV2 = 0;
							//off [vdvMatrixAudio[4],199]
							send_level vdvMATRIXAUDIO[4],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUTSELECT-3'";		//Input 3(DSTV) Output 4(MAIN BATHROOM)
							DSTV2 = 1;
							DVD2 = 0;
							TUNER2 = 0;
							//off [vdvMatrixAudio[4],199]
							send_level vdvMATRIXAUDIO[4],1,128;
			case 7: IF (DVD2 = 1)
							{
								PULSE [dvDVD,cPlay];
							}
							ELSE IF (DSTV2 = 1)
							{
								PULSE [dvDSTV,cdChUp];
							}
							ELSE IF (TUNER2 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							}
			case 8: IF (DVD2 = 1)
							{
								PULSE [dvDVD,cStop];
							}
							ELSE IF (DSTV2 = 1)
							{
								PULSE [dvDSTV,cdChDn];
							}
							ELSE IF (TUNER2 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							}
			case 9: IF (DVD2 = 1)
							{
								PULSE [dvDVD,cPrev];
							}
							ELSE IF (TUNER2 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							}
			case 10:IF (DVD2 = 1)
							{
								PULSE [dvDVD,cNext];
							}
							ELSE IF (TUNER2 = 1)
							{
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
							}
			case 11:PULSE[vdvMatrixAudio[4],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvKP2,12]																								//MAIN BATHROOM VOL UP
button_event[dvKP2,13]																								//MAIN BATHROOM VOL DN

{
  hold[1,repeat]:
  {
	to[dvKP2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 12:on[vdvMatrixAudio[4],24]
							wait 5
							{
								off[vdvMatrixAudio[4],24]
							}
			case 13:on[vdvMatrixAudio[4],25]
							wait 5
							{
								off[vdvMatrixAudio[4],25]
							}
		}
  }
}
 
LEVEL_EVENT[dvKP2,2]
{
VOLUME = level.value
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvKP2,1,VOLUME


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

