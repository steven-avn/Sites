MODULE_NAME='AMX_Intercom_Comm' (DEV vdvTP_DPS_ARRAY[], DEV dvTP_DPS_ARRAY[])
(***********************************************************)
(*  FILE CREATED ON: 08/25/2006  AT: 14:48:25              *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 03/25/2011  AT: 13:50:58        *)
(***********************************************************)
//####################################################################//
//# Copyright Notice :                                               #//
//#    Copyright, AMX, Inc., 2006                                    #//
//#    Private, proprietary information, the sole property of AMX.   #//
//#    The contents, ideas, and concepts expressed herein are not to #//
//#    be disclosed except within the confines of a confidential     #//
//#    relationship and only then on a need to know basis.           #//
//####################################################################//
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 08/28/2006                              *)
(*                                                         *)
(*  COMMENTS: module by Christine Ayers
 *  $Header: /NetLinxModules/Amx/Intercom/Phoenix/AMX_Intercom_Comm.axs 5     5/29/07 8:47a Cayers $
 *  $Revision: 5 $
 *  $Log: /NetLinxModules/Amx/Intercom/Phoenix/AMX_Intercom_Comm.axs $
 *
 * 5     5/29/07 8:47a Cayers
 * v1.3
 *
 * 1     1/09/07 2:57p Cayers
 * v1.0 - Initial Release
 *
 * 3     12/14/06 6:17p Cayers
 * Internal version 0.6/ Release version 1.0
 *
 * 2     12/08/06 12:50p Cayers
 * VERSION 0.3
 *
 * 1     11/30/06 2:45p Cayers
 *
 * 1     11/30/06 2:44p Cayers
 * Phoenix Project Version
 *
 * 8/10/2010 DJHarrison V1.9 to support the 9000i panel, which does
 * not go OFFLINE when removed from dock - just loses IP connection.
 * Panel sends ^ICE command TO the module to warn of disconnect.
 *
*)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

