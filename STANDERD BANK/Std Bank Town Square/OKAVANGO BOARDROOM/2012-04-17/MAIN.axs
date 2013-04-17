PROGRAM_NAME='MAIN'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
		CLIENT: STD BANK OKAVANGO BOARDROOM
		MASTER (NI-2100) IP: 192.168.0.10
		TP1 (NXD-500i) IP: 192.168.0.11
		DIMMER AXLINK: 170
		VOL3_1 AXLINK: 87
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

////////////////////////RELAYS////////////////////////////

dvRELAYS						=		5001:4:1								  	//RELAYS FOR SCREEN AND LIFT

///////////////////////AXLINK DEVICES/////////////////////

dvLIGHTS						=		0170:1:1					 					 //RE-DM4 DIMMER FOR LIGHTS
dvVOL3_1						=		0087:1:1					  				 //VOL CONTROL

//////////////////////RS232 DEVICES////////////////////////

dvPROJECTOR					=		5001:1:1											//NEC PROJECTOR

//////////////////////ETHERNET DEVICES/////////////////////

dvTP1								=		10001:1:1										 //TOUCH PANEL

//////////////////////IR DEVICES///////////////////////////

dvDVD								=		5001:6:1										 //DVD/VCR SAMSUNG DVD-V70

//////////////////////IO DEVICES///////////////////////////

dvPIR								=		5001:9:1										 //MOTION SENSOR


