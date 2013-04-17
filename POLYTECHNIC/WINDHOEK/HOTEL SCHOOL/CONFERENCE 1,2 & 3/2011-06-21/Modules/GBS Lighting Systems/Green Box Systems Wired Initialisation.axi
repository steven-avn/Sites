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

dvGBS_IP_TX_DEVICE		= 0:13:0;
dvGBS_IP_RX_DEVICE		= 0:14:0;
vdvGBS_4_DIMMER_1			= 33001:1:0;
vdvGBS_4_DIMMER_2			= 33002:1:0;
vdvGBS_4_DIMMER_3			= 33003:1:0;
vdvGBS_4_DIMMER_4			= 33004:1:0;
vdvGBS_4_DIMMER_5			= 33005:1:0;
vdvGBS_4_DIMMER_6			= 33006:1:0;

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

VOLATILE DEV			vGBS_DEV_ARRAY[] 				= 	{vdvGBS_4_DIMMER_1,vdvGBS_4_DIMMER_2,vdvGBS_4_DIMMER_3,vdvGBS_4_DIMMER_4,vdvGBS_4_DIMMER_5,vdvGBS_4_DIMMER_6};

VOLATILE INTEGER	vGBS_DEVICE_ID_ARRAY[] 	= 	{5,6,7,11,12,13};		//CHANGE DEVICE ID'S

VOLATILE INTEGER 	GBS_INDIVIDUAL_DEBUGS[] = 	{0,0,0,0,0,0};
VOLATILE INTEGER	GBS_NODE_COUNT 					= 	6;
VOLATILE INTEGER 	GBS_DEBUG 							= 	0;
VOLATILE INTEGER 	GBS_LIGHTING_LEVELS[64][48];
VOLATILE INTEGER 	GBS_SWITCH_STATES[64][48];
VOLATILE INTEGER  GBS_MODULE_VERSION;
VOLATILE INTEGER	GBS_IP_PORT 						= 	6000;
VOLATILE CHAR			GBS_TX_IP_ADDRESS[] 		= 	'192.168.10.250';

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

//------------------CONFERENCE 1----------------------//
BUTTON_EVENT[dvTP1,1]		//PC1 INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(50)";		//Downlighters1 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		//Fluorescents1 Off
	}
}

BUTTON_EVENT[dvTP1,2]		//DVD INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(50)";		//Downlighters1 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		//Fluorescents1 Off
	}
}

BUTTON_EVENT[dvTP1,4]		//ALL OFF1
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";		//Downlighters1 0%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";		//Fluorescents1 Off
	}
}

BUTTON_EVENT[dvTP1,90]		//PC1 INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";		//Fluorescents1 ON
	}
}

BUTTON_EVENT[dvTP1,91]		//DVD INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		//Fluorescents1 Off
	}
}

//------------------CONFERENCE 2----------------------//
BUTTON_EVENT[dvTP2,47]		//PC2 INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(50)";		//Downlighters 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		//Fluorescents Off
	}
}

BUTTON_EVENT[dvTP2,48]		//DVD INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(50)";		//Downlighters2 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		//Fluorescents2 Off
	}
}

BUTTON_EVENT[dvTP2,49]		//ALL OFF2
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";		//Downlighters2 0%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		//Fluorescents2 Off
	}
}

BUTTON_EVENT[dvTP2,92]		//DVD INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		//Fluorescents2 ON
	}
}

BUTTON_EVENT[dvTP2,93]		//ALL OFF2
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		//Fluorescents2 Off
	}
}

//------------------CONFERENCE 3----------------------//
BUTTON_EVENT[dvTP3,58]		//PC3 INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(50)";		//Downlighters3 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";		//Fluorescents3 Off
	}
}

BUTTON_EVENT[dvTP3,59]		//DVD INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(50)";		//Downlighters3 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";		//Fluorescents3 Off
	}
}

BUTTON_EVENT[dvTP3,60]		//ALL OFF
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[1]:',ITOA(100)";		//Downlighters3 0%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		//Fluorescents3 Off
	}
}

BUTTON_EVENT[dvTP3,94]		//
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(100)";		//Fluorescents3 ON
	}
}

BUTTON_EVENT[dvTP3,95]		//ALL OFF
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[1]:',ITOA(0)";		//Fluorescents3 Off
	}
}

//------------------CONFERENCE COMBINE----------------------//
BUTTON_EVENT[dvTP1,42]		//PC1 & PC2 INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(50)";		//Downlighters1 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		//Fluorescents1 Off
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(50)";		//Downlighters2 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		//Fluorescents2 Off
	}
}

BUTTON_EVENT[dvTP1,43]		//DVD INPUT
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(50)";		//Downlighters1 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		//Fluorescents1 Off
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(50)";		//Downlighters2 50%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		//Fluorescents2 Off
	}
}

BUTTON_EVENT[dvTP1,44]		//ALL OFF
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[2],"'L:[1]:',ITOA(100)";		//Downlighters1 0%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		//Fluorescents1 Off
		SEND_COMMAND vGBS_DEV_ARRAY[1],"'L:[2]:',ITOA(100)";		//Downlighters2 0%
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";		//Fluorescents2 Off
	}
}

BUTTON_EVENT[dvTP1,96]
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(100)";		//Fluorescents1 ON
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(100)";		//Fluorescents2 ON
	}
}

BUTTON_EVENT[dvTP1,97]
{
	PUSH:
	{
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[2]:',ITOA(0)";		//Fluorescents1 Off
		SEND_COMMAND vGBS_DEV_ARRAY[3],"'L:[3]:',ITOA(0)";		//Fluorescents2 Off
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