CHAR sVERSION[] = '1.10'    // CURRENT NETLINX COMM MODULE VERSION NUMBER
(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nDEBUG = 1					// INDICATES CURRENT DEBUGGING LEVEL
(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvTP_DPS_ARRAY]
{
    ONLINE:
    {
	STACK_VAR DEV dvTP
	STACK_VAR DEV vdvTP
	STACK_VAR DEV_INFO_STRUCT INFO
	STACK_VAR IP_ADDRESS_STRUCT IPADDR

	dvTP = dvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]
	vdvTP = vdvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]
	IPADDR.IPAddress = ''
	INFO.DEVICE_ID_STRING = ''
	DEVICE_INFO(dvTP, INFO)
	IF (GET_IP_ADDRESS(dvTP, IPADDR) == 0 && INFO.DEVICE_ID != 0)
	{
	    SEND_STRING vdvTP, "'DEV_ONLINE-',INFO.DEVICE_ID_STRING,',',IPADDR.IPAddress"
	    IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
	    {
		SEND_COMMAND dvTP, 'SET VIDEO MJPEG'
		SEND_COMMAND dvTP, 'STREAM STOP-ALL'
		//SEND_COMMAND dvTP, 'SET AUDIO G711ULAW'
	    }
	    ELSE
	    {
		//SEND_COMMAND dvTP,"'^RMF-StormVideo,%H127.0.0.1%Ftemp.mjpg%R10'"
		//SEND_COMMAND dvTP,"'^RFR-StormVideo'";
	    }
	}
    }// END ONLINE
    COMMAND:
    {
	STACK_VAR DEV dvTP
	STACK_VAR DEV vdvTP
	STACK_VAR CHAR cCMD[20]

	dvTP = dvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]
	vdvTP = vdvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]

	IF (nDEBUG > 4) { SEND_STRING 0, "'FOR PHYSICAL DEVICE ',ITOA(dvTP.NUMBER),', COMM RECEIVED CMD: ',DATA.TEXT" }
	IF(FIND_STRING(DATA.TEXT, '-', 1)) { cCMD = UPPER_STRING(REMOVE_STRING(DATA.TEXT, '-', 1)) }
	ELSE IF (FIND_STRING(DATA.TEXT, '?', 1)) { cCMD = UPPER_STRING(REMOVE_STRING(DATA.TEXT, '?', 1)) }
	ELSE { cCMD = UPPER_STRING(DATA.TEXT) }
	SWITCH(cCMD)
	{
	    CASE '^ICE':	// Call ending due to undock - kill call in UI
	    {
		SEND_STRING vdvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)], 'CALL_CANCEL'
	    }
	    CASE '^MODEL-':
	    {
		STACK_VAR CHAR sMODEL[20]

		sMODEL = data.text
		GET_BUFFER_STRING(data.text, length_array(data.text)-1)
		if (data.text == 'i') { SEND_STRING vdvTP, "'MODEL-',sMODEL" }
		else
		{
		    send_string 0, "'ERROR: Device ',itoa(dvTP.NUMBER),':',itoa(dvTP.PORT),':',itoa(dvTP.SYSTEM),' is not intercomm ready'"
		}
	    }
	    CASE '^WCN-': { SEND_STRING vdvTP, "'NAME-',DATA.TEXT" }
	}
    }// END COMMAND
    STRING:
    {
	STACK_VAR DEV dvTP
	STACK_VAR DEV vdvTP
	STACK_VAR CHAR cCMD[20]
	STACK_VAR DEV_INFO_STRUCT INFO
	STACK_VAR IP_ADDRESS_STRUCT IPADDR

	dvTP = dvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]
	vdvTP = vdvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]

	IF (nDEBUG > 4) { SEND_STRING 0, "'FOR PHYSICAL DEVICE ',ITOA(dvTP.NUMBER),', COMM RECEIVED STR: ',DATA.TEXT" }
	IF(FIND_STRING(DATA.TEXT, '-', 1)) { cCMD = UPPER_STRING(REMOVE_STRING(DATA.TEXT, '-', 1)) }
	ELSE IF (FIND_STRING(DATA.TEXT, '?', 1)) { cCMD = UPPER_STRING(REMOVE_STRING(DATA.TEXT, '?', 1)) }
	ELSE IF (FIND_STRING(DATA.TEXT, '=', 1)) { cCMD = UPPER_STRING(REMOVE_STRING(DATA.TEXT, '=', 1)) }
	ELSE { cCMD = UPPER_STRING(DATA.TEXT) }
	SWITCH(cCMD)
	{
	    CASE 'MODEL-':
	    {
		STACK_VAR CHAR sMODEL[20]

		sMODEL = data.text
		GET_BUFFER_STRING(data.text, length_array(data.text)-1)
		if (LEFT_STRING(sMODEL,3) == 'MET') { SEND_STRING vdvTP, "'MODEL-',sMODEL" }
		else
		{
		    send_string 0, "'ERROR: Device ',itoa(dvTP.NUMBER),':',itoa(dvTP.PORT),':',itoa(dvTP.SYSTEM),' is not intercomm ready'"
		}
	    }
	    CASE 'DOOR-':
	    {
		REMOVE_STRING(DATA.TEXT, '=', 1)
		SEND_STRING vdvTP, "'NAME-',DATA.TEXT"
	    }
	    CASE 'GAIN =':
	    {
		GET_BUFFER_CHAR(DATA.TEXT)
		SEND_STRING vdvTP, "'GAIN-',DATA.TEXT"
	    }
	    CASE 'VOLUME =':
	    {
		GET_BUFFER_CHAR(DATA.TEXT)
		SEND_STRING vdvTP, "'VOLUME-',DATA.TEXT"
	    }
	    CASE 'SWAP':	// 9000i undock/dock IP change
	    {
		IPADDR.IPAddress = ''
		INFO.DEVICE_ID_STRING = ''
		DEVICE_INFO(dvTP, INFO)
		IF (GET_IP_ADDRESS(dvTP, IPADDR) == 0)
		{
		    IF (INFO.DEVICE_ID != 0)
		    {
			SEND_STRING vdvTP, "'CHANGE_IP-',IPADDR.IPAddress"
		    }
		    ELSE IF (nDEBUG > 0){SEND_STRING 0,"'SWAP received, but DEVICE_ID = 0'"}
		}
		ELSE IF (nDEBUG > 0){SEND_STRING 0,"'SWAP received, but GET_IP_ADDRESS failed'"}
	    }
	}

    }// END STRING
    OFFLINE: { SEND_STRING vdvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)], 'DEV_OFFLINE' }
}

