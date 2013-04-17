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
vdvGBS_4_DIMMER_1					= 34011:1:0;		//DIMMER 1 DB1 PLANTROOM(4CH)
vdvGBS_4_DIMMER_2					= 34012:1:0;		//DIMMER 2 DB1 PLANTROOM(4CH)
vdvGBS_4_DIMMER_3					= 34013:1:0;		//RELAY 1 DB1 PLANTROOM(8CH)
vdvGBS_4_DIMMER_4					= 34014:1:0;		//RELAY 2 DB1 PLANTROOM(8CH)
vdvGBS_4_DIMMER_5					= 34015:1:0;		//DIMMER 3 DB2 KITCHEN(4CH)
vdvGBS_4_DIMMER_6					= 34016:1:0;		//RELAY 3 DB2 KITCHEN(8CH)
vdvGBS_4_DIMMER_7					= 34017:1:0;		//RELAY 4 DB2 KITCHEN(4CH)
vdvGBS_4_DIMMER_8					= 34018:1:0;		//DIMMER 4 DB2 KITCHEN(2CH)

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

VOLATILE DEV			vGBS_DEV_ARRAY[] 				= 	{vdvGBS_4_DIMMER_1,vdvGBS_4_DIMMER_2,vdvGBS_4_DIMMER_3,vdvGBS_4_DIMMER_4,vdvGBS_4_DIMMER_5,vdvGBS_4_DIMMER_6,vdvGBS_4_DIMMER_7,vdvGBS_4_DIMMER_8}; //ADD THE DEVICES AS NECESARRY
VOLATILE INTEGER	vGBS_DEVICE_ID_ARRAY[] 	= 	{12,13,14,15,16,17,18,19};	//ADD DEVICE ID AS PER ABOVE
VOLATILE INTEGER 	GBS_INDIVIDUAL_DEBUGS[] = 	{0,0};
VOLATILE INTEGER	GBS_NODE_COUNT 					= 	8;	//INDICATES HOW MANY DEVICES IS CONNECTED
VOLATILE INTEGER 	GBS_DEBUG 							= 	0;
VOLATILE INTEGER 	GBS_LIGHTING_LEVELS[64][48];
VOLATILE INTEGER 	GBS_SWITCH_STATES[64][48];
VOLATILE INTEGER  GBS_MODULE_VERSION;
VOLATILE INTEGER	GBS_IP_PORT 						= 	6000;
VOLATILE CHAR			GBS_TX_IP_ADDRESS[] 		= 	'192.168.1.251';	//IP ADDRESS OF HYBRID

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