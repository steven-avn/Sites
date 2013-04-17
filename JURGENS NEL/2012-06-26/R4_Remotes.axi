PROGRAM_NAME='R4_Remotes'
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

//--------------------R4 REMOTE 1 MAIN BEDROOM---------------//
button_event[dvR4_1,1]
button_event[dvR4_1,2]
button_event[dvR4_1,3]
button_event[dvR4_1,6]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 1:	SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-3'";		//Input 3(DSTV) Output 3(MAIN BEDROOM)
							SEND_STRING dvPUTRON, "'1V1.'"			 //DSTV1 IN1 TO OUT1 (MAINBEDROOM)
							off [vdvMatrixAudio[3],199]
							send_level vdvMATRIXAUDIO[3],1,128;
			case 2: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUTSELECT-4'";		//Input 4(DVD) Output 3(MAIN BEDROOM)
							SEND_STRING dvPUTRON, "'3V1.'"			 //DVD IN3 TO OUT1 (MAINBEDROOM)
							off [vdvMatrixAudio[3],199]
							send_level vdvMATRIXAUDIO[3],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[3],"'INPUT-INTERNAL TUNER,1'";
							off [vdvMatrixAudio[3],199]
							send_level vdvMATRIXAUDIO[3],1,128;
			case 6:	PULSE[vdvMatrixAudio[3],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvR4_1,4]																								//MAIN BEDROOM VOL UP
button_event[dvR4_1,5]																								//MAIN BEDROOM VOL DN

{
	hold[1,repeat]:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 4:on[vdvMatrixAudio[3],24]
							wait 5
							{
								off[vdvMatrixAudio[3],24]
							}
			case 5:on[vdvMatrixAudio[3],25]
							wait 5
							{
								off[vdvMatrixAudio[3],25]
							}
		}
  }
}
 
//--------------------R4 REMOTE 2 BRAAI AREA ---------------//
button_event[dvR4_2,1]
button_event[dvR4_2,2]
button_event[dvR4_2,3]
button_event[dvR4_2,6]

{
  push:
  {
	to[dvR4_2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 1:	SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-3'";		//Input 3(DSTV) Output 3(BRAAI AREA)
							off [vdvMatrixAudio[1],199]
							send_level vdvMATRIXAUDIO[1],1,128;
			case 2: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUTSELECT-4'";		//Input 4(DVD) Output 3(BRAAI AREA)
							off [vdvMatrixAudio[1],199]
							send_level vdvMATRIXAUDIO[1],1,128;
			case 3: SEND_COMMAND vdvMATRIXAUDIO[1],"'INPUT-INTERNAL TUNER,1'";
							off [vdvMatrixAudio[1],199]
							send_level vdvMATRIXAUDIO[1],1,128;
			case 6:	PULSE[vdvMatrixAudio[1],26]					//CYCLE VOLUME MUTE
		}
  }
}

button_event[dvR4_2,4]																								//BRAAI AREA VOL UP
button_event[dvR4_2,5]																								//BRAAI AREA VOL DN

{
	hold[1,repeat]:
  {
	to[dvR4_2,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 4:on[vdvMatrixAudio[1],24]
							wait 5
							{
								off[vdvMatrixAudio[1],24]
							}
			case 5:on[vdvMatrixAudio[1],25]
							wait 5
							{
								off[vdvMatrixAudio[1],25]
							}
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