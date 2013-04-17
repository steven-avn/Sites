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
	PROGRAMMER: Steven Grobler
	CLIENT: PWC WINDHOEK
	MASTER (NI-2100) IP: 192.168.0.10
	TP1 (NXD-430) IP: 192.168.0.11
	KP1 (MIO MODERO CLASSIC) AXLINK: 69
	KP2 (MIO MODERO CLASSIC) AXLINK: 86
	VOL3_1 AXLINK: 87
	VOL3_2 AXLINK: 88
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

///////////////////////AXLINK DEVICES/////////////////////

dvKP1				=		0069:1:1											 //KEYPAD IN GND FL TRAINING RM 1
dvKP2				=		0086:1:1											 //KEYPAD IN GND FL TRAINING RM 2

dvVOL3_1		=		0087:1:1									  	 //VOL CONTROL FOR TRAINING ROOMS
dvVOL3_2		=		0088:1:1											//VOL CONTROL FOR 3RD FL BOARD RM

//////////////////////RS232 DEVICES////////////////////////

dvPUTRON		=		5001:1:1												//PUTRON MVG88 VGA/AUDIO MATRIX
dvKRAMER		=		5001:2:1						//KRAMER VP-4x4, 4X4 VGA/XGA & AUDIO MATRIX

//////////////////////ETHERNET DEVICES/////////////////////

dvTP1				=		11001:1:1											 //TOUCH PANEL IN 3RD FL BOARD RM

//////////////////////IR DEVICES///////////////////////////

dvDSTV			=		5001:5:1										//DSTV DECODER FOR SYSTEM IR PORT 5
dvDVD				=		5001:6:1												 //DVD/VCR FOR SYSTEM IR PORT 6


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

//////////////DVD CONSTANTS////////////////////////////////
DVD_PLAY        =    19 
DVD_STOP        =    16
DVD_PAUSE       =    15
DVD_FFWD        =    22
DVD_REW         =    23
DVD_SELECT      =    3
VCR_SELECT      =    4


/////////////SOURCE CONSTANTS///////////////////////////////
SOURCE_DSTV     =  	 1 																	//DSTV
SOURCE_DVD      =    2 																	//DVD
SOURCE_PC       =    3 																	//PC             

/////////////DSTV CONSTANTS//////////////////////////////////
DSTV_VOL_UP     =    76
DSTV_VOL_DN     =    77
DSTV_CH_UP      =    79
DSTV_CH_DN      =    80
DSTV_0          =    10
DSTV_1   		    =    11
DSTV_2      	  =    12
DSTV_3        	=    13
DSTV_4  	      =    14
DSTV_5    	    =    15
DSTV_6      	  =    16
DSTV_7	        =    17
DSTV_8  	      =    18
DSTV_9    	    =    19

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER VOL_LEVEL   											  	    	//VOLUME LEVEL FOR BARGRAPH

