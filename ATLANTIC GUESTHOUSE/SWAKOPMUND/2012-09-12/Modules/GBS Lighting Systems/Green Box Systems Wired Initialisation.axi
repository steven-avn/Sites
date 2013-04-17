PROGRAM_NAME='Green Box Systems Wired Initialisation'
(*   DATE:11/30/00    TIME:14:01:48    *)
(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  FILE CREATED ON: 08/01/2000 AT: 13:52:19               *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/12/2012  AT: 11:13:31        *)
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

dvGBS_IP_TX_DEVICE		= 0:13:0;
dvGBS_IP_RX_DEVICE		= 0:14:0;
vdvGBS_4_DIMMER_1			= 33001:1:0;
vdvGBS_4_DIMMER_2			= 33002:1:0;
vdvGBS_4_DIMMER_3			= 33003:1:0;
//vdvGBS_4_DIMMER_4			= 33004:1:0;
//vdvGBS_4_DIMMER_5			= 33005:1:0;
//vdvGBS_4_DIMMER_6			= 33006:1:0;

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

VOLATILE DEV			vGBS_DEV_ARRAY[] 				= 	{vdvGBS_4_DIMMER_1,vdvGBS_4_DIMMER_2,vdvGBS_4_DIMMER_3};

VOLATILE INTEGER	vGBS_DEVICE_ID_ARRAY[] 	= 	{7,8,9};		//CHANGE DEVICE ID'S

VOLATILE INTEGER 	GBS_INDIVIDUAL_DEBUGS[] = 	{0,0,0};
VOLATILE INTEGER	GBS_NODE_COUNT 					= 	3;
VOLATILE INTEGER 	GBS_DEBUG 							= 	0;
VOLATILE INTEGER 	GBS_LIGHTING_LEVELS[64][48];
VOLATILE INTEGER 	GBS_SWITCH_STATES[64][48];
VOLATILE INTEGER  GBS_MODULE_VERSION;
VOLATILE INTEGER	GBS_IP_PORT 						= 	6000;
VOLATILE CHAR			GBS_TX_IP_ADDRESS[] 		= 	'192.168.1.111';
volatile integer Room1Lights = 0
volatile integer Room2Lights = 0
//volatile integer Screen = 0
//volatile integer Curtain1 = 0
//volatile integer Curtain2 = 0

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

define_module 'GBSCommMod' EXAMPLE_INSTANCE (vGBS_DEV_ARRAY, vGBS_DEVICE_ID_ARRAY, GBS_NODE_COUNT, dvGBS_IP_TX_DEVICE, dvGBS_IP_RX_DEVICE, GBS_TX_IP_ADDRESS, GBS_IP_PORT, GBS_LIGHTING_LEVELS, GBS_SWITCH_STATES, GBS_MODULE_VERSION, GBS_DEBUG, GBS_INDIVIDUAL_DEBUGS);

(***********************************************************)
(*                THE EVENTS GOES BELOW                    *)
(***********************************************************)
DEFINE_EVENT

define_call 'AllLightsOn'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)"
	 Room1Lights = 1

	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(100)"
	 Room2Lights = 1
}

define_call 'AllLightsOff'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(0)"
	 Room1Lights = 0

	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(0)"
	 Room2Lights = 0
}

define_call '1SingleLightsOn'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(100)"
	 Room1Lights = 1
}

define_call '1SingleLightsOff'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(0)"
	 Room1Lights = 0
}

define_call '2SingleLightsOn'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(100)"
	 Room2Lights = 1
}

define_call '2SingleLightsOff'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(0)"
	 Room2Lights = 0
}

define_call 'CombinePresentation'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)"

	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(100)"
	 Room1Lights = 1
	 Room2Lights = 1
}

define_call 'CombineOn'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)"

	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(100)"
	 Room1Lights = 1
	 Room2Lights = 1
}

define_call '1SingleLightsPresentation'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(100)"
	 Room1Lights = 1
}

define_call '2SingleLightsPresentation'
{
	 send_command vGBS_DEV_ARRAY[1],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[1],"'L:[4]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[2]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(100)"
	 Room2Lights = 1
}

define_call 'Rm2CurtainOpen'
{
	 send_command vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(0)"
	 wait 20
	 send_command vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(0)"
}

define_call 'Rm2CurtainClose'
{
	 send_command vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(100)"
	 send_command vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)"
	 wait 20
	 send_command vGBS_DEV_ARRAY[3],"'L:[4]:',ITOA(0)"
	 send_command vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)"
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)

DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)