(***********************************************************)
(*          CONNECT LEVEL DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONNECT_LEVEL
                 
(dvTP1,1,dvVOL3_1,1,dvVOL3_1,2,dvVOL3_1,3)   		 //  CONNECTS LEVELS AT COMPILE 


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//////////////DVD CONSTANTS////////////////////////////////
DVD_PLAY        =    3 
DVD_STOP        =    4
DVD_PAUSE       =    3
DVD_NEXT        =    6
DVD_PREV        =    5 
DVD_MENU   	    =    7
DVD_OK	        =    8
DVD_UP          =    9
DVD_RIGHT       =    10
DVD_DOWN	      =    11
DVD_LEFT        =    12
DVD_EXIT				=		 13
DVD_POWER			  =    14
DVD_SELECT			=			1
VCR_SELECT			=			2

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER VOL_LEVEL   											  	    	//VOLUME LEVEL FOR BARGRAPH
MUTE
DEVCHAN PIR			=			{dvPIR,1}											//PIR PORT 9 CHANNEL 1
INTEGER WAIT_TIME		=		3000  											//WAIT TIME IS 5 MIN
INTEGER PIR_CONTOL

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

([dvRELAYS,1],[dvRELAYS,2])

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvPROJECTOR, "'SET BAUD,38400,N,8,1'"	 //NEC PROJ RD-232 SETTINGS
CREATE_LEVEL dvVOL3_1,1,VOL_LEVEL			 //LEVEL FOR TP BARGRAPH 3RD FL BOARDROOM
PIR_CONTOL=0

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//////////////////////CHANNEL EVENT FOR MOTION DETECTOR////////////////////////


CHANNEL_EVENT[PIR]
{
	OFF:
	{
		IF(PIR_CONTOL=0)
		{
			CANCEL_ALL_WAIT															//CALCELS ALL ACTIVE WAITS
			SEND_COMMAND dvLIGHTS, "'P5-6L100%T2'"			//SWITCHES ALL LIGHTS ON
		}
	}

	ON:
	{
		IF(PIR_CONTOL=0)
		{
			WAIT WAIT_TIME															//STARTS WAITTIME (6000)(10MIN)
			SEND_COMMAND dvLIGHTS, "'P1-6L0%T5'"				//SWITCHES LIGHTS OFF
		}
	}
}


/////////////////////EVENTS FOR TOUCHPANEL FOR BOARDROOM///////////////////////
BUTTON_EVENT[dvTP1,1]																		//PRESENTATION
BUTTON_EVENT[dvTP1,2]																		//DVD
BUTTON_EVENT[dvTP1,3]																		//PC
BUTTON_EVENT[dvTP1,4]																		//ALL OFF
BUTTON_EVENT[dvTP1,5]																		//VOLUME UP
BUTTON_EVENT[dvTP1,6]																		//VOLUME DWN
BUTTON_EVENT[dvTP1,7]																		//DVD PLAY
BUTTON_EVENT[dvTP1,8]																		//DVD STOP
BUTTON_EVENT[dvTP1,9]																		//DVD NEXT
BUTTON_EVENT[dvTP1,10]																	//DVD PREVIOUS	
BUTTON_EVENT[dvTP1,11]																	//DVD PAUSE
BUTTON_EVENT[dvTP1,12]																	//DVD SELECT
BUTTON_EVENT[dvTP1,13]																	//VCR SELECT
BUTTON_EVENT[dvTP1,14]																	//DVD MENU
BUTTON_EVENT[dvTP1,15]																	//DVD OK
BUTTON_EVENT[dvTP1,16]																	//DVD UP
BUTTON_EVENT[dvTP1,17]																	//DVD RIGHT	
BUTTON_EVENT[dvTP1,18]																	//DVD DOWN
BUTTON_EVENT[dvTP1,19]																	//DVD LEFT
BUTTON_EVENT[dvTP1,20]																	//DVD/VCR POWER
BUTTON_EVENT[dvTP1,21]																	//MUTE
BUTTON_EVENT[dvTP1,22]																	//AIRCON ON/OFF
BUTTON_EVENT[dvTP1,23]																	//PROJECTOR ON
BUTTON_EVENT[dvTP1,24]																	//PROJECTOR OFF

{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE  1: ON[dvRELAYS,1]														//LOWER SCREEN & LIFT
							 PIR_CONTOL=1
							 SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
							 SEND_COMMAND dvLIGHTS, "'P1-4L25%T5'"		//ALL LIGHTS TO 25%
							 SEND_COMMAND dvLIGHTS, "'P5-6L0%T0'"			//TURN FLUORESCENTS OFF
							 WAIT 20
								SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$02,$0A"	//VGA INPUT 2
							  SEND_STRING dvVOL3_1, "'P2L50%T5'"			//CHANNEL 2 TO 50%
							 PULSE[dvVOL3_1,3]												//ALL CHANNELS MUTE
							 WAIT 240
							 {
								OFF[dvRELAYS,1]
							 }
			CASE  2: PIR_CONTOL=1
							 SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
							 ON[dvRELAYS,1]														//LOWER SCREEN & LIFT
							 SEND_COMMAND dvLIGHTS, "'P1-4L25%T5'"		//ALL LIGHTS TO 25%
							 SEND_COMMAND dvLIGHTS, "'P5-6L0%T0'"			//TURN FLUORESCENTS OFF
							 WAIT 20;
								SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$06,$0E"	//VIDEO INPUT
							  SEND_STRING dvVOL3_1, "'P1L50%T5'"				//CHANNEL 2 TO 50%
							 PULSE[dvVOL3_1,3]												//ALL CHANNELS MUTE
							 WAIT 240
							 {
								OFF[dvRELAYS,1]
							 }
							 
			CASE  3: PIR_CONTOL=1
							 SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
							 ON[dvRELAYS,1]														//LOWER SCREEN & LIFT
							 SEND_COMMAND dvLIGHTS, "'P1-4L25%T5'"		//ALL LIGHTS TO 25%
							 SEND_COMMAND dvLIGHTS, "'P5-6L0%T0'"			//TURN FLUORESCENTS OFF
							 WAIT 20;
								SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$01,$09"	//VGA INPUT 1
							  SEND_STRING dvVOL3_1, "'P3L50%T5'"				//CHANNEL 2 TO 50%
								PULSE[dvVOL3_1,3]												//ALL CHANNELS MUTE
							 WAIT 240
							 {
								OFF[dvRELAYS,1]
							 }
							 
			CASE  4: ON[dvRELAYS,2]														//RAISE SCREEN % LIFT
							 PIR_CONTOL=0
							 SEND_COMMAND dvLIGHTS, "'P1-6L100%T5'"		//ALL LIGHTS TO 100%
							 PULSE[dvVOL3_1,3]												//ALL CHANNELS MUTE
							 SEND_STRING dvPROJECTOR, "$02,$01,$00,$00,$00,$03"		//OFF
							 WAIT 240
							 {
								OFF[dvRELAYS,2]
							 }
							 
			CASE  5: TO[dvVOL3_1,1]														//VOLUME UP
			CASE  6: TO[dvVOL3_1,2]														//VOLUME DOWN
			CASE  7: PULSE[dvDVD,DVD_PLAY]										//DVD PLAY
			CASE  8: PULSE[dvDVD,DVD_STOP]										//DVD STOP
			CASE  9: PULSE[dvDVD,DVD_NEXT]										//DVD NEXT
			CASE 10: PULSE[dvDVD,DVD_PREV]										//DVD PREVIOUS
			CASE 11: PULSE[dvDVD,DVD_PAUSE]										//DVD PAUSE 
			CASE 12: PULSE[dvDVD,DVD_SELECT]									//DVD SELECT
			CASE 13: PULSE[dvDVD,VCR_SELECT]									//VCR SELECT
			CASE 14: PULSE[dvDVD,DVD_MENU]										//DVD MENU
			CASE 15: PULSE[dvDVD,DVD_OK]											//DVD OK
			CASE 16: PULSE[dvDVD,DVD_UP]											//DVD UP
			CASE 17: PULSE[dvDVD,DVD_RIGHT]										//DVD RIGHT
			CASE 18: PULSE[dvDVD,DVD_DOWN]										//DVD DOWN
			CASE 19: PULSE[dvDVD,DVD_LEFT]										//DVD LEFT
			CASE 20: PULSE[dvDVD,DVD_POWER]										//DVD/VCR POWER
			CASE 21: MUTE = !MUTE 										 //TOGGLE VARIABLE TRUE / FALSE
								IF(MUTE)
										 {
											 ON[dvTP1,21]
											 ON[dvVOL3_1,3]										// MUTE/UNMUTE  VOL 1&2  
										 }
								ELSE 
										 {
											 OFF[dvVOL3_1,3]									// MUTE/UNMUTE  VOL 1&2
											 OFF[dvTP1,21]
										 }
			CASE 22:	PULSE[dvRELAYS,3]												//SWITCH AIRCON ON/OFF
			CASE 23:	SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
			CASE 24:	SEND_STRING dvPROJECTOR, "$02,$01,$00,$00,$00,$03"		//OFF
		}
  }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP1,21]=[dvVOL3_1,3]
SEND_LEVEL dvTP1,1,VOL_LEVEL     							 	//SHOW VOLUME LEVEL ON BARGRAPH


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

