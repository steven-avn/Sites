PROGRAM_NAME='Alarm'
(***********************************************************)
(*  FILE CREATED ON: 10/03/2012  AT: 10:55:17              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/10/2012  AT: 13:57:30        *)
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

dvAlarm       = 5001:4:0
dvAlarmTP     = 10001:8:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

DEFINE_COMBINE

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

SEND_COMMAND dvAlarm,'SET BAUD,9600,N,8,1'		//NX-587E SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

BUTTON_EVENT[dvAlarmTP,2]	// Alarm arm
{
  PUSH:
  {
		send_string dvAlarm,'1234';		// Arm away mode no delay code 1234
		send_string 0, 'alarm arm 1234';
		on [dvAlarmTP,6];
		off [dvAlarmTP,7];
	}
}

BUTTON_EVENT[dvAlarmTP,3]	// Alarm disarm
{
  PUSH:
  {
		send_string dvAlarm,'1234';		// Disarm away mode no delay code 1234
		send_string 0, 'alarm disarm';
	}
}

BUTTON_EVENT[dvAlarmTP,1]	// Alarm stay mode arm
{
  PUSH:
  {
		send_string dvAlarm,'S';		// arm stay mode no delay
		send_string 0, 'alarm stay';
		off [dvAlarmTP,6];
		on [dvAlarmTP,7];
	}
}

DATA_EVENT [dvAlarm]		// State of alarm for partition 1
{
	STRING:
	{
		SEND_STRING 0, DATA.TEXT

		if(find_string(DATA.TEXT,'System Ready',1)) //"$0ADL1  System Ready  $0D$0ADL2Type code to arm$0D"
		{
			off [dvAlarmTP,4];
			off [dvAlarmTP,5];
			off [dvAlarmTP,6];
			off [dvAlarmTP,7];
			send_string 0, 'Alarm says system is ready';
		}
		else if(find_string(DATA.TEXT,'Armed',1))	//"$0ADL1  System Armed  $0D$0ADL2All Zones Secure$0D"
		{
			on [dvAlarmTP,5];
			send_string 0, 'Alarm says system armed';
		}
		else if(find_string(DATA.TEXT,'Not Ready',1))	//"$0ADL1System Not Ready$0D$0ADL2For help, press~$0D"
		{
			on [dvAlarmTP,4];
			send_string 0, 'Alarm says system is NOT ready'; 
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