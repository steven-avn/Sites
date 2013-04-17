(*********************************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 06/09/2008  AT: 13:53:35        *)
(***********************************************************)
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
MODULE_NAME = 'Bose ESP88 GainComponent' (dev vdvDev[], dev dvTP, dev dvTPMain, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 6/18/2007 3:14:50 PM                    *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

#include 'Bose ESP88 MainInclude.axi'

#include 'SNAPI.axi'
#include 'G4API.axi'

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

// Channels
BTN_GAIN_LVL_RELEASE            = 3400  // Button: setGain Lvl Release Btn

// Levels

// Variable Text Addresses

/* G4 CHANNELS
BTN_GAIN_MUTE                   = 144   // Button: Gain Mute
BTN_GAIN_UP                     = 140   // Button: Gain Up
BTN_GAIN_DN                     = 141   // Button: Gain Down
*/

/* G4 LEVELS
LVL_GAIN                        = 5     // Level: Gain
*/

/* SNAPI CHANNELS
GAIN_MUTE_ON                    = 143   // Button: setGainMuteOn
*/

/* SNAPI LEVELS
GAIN_LVL                        = 5     // Level: setGain
*/

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT


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

integer nGAIN_LVL[MAX_ZONE] // Stores level values for GAIN_LVL


//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnDeviceChanged
//
// PURPOSE:          This function is used by the device selection BUTTON_EVENT
//                   to notify the module that a device change has occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnDeviceChanged()
{

    println ("'OnDeviceChanged'")
}

//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnPageChanged
//
// PURPOSE:          This function is used by the page selection BUTTON_EVENT
//                   to notify the module that a component change may have occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnPageChanged()
{

    println ("'OnPageChanged'")
}

//---------------------------------------------------------------------------------
//
// FUNCTION NAME:    OnZoneChange
//
// PURPOSE:          This function is used by the zone selection BUTTON_EVENT
//                   to notify the module that a zone change has occurred
//                   allowing updates to the touch panel user interface.
//
//---------------------------------------------------------------------------------
DEFINE_FUNCTION OnZoneChange()
{

    send_level dvTP, LVL_GAIN, nGAIN_LVL[nCurrentZone]

    println ("'OnZoneChange'")
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'GainComponent'
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


(***********************************************************)
(*             TOUCHPANEL EVENTS GO BELOW                  *)
(***********************************************************)
DATA_EVENT [dvTP]
{

    ONLINE:
    {
        bActiveComponent = FALSE
        nActiveDevice = 1
        nActivePage = 0
        nActiveDeviceID = nNavigationBtns[1]
        nActivePageID = 0
        nCurrentZone = 1
        bNoLevelReset = 0

    }
    OFFLINE:
    {
        bNoLevelReset = 1
    }

}


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       DATA_EVENT for vdvDev
//                   GainComponent: data event 
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the GainComponent.
//
// LOCAL VARIABLES:  cHeader     :  SNAPI command header
//                   cParameter  :  SNAPI command parameter
//                   nParameter  :  SNAPI command parameter value
//                   cCmd        :  received SNAPI command
//
//---------------------------------------------------------------------------------
DATA_EVENT[vdvDev]
{
    COMMAND :
    {
        // local variables
        STACK_VAR CHAR    cCmd[DUET_MAX_CMD_LEN]
        STACK_VAR CHAR    cHeader[DUET_MAX_HDR_LEN]
        STACK_VAR CHAR    cParameter[DUET_MAX_PARAM_LEN]
        STACK_VAR INTEGER nParameter
        STACK_VAR CHAR    cTrash[20]
        STACK_VAR INTEGER nZone
        
        nZone = getFeedbackZone(data.device)
        
        // get received SNAPI command
        cCmd = DATA.TEXT
        
        // parse command header
        cHeader = DuetParseCmdHeader(cCmd)
        SWITCH (cHeader)
        {
            // SNAPI::DEBUG-<state>
            CASE 'DEBUG' :
            {
                // This will toggle debug printing
                nDbg = ATOI(DuetParseCmdParam(cCmd))
            }

        }
    }
}


//----------------------------------------------------------
// CHANNEL_EVENTs For GainComponent
//
// The following channel events are used in conjunction
// with the GainComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   GainComponent: channel button - ramping channel
//                   on BTN_GAIN_DN
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the GainComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GAIN_DN]
{
    push:
    {
        if (bActiveComponent)
        {
            on[vdvDev[nCurrentZone], GAIN_DN]
            println (" 'on[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_DN),']'")
        }
    }
    release:
    {
        if (bActiveComponent)
        {
            off[vdvDev[nCurrentZone], GAIN_DN]
            println (" 'off[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_DN),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   GainComponent: channel button - ramping channel
//                   on BTN_GAIN_UP
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the GainComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GAIN_UP]
{
    push:
    {
        if (bActiveComponent)
        {
            on[vdvDev[nCurrentZone], GAIN_UP]
            println (" 'on[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_UP),']'")
        }
    }
    release:
    {
        if (bActiveComponent)
        {
            off[vdvDev[nCurrentZone], GAIN_UP]
            println (" 'off[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_UP),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   GainComponent: channel button - discrete channel
//                   on GAIN_MUTE_ON
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the GainComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, GAIN_MUTE_ON]
{
    push:
    {
        if (bActiveComponent)
        {
            [vdvDev[nCurrentZone],GAIN_MUTE_ON] = ![vdvDev[nCurrentZone],GAIN_MUTE_ON]
            println (" '[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_MUTE_ON),'] = ![',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_MUTE_ON),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   GainComponent: momentary button - momentary channel
//                   on BTN_GAIN_MUTE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the GainComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GAIN_MUTE]
{
    push:
    {
        if (bActiveComponent)
        {
            pulse[vdvDev[nCurrentZone], GAIN_MUTE]
            println (" 'pulse[',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_MUTE),']'")
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   GainComponent: channel button - level
//                   on BTN_GAIN_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input 
//                   on the touch panel and update the GainComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_GAIN_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
            if (!bNoLevelReset)
            {
                send_level vdvDev[nCurrentZone], GAIN_LVL, nGAIN_LVL[nCurrentZone]
				
				
                println (" 'send_level ',dpstoa(vdvDev[nCurrentZone]),', ',itoa(GAIN_LVL),', ',itoa(nGAIN_LVL[nCurrentZone])")
            }
        }
    }
}


//----------------------------------------------------------
// LEVEL_EVENTs For GainComponent
//
// The following level events are used in conjunction
// with the GainComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   GainComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes 
//                   and update the GainComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, GAIN_LVL]
{
    if (bActiveComponent)
    {
        if (!bNoLevelReset)
        {
            nGAIN_LVL[nCurrentZone] = Level.value
        }
    }
}

//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for vdvDev
//                   GainComponent: level event for GainComponent
//
// PURPOSE:          This level event is used to listen for SNAPI GainComponent changes
//                   on the GainComponent and update the touch panel user
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[vdvDev, GAIN_LVL]
{
    if (!bNoLevelReset)
    {
        stack_var integer zone
        zone = getFeedbackZone(Level.input.device)
        
        nGAIN_LVL[zone] = level.value
        if (zone == nCurrentZone)
        {
            send_level dvTP, LVL_GAIN, nGAIN_LVL[nCurrentZone]
            println (" 'send_level ',dpstoa(dvTP),', ',itoa(LVL_GAIN),', ',itoa(nGAIN_LVL[nCurrentZone])")
        }
    }
}



(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,GAIN_MUTE_ON] = [vdvDev[nCurrentZone],GAIN_MUTE_FB]
[dvTP,BTN_GAIN_UP] = [vdvDev[nCurrentZone],GAIN_UP_FB]
[dvTP,BTN_GAIN_DN] = [vdvDev[nCurrentZone],GAIN_DN_FB]

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