DATA_EVENT[vdvTP_DPS_ARRAY]
{
    COMMAND:
    {
	STACK_VAR DEV vdvTP
	STACK_VAR DEV dvTP
	STACK_VAR DEV_INFO_STRUCT INFO
	STACK_VAR CHAR cCMD[20]

	dvTP = dvTP_DPS_ARRAY[GET_LAST(vdvTP_DPS_ARRAY)]
	vdvTP = vdvTP_DPS_ARRAY[GET_LAST(vdvTP_DPS_ARRAY)]
	INFO.DEVICE_ID_STRING = ''
	DEVICE_INFO(dvTP, INFO)

	IF (nDEBUG > 4) { SEND_STRING 0, "'FOR VIRTUAL DEVICE ',ITOA(vdvTP.NUMBER),', COMM RECEIVED CMD: ',DATA.TEXT" }

	IF(FIND_STRING(DATA.TEXT, '-', 1)) { cCMD = UPPER_STRING(REMOVE_STRING(DATA.TEXT, '-', 1)) }
	ELSE { cCMD = UPPER_STRING(DATA.TEXT) }
	SWITCH(cCMD)
	{
	    CASE 'CREATE_CALL-':
	    {
		IF (FIND_STRING(DATA.TEXT,'SOURCE',1))
		{
		    REMOVE_STRING(DATA.TEXT, ',', 1)
		    IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
		    {
			SEND_COMMAND dvTP, 'STREAM-STOP 1'
			SEND_COMMAND dvTP, "'STREAM-SET ',DATA.TEXT,',3002,3000,AUDIO,BOTH,1'"
			SEND_COMMAND dvTP,'SET LED-STATE ACTIVE'
			SEND_COMMAND dvTP,'STREAM-PLAY 1'
		    }
		    ELSE
		    {
			SEND_COMMAND dvTP, '^ICE'
			SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3002,3000,2'"
		    }
		}
		ELSE IF (FIND_STRING(DATA.TEXT, 'DESTINATION', 1))
		{
		    REMOVE_STRING(DATA.TEXT, ',', 1)
		    IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
		    {
			SEND_COMMAND dvTP, 'STREAM-STOP 1'
			SEND_COMMAND dvTP, "'STREAM-SET ',DATA.TEXT,',3000,3002,AUDIO,BOTH,1'"
			SEND_COMMAND dvTP,'SET LED-STATE ACTIVE'
			SEND_COMMAND dvTP,'STREAM-PLAY 1'
		    }
		    ELSE
		    {
			SEND_COMMAND dvTP, '^ICE'
			SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3000,3002,2'"
		    }
		}
	    }
	    CASE 'CREATE_MONITOR-':
	    {
		IF (FIND_STRING(DATA.TEXT,'SOURCE',1))
		{
		    REMOVE_STRING(DATA.TEXT, ',', 1)
		    IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
		    {
			SEND_COMMAND dvTP, 'STREAM-STOP 2'
			SEND_COMMAND dvTP, "'STREAM-SET ',DATA.TEXT,',3004,3006,AUDIO,TALK,2'"
			SEND_COMMAND dvTP,'STREAM-PLAY 2'
		    }
		    ELSE
		    {
			SEND_COMMAND dvTP, '^ICE'
			SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3004,3006,1'"
		    }
		}
		ELSE IF (FIND_STRING(DATA.TEXT, 'DESTINATION', 1))
		{
		    REMOVE_STRING(DATA.TEXT, ',', 1)
		    IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
		    {
			SEND_COMMAND dvTP, 'STREAM-STOP 2'
			SEND_COMMAND dvTP, "'STREAM-SET ',DATA.TEXT,',3006,3004,AUDIO,LISTEN,2'"
			SEND_COMMAND dvTP,'STREAM-PLAY 2'
		    }
		    ELSE
		    {
			SEND_COMMAND dvTP, '^ICE'
			SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3006,3004,0'"
		    }
		}
	    }
	    CASE 'DEBUG-':
	    {
		nDEBUG = ATOI(DATA.TEXT)
		send_string 0, "'Debug is now ',itoa(nDEBUG)"
		send_string vdvTP,"'DEBUG-',ITOA(nDEBUG)"
	    }
	    CASE '?DEBUG': { send_string vdvTP,"'DEBUG-',ITOA(nDEBUG)" }
	    CASE 'DISPLAY-': { SEND_COMMAND dvTP, "'SET DISP-BANNER /mnt/amx/usr/upload/',DATA.TEXT" }
	    CASE 'ENABLE_MIC':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET') {}// SEND_COMMAND dvTP,'STREAM-PLAY 1' }
		ELSE { SEND_COMMAND dvTP,'^ICM-TALK' }
	    }
	    CASE 'ENABLE_SPEAKER':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET') {}// SEND_COMMAND dvTP,'STREAM-PLAY 1' }
		ELSE { SEND_COMMAND dvTP,'^ICM-LISTEN' }
	    }
	    CASE 'END_CALLS':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING, 3) == 'MET')
		{
		    SEND_COMMAND dvTP, 'STREAM-STOP 1'
		    SEND_COMMAND dvTP, 'SET LED-STATE IDLE'
		}
		ELSE { SEND_COMMAND dvTP, '^ICE'  }
	    }
	    CASE 'END_MONITOR':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING, 3) == 'MET')
		{
		    SEND_COMMAND dvTP, 'STREAM-STOP 2'
		}
		ELSE { SEND_COMMAND dvTP, '^ICE'  }
	    }
	    CASE 'END_VIEW':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING, 3) == 'MET')
		{
		    SEND_COMMAND dvTP, 'STREAM-STOP 2'
		}
		ELSE { SEND_COMMAND dvTP, '^ICE'  }
	    }
	    CASE 'GAIN-':
	    {
		IF (ATOI(DATA.TEXT) >= 0 && ATOI(DATA.TEXT) <= 100)
		{
		    SEND_COMMAND dvTP, "'SET GAIN ',DATA.TEXT"
		    SEND_COMMAND dvTP, 'GET GAIN'
		}
	    }
	    CASE '?GAIN': { SEND_COMMAND dvTP, 'GET GAIN' }
	    CASE '?MODEL':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING, 3) == 'MET') { SEND_COMMAND dvTP, '^MOD?' }
		ELSE { SEND_COMMAND dvTP, '^MODEL?' }
	    }
	    CASE '?NAME':
	    {
		if (RIGHT_STRING(INFO.DEVICE_ID_STRING,1) == 'i' || INFO.DEVICE_ID_STRING == 'MVP5200i Touch Panel') { SEND_COMMAND dvTP, '^WCN?' }
		ELSE { SEND_COMMAND dvTP, 'GET DOOR-DESC 2' }
	    }
	    CASE 'PASSTHRU-': { SEND_COMMAND dvTP, "DATA.TEXT" }
	    CASE 'RECEIVE_PAGE-':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) != 'MET')
		{
		    SEND_COMMAND dvTP, '^ICE'
		    SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3000,3002,0'"
		}
	    }
	    CASE 'RECEIVE_VIEW-':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) != 'MET')
		{
		    SEND_COMMAND dvTP, '^ICE'
		    SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3010,3008,0'"
		}
	    }
	    CASE 'SEND_PAGE-':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) != 'MET')
		{
		    SEND_COMMAND dvTP, '^ICE'
		    SEND_COMMAND dvTP, "'^ICS-',DATA.TEXT,',3000,3002,1'"
		}
	    }
	    CASE 'SEND_VIEW-':
	    {
		IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
		{
		    SEND_COMMAND dvTP, 'STREAM-STOP 2'
		    SEND_COMMAND dvTP, "'STREAM-SET ',DATA.TEXT,',3008,3010,AUDIO,TALK,2'"
		    SEND_COMMAND dvTP,'STREAM-PLAY 2'
		}
	    }
	    CASE '?VERSION': { send_string vdvTP,"'VERSION-',sVERSION" }
	    CASE 'VOLUME-':
	    {
		IF (ATOI(DATA.TEXT) >= 0 && ATOI(DATA.TEXT) <= 100)
		{
		    SEND_COMMAND dvTP, "'SET VOLUME ',DATA.TEXT"
		    SEND_COMMAND dvTP, 'GET VOLUME'
		}
	    }
	    CASE '?VOLUME': { SEND_COMMAND dvTP, 'GET VOLUME' }
	}
    }
}

