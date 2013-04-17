(*********************************************************************)
(*  AMX Corporation                                                  *)
(*  Copyright (c) 2004-2006 AMX Corporation. All rights reserved.    *)
(*********************************************************************)
(* Copyright Notice :                                                *)
(* Copyright, AMX, Inc., 2004-2007                                   *)
(*    Private, proprietary information, the sole property of AMX.    *)
(*    The contents, ideas, and concepts expressed herein are not to  *)
(*    be disclosed except within the confines of a confidential      *)
(*    relationship and only then on a need to know basis.            *)
(*********************************************************************)
PROGRAM_NAME = 'NEC NPV260W Main' 
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 7/29/2008 3:24:54 PM                     *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
vdvNECNPV260W = 41001:1:0  	// Virtual Duet device
dvNECNPV260WTp = 10001:1:0 	// Touch panel
//dvNECNPV260W = 5001:1:0 		// Serial connection
dvNECNPV260W = 0:3:0 		// IP Connection
dvKP = 85:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

DEV vdvDev[] = {vdvNECNPV260W}

// ----------------------------------------------------------
// CURRENT DEVICE NUMBER ON TP NAVIGATION BAR
INTEGER nNECNPV260W = 1

// ----------------------------------------------------------
// DEFINE THE PAGES THAT YOUR COMPONENTS ARE USING IN THE 
// SUB NAVIGATION BAR HERE
INTEGER nNECNPV260WPages[] = { 1 }
INTEGER nLampPages[] = { 2 }
INTEGER nDisplayPages[] = { 3,4,5 }
INTEGER nSourceSelectPages[] = { 6 }
INTEGER nVolumePages[] = { 7 }
INTEGER nMenuPages[] = { 8,9,10 }
INTEGER nModulePages[] = { 11 }
INTEGER nZonePages[] = {12}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START


// ----------------------------------------------------------
// DEVICE MODULE GROUPS SHOULD ALL HAVE THE SAME DEVICE NUMBER
DEFINE_MODULE 'NEC NPV260W DisplayComponent' display(vdvDev, dvNECNPV260WTp, nNECNPV260W, nDisplayPages)
DEFINE_MODULE 'NEC NPV260W LampComponent' lamp(vdvDev, dvNECNPV260WTp, nNECNPV260W, nLampPages)
DEFINE_MODULE 'NEC NPV260W MenuComponent' menu(vdvDev, dvNECNPV260WTp, nNECNPV260W, nMenuPages)
DEFINE_MODULE 'NEC NPV260W ModuleComponent' module(vdvDev, dvNECNPV260WTp, nNECNPV260W, nModulePages)
DEFINE_MODULE 'NEC NPV260W SourceSelectComponent' sourceselect(vdvDev, dvNECNPV260WTp, nNECNPV260W, nSourceSelectPages)
DEFINE_MODULE 'NEC NPV260W VideoProjectorComponent' NECNPV260W(vdvDev, dvNECNPV260WTp, nNECNPV260W, nNECNPV260WPages)
DEFINE_MODULE 'NEC NPV260W VolumeComponent' volume(vdvDev, dvNECNPV260WTp, nNECNPV260W, nVolumePages)


// Define your communications module here like so:
 DEFINE_MODULE 'NEC_NPV260W_Comm_dr1_0_0' comm(vdvNECNPV260W, dvNECNPV260W)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
DATA_EVENT[vdvNECNPV260W]
{
    ONLINE:
    {
	//#WARN'***************************************************'
	//#WARN'**   Verify PROPERTY-Poll_Time for the module    **'
	//#WARN'**   Verify PROPERTY-Baud_Rate for the module    **'
	//#WARN'**   Verify PROPERTY-IP_Address for the module   **'
	//#WARN'***************************************************'           
	//send_command vdvNECNPV260W, 'PROPERTY-Poll_Time,10000'
	//send_command vdvNECNPV260W, 'PROPERTY-Baud_Rate,38400'
	send_command vdvNECNPV260W, 'PROPERTY-IP_Address,192.168.0.10'
	send_command vdvNECNPV260W, 'REINIT'
    }
}

BUTTON_EVENT [dvKP,1]
{
	PUSH:
	{
		ON [vdvNECNPV260W,255];
	}
}

BUTTON_EVENT [dvKP,2]
{
	PUSH:
	{
		OFF [vdvNECNPV260W,255];
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

