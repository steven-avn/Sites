(*********************************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/21/2012  AT: 10:45:42        *)
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
MODULE_NAME = 'Bose ESP88 AudioMixerComponent' (dev vdvDev[], dev dvTP, dev dvTPMain, INTEGER nDevice, INTEGER nPages[])
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 6/18/2007 3:14:19 PM                    *)
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
BTN_QUERY_XPOINT                = 1025  // Button: Query Crosspoint
BTN_QUERY_MIXER_PRESET          = 1026  // Button: Query Mixer Preset
BTN_QUERY_XPOINT_MUTE           = 1027  // Button: Query Crosspoint Mute
BTN_XPOINT_LVL_RELEASE          = 3025  // Button: AudioMixerCrosspoint Lvl Release Btn

// Levels

// Variable Text Addresses

/* G4 CHANNELS
BTN_MIXER_PRESET_SAVE           = 260   // Button: Save Preset

#IF_NOT_DEFINED BTN_MIXER_OUTPUT
INTEGER BTN_MIXER_OUTPUT[]      =       // Button: Output
{
  301,  302,  303,  304,  305,
  306,  307,  308,  309,  310,
  311,  312,  313,  314,  315,
  316,  317,  318,  319,  320
}
#END_IF // BTN_MIXER_OUTPUT

BTN_MIXER_XPOINT_DN             = 259   // Button: Crosspoint Down

#IF_NOT_DEFINED BTN_MIXER_INPUT
INTEGER BTN_MIXER_INPUT[]       =       // Button: Input
{
  281,  282,  283,  284,  285,
  286,  287,  288,  289,  290,
  291,  292,  293,  294,  295,
  296,  297,  298,  299,  300
}
#END_IF // BTN_MIXER_INPUT

BTN_MIXER_XPOINT_UP             = 258   // Button: Crosspoint Up
BTN_MIXER_XPOINT_MUTE           = 256   // Button: Crosspoint Mute

#IF_NOT_DEFINED BTN_MIXER_PRESET
INTEGER BTN_MIXER_PRESET[]      =       // Button: Preset
{
  261,  262,  263,  264,  265,
  266,  267,  268,  269,  270,
  271,  272,  273,  274,  275,
  276,  277,  278,  279,  280
}
#END_IF // BTN_MIXER_PRESET

*/

/* G4 LEVELS
LVL_MIXER_XPOINT_SET            = 8     // Level: Crosspoint Value
*/

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT



INTEGER MAX_INPUTS = 20
INTEGER MAX_OUTPUTS = 20


