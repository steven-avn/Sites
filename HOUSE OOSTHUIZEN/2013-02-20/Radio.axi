PROGRAM_NAME='Radio'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
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

INTEGER RADIO_BUTTONS[] =  {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
													 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,
													 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,
													 48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,
													 64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,
													 80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,
													 96,97,98,99,100,101,102,103,104,105,106,107,108,
													 109,110
													 }

/*
 *	RADIO WAVE - 96.7 / 87.8
 *	RADIO KOSMOS - 94.1
 *	RADIO KUDU - 103.5
 *	RADIO ENERGY - 100.0
 *	RADIO 99 - 99.0
 *	NBC AFRIKAANS - 88.6
 *	GERMAN RADIO - 99.8
 *	KANAAL 7 - 102.3
 *
 */

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

SET_PULSE_TIME (2)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//--------------------------TOUCH PANEL------------------//
BUTTON_EVENT[dvTP_RADIO,RADIO_BUTTONS]
{
  PUSH:
	 {
			TO[dvTP_RADIO,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 31:	SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
			CASE 32:	SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
			CASE 33:	SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-95.8'";
								SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
			CASE 34:	SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
			CASE 35:	SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[9],1,179;
			CASE 36:	SEND_COMMAND vdvMATRIXAUDIO[9],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[9],1,179;

			CASE 51:	SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
			CASE 52:	SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
			CASE 53:	SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-95.8'";
								SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
			CASE 54:	SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
			CASE 55:	SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[11],1,179;
			CASE 56:	SEND_COMMAND vdvMATRIXAUDIO[11],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[11],1,179;

			CASE 71:	SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
			CASE 72:	SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
			CASE 73:	SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-95.8'";
								SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
			CASE 74:	SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
			CASE 75:	SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[7],1,179;
			CASE 76:	SEND_COMMAND vdvMATRIXAUDIO[7],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[7],1,179;

			CASE 81:	SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
			CASE 82:	SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
			CASE 83:	SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-95.8'";
								SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
			CASE 84:	SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
			CASE 85:	SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[8],1,179;
			CASE 86:	SEND_COMMAND vdvMATRIXAUDIO[8],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[8],1,179;

//			CASE 91:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 92:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 93:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-95.8'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 94:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 95:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 96:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;

//			CASE 101:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 102:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 103:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-95.8'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 104:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 105:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
//			CASE 106:	SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
//								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
//								SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
			}
	 }
}

//-------------------------REMOTE-----------------------//
BUTTON_EVENT[dvR4_Radio_MainBedrm,RADIO_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_Radio_MainBedrm,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 45:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,179;
			CASE 41:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,179;
			CASE 42:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,179;
			CASE 44:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,179;
			CASE 43:	SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[4],1,179;
			}
	 }
}

//-------------------------REMOTE-----------------------//
BUTTON_EVENT[dvR4_Radio_Bedrm2,RADIO_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_Radio_Bedrm2,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 45:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
			CASE 41:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
			CASE 42:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
			CASE 44:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
			CASE 43:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[3],1,179;
			}
	 }
}

//-------------------------REMOTE-----------------------//
BUTTON_EVENT[dvR4_Radio_Bedrm1,RADIO_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_Radio_Bedrm1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 45:	SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
			CASE 41:	SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
			CASE 42:	SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
			CASE 44:	SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
			CASE 43:	SEND_COMMAND vdvMATRIXAUDIO[2],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[2],1,179;
			}
	 }
}

//-------------------------REMOTE-----------------------//
BUTTON_EVENT[dvR4_Radio_FamTvRm,RADIO_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_Radio_FamTvRm,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 45:	SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-87.8'";
								SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
			CASE 41:	SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
								SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
			CASE 42:	SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
								SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
			CASE 44:	SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-88.6'";
								SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
			CASE 43:	SEND_COMMAND vdvMATRIXAUDIO[10],"'INPUT-INTERNAL TUNER,1'";
								SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.5'";
								SEND_LEVEL vdvMATRIXAUDIO[10],1,179;
			}
	 }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)