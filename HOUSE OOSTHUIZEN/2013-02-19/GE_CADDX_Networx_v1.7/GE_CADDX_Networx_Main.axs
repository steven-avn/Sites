PROGRAM_NAME='GE_CADDX_Networx_Main'
(*{{PS_SOURCE_INFO(PROGRAM STATS)                          *)
(***********************************************************)
(*  FILE CREATED ON: 04/10/2003 AT: 09:46:45               *)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 07/01/2004 AT: 09:01:14         *)
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

    dvNetworxNX8E       = 5001:4:0

    dvNetworxNX8ETP     = 10001:1:0

    vdvNetworxNX8E      = 33001:1:0

    vdvNetworxNX8ETP    = 33002:1:0

DEFINE_CONSTANT

    INTEGER nBUTTON_ARRAY[] = 

    {

        1,      //  PANIC
        2,      //  FIRE
        3,      //  MEDICAL
        
        257,
        257,
        257,
        257,
        257,
        
        9,      //  FEEDBACK        
        10,     //  ARMED STATE
        11,     //  ARMHOME INSTANT
        12,     //  ARMAWAY INSTANT
        13,     //  ARMHOME DELAY
        14,     //  ARMHOME DELAY
        15,     //  DISARM
        16,     //  BYPASS
        17,     //  BYPASS-CANCEL
                        
        257,
        257,        
        
        20,     //  ZONE STATUS
        21,     //  ZONE 1
        22,     //  ZONE 2
        23,     //  ZONE 3
        24,     //  ZONE 4
        25,     //  ZONE 5
        26,     //  ZONE 6
        27,     //  ZONE 7
        28,     //  ZONE 8        
        29,     //  SYSTEM STATUS, FAULTED OR SECURE
        
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        
        40,     //  ACTIVE PARTITION WINDOW
        41,     //  PARTITION 1
        42,     //  PARTITION 2
        43,     //  PARTITION 3
        44,     //  PARTITION 4
        45,     //  PARTITION 5
        46,     //  PARTITION 6
        47,     //  PARTITION 7
        48,     //  PARTITION 8
        49,
        50,
        
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        
        61,     //  PARTITION 1 ALARM STATE
        62,     //  PARTITION 2 ALARM STATE
        63,     //  PARTITION 3 ALARM STATE
        64,     //  PARTITION 4 ALARM STATE
        65,     //  PARTITION 5 ALARM STATE
        66,     //  PARTITION 6 ALARM STATE
        67,     //  PARTITION 7 ALARM STATE
        68,     //  PARTITION 8 ALARM STATE
        
        257,
        257,
        
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        257,
        100,    // KEYPAD 0
        
        101,    //  KEYPAD 1
        102,    //  KEYPAD 2
        103,    //  KEYPAD 3
        104,    //  KEYPAD 4
        105,    //  KEYPAD 5
        106,    //  KEYPAD 6
        107,    //  KEYPAD 7
        108,    //  KEYPAD 8
        109,    //  KEYPAD 9
        257,    //  NOT USED
        111,    //  KEYPAD *
        112     //  KEYPAD #
        
    }

   
DEFINE_COMBINE

    (vdvNetworxNX8ETP, dvNetworxNX8ETP)

DEFINE_TYPE

DEFINE_VARIABLE

     VOLATILE INTEGER nZoneCount    =   192
     DEV dvTPArray[] = { vdvNetworxNX8ETP, dvNetworxNX8ETP }

DEFINE_MODULE 'GE_CADDX_Networx_Comm' mdlNetworxNX8E_APP(vdvNetworxNX8E, 
                                                      dvNetworxNX8E, 
                                                      nZoneCount)

DEFINE_MODULE 'GE_CADDX_Networx_UI' mdlNetworxNX8E_APP(vdvNetworxNX8E, 
                                                    dvTPArray, 
                                                    nBUTTON_ARRAY)

