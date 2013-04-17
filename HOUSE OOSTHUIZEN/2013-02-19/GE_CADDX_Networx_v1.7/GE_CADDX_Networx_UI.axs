MODULE_NAME='GE_CADDX_Networx_UI'(DEV vdvNetworxNX8E, 
                               DEV TPArray[], 
                               INTEGER nBUTTON_ARRAY[])
(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  FILE CREATED ON: 04/10/2003 AT: 09:47:02               *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/08/2003 AT: 09:22:49         *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 1                                *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 12/08/2003                              *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 07/01/2003                              *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 04/10/2003                              *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)

DEFINE_DEVICE

DEFINE_CONSTANT

     
    INTEGER nFALSE          =   0
    INTEGER nNULL           =   0
    INTEGER nTRUE           =   1
    INTEGER nPANIC          =   1
    INTEGER nFIRE           =   2
    INTEGER nMEDICAL        =   3
    INTEGER nMAX_ARGS       =   8
    
    INTEGER nTP_RED         =   0
    INTEGER nTP_WHITE       =   72 
    INTEGER nTP_BLACK       =   87
    
    INTEGER nFEEDBACK       =   9
    INTEGER nARM_STATE      =   10
    INTEGER nARM_HOME_INST  =   11
    INTEGER nARM_AWAY_INST  =   12
    INTEGER nARM_HOME       =   13
    INTEGER nARM_AWAY       =   14
    INTEGER nDISARM         =   15
    INTEGER nBYPASS         =   16
    INTEGER nBYPASS_CANCEL  =   17
    //  ZONES
    INTEGER nZONE_STATUS    =   20
    INTEGER nZONE1          =   21
    INTEGER nZONE2          =   22
    INTEGER nZONE3          =   23
    INTEGER nZONE4          =   24
    INTEGER nZONE5          =   25
    INTEGER nZONE6          =   26
    INTEGER nZONE7          =   27
    INTEGER nZONE8          =   28
    INTEGER nSYS_STATUS     =   29
    //  PARTITIONS
    INTEGER nACTIVE_PART    =   40
    INTEGER nPARTITION1     =   41
    INTEGER nPARTITION2     =   42
    INTEGER nPARTITION3     =   43
    INTEGER nPARTITION4     =   44
    INTEGER nPARTITION5     =   45
    INTEGER nPARTITION6     =   46
    INTEGER nPARTITION7     =   47
    INTEGER nPARTITION8     =   48
    //  ALARMS
    INTEGER nPART1_ALARM    =   61
    INTEGER nPART2_ALARM    =   62
    INTEGER nPART3_ALARM    =   63
    INTEGER nPART4_ALARM    =   64
    INTEGER nPART5_ALARM    =   65
    INTEGER nPART6_ALARM    =   66
    INTEGER nPART7_ALARM    =   67
    INTEGER nPART8_ALARM    =   68
    //  KEYPAD KEYS
    INTEGER nKEYPAD1        =   101
    INTEGER nKEYPAD2        =   102
    INTEGER nKEYPAD3        =   103
    INTEGER nKEYPAD4        =   104
    INTEGER nKEYPAD5        =   105
    INTEGER nKEYPAD6        =   106
    INTEGER nKEYPAD7        =   107
    INTEGER nKEYPAD8        =   108
    INTEGER nKEYPAD9        =   109
    INTEGER nKEYPAD0        =   100
    INTEGER nKEYPAD_STAR    =   111
    INTEGER nKEYPAD_POUND   =   112
    
    CHAR cARG_COUNT_ERROR   =   1
    
    INTEGER nZONE_COUNT     =   64
    
    VOLATILE CHAR cARM_ARRAY[5][10] =   {'ARMHOMENOW',
                                         'ARMAWAYNOW',
                                         'ARMHOME',
                                         'ARMAWAY',                                         
                                         'DISARM'
                                        }
    VOLATILE CHAR cBYP_ARRAY[2][8]  =   {
                                         'BYPASS',
                                         'CANCEL'
                                        }

