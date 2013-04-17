PROGRAM_NAME='DENON'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/17/2012  AT: 10:22:29        *)
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

//dvTP_DENON					=		10001:5:0		// Touch Panel
//dvDenonRec					=		5001:1:0		// DENON DNF650R RECORDER RS232

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

VOLATILE INTEGER TPDENONBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,
																  11,12,13,14,15,16,17,18}


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



DEFINE_CALL 'DenonMark'		// DENON RECORDER ADD MARK
{
		SEND_STRING dvDenonRec, "$40,$30,$32,$33,$31,$32,$31,$0D";	//"'@023121',$0D";
		ON[dvTP_DENON,8];
		WAIT 200;
		OFF[dvTP_DENON,8];
		SEND_STRING 0, "'MARK ADDED'";
}

DEFINE_CALL 'DenonPause'		// DENON RECORDER PAUSE
{
		SEND_STRING dvDenonRec, "$40,$30,$32,$33,$34,$38,$0D";	//"'@02348',$0D";
		OFF[dvTP_DENON,5];
		ON[dvTP_DENON,6];
		OFF[dvTP_DENON,7];
		SEND_STRING 0, "'PAUSED'";
}


DEFINE_CALL 'DenonStop'		// DENON RECORDER STOP
{
		SEND_STRING dvDenonRec, "$40,$30,$32,$33,$35,$34,$0D";//"'@02354',$0D";
		ON[dvTP_DENON,5];
		OFF[dvTP_DENON,6];
		OFF[dvTP_DENON,7];
		SEND_STRING 0, "'STOPPED'";
}

DEFINE_CALL 'DenonRecord'		// DENON RECORDER RECORD
{
		SEND_STRING dvDenonRec, "$40,$30,$32,$33,$35,$35,$0D";	//"'@02355',$0D";
		OFF[dvTP_DENON,5];
		OFF[dvTP_DENON,6];
		ON[dvTP_DENON,7];
		SEND_STRING 0, "'RECORDING'";
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

//SEND_COMMAND dvDenonRec,'SET BAUD,9600,N,8,1'		// DENON

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvTP_DENON,TPDENONBUTTONS]
{
		PUSH:
		{
				TO[dvTP_DENON,BUTTON.INPUT.CHANNEL]
				SWITCH(BUTTON.INPUT.CHANNEL)
				{
						CASE 1: CALL 'DenonRecord'		// DENON RECORDER RECORD
						CASE 2: CALL 'DenonMark'		// DENON RECORDER ADD MARK
						CASE 3: CALL 'DenonPause'		// DENON RECORDER PAUSE
						CASE 4: CALL 'DenonStop'		// DENON RECORDER STOP
				}
		}
}

DATA_EVENT[dvDenonRec]
{
   STRING:
	{
		SEND_STRING 0, DATA.TEXT
	}

   ONLINE:
  {
    SEND_STRING 0, "'DENON ONLINE'";
  }

   OFFLINE:
  {
    SEND_STRING 0, "'DENON OFFLINE'";
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