(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvPUTRON,'SET BAUD,9600,N,8,1'		 	 //PUTRON SERIAL COMMS SETTINGS
SEND_COMMAND dvKRAMER,'SET BAUD,9600,N,8,1'			 //KRAMER SERIAL COMMS SETTINGS
SEND_COMMAND dvKP1,"'@BRT-32,10'"					//KEYPADS START BRIGHTNESS LEVEL 100%
SEND_COMMAND dvKP2,"'@BRT-32,10'"									 //SLEEP BRIGHTNESS LEVEL 30% 
CREATE_LEVEL dvVOL3_2,1,VOL_LEVEL			 //LEVEL FOR TP BARGRAPH 3RD FL BOARDROOM

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

/////////////////////EVENTS FOR KEYPAD 1 TRAINING ROOM 1///////////////////////
BUTTON_EVENT[dvKP1,1]																		//COMBINE PRESENTATION
BUTTON_EVENT[dvKP1,5]																		//SINGLE PRESENTATION
BUTTON_EVENT[dvKP1,2]																		//DSTV
BUTTON_EVENT[dvKP1,6]																		//DVD	
BUTTON_EVENT[dvKP1,3]																		//DVD PLAY
BUTTON_EVENT[dvKP1,7]																		//DVD STOP	
BUTTON_EVENT[dvKP1,4]																		//VOLUME UP
BUTTON_EVENT[dvKP1,8]																		//VOLUME DWN
{
  PUSH:
  {
		TO[dvKP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 1: SEND_STRING dvKRAMER, "$01,$81,$81,$81"	//COMBINE PRESEN(VIDEO)
								SEND_STRING dvKRAMER, "$01,$81,$82,$81"	//COMBINE PRESEN(VIDEO)
								SEND_STRING dvPUTRON, "'4A7,8.'"	//COMBINE AUDIO IN4 TO OUT7&8
								SEND_STRING dvPUTRON, "'5A7,8.'"	//COMBINE AUDIO IN5 TO OUT7,8
								SEND_STRING dvVOL3_1, "'P0L50%'"  //RAMPS BOTH CHANNELS TO 50%
				
				CASE 5: SEND_STRING dvKRAMER, "$01,$81,$81,$81"	//SINGLE PRESENT(VIDEO)
								SEND_STRING dvPUTRON, "'4A7.'"			 //SINGLE AUDIO IN4 TO OUT7
								SEND_STRING dvKRAMER, "$01,$82,$82,$81"	//SINGLE PRESENT(VIDEO)
								SEND_STRING dvPUTRON, "'5A8.'"			 //SINGLE AUDIO IN5 TO OUT8
								
				CASE 2: SEND_STRING dvPUTRON, "'1V8.'"			 //DSTV IN1 TO OUT8 (VIDEO)
								SEND_STRING dvPUTRON, "'1A7.'"			 //DSTV IN2 TO OUT7 (AUDIO)
								SEND_STRING dvKRAMER, "$01,$83,$81,$81" //VIDEO IN3 TO OUT1
								
				CASE 6: SEND_STRING dvPUTRON, "'2V8.'"				//DVD IN1 TO OUT8 (VIDEO)
								SEND_STRING dvPUTRON, "'2A7.'"				//DVD IN2 TO OUT7 (AUDIO)
								SEND_STRING dvKRAMER, "$01,$83,$81,$81"	//VIDEO IN3 TO OUT1
								
				CASE 3: PULSE[dvDVD,DVD_PLAY]										//DVD PLAY
				
				CASE 4: TO[dvVOL3_1,4]													//VOLUME UP
				
				CASE 7: PULSE[dvDVD,DVD_STOP]										//DVD STOP
				
				CASE 8: TO[dvVOL3_1,5]													//VOLUME DOWN
			}	
			
	}
}

/////////////////////EVENTS FOR KEYPAD 2 TRAINING ROOM 2///////////////////////
BUTTON_EVENT[dvKP2,1]																		//COMBINE DSTV
BUTTON_EVENT[dvKP2,5]																		//COMBINE DVD
BUTTON_EVENT[dvKP2,2]																		//DSTV
BUTTON_EVENT[dvKP2,6]																		//DVD	
BUTTON_EVENT[dvKP2,3]																		//DVD PLAY
BUTTON_EVENT[dvKP2,7]																		//DVD STOP
BUTTON_EVENT[dvKP2,4]																		//VOLUME UP
BUTTON_EVENT[dvKP2,8]																		//VOLUME DWN
{
  PUSH:
  {
		TO[dvKP2,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				CASE 1: SEND_STRING dvPUTRON, "'1A7,8.'"	   //COMBINE DSTV IN1 TO OUT7
								SEND_STRING dvKRAMER, "'1V8.'"			 //COMBINE DSTV IN1 TO OUT8
								SEND_STRING dvKRAMER, "$01,$83,$81,$81"	//COMBINE DSTV (VIDEO)
								SEND_STRING dvKRAMER, "$01,$83,$82,$81"	//COMBINE DSTV (VIDEO)
								SEND_COMMAND dvVOL3_1, "'P0L50%'"  //RAMPS BOTH CHANNELS TO 50%
					
				CASE 5: SEND_STRING dvPUTRON, "'2A7,8.'"				//COMBINE DVD AUDIO
								SEND_STRING dvKRAMER, "'2V8.'"					//COMBINE DVD VIDEO
								SEND_STRING dvKRAMER, "$01,$83,$81,$81"	//COMBINE DVD (VIDEO)
								SEND_STRING dvKRAMER, "$01,$83,$82,$81"	//COMBINE DVD (VIDEO)
								SEND_COMMAND dvVOL3_1, "'P0L50%'"  //RAMPS BOTH CHANNELS TO 50%
								
				CASE 2: SEND_STRING dvPUTRON, "'1B8.'"			//DSTV IN1 TO OUT8 (AUDIO)
								SEND_STRING dvKRAMER, "$01,$83,$82,$81" //VIDEO IN3 TO OUT2
								
				CASE 6: SEND_STRING dvPUTRON, "'2V8.'"				//DVD IN1 TO OUT8 (VIDEO)
								SEND_STRING dvPUTRON, "'2A8.'"				//DVD IN2 TO OUT7 (AUDIO)
								SEND_STRING dvKRAMER, "$01,$83,$82,$81" //VIDEO IN3 TO OUT2
								
				CASE 3: PULSE[dvDVD,DVD_PLAY]										//DVD PLAY
				
				CASE 4: TO[dvVOL3_1,7]													//VOLUME UP
				
				CASE 7: PULSE[dvDVD,DVD_STOP]										//DVD STOP
				
				CASE 8: TO[dvVOL3_1,8]													//VOLUME DOWN
			}
		}
}

//////////////////////EVENTS FOR TOUCHPANEL 3RD FL BOARDROOM///////////////////
BUTTON_EVENT[dvTP1,1]																		//PC
BUTTON_EVENT[dvTP1,2]																		//DSTV
BUTTON_EVENT[dvTP1,3]																		//DVD
BUTTON_EVENT[dvTP1,4]																		//VOLUME UP	
BUTTON_EVENT[dvTP1,5]																		//VOLUME DWN
BUTTON_EVENT[dvTP1,6]																		//CHANNEL UP
BUTTON_EVENT[dvTP1,7]																		//CHANNEL DWN
BUTTON_EVENT[dvTP1,8]																		//DVD PLAY
BUTTON_EVENT[dvTP1,9]																		//DVD STOP
BUTTON_EVENT[dvTP1,10]																	//DVD NEXT
BUTTON_EVENT[dvTP1,11]																	//DVD PREVIOUS	
BUTTON_EVENT[dvTP1,12]																	//DVD PAUSE
BUTTON_EVENT[dvTP1,13]																	//DSTV 0
BUTTON_EVENT[dvTP1,14]																	//DSTV 1
BUTTON_EVENT[dvTP1,15]																	//DSTV 2
BUTTON_EVENT[dvTP1,16]																	//DSTV 3
BUTTON_EVENT[dvTP1,17]																	//DSTV 4
BUTTON_EVENT[dvTP1,18]																	//DSTV 5
BUTTON_EVENT[dvTP1,19]																	//DSTV 6
BUTTON_EVENT[dvTP1,20]																	//DSTV 7
BUTTON_EVENT[dvTP1,21]																	//DSTV 8
BUTTON_EVENT[dvTP1,22]																	//DSTV 9
BUTTON_EVENT[dvTP1,23]																	//DSTV TO TV's
BUTTON_EVENT[dvTP1,24]																	//DVD TO TV's
BUTTON_EVENT[dvTP1,25]																	//PC TO TV's
BUTTON_EVENT[dvTP1,26]																	//DSTV VOLUME UP
BUTTON_EVENT[dvTP1,27]																	//DSTV VOLUME DOWN
BUTTON_EVENT[dvTP1,28]																	//DVD SELECT
BUTTON_EVENT[dvTP1,29]																	//VCR SELECT
{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE  1: SEND_STRING dvPUTRON, "'3B6.'"						//PC IN3 TO OUT6
			CASE  2: SEND_STRING dvPUTRON, "'1B6.'"						//DSTV IN1 TO OUT6
			CASE  3: SEND_STRING dvPUTRON, "'2B6.'"						//DVD IN2 TO OUT6
			CASE  4: TO[dvVOL3_2,1]														//VOLUME UP
			CASE  5: TO[dvVOL3_2,2]														//VOLUME DOWN
			CASE  6: PULSE[dvDSTV,DSTV_CH_UP]									//CHANNEL UP
			CASE  7: PULSE[dvDSTV,DSTV_CH_DN]									//CHANNEL DWN
			CASE  8: PULSE[dvDVD,DVD_PLAY]										//DVD PLAY
			CASE  9: PULSE[dvDVD,DVD_STOP]										//DVD STOP
			CASE 10: PULSE[dvDVD,DVD_FFWD]										//DVD NEXT
			CASE 11: PULSE[dvDVD,DVD_REW]											//DVD PREVIOUS
			CASE 12: PULSE[dvDVD,DVD_PAUSE]										//DVD PAUSE 
			CASE 13: PULSE[dvDSTV,DSTV_0]											//DSTV 0
			CASE 14: PULSE[dvDSTV,DSTV_1]											//DSTV 1
			CASE 15: PULSE[dvDSTV,DSTV_2]											//DSTV 2
			CASE 16: PULSE[dvDSTV,DSTV_3]											//DSTV 3
			CASE 17: PULSE[dvDSTV,DSTV_4]											//DSTV 4
			CASE 18: PULSE[dvDSTV,DSTV_5]											//DSTV 5
			CASE 19: PULSE[dvDSTV,DSTV_6]											//DSTV 6	
			CASE 20: PULSE[dvDSTV,DSTV_7]											//DSTV 7
			CASE 21: PULSE[dvDSTV,DSTV_8]											//DSTV 8
			CASE 22: PULSE[dvDSTV,DSTV_9]											//DSTV 9
			CASE 23: SEND_STRING dvPUTRON, "'1B1,2,3,4,5.'"		//DSTV TO TV's
			CASE 24: SEND_STRING dvPUTRON, "'2B1,2,3,4,5.'"		//DVD TO TV's
			CASE 25: SEND_STRING dvPUTRON, "'3B1,2,3,4,5.'"		//PC TO TV's
			CASE 26: PULSE[dvDSTV,DSTV_VOL_UP]								//DSTV VOLUME UP
			CASE 27: PULSE[dvDSTV,DSTV_VOL_DN]								//DSTV VOLUME DOWN
			CASE 28: PULSE[dvDSTV,DVD_SELECT]									//DVD SELECT
			CASE 29: PULSE[dvDSTV,VCR_SELECT]								//VCR SELECT
		}
  }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

SEND_LEVEL dvTP1,1,VOL_LEVEL     							 	//SHOW VOLUME LEVEL ON BARGRAPH

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