DEFINE_TYPE
    STRUCTURE _sCommStruct
    {
        INTEGER nArgCount
        CHAR cParam[8][32]
        CHAR cRawData[255]     
    }
DEFINE_VARIABLE

    VOLATILE INTEGER nZone          =   1
    VOLATILE INTEGER nPartition     =   1
    VOLATILE INTEGER nDebug         =   nFALSE    
    VOLATILE INTEGER nPartArray[8]  =   {0,0,0,0,0,0,0,0}
    VOLATILE INTEGER nAlarmArray[8] =   {0,0,0,0,0,0,0,0}
                                            
    VOLATILE INTEGER nZoneArray[nZONE_COUNT] 
    VOLATILE CHAR    cZoneState[nZONE_COUNT]
    VOLATILE INTEGER nZoneIdx 
                                             
    VOLATILE CHAR cPassword[6]
    VOLATILE CHAR cGlobMsg[64]
    VOLATILE CHAR cBlank[6]
    VOLATILE _sCommStruct _sCmdStruct

DEFINE_LATCHING


//
// Function : ClearCmdStruct()
// Purpose  : clear command structure
// Params   : none
// Return   : none
// Notes    : none
//    
DEFINE_FUNCTION ClearCmdStruct ()
{
    STACK_VAR INTEGER nIndex
    
    IF ( nDebug )
        NetBug(0, "ITOA( __LINE__ ), ' ClearCmdStruct '", "0")
    
    FOR (nIndex = 1; nIndex <= nMAX_ARGS; nIndex++)    
        _sCmdStruct.cParam[nIndex] = ''
    
    _sCmdStruct.nArgCount = nNULL
    
    _sCmdStruct.cRawData = ''
}


// Function : ParseArgument()
// Purpose  : To count arg's, copy arguments, return number of errors 
// Params   : string , char to search for
// Return   : Errors: No errors (0,nNULL) or cARG_COUNT_ERROR (number of valid arguments is 1-8)
// Notes    : This function counts variables and parses arguments.
//          : Even though this function is named 'ParseArgument',
//          : it copies, counts, and returns a value.  
// Further  : All of the valid arguments (non-zero-length)are saved off into
//          : the command structure in their corresponding location 1-8
DEFINE_FUNCTION INTEGER ParseArgument (CHAR cSearchStr[], CHAR cSeparator)
{
    STACK_VAR INTEGER nCount, nArgs
    STACK_VAR CHAR cBuffer[1024]
    STACK_VAR CHAR cArgstr[32]
            
        
    cBuffer = cSearchStr
    
    _sCmdStruct.cRawData = cSearchStr
    
    WHILE (FIND_STRING (cBuffer, "cSeparator", 1))
    {
        cArgstr = REMOVE_STRING (cBuffer, "cSeparator", 1)
        
        IF (LENGTH_STRING (cArgstr) > 1)
        {            
            SET_LENGTH_STRING (cArgstr, LENGTH_STRING (cArgstr) - 1)
            
            nArgs ++
            
            IF (nArgs <= nMAX_ARGS)
                _sCmdStruct.cParam[nArgs] = cArgstr
            ELSE
                RETURN cARG_COUNT_ERROR
        }
    }
    
    IF (LENGTH_STRING (cBuffer))
    {
        nArgs ++
         
        IF (nArgs <= nMAX_ARGS)       
            _sCmdStruct.cParam[nArgs] = cBuffer
        ELSE
            RETURN cARG_COUNT_ERROR
    }
    
    
    _sCmdStruct.nArgCount = nArgs
    
    IF ( nDebug )
        NetBug(0, "ITOA( __LINE__ ), ' ParseArgument '", "ITOA (nArgs)")        
    
    RETURN nNULL
}