BUTTON_EVENT[dvTP_DPS_ARRAY,1]
{
    PUSH:
    {
	STACK_VAR DEV dvTP
	STACK_VAR DEV_INFO_STRUCT INFO
	STACK_VAR IP_ADDRESS_STRUCT IPADDR

	dvTP = dvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]
	IPADDR.IPAddress = ''
	INFO.DEVICE_ID_STRING = ''

	DEVICE_INFO(dvTP, INFO)

	IF (GET_IP_ADDRESS(dvTP, IPADDR) == 0 && INFO.DEVICE_ID != 0)
	{
	    IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
	    {
		STACK_VAR DEV vdvTP

		vdvTP = vdvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)]
		// Change LED Color To RED
		SEND_COMMAND dvTP,'SET LED-STATE ACTIVE'
		// Inform the UI the Door button was pressed
		SEND_STRING vdvTP,"'INCOMINGCALL-',IPADDR.IPAddress";
	    }
	}
    }
    RELEASE:
    {
	STACK_VAR DEV_INFO_STRUCT INFO

	DEVICE_INFO(dvTP_DPS_ARRAY[GET_LAST(dvTP_DPS_ARRAY)], INFO)

	IF (LEFT_STRING(INFO.DEVICE_ID_STRING,3) == 'MET')
	{	// Change LED Color to YELLOW
	    SEND_COMMAND BUTTON.INPUT.DEVICE,'SET LED-STATE IDLE';
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