(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE



#IF_NOT_DEFINED _uPanelIO
STRUCTURE _uPanelIO
{
    INTEGER    nInput
    INTEGER    nOutput[MAX_INPUTS][MAX_OUTPUTS]
    INTEGER    nLevel[MAX_INPUTS]
    INTEGER    bState[MAX_INPUTS]
    INTEGER    bMute[MAX_INPUTS]
}
#END_IF


(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

char sMIXERPRESET[MAX_ZONE][20] = { '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '' }

VOLATILE _uPanelIO uPanelIO[20]
VOLATILE INTEGER bBTN_MIXER_PRESET_SAVE = 0


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


    println ("'OnZoneChange'")
}


//*********************************************************************
// Function : SendXPointLevel
// Purpose  : Format and send the crosspoint command
// Params   : nLevel - level set value
//            nInput - currently selected input
//            nOutput[] - array of currently selected outputs
// Return   : none
//*********************************************************************
DEFINE_FUNCTION SendXPointLevel(integer nLevel, integer nInput, integer nOutput[MAX_OUTPUTS])
{
    stack_var char sOutputString[100]
    stack_var integer nLoop

    IF (nInput)
    {
		for (nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
		{
			IF (nOutput[nLoop])
				sOutputString = "sOutputString, itoa(nLoop), ','"
		}
		set_length_string (sOutputString, length_string(sOutputString) - 1)

		send_command vdvDev[nCurrentZone], "'XPOINT-',itoa(nLevel),',',itoa(nInput),',',sOutputString"
		println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'XPOINT-',itoa(nLevel),',',itoa(nInput),',',sOutputString,39")
    }
}
//*********************************************************************
// Function : initialize
// Purpose  : initialize any variables to default values
// Params   : none
// Return   : none
//*********************************************************************
DEFINE_FUNCTION Initialize()
{
    STACK_VAR INTEGER nLoop
    STACK_VAR INTEGER i
    STACK_VAR INTEGER x

    for (nLoop = 1; nLoop <= LENGTH_ARRAY(nZoneBtns); nLoop++)
    {
		uPanelIO[nLoop].nInput = 1
		for (i = 1; i <= MAX_INPUTS; i++)
		{
			uPanelIO[nLoop].nLevel[i] = 0
			uPanelIO[nLoop].bState[i] = FALSE
			for (x = 1; x <= MAX_OUTPUTS; x++)
				uPanelIO[nLoop].nOutput[i][x] = 0
		}
    }
}


DEFINE_MUTUALLY_EXCLUSIVE
([dvTp,BTN_MIXER_INPUT[1]]..[dvTp,BTN_MIXER_INPUT[LENGTH_ARRAY(BTN_MIXER_INPUT)]])
([dvTp,BTN_MIXER_PRESET[1]]..[dvTp,BTN_MIXER_PRESET[LENGTH_ARRAY(BTN_MIXER_PRESET)]])


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

strCompName = 'AudioMixerComponent'

// Initialize all place holder variables here
Initialize()


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
//                   AudioMixerComponent: data event
//
// PURPOSE:          This data event is used to listen for SNAPI component
//                   commands and track feedback for the AudioMixerComponent.
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
            // SNAPI::MIXERPRESET-<preset>
            CASE 'MIXERPRESET' :
            {
                sMIXERPRESET[nZone] = DuetParseCmdParam(cCmd)
                // get parameter value from SNAPI command and set feeback on user interface
                nParameter = ATOI(sMIXERPRESET[nZone])
                off[dvTP,BTN_MIXER_PRESET]
                if (nParameter)
                    on[dvTP,BTN_MIXER_PRESET[nParameter]]

            }

            //----------------------------------------------------------
            // CODE-BLOCK For AudioMixerComponent
            //
            // The following case statements are used in conjunction
            // with the AudioMixerComponent code-block.
            //----------------------------------------------------------


			// SNAPI::XPOINTMUTE-<state>,<input>,<output>
			CASE 'XPOINTMUTE' :
			{
				STACK_VAR INTEGER nInput
				STACK_VAR INTEGER nOutput

				nParameter = ATOI(DuetParseCmdParam(cCmd))
				nInput = ATOI(DuetParseCmdParam(cCmd))
				nOutput = ATOI(DuetParseCmdParam(cCmd))

				if (nInput > 0)
				{
					uPanelIO[nCurrentZone].bMute[nInput] = nParameter
					if (uPanelIO[nCurrentZone].nInput = nInput && uPanelIO[nCurrentZone].bState[nInput])
					{
						if (nOutput > 0)
						{
							if (uPanelIO[nCurrentZone].nOutput[nInput][nOutput])
								[dvTP, BTN_MIXER_XPOINT_MUTE] = uPanelIO[nCurrentZone].bMute[nInput]
						}
					}
				}
			}
			// SNAPI::XPOINT-<value>,<input>,<output,...>
			CASE 'XPOINT' :
			{
				STACK_VAR INTEGER nInput
				STACK_VAR INTEGER nOutput

				nParameter = ATOI(DuetParseCmdParam(cCmd))
				nInput = ATOI(DuetParseCmdParam(cCmd))
				nOutput = ATOI(DuetParseCmdParam(cCmd))

				if (nInput > 0)
				{
					uPanelIO[nCurrentZone].nLevel[nInput] = nParameter
					if (uPanelIO[nCurrentZone].nInput = nInput && uPanelIO[nCurrentZone].bState[nInput])
					{
						if (nOutput > 0)
						{
							if (uPanelIO[nCurrentZone].nOutput[nInput][nOutput])
								SEND_LEVEL dvTP, LVL_MIXER_XPOINT_SET, uPanelIO[nCurrentZone].nLevel[nInput]
						}
					}
				}
			}
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
// CHANNEL_EVENTs For AudioMixerComponent
//
// The following channel events are used in conjunction
// with the AudioMixerComponent code-block.
//----------------------------------------------------------


//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_QUERY_MIXER_PRESET
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the AudioMixerComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_QUERY_MIXER_PRESET]
{
    push:
    {
        if (bActiveComponent)
        {
            send_command vdvDev[nCurrentZone], '?MIXERPRESET'
            println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?MIXERPRESET',39")
        }
    }
}


//----------------------------------------------------------
// EXTENDED EVENTS For AudioMixerComponent
//
// The following events are used in conjunction
// with the AudioMixerComponent code-block.
//----------------------------------------------------------



//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel range button - command
//                   on BTN_MIXER_PRESET
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
button_event[dvTP, BTN_MIXER_PRESET]
{
    push:
    {
        if (bActiveComponent)
		{
			stack_var integer btn
			btn = get_last(BTN_MIXER_PRESET)

			IF (bBTN_MIXER_PRESET_SAVE = TRUE)
			{
				send_command vdvDev[nCurrentZone], "'MIXERPRESETSAVE-',itoa(btn)"
				println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'MIXERPRESETSAVE-',itoa(btn),39")

				// reset the button state
				bBTN_MIXER_PRESET_SAVE = FALSE
				[dvTP, BTN_MIXER_PRESET_SAVE] = bBTN_MIXER_PRESET_SAVE
			}
			ELSE
			{
				send_command vdvDev[nCurrentZone], "'MIXERPRESET-',itoa(btn)"
				println("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'MIXERPRESET-',itoa(btn),39")
			}
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_MIXER_PRESET_SAVE
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
button_event[dvTP, BTN_MIXER_PRESET_SAVE]
{
    push:
    {
        if (bActiveComponent)
		{
			bBTN_MIXER_PRESET_SAVE = !(bBTN_MIXER_PRESET_SAVE)
			[dvTP, BTN_MIXER_PRESET_SAVE] = bBTN_MIXER_PRESET_SAVE
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel range button - command
//                   on BTN_MIXER_INPUT
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MIXER_INPUT]
{
    push:
    {
        if (bActiveComponent)
        {
			STACK_VAR INTEGER nLoop
			STACK_VAR INTEGER nInput
			STACK_VAR INTEGER nOutput[MAX_OUTPUTS]

			// get panel input selection
			nInput = GET_LAST(BTN_MIXER_INPUT)

			IF (uPanelIO[nCurrentZone].nInput <> nInput)
			{
				uPanelIO[nCurrentZone].nInput = nInput
				uPanelIO[nCurrentZone].bState[nInput] = TRUE
			}
			ELSE
			{
				uPanelIO[nCurrentZone].bState[nInput] = !(uPanelIO[nCurrentZone].bState[nInput])
			}

			IF (uPanelIO[nCurrentZone].bState[nInput] = TRUE)
			{
				FOR(nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
					nOutput[nLoop] = uPanelIO[nCurrentZone].nOutput[nInput][nLoop]
			}
			ELSE
			{
				FOR(nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
					nOutput[nLoop] = 0
			}

			// update panel input
			[dvTP, BTN_MIXER_INPUT[nInput]] = uPanelIO[nCurrentZone].bState[nInput]

			// output select feedback
			FOR(nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
				[dvTP,BTN_MIXER_OUTPUT[nLoop]] = (nOutput[nLoop])
        }
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel range button - command
//                   on BTN_MIXER_OUTPUT
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MIXER_OUTPUT]
{
    push:
    {
        if (bActiveComponent)
        {
			stack_var integer btn

			btn = GET_LAST(BTN_MIXER_OUTPUT)

			if (uPanelIO[nCurrentZone].nInput)
			{
				uPanelIO[nCurrentZone].nOutput[uPanelIO[nCurrentZone].nInput][btn] =
					!(uPanelIO[nCurrentZone].nOutput[uPanelIO[nCurrentZone].nInput][btn])
			}

			[dvTP, BTN_MIXER_OUTPUT[btn]] = ![dvTP, BTN_MIXER_OUTPUT[btn]]
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_MIXER_XPOINT_DN
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MIXER_XPOINT_DN]
{
    push:
    {
        if (bActiveComponent)
        {
			if (uPanelIO[nCurrentZone].nInput)
			{
				stack_var integer nInput

				nInput = uPanelIO[nCurrentZone].nInput
				if (uPanelIO[nCurrentZone].bState[nInput])
				{
					IF (uPanelIO[nCurrentZone].nLevel[nInput] > 0)
					{
						// SNAPI:XPOINT-<value>,<input>,<output,...>
						uPanelIO[nCurrentZone].nLevel[nInput] = uPanelIO[nCurrentZone].nLevel[nInput] - 1
						SendXPointLevel(uPanelIO[nCurrentZone].nLevel[nInput],
							nInput,
							uPanelIO[nCurrentZone].nOutput[nInput])
					}
				}
			}
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_MIXER_XPOINT_UP
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MIXER_XPOINT_UP]
{
    push:
    {
        if (bActiveComponent)
        {
			if (uPanelIO[nCurrentZone].nInput)
			{
				stack_var integer nInput

				nInput = uPanelIO[nCurrentZone].nInput
				if (uPanelIO[nCurrentZone].bState[nInput])
				{
					IF (uPanelIO[nCurrentZone].nLevel[nInput] < 255)
					{
						// SNAPI:XPOINT-<value>,<input>,<output,...>
						uPanelIO[nCurrentZone].nLevel[nInput] = uPanelIO[nCurrentZone].nLevel[nInput] + 1
						SendXPointLevel(uPanelIO[nCurrentZone].nLevel[nInput],
							nInput,
							uPanelIO[nCurrentZone].nOutput[nInput])
					}
				}
			}
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_QUERY_XPOINT
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_QUERY_XPOINT]
{
    push:
    {
        if (bActiveComponent)
        {
			if (uPanelIO[nCurrentZone].nInput)
			{
				stack_var integer nInput
				stack_var integer nLoop

				nInput = uPanelIO[nCurrentZone].nInput
				if (uPanelIO[nCurrentZone].bState[nInput])
				{
					for (nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
					{
						IF (uPanelIO[nCurrentZone].nOutput[nInput][nLoop])
						{
							send_command vdvDev[nCurrentZone], "'?XPOINT-',itoa(nInput),',',itoa(nLoop)"
							println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?XPOINT-',itoa(nInput),',',itoa(nLoop),39")
						}
					}
				}
			}
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_MIXER_XPOINT_MUTE
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_MIXER_XPOINT_MUTE]
{
    push:
    {
        if (bActiveComponent)
        {
			if (uPanelIO[nCurrentZone].nInput)
			{
				stack_var integer nInput
				stack_var integer nLoop

				nInput = uPanelIO[nCurrentZone].nInput
				if (uPanelIO[nCurrentZone].bState[nInput])
				{
					uPanelIO[nCurrentZone].bMute[nInput] = !(uPanelIO[nCurrentZone].bMute[nInput])

					for (nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
					{
						IF (uPanelIO[nCurrentZone].nOutput[nInput][nLoop])
						{
							send_command vdvDev[nCurrentZone], "'XPOINTMUTE-',itoa(uPanelIO[nCurrentZone].bMute[nInput]),',',itoa(nInput),',',itoa(nLoop)"
							println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'XPOINTMUTE-',itoa(uPanelIO[nCurrentZone].bMute[nInput]),',',itoa(nInput),',',itoa(nLoop),39")
						}
					}
				}
			}
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_QUERY_XPOINT_MUTE
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the .
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_QUERY_XPOINT_MUTE]
{
    push:
    {
        if (bActiveComponent)
        {
			if (uPanelIO[nCurrentZone].nInput)
			{
				stack_var integer nInput
				stack_var integer nLoop

				nInput = uPanelIO[nCurrentZone].nInput
				if (uPanelIO[nCurrentZone].bState[nInput])
				{
					for (nLoop = 1; nLoop <= MAX_OUTPUTS; nLoop++)
					{
						IF (uPanelIO[nCurrentZone].nOutput[nInput][nLoop])
						{
							// SNAPI:?XPOINTMUTE-<input>,<output>
							send_command vdvDev[nCurrentZone], "'?XPOINTMUTE-',itoa(nInput),',',itoa(nLoop)"
							println ("'send_command ',dpstoa(vdvDev[nCurrentZone]),', ',39,'?XPOINTMUTE-',itoa(nInput),',',itoa(nLoop),39")
						}
					}
				}
			}
        }
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       BUTTON_EVENT for dvTP
//                   AudioMixerComponent: channel button - command
//                   on BTN_XPOINT_LVL_RELEASE
//
// PURPOSE:          This button event is used to listen for input
//                   on the touch panel and update the AudioMixerComponent.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
BUTTON_EVENT[dvTP, BTN_XPOINT_LVL_RELEASE]
{
    release:
    {
        if (bActiveComponent)
        {
			if (!bNoLevelReset)
			{
				if (uPanelIO[nCurrentZone].nInput)
				{
					// SNAPI:XPOINT-<value>,<input>,<output,...>
					stack_var integer nInput

					nInput = uPanelIO[nCurrentZone].nInput
					if (uPanelIO[nCurrentZone].bState[nInput])
					{
						SendXPointLevel(uPanelIO[nCurrentZone].nLevel[nInput],
							nInput,
							uPanelIO[nCurrentZone].nOutput[nInput])
					}
				}
			}
		}
    }
}
//---------------------------------------------------------------------------------
//
// EVENT TYPE:       LEVEL_EVENT for dvTP
//                   AudioMixerComponent: level event for dvTP
//
// PURPOSE:          This level event is used to listen for touch panel changes
//                   and update the AudioMixerComponent
//                   interface feedback.
//
// LOCAL VARIABLES:  {none}
//
//---------------------------------------------------------------------------------
LEVEL_EVENT[dvTP, LVL_MIXER_XPOINT_SET]
{
    if (bActiveComponent)
    {
		if (!bNoLevelReset)
		{
			if (uPanelIO[nCurrentZone].nInput)
			{
				stack_var integer nInput

				nInput = uPanelIO[nCurrentZone].nInput
				uPanelIO[nCurrentZone].nLevel[nInput] = Level.value
			}
		}
    }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


wait 10
{
    if (bBTN_MIXER_PRESET_SAVE)
    {
		// blink the button
		[dvTP, BTN_MIXER_PRESET_SAVE] = ![dvTP, BTN_MIXER_PRESET_SAVE]
    }
}

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

