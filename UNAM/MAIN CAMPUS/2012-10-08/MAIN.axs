PROGRAM_NAME='MAIN'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 10/08/2012  AT: 10:33:10        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: UNAM Main Campus
	MASTER SYSTEM 1 (NI-2100) IP: 192.168.1.100
	TP1 (NXD-435) IP: 192.168.1.110 (dvTP1) DPS: 10001
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

//////////////////////RS232 DEVICES//////////////////////
dvCLOUD					=		5001:2:0	//CLOUD CX462 AUDIO CONTROLLER
dvPROJECTOR			=		5001:1:0

//////////////////////ETHERNET DEVICES///////////////////
dvTP1						=		10001:1:0	//TOUCH PANEL

////////////////////RELAYS//////////////////////////////
dvKRAMER				=		5001:4:0	//Kramer VP-211DS
dvSCREEN				=		5001:4:0	//Screen

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////SCREEN CONSTANTS/////////////////////////////
SCR_UP     			=  	 	1 								//SCREEN UP
SCR_DOWN      	=    	2 								//SCREEN DOWN
KRAMER_IN_1			=			3
KRAMER_IN_2			=			4

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

SEND_COMMAND dvCLOUD,"'SET BAUD,9600,N,8,1'"		//CLOUD SERIAL COMMS SETTINGS
SEND_COMMAND dvPROJECTOR, "'SET BAUD,38400,N,8,1'"		//NEC PROJ RS-232 SETTINGS

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//////////////////////EVENTS FOR TOUCHPANEL///////////////////
BUTTON_EVENT[dvTP1,1]																		//PC
BUTTON_EVENT[dvTP1,2]																		//POPUP
BUTTON_EVENT[dvTP1,4]																		//OFF
BUTTON_EVENT[dvTP1,9]																		//MUTE
BUTTON_EVENT[dvTP1,10]																	//UNMUTE
{
  PUSH:
  {
		TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE  1: SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
 							 PULSE[dvSCREEN,SCR_DOWN]									//SCREEN DOWN
						   PULSE[dvKRAMER,KRAMER_IN_1]
							 SEND_STRING dvCLOUD, "'<MU,SA1/>'"				//PC IN1
							 SEND_STRING dvCLOUD, "'<MU,LA40/>'"			//PC IN1 LEVEL 50%
							 SEND_STRING dvCLOUD, "'<MI,LA40/>'"			//MIC LEVEL 50%
							 send_string 0, 'PC Selected';

			CASE  2: SEND_STRING dvPROJECTOR, "$02,$00,$00,$00,$00,$02"		 //ON
 							 PULSE[dvSCREEN,SCR_DOWN]									//SCREEN DOWN
						   PULSE[dvKRAMER,KRAMER_IN_2]
							 SEND_STRING dvCLOUD, "'<MU,SA1/>'"				//PC IN1
							 SEND_STRING dvCLOUD, "'<MU,LA40/>'"			//PC IN1 LEVEL 50%
							 SEND_STRING dvCLOUD, "'<MI,LA40/>'"			//MIC LEVEL 50%
							 send_string 0, 'Popup Selected';

			CASE  4: SEND_STRING dvPROJECTOR, "$02,$01,$00,$00,$00,$03"		//OFF
 							 PULSE[dvSCREEN,SCR_UP]										//SCREEN UP
							 SEND_STRING dvCLOUD, "'<MU,SA0/>'"				//ALL INPUTS OFF
							 send_string 0, 'System off called';

			CASE  9: SEND_STRING dvCLOUD, "'<MU,M/>'"					//MAIN MUTE
								on[dvTP1,9]
								off[dvTP1,10]
								send_string 0, 'Mute called';

			CASE 10: SEND_STRING dvCLOUD, "'<MU,O/>'"					//MAIN UNMUTE
								off[dvTP1,9]
								on[dvTP1,10]
								send_string 0, 'Unmute called';
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
								send_string 0, 'Main Volume Up';
			CASE 6: SEND_STRING dvCLOUD, "'<MU,LD5/>'"				//MAIN VOLUME DOWN
								send_string 0, 'Main Volume Down';
			CASE 7: SEND_STRING dvCLOUD, "'<MI,LU1/>'"				//MIC VOLUME UP
								send_string 0, 'Mic Volume Up';
			CASE 8: SEND_STRING dvCLOUD, "'<MI,LD1/>'"				//MIC VOLUME DOWN
								send_string 0, 'Mic Volume Down';
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