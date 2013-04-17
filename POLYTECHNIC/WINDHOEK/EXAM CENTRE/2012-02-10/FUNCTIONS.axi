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
}

DEFINE_CALL 'Projector1_Off'		//PROJECTOR OFF
{
	 PULSE [dvSCREENS,SCREEN1_UP]
	 SEND_COMMAND dvPROJ1,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ1, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
}

DEFINE_CALL 'Projector2_On'		//PROJECTOR ON
{
	 PULSE [dvSCREENS,SCREEN2_DOWN]
	 SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
	 WAIT 50
	 SEND_STRING dvPROJ2, "$A9,$17,$2E,$00,$00,$00,$3F,$9A"		//ON
}

DEFINE_CALL 'Projector2_Off'		//PROJECTOR OFF
{
	 PULSE [dvSCREENS,SCREEN2_UP]
	 SEND_COMMAND dvPROJ2,'SET BAUD,38400,E,8,1,DISABLE'		//SONY EX-100
	 WAIT 50
	 SEND_STRING dvPROJ2, "$A9,$17,$2F,$00,$00,$00,$3F,$9A"		//OFF
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