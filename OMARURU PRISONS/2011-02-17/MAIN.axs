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
	CLIENT: Omaruru Prison
	MASTER SYSTEM 1 (NI-2100) IP: 192.168.0.100
	MASTER SYSTEM 2 (NI-700)	IP: 192.168.0.101
	TP1 (NXD-435) IP: 192.168.0.110 (dvTP1) DPS: 10001
	SCALER (PTN SC91DM) RS232 PORT 1 DPS: 5001:1:0 (dvSCALER)
	MATRIX (PTN MVG44A) IR PORT 1 DPS: 5001:5:1 (dvMATRIX)
	AUDIO CONTROLER (CLOUD CX462) RS232 PORT 2 DPS: 5001:2:1 (dvAUDIO)
	PROJECTOR (NEC NP610) RS232 PORT 3 DPS: 5001:3:1 (dvPROJECTOR)
	SCREEN IR PORT 2 DPS: 5001:6:1 (dvSCREEN)
	Mvix PVR IR PORT 3 DPS: 5001:7:1 (dvPVR)
	PTZ CAMERA RS232 PORT 1 SYSTEM 2 DPS: 5001:1:2 (dvPTZ)
*) 
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

//////////////////////RS232 DEVICES//////////////////////
dvSCALER				=		5001:1:1						//PUTRON SC91DM SCALER SWITCHEr
dvCLOUD					=		5001:2:1						//CLOUD CX462 AUDIO CONTROLLER
dvPROJECTOR			=		5001:1:2						//PTZ ON NI-700 PORT 1

dvPTZ						=		5001:3:1						//PTZ ON NI-2100 PORT 3
dvMATRIX				=		5001:2:2						//PTN MCV44A ON NI-2100

//////////////////////ETHERNET DEVICES///////////////////
dvTP1						=		10001:1:1						//TOUCH PANEL

//////////////////////IR DEVICES/////////////////////////
dvSCREEN				=		5001:6:1						//Screen IR PORT 6
dvPVR						=		5001:7:1						//Mvix PVR