//
// Function : SendData()
// Purpose  : Provide debug feedback through telnet
// Params   : char msg[]
// Return   : integer
// Notes    : 
//
DEFINE_FUNCTION INTEGER SendData(CHAR cCommand[])
{
    IF (nDebug) 
        NetBug(0, "ITOA( __LINE__ ), ' SendData '", "cCommand")
        
    
    SEND_COMMAND vdvNetworxNX8E, "cCommand"
}

DEFINE_MUTUALLY_EXCLUSIVE

//
// Function : NetBug()
// Purpose  : Provide debug feedback through telnet
// Params   : char msg[]
// Return   : integer
// Notes    : 
//
DEFINE_FUNCTION INTEGER NetBug(INTEGER dvDev, CHAR sPrefix[], CHAR sMsg[])
{
        SEND_STRING dvDev, "'From ',__FILE__,' ', sPrefix, sMsg, $0D, $0A"
}

DEFINE_EVENT

BUTTON_EVENT[TPArray, nBUTTON_ARRAY]
{
    PUSH:
    {
        STACK_VAR INTEGER nLastButton, nButton
        STACK_VAR CHAR cCommand[128]
                                
        nLastButton = GET_LAST (nBUTTON_ARRAY)
        
        IF (nDebug) 
            NetBug(0, "ITOA( __LINE__ ), ' Button '", "ITOA (nLastButton)")
            
        SWITCH (nLastButton)
        {            
            //  ARMING
            CASE nARM_AWAY:
            CASE nARM_HOME:            
            CASE nDISARM:
            {                
                nButton = nLastButton - 10
                
                IF (LENGTH_STRING (cPassword))
                {
                    CANCEL_WAIT 'DeletePWD'
                    cCommand = "'PARTITION=', ITOA (nPartition), ':', cARM_ARRAY[nButton], ':',cPassword"
                }
                ELSE
                {
                    cCommand = ''
                    SEND_COMMAND TPArray, "'!T', nFEEDBACK, 'Enter Password,|then GO'"
                    cGlobMsg = "'PARTITION=', ITOA (nPartition), ':', cARM_ARRAY[nButton]"
                    WAIT 100 'DeletePWD'
                    {
                        SEND_COMMAND TPArray, "'!T', nFEEDBACK, ''"
                        cGlobMsg = ''
                    }
                }
            }
            CASE nARM_AWAY_INST:
            CASE nARM_HOME_INST:
            {                
                nButton = nLastButton - 10
                
                cCommand = "'PARTITION=', ITOA (nPartition), ':', cARM_ARRAY[nButton]"
            }
            //  BYPASS
            CASE nBYPASS:
            CASE nBYPASS_CANCEL:
            {
                nButton = nLastButton - 15
                //  PASSWORD REQUIRED BY API, BUT NOT NETWORX THEREFORE 'NULL' IS SENT
                cCommand = "'ZONE=', ITOA (nPartition), ':', ITOA (nZone), ':', cBYP_ARRAY[nButton], ':NULL'"               
            }            
            CASE nKEYPAD1:
            CASE nKEYPAD2:
            CASE nKEYPAD3:
            CASE nKEYPAD4:
            CASE nKEYPAD5:
            CASE nKEYPAD6:
            CASE nKEYPAD7:
            CASE nKEYPAD8:
            CASE nKEYPAD9:
            CASE nKEYPAD0:
            CASE nKEYPAD_STAR:
            CASE nKEYPAD_POUND:
            {
                
                SWITCH (nLastButton)
                {
                    CASE nKEYPAD_STAR:
                    {
                        CANCEL_WAIT 'DeletePWD'
                        cPassword = GET_BUFFER_STRING (cPassword, LENGTH_STRING (cPassword) - 1)
                        cBlank = GET_BUFFER_STRING (cBlank, LENGTH_STRING (cBlank) - 1)
                        SEND_COMMAND TPArray, "'!T', nFEEDBACK, cBlank"
                        WAIT 100 'DeletePWD'
                        {
                            cPassword = ''
                            SEND_COMMAND TPArray, "'!T', nFEEDBACK, ''"
                        }
                    }
                    CASE nKEYPAD_POUND:
                    {
                        CANCEL_WAIT 'DeletePWD'
                        cCommand = "cGlobMsg, ':', cPassword"
                        SendData (cCommand)
                        SEND_COMMAND TPArray, "'!T', nFEEDBACK, ''"
                        cCommand = ''
                        cPassword = ''
                        cBlank = ''
                        cGlobMsg = ''
                    }
                    DEFAULT:
                    {
                        CANCEL_WAIT 'DeletePWD'
                        cPassword = "cPassword, ITOA (nLastButton - 100)"
                        cBlank = "cBlank, '*'"
                        SEND_COMMAND TPArray, "'!T', nFEEDBACK, cBlank"
                        WAIT 100 'DeletePWD'
                        {
                            cPassword = ''
                            SEND_COMMAND TPArray, "'!T', nFEEDBACK, ''"
                        }
                    }
                }                
            }
            CASE nPARTITION1:
            CASE nPARTITION2:
            CASE nPARTITION3:
            CASE nPARTITION4:
            CASE nPARTITION5:
            CASE nPARTITION6:
            CASE nPARTITION7:
            CASE nPARTITION8:
            //  PARTITIONS
            {
                OFF [TPArray, nPartArray]
                
                nPartition = nLastButton - 40
                
                ON [TPArray, nPartArray[nPartition]]
                
                cCommand = "'PARTITION=', ITOA (nPartition),'?'"
                SEND_COMMAND TPArray, "'!T', nPartArray[nPartition],''"
                SEND_COMMAND TPArray, "'!T'  , nACTIVE_PART, ITOA (nPartition)"
            }
            CASE nPART1_ALARM:
            CASE nPART2_ALARM:
            CASE nPART3_ALARM:
            CASE nPART4_ALARM:
            CASE nPART5_ALARM:
            CASE nPART6_ALARM:
            CASE nPART7_ALARM:
            CASE nPART8_ALARM:
            {
                STACK_VAR INTEGER nAlarmPart                
                
                nAlarmPart = nLastButton - 60
                
                cCommand = "'ALARM=', ITOA (nAlarmPart),'?'"
                SEND_COMMAND TPArray, "'!T', nAlarmArray[nAlarmPart],''"
            }
            //  ZONES
            CASE nZONE1:
            CASE nZONE2:
            CASE nZONE3:
            CASE nZONE4:
            CASE nZONE5:
            CASE nZONE6:
            CASE nZONE7:
            CASE nZONE8:
            {
                nZone = nLastButton - 20
                cCommand = "'ZONE=', ITOA (nPartition), ':', ITOA (nZone),'?'"
                SEND_COMMAND TPArray, "'!T'  , nZONE_STATUS, ''"
            }                        
        }
        
        IF (LENGTH_STRING (cCommand))
            SendData (cCommand)
    } 
    HOLD[20]:
    {
        STACK_VAR INTEGER nLastButton
        STACK_VAR CHAR cCommand[128]
                                
        nLastButton = GET_LAST (nBUTTON_ARRAY)
        
        IF (nDebug) 
            NetBug(0, "ITOA( __LINE__ ), ' Button '", "ITOA (nLastButton)")
            
        SWITCH (nLastButton)
        {                        
            //  ALARMS
            CASE nFIRE:
            {
                cCommand = "'ALARM=', ITOA (nPartition), ':FIRE'"
            }            
            CASE nMEDICAL:
            {
                cCommand = "'ALARM=', ITOA (nPartition), ':MEDICAL'"
            }
            CASE nPANIC:
            {
                cCommand = "'ALARM=', ITOA (nPartition), ':PANIC'"
            }
        }
        IF (LENGTH_STRING (cCommand))
            SendData (cCommand)
    }   
    RELEASE:
    {
    }
}



