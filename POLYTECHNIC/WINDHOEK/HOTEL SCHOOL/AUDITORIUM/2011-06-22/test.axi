PROGRAM_NAME='test'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/04/2006  AT: 11:33:16        *)
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

DEV SERIALPORT_1 = {5001:1:0}				//SERIAL PORT 1 ON MASTER
DEV SERIALPORT_2 = {5001:2:0}				//SERIAL PORT 2 ON MASTER
DEV SERIALPORT_3 = {5001:3:0}				//SERIAL PORT 3 ON MASTER


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

///////////////////FOR TESTNG PURPOSES////////////////////////////////////////
DATA_EVENT[SERIALPORT_1]
{
	ONLINE:
	{
		SEND_STRING 0,"'SERIAL PORT ',ITOA(DATA.DEVICE.NUMBER),':',ITOA(DATA.DEVICE.PORT),':',ITOA(DATA.DEVICE.SYSTEM),' HAS COME ONLINE.'"
		SEND_COMMAND DATA.DEVICE, "'GET BAUD'" 
	}
	STRING:
	{
		SEND_STRING 0,"'SERIAL PORT ',ITOA(DATA.DEVICE.NUMBER),':',ITOA(DATA.DEVICE.PORT),':',ITOA(DATA.DEVICE.SYSTEM),' SAID: ',DATA.TEXT"
	}
}

DATA_EVENT[SERIALPORT_2]
{
	ONLINE:
	{
		SEND_STRING 0,"'SERIAL PORT ',ITOA(DATA.DEVICE.NUMBER),':',ITOA(DATA.DEVICE.PORT),':',ITOA(DATA.DEVICE.SYSTEM),' HAS COME ONLINE.'"
		SEND_COMMAND DATA.DEVICE, "'GET BAUD'" 
	}
	STRING:
	{
		SEND_STRING 0,"'SERIAL PORT ',ITOA(DATA.DEVICE.NUMBER),':',ITOA(DATA.DEVICE.PORT),':',ITOA(DATA.DEVICE.SYSTEM),' SAID: ',DATA.TEXT"
	}
}

DATA_EVENT[SERIALPORT_3]
{
	ONLINE:
	{
		SEND_STRING 0,"'SERIAL PORT ',ITOA(DATA.DEVICE.NUMBER),':',ITOA(DATA.DEVICE.PORT),':',ITOA(DATA.DEVICE.SYSTEM),' HAS COME ONLINE.'"
		SEND_COMMAND DATA.DEVICE, "'GET BAUD'" 
	}
	STRING:
	{
		SEND_STRING 0,"'SERIAL PORT ',ITOA(DATA.DEVICE.NUMBER),':',ITOA(DATA.DEVICE.PORT),':',ITOA(DATA.DEVICE.SYSTEM),' SAID: ',DATA.TEXT"
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
