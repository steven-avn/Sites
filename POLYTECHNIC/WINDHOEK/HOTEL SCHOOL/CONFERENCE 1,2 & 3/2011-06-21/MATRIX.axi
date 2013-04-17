PROGRAM_NAME='MATRIX'
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

dvPUTRON		=		5001:1:1												//PUTRON MVG88 VGA/AUDIO MATRIX

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

SEND_COMMAND dvPUTRON,'SET BAUD,9600,N,8,1'		 	 //PUTRON SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

/////////////////////EVENTS FOR KEYPAD 1 TRAINING ROOM 1///////////////////////
BUTTON_EVENT[dvKP1,1]																		//COMBINE AUDIO OUTPUTS
BUTTON_EVENT[dvKP1,2]																		//SINGLE AUDIO ROUTING
BUTTON_EVENT[dvKP1,3]																		//SINGLE AUDIO/VIDEO ROUTING
BUTTON_EVENT[dvKP1,4]																		//SINGLE AUDIO/VIDEO ROUTING	

{
  PUSH:
  {
		TO[dvKP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 1: SEND_STRING dvPUTRON, "'4A7,8.'"			//COMBINE AUDIO IN4 TO OUT7&8
								SEND_STRING dvPUTRON, "'5A7,8.'"			//COMBINE AUDIO IN5 TO OUT7,8
				
				CASE 2: SEND_STRING dvPUTRON, "'4A7.'"			 	//SINGLE AUDIO IN4 TO OUT7
								SEND_STRING dvPUTRON, "'5A8.'"			 	//SINGLE AUDIO IN5 TO OUT8
								
				CASE 3: SEND_STRING dvPUTRON, "'1V8.'"			 	//DSTV IN1 TO OUT8 (VIDEO)
								SEND_STRING dvPUTRON, "'1A7.'"			 	//DSTV IN2 TO OUT7 (AUDIO)
									
				CASE 4: SEND_STRING dvPUTRON, "'2V8.'"				//DVD IN1 TO OUT8 (VIDEO)
								SEND_STRING dvPUTRON, "'2A7.'"				//DVD IN2 TO OUT7 (AUDIO)
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