DATA_EVENT[vdvNetworxNX8E]
{
    STRING:
    {
        STACK_VAR CHAR cMsg[64]
        STACK_VAR INTEGER nArgs
        
        IF (nDebug)
            NetBug(0, "ITOA( __LINE__ ), ' DATA_EVENT '", "DATA.TEXT")
        
        ClearCmdStruct ()
        
        IF (FIND_STRING (DATA.TEXT, '=', 1))
        {
            cMsg = REMOVE_STRING (DATA.TEXT, '=', 1)
                    
            SET_LENGTH_STRING (cMsg, LENGTH_STRING (cMsg) - 1)
            
            ParseArgument (DATA.TEXT, ':')
                
            nArgs = _sCmdStruct.nArgCount      
            
            SWITCH (cMsg)             
            {   
                //  ALARM=1:1:1:INTRUSION:0
                CASE 'ALARM':
                {
                    STACK_VAR INTEGER Alarm_Part
                    
                    Alarm_Part = ATOI (_sCmdStruct.cParam[1])
                    
                    IF (ATOI (_sCmdStruct.cParam[5]))
                    {
                        SEND_COMMAND TPArray, "'@CTF',nAlarmArray[Alarm_Part], nTP_RED"
                        SEND_COMMAND TPArray, "'!T', nAlarmArray[Alarm_Part], 
                                                     _sCmdStruct.cParam[4],
                                                     ' = ON'"
                    }
                    ELSE
                    {
                        SEND_COMMAND TPArray, "'@CTF',nAlarmArray[Alarm_Part], nTP_BLACK"
                        SEND_COMMAND TPArray, "'!T', nAlarmArray[Alarm_Part], 
                                                     _sCmdStruct.cParam[4],
                                                     ' = OFF'"
                    }
                }
                CASE 'DEBUG':
                {                     
                    nDebug = ATOI (_sCmdStruct.cParam[1])
                }
                CASE 'ERROR':
                {
                    NetBug(0, "ITOA( __LINE__ ), ' ***ERROR MESSAGE*** '", "DATA.TEXT")
                }
                CASE 'HELP':
                {
                    NetBug(0, "ITOA( __LINE__ ), ' ***HELP MESSAGE*** '", "DATA.TEXT")
                }
                CASE 'PARTITION':
                {
                    STACK_VAR INTEGER nPartition
                    
                    nPartition = ATOI (_sCmdStruct.cParam[1])
                    
                    SWITCH (_sCmdStruct.cParam[2])
                    {
                        CASE 'DISARMED':
                        {
                            OFF[TPArray, nARM_STATE]
                            SEND_COMMAND TPArray, "'@CTF',nARM_STATE, nTP_BLACK"
                            SEND_COMMAND TPArray, "'!T', nARM_STATE, 'DISARMED'"
                        }
                        CASE 'ARMEDHOME':
                        CASE 'ARMEDAWAY':
                        {
                            OFF[TPArray, nARM_STATE]
                            SEND_COMMAND TPArray, "'@CTF',nARM_STATE, nTP_RED"
                            SEND_COMMAND TPArray, "'!T', nARM_STATE, 'SYSTEM ARMED'"
                        }
                        CASE 'EXITDELAY':
                        {
                            ON[TPArray, nARM_STATE]
                            SEND_COMMAND TPArray, "'@CTF',nARM_STATE, nTP_RED"
                            SEND_COMMAND TPArray, "'!T', nARM_STATE, 'ARMING...'"
                        }
                    }
                    SEND_COMMAND TPArray, "'!T', nPartArray[nPartition], _sCmdStruct.cParam[2]"
                }
                CASE 'ZONE':
                {                     
                    STACK_VAR INTEGER nPartition
                    STACK_VAR INTEGER nZone
                    
                    nPartition = ATOI (_sCmdStruct.cParam[1])
                    
                    nZone = ATOI (_sCmdStruct.cParam[2])
                                        
                    SEND_COMMAND TPArray, "'@CTF', nZONE_STATUS, nTP_BLACK"
                    SEND_COMMAND TPArray, "'!T'  , nZONE_STATUS, ITOA (nZone), ' ', _sCmdStruct.cParam[3]"
                    
                    IF (nZone <= 8)
                    {
                        SWITCH (_sCmdStruct.cParam[3])
                        {                        
                            CASE 'FAULT':
                            {
                                ON[TPArray, nZoneArray[nZone]]
                                ON[TPArray, nSYS_STATUS]
                                cZoneState[nZone] = $01
                            }
                            CASE 'SECURE':
                            {                               
                                OFF[TPArray, nZoneArray[nZone]]
                                
                                cZoneState[nZone] = 0
                                
                                [TPArray, nSYS_STATUS] = FIND_STRING (cZoneState, "$01", 1)
                            }
                        }
                    }
                    
                }
            }
        }
    }
    COMMAND:
    {
    }
    ONLINE:
    {
    }
    OFFLINE:
    {
    }
}

