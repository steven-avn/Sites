PROGRAM_NAME='Green Box Systems Wired Initialisation'

(*   DATE:11/30/00    TIME:14:01:48    *)
(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  FILE CREATED ON: 08/01/2000 AT: 13:52:19               *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/15/2003 AT: 18:14:15         *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 0                                *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 05/06/2003                              *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 08/01/2000                              *)
(*                                                         *)
(*  COMMENTS:                                              *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 08/01/2000                              *)
(*                                                         *)
(*  COMMENTS:                                              *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)

(*   DATE:07/25/00    TIME:20:07:21    *)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvGBS_IP_TX_DEVICE 				= 0:13:0;
dvGBS_IP_RX_DEVICE 				= 0:14:0;
vdvGBS_4_DIMMER_1					= 33001:1:0;
vdvGBS_4_DIMMER_2					= 33002:1:0;

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

VOLATILE DEV			vGBS_DEV_ARRAY[] 				= 	{vdvGBS_4_DIMMER_1};
VOLATILE INTEGER	vGBS_DEVICE_ID_ARRAY[] 	= 	{7};
VOLATILE INTEGER 	GBS_INDIVIDUAL_DEBUGS[] = 	{0,0};
VOLATILE INTEGER	GBS_NODE_COUNT 					= 1;
VOLATILE INTEGER 	GBS_DEBUG 							= 0;
VOLATILE INTEGER 	GBS_LIGHTING_LEVELS[64][48];
VOLATILE INTEGER 	GBS_SWITCH_STATES[64][48];
VOLATILE INTEGER  GBS_MODULE_VERSION;
VOLATILE INTEGER	GBS_IP_PORT 						= 6000;
VOLATILE CHAR			GBS_TX_IP_ADDRESS[] 		= '192.168.10.250';

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*           SUBROUTINE DEFINITIONS GO BELOW               *)
(***********************************************************)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

DEFINE_MODULE 'GBSCommMod' EXAMPLE_INSTANCE (vGBS_DEV_ARRAY, vGBS_DEVICE_ID_ARRAY, GBS_NODE_COUNT, dvGBS_IP_TX_DEVICE, dvGBS_IP_RX_DEVICE, GBS_TX_IP_ADDRESS, GBS_IP_PORT, GBS_LIGHTING_LEVELS, GBS_SWITCH_STATES, GBS_MODULE_VERSION, GBS_DEBUG, GBS_INDIVIDUAL_DEBUGS);

(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

(*
BUTTON_EVENT[dTP,1]
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)";
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)";
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(0)";
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(0)";
	}
}

BUTTON_EVENT[dTP,2]
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)";
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)";
	}
}
*)

(*
LEVEL_EVENT[vdvGBS_4_DIMMER_1,1]
{
	iDimmer1Channel1Level = level.value;
}

LEVEL_EVENT[vdvGBS_4_DIMMER_1,2]
{
	iDimmer1Channel2Level = level.value;
}

LEVEL_EVENT[vdvGBS_4_DIMMER_1,3]
{
	iDimmer1Channel3Level = level.value;
}

LEVEL_EVENT[vdvGBS_4_DIMMER_1,4]
{
	iDimmer1Channel4Level = level.value;
}
*)

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)

DEFINE_PROGRAM

(*
WAIT 5
{
	[dTP,1] = ((GBS_LIGHTING_LEVELS[1][1] == 0) AND
						(GBS_LIGHTING_LEVELS[1][2] == 0) AND
						(GBS_LIGHTING_LEVELS[1][3] == 0) AND
						(GBS_LIGHTING_LEVELS[1][4] == 0));
	[dTP,2] = ((GBS_LIGHTING_LEVELS[1][1] == 100) AND
						(GBS_LIGHTING_LEVELS[1][2] == 100) AND
						(GBS_LIGHTING_LEVELS[1][3] == 100) AND
						(GBS_LIGHTING_LEVELS[1][4] == 100));
}
*)

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)