(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////SCREEN CONSTANTS/////////////////////////////
SCR_UP     			=  	 	1 								//SCREEN UP
SCR_DOWN      	=    	3 								//SCREEN DOWN

/////////////PVR CONSTANTS///////////////////////////////
PLAY     				=  	 	1 								//PLAY
STOP      			=    	2 								//STOP
PAUSE						=			3 								//PAUSE
RECORD 					=  	 	4 								//RECORD
LIBRARY					=			6 								//LIBRARY
EXIT   					=  	 	7 								//RETURN
UP      				=    	10 								//UP
RIGHT						=			11 								//RIGHT
DOWN    		 		=  	 	12 								//DOWN
LEFT      			=    	13 								//LEFT
OK							=			14 								//OK
POWER						=			9									//POWER


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

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

SET_PULSE_TIME (2)
SEND_COMMAND dvSCALER,"'SET BAUD,9600,N,8,1'"		 				//SCALER SERIAL COMMS SETTINGS
SEND_COMMAND dvCLOUD,"'SET BAUD,9600,N,8,1'"		 				//CLOUD SERIAL COMMS SETTINGS
SEND_COMMAND dvPROJECTOR, "'SET BAUD,9600,N,8,1'"	 			//NEC PROJ RS-232 SETTINGS
SEND_COMMAND dvPTZ, "'SET BAUD,9600,N,8,1'"	 		 				//PTZ CAM RS-485 SETTINGS
SEND_COMMAND dvMATRIX,'SET BAUD,9600,N,8,1'		 	 				//PUTRON SERIAL COMMS SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//////////////////////EVENTS FOR TOUCHPANEL///////////////////
BUTTON_EVENT[dvTP1,1]																		//PC
BUTTON_EVENT[dvTP1,2]																		//POPUP
BUTTON_EVENT[dvTP1,3]																		//CAMS
BUTTON_EVENT[dvTP1,4]																		//OFF
BUTTON_EVENT[dvTP1,9]																		//MUTE
BUTTON_EVENT[dvTP1,10]																	//PLAY
BUTTON_EVENT[dvTP1,11]																	//STOP	
BUTTON_EVENT[dvTP1,12]																	//PAUSE
BUTTON_EVENT[dvTP1,13]																	//UNMUTE
BUTTON_EVENT[dvTP1,14]																	//RECORD
BUTTON_EVENT[dvTP1,15]																	//LIBRARY
BUTTON_EVENT[dvTP1,16]																	//EXIT
BUTTON_EVENT[dvTP1,17]																	//UP
BUTTON_EVENT[dvTP1,18]																	//RIGHT
BUTTON_EVENT[dvTP1,19]																	//DOWN
BUTTON_EVENT[dvTP1,20]																	//OK
BUTTON_EVENT[dvTP1,21]																	//LEFT
BUTTON_EVENT[dvTP1,22]																	//C_UP
BUTTON_EVENT[dvTP1,23]																	//C_LEFT
BUTTON_EVENT[dvTP1,24]																	//C_RIGHT
BUTTON_EVENT[dvTP1,25]																	//C_DOWN
BUTTON_EVENT[dvTP1,26]																	//C_OK
BUTTON_EVENT[dvTP1,27]																	//C_ZOOM +
BUTTON_EVENT[dvTP1,28]																	//C_ZOOM -
BUTTON_EVENT[dvTP1,29]																	//PTZ_SELECT
BUTTON_EVENT[dvTP1,30]																	//FIXED_SELECT
BUTTON_EVENT[dvTP1,31]																	//Mvix POWER
{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE  1: SEND_STRING dvSCALER, "'0703%'"					//PC IN VGA1 TO OUT 1024X768
							 SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
 							 PULSE[dvSCREEN,SCR_DOWN]									//SCREEN DOWN
							 SEND_STRING dvCLOUD, "'<MU,SA1/>'"				//PC IN1
							 SEND_STRING dvCLOUD, "'<MU,LA40/>'"			//PC IN1 LEVEL 50%
							 SEND_STRING dvCLOUD, "'<MI,LA40/>'"			//MIC LEVEL 50%
							 WAIT 40
							 SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$01,$09"	//VGA INPUT 1
								
			CASE  2: SEND_STRING dvSCALER, "'0704%'"					//POPUP IN VGA2 TO OUT 1024X768
							 SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
 							 PULSE[dvSCREEN,SCR_DOWN]									//SCREEN DOWN
							 SEND_STRING dvCLOUD, "'<MU,SA2/>'"				//POPUP IN2
							 SEND_STRING dvCLOUD, "'<MU,LA40/>'"			//POPUP IN2 LEVEL 50%
							 SEND_STRING dvCLOUD, "'<MI,LA40/>'"			//MIC LEVEL 50%
							 WAIT 40
							 SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$01,$09"	//VGA INPUT 1
							 
			CASE  3: SEND_STRING dvSCALER, "'0708%'"					//PVR IN COMP7 TO OUT 1024X768
							 SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
 							 PULSE[dvSCREEN,SCR_DOWN]									//SCREEN DOWN
							 
 							 PULSE[dvMATRIX,13]												//VIDEO SELECT
							 WAIT 10
 							 PULSE[dvMATRIX,1]												//INPUT 1 PTZ
							 WAIT 10
 							 PULSE[dvMATRIX,21]												//OUTPUT 1
							 
							 SEND_STRING dvCLOUD, "'<MU,SA3/>'"				//PVR IN3
							 SEND_STRING dvCLOUD, "'<MU,LA40/>'"			//PVR IN3 LEVEL 50%
							 SEND_STRING dvCLOUD, "'<MI,LA40/>'"			//MIC LEVEL 50%
							 WAIT 20
							 SEND_STRING dvPROJECTOR, "$02,$03,$00,$00,$02,$01,$01,$09"	//VGA INPUT 1
								
			CASE  4: SEND_STRING dvSCALER, "'0701%'"					//PVR IN7 TO OUT 1024X768
							 SEND_STRING dvPROJECTOR, "$02,$01,$00,$00,$00,$03"		//OFF
 							 PULSE[dvSCREEN,SCR_UP]										//SCREEN UP
							 SEND_STRING dvCLOUD, "'<MU,SA0/>'"				//ALL INPUTS OFF
								
			CASE  9: SEND_STRING dvCLOUD, "'<MU,M/>'"					//MAIN MUTE
			
			CASE 10: PULSE[dvPVR,PLAY]												//PLAY
			CASE 11: PULSE[dvPVR,STOP]												//STOP
			CASE 12: PULSE[dvPVR,PAUSE]												//PAUSE
			
			CASE 13: SEND_STRING dvCLOUD, "'<MU,O/>'"					//MAIN UNMUTE
			
			CASE 14: PULSE[dvPVR,RECORD]											//RECORD
			CASE 15: PULSE[dvPVR,LIBRARY]											//LIBRARY
			CASE 16: PULSE[dvPVR,EXIT]												//EXIT
			CASE 17: PULSE[dvPVR,UP]													//UP
			CASE 18: PULSE[dvPVR,RIGHT]												//RIGHT
			CASE 19: PULSE[dvPVR,DOWN]												//DOWN
			CASE 20: PULSE[dvPVR,OK]													//OK
			CASE 21: PULSE[dvPVR,LEFT]												//LEFT
			
			CASE 22: SEND_STRING dvPTZ, "$FF,$01,$00,$08,$00,$20,$29"		//UP
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			CASE 23: SEND_STRING dvPTZ, "$FF,$01,$00,$04,$20,$00,$25"		//LEFT
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			CASE 24: SEND_STRING dvPTZ, "$FF,$01,$00,$02,$20,$00,$23"		//RIGHT
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			CASE 25: SEND_STRING dvPTZ, "$FF,$01,$00,$10,$00,$20,$31"		//DOWN
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			CASE 26: SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			CASE 27: SEND_STRING dvPTZ, "$FF,$01,$00,$20,$00,$00,$21"		//ZOOM +
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			CASE 28: SEND_STRING dvPTZ, "$FF,$01,$00,$40,$00,$00,$41"		//ZOOM -
							 WAIT 2
							 SEND_STRING dvPTZ, "$FF,$01,$00,$00,$00,$00,$01"		//STOP
			
			CASE 29: SEND_STRING dvMATRIX, "'1V1.'"						//IN1 TO OUT1 (VIDEO)
			CASE 30: SEND_STRING dvMATRIX, "'2V1.'"						//IN2 TO OUT1 (VIDEO)
			CASE 31: PULSE[dvPVR,POWER]												//Mvix POWER
		}	
  }
}

//////////////////////EVENTS FOR TOUCHPANEL///////////////////
BUTTON_EVENT[dvTP1,5]																		//VOLUME UP
BUTTON_EVENT[dvTP1,6]																		//VOLUME DWN
BUTTON_EVENT[dvTP1,7]																		//MIC VOL UP
BUTTON_EVENT[dvTP1,8]																		//MIC VOL DWN

{
  HOLD[1,REPEAT]:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 5: SEND_STRING dvCLOUD, "'<MU,LU5/>'"				//MAIN VOLUME UP
			CASE 6: SEND_STRING dvCLOUD, "'<MU,LD5/>'"				//MAIN VOLUME DOWN
			CASE 7: SEND_STRING dvCLOUD, "'<MI,LU1/>'"				//MIC VOLUME UP
			CASE 8: SEND_STRING dvCLOUD, "'<MI,LD1/>'"				//MIC VOLUME DOWN
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