DATA_EVENT[TPArray]
{
    STRING:
    {
    }
    COMMAND:
    {
    }
    ONLINE:
    {
    }
    OFFLINE:
    {
    }
}

DEFINE_START

    SEND_COMMAND vdvNetworxNX8E, "'DEBUG=1'"
    SEND_COMMAND TPArray, "'!T'  , nACTIVE_PART, ITOA (nPartition)"
    SET_LENGTH_ARRAY(nZoneArray, 64)
    SET_LENGTH_STRING(cZoneState, 64)
    //  FILL ZONE ARRAY VALUES
    nZoneArray[1] = nBUTTON_ARRAY[nZONE1]
    nZoneArray[2] = nBUTTON_ARRAY[nZONE2]
    nZoneArray[3] = nBUTTON_ARRAY[nZONE3]
    nZoneArray[4] = nBUTTON_ARRAY[nZONE4]
    nZoneArray[5] = nBUTTON_ARRAY[nZONE5]
    nZoneArray[6] = nBUTTON_ARRAY[nZONE6]
    nZoneArray[7] = nBUTTON_ARRAY[nZONE7]
    nZoneArray[8] = nBUTTON_ARRAY[nZONE8]
    //  PARTITION ARRAY
    nPartArray[1] = nBUTTON_ARRAY[nPARTITION1]
    nPartArray[2] = nBUTTON_ARRAY[nPARTITION2]
    nPartArray[3] = nBUTTON_ARRAY[nPARTITION3]
    nPartArray[4] = nBUTTON_ARRAY[nPARTITION4]
    nPartArray[5] = nBUTTON_ARRAY[nPARTITION5]
    nPartArray[6] = nBUTTON_ARRAY[nPARTITION6]
    nPartArray[7] = nBUTTON_ARRAY[nPARTITION7]
    nPartArray[8] = nBUTTON_ARRAY[nPARTITION8]
    //  ALARM ARRAY
    nAlarmArray[1] = nBUTTON_ARRAY[nPART1_ALARM]
    nAlarmArray[2] = nBUTTON_ARRAY[nPART2_ALARM]
    nAlarmArray[3] = nBUTTON_ARRAY[nPART3_ALARM]
    nAlarmArray[4] = nBUTTON_ARRAY[nPART4_ALARM]
    nAlarmArray[5] = nBUTTON_ARRAY[nPART5_ALARM]
    nAlarmArray[6] = nBUTTON_ARRAY[nPART6_ALARM]
    nAlarmArray[7] = nBUTTON_ARRAY[nPART7_ALARM]
    nAlarmArray[8] = nBUTTON_ARRAY[nPART8_ALARM]

DEFINE_PROGRAM

