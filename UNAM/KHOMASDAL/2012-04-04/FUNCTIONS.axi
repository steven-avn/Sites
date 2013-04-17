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
	CLIENT: UNAM KHOMASDAL LECTURE HALLS
	
	MASTER (NI-2100) IP: 192.168.1.101
	TP1 (NXD-430) IP: 192.168.1.102
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


DEFINE_CALL 'Main1_VolUp'		//MAIN VOLUME UP
{
	 SEND_STRING dvCLOUD1,'<MU,LU1/>'		//MAIN VOLUME UP
	 while (VOL_LEVEL1 >= 0 && VOL_LEVEL1 < 48)
	 {
			VOL_LEVEL1 = VOL_LEVEL1 + 2
			send_level dvTP1,1,VOL_LEVEL1
	 }
}

DEFINE_CALL 'Main1_VolDown'		//MAIN VOLUME DOWN
{
	 SEND_STRING dvCLOUD1,'<MU,LD1/>'		//MAIN VOLUME DOWN
	 while (VOL_LEVEL1 >= 0 && VOL_LEVEL1 < 48)
	 {
			VOL_LEVEL1 = VOL_LEVEL1 - 2
			send_level dvTP1,1,VOL_LEVEL1
	 }
}

DEFINE_CALL 'Main1_MicUp'		//MAIN MIC UP
{
	 SEND_STRING dvCLOUD1,'<MI,LU1/>'		//MAIN MIC UP
	 while (MIC_LEVEL1 >= 0 && MIC_LEVEL1 < 48)
	 {
			MIC_LEVEL1 = MIC_LEVEL1 + 2
			send_level dvTP1,2,MIC_LEVEL1
	 }
}

DEFINE_CALL 'Main1_MicDown'		//MAIN MIC DOWN
{
	 SEND_STRING dvCLOUD1,'<MI,LD1/>'		//MAIN MIC DOWN
	 while (MIC_LEVEL1 >= 0 && MIC_LEVEL1 < 48)
	 {
			MIC_LEVEL1 = MIC_LEVEL1 - 2
			send_level dvTP1,2,MIC_LEVEL1
	 }
}

DEFINE_CALL 'SmartBoard_On'		//SmartBoard On
{
	 SEND_STRING dvSMART, "'on',$0A,$0D"		//on with carriage return(x0D) and line feed(x0A)
}

DEFINE_CALL 'SmartBoard_Off'		//SmartBoard Off
{
	 SEND_STRING dvSMART, "'off',$0D,$0A"		//off with carriage return(x0D) and line feed(x0A)
	 WAIT 100
	 SEND_STRING dvSMART, "'off',$0D,$0A"		//off with carriage return(x0D) and line feed(x0A)
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