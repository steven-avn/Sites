PROGRAM_NAME='FUNCTIONS'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: POLYTECHNIC EXAM CENTRE
	
	MASTER (NI-2100) IP: 192.168.1.101
	TP1 (NXD-430) IP: 192.168.1.102
	TP2 (NXD-430) IP: 192.168.1.103
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

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

DEFINE_CALL 'Projector1_On'		//PROJECTOR ON
{
	 PULSE [dvSCREENS,SCREEN1_DOWN]
	 SEND_COMMAND dvPROJ1,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ1, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 WAIT 50
	 SEND_STRING dvPROJ1, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
}

DEFINE_CALL 'Projector1_Off'		//PROJECTOR OFF
{
	 PULSE [dvSCREENS,SCREEN1_UP]
	 SEND_COMMAND dvPROJ1,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ1, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
	 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
}

DEFINE_CALL 'Projector2_On'		//PROJECTOR ON
{
	 PULSE [dvSCREENS,SCREEN2_DOWN]
	 SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 WAIT 50
	 SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 SEND_STRING dvCLOUD2, '<MU,O/>'		//MAIN UNMUTE
}

DEFINE_CALL 'Projector2_Off'		//PROJECTOR OFF
{
	 PULSE [dvSCREENS,SCREEN2_UP]
	 SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ2, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
 	 SEND_STRING dvCLOUD2, '<MU,M/>'		//MAIN MUTE
}

DEFINE_CALL 'Main1_VolUp'		//MAIN HALL VOLUME UP
{
	 SEND_STRING dvCLOUD1,'<MU,LU1/>'		//MAIN VOLUME UP
	 VOL_LEVEL1 = VOL_LEVEL1 + 2
	 SEND_LEVEL dvTP1,1,VOL_LEVEL1
}

DEFINE_CALL 'Main1_VolDown'		//MAIN HALL VOLUME DOWN
{
	 SEND_STRING dvCLOUD1,'<MU,LD1/>'		//MAIN VOLUME DOWN
	 VOL_LEVEL1 = VOL_LEVEL1 - 2
	 SEND_LEVEL dvTP1,1,VOL_LEVEL1
}

DEFINE_CALL 'Main1_MicUp'		//MAIN HALL MIC UP
{
	 SEND_STRING dvCLOUD1,'<MI,LU1/>'		//MAIN VOLUME UP
	 MIC_LEVEL1 = MIC_LEVEL1 + 2
	 SEND_LEVEL dvTP1,2,MIC_LEVEL1
}

DEFINE_CALL 'Main1_MicDown'		//MAIN HALL MIC DOWN
{
	 SEND_STRING dvCLOUD1,'<MI,LD1/>'		//MAIN VOLUME DOWN
	 MIC_LEVEL1 = MIC_LEVEL1 - 2
	 SEND_LEVEL dvTP1,2,MIC_LEVEL1
}

DEFINE_CALL 'Hall2_VolUp'		//SMALL HALL VOLUME UP
{
	 SEND_STRING dvCLOUD2,'<MU,LU1/>'		//SMALL VOLUME UP
	 VOL_LEVEL2 = VOL_LEVEL2 + 2
	 SEND_LEVEL dvTP2,1,VOL_LEVEL2
}

DEFINE_CALL 'Hall2_VolDown'		//SMALL HALL VOLUME DOWN
{
	 SEND_STRING dvCLOUD2,'<MU,LD1/>'		//SMALL VOLUME DOWN
	 VOL_LEVEL2 = VOL_LEVEL2 - 2
	 SEND_LEVEL dvTP2,1,VOL_LEVEL2
}

DEFINE_CALL 'Hall2_MicUp'		//SMALL HALL MIC UP
{
	 SEND_STRING dvCLOUD2,'<MI,LU1/>'		//SMALL VOLUME UP
	 MIC_LEVEL2 = MIC_LEVEL2 + 2
	 SEND_LEVEL dvTP2,2,MIC_LEVEL2
}

DEFINE_CALL 'Hall2_MicDown'		//SMALL HALL MIC DOWN
{
	 SEND_STRING dvCLOUD2,'<MI,LD1/>'		//SMALL VOLUME DOWN
	 MIC_LEVEL2 = MIC_LEVEL1 - 2
	 SEND_LEVEL dvTP2,2,MIC_LEVEL2
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)