PROGRAM_NAME='RADIO'
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

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//--------------------R4 REMOTE 1---------------//
button_event[dvR4_1,20]
button_event[dvR4_1,21]
button_event[dvR4_1,22]
button_event[dvR4_1,23]
button_event[dvR4_1,24]
button_event[dvR4_1,25]
button_event[dvR4_1,30]
button_event[dvR4_1,31]
button_event[dvR4_1,32]
button_event[dvR4_1,33]
button_event[dvR4_1,34]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 20:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 21:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 22:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 23:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 24:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 25:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.4'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 30:PULSE[vdvMatrixAudio[1],22]					//NEXT TUNER CH PRESET
			case 31:PULSE[vdvMatrixAudio[1],23]					//PREV TUNER CH PRESET
			case 32:PULSE[vdvMatrixAudio[1],230]				//START TUNER SEEK BACKWARD
			case 33:PULSE[vdvMatrixAudio[1],229]				//START TUNER SEEK FORWARD
			//case 34:PULSE[vdvMatrixAudio[3],26]					//CYCLE VOLUME MUTE
		}
  }
}

//--------------------R4 REMOTE 2---------------//
button_event[dvR4_2,20]
button_event[dvR4_2,21]
button_event[dvR4_2,22]
button_event[dvR4_2,23]
button_event[dvR4_2,24]
button_event[dvR4_2,25]
button_event[dvR4_2,30]
button_event[dvR4_2,31]
button_event[dvR4_2,32]
button_event[dvR4_2,33]
button_event[dvR4_2,34]

{
  push:
  {
	to[dvR4_2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 20:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-94.1'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 21:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-96.7'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 22:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-99.0'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 23:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-100.0'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 24:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-102.7'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 25:SEND_COMMAND vdvMATRIXAUDIO[4],"'INPUT-INTERNAL TUNER,1'";
							SEND_COMMAND vdvMatrixAudio[1],"'XCH-103.4'";
							SEND_LEVEL vdvMATRIXAUDIO[4],1,148;
			case 30:PULSE[vdvMatrixAudio[1],22]					//NEXT TUNER CH PRESET
			case 31:PULSE[vdvMatrixAudio[1],23]					//PREV TUNER CH PRESET
			case 32:PULSE[vdvMatrixAudio[1],230]			//START TUNER SEEK BACKWARD
			case 33:PULSE[vdvMatrixAudio[1],229]				//START TUNER SEEK FORWARD
			//case 34:PULSE[vdvMatrixAudio[3],26]					//CYCLE VOLUME MUTE
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

