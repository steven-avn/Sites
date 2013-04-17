PROGRAM_NAME='MAIN'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 09/11/2012  AT: 12:02:50        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
	PROGRAMMER: Steven Grobler
	CLIENT: MINISTRY OF GENDER WINDHOEK 5TH & 6TH FLOOR

	MASTER (NI-2100) IP: 192.168.1.101
	TP1 (NXD-700i) IP: 192.168.1.102
	LUTRON INTERFACE () IP: 192.168.1.103 PASSW:1234
	 ESN: 0073F968, NWK DEVICE (S/No): 0x0031260D

*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

///////////////////////RELAY DEVICES/////////////////////
dvSCREENS			=		5001:4:0		//SCREENS
dvCAB_LIGHTS	=		5001:4:0		//Cabinet Lights

//////////////////////RS232 DEVICES////////////////////////
dvCLOUD1			=		5001:1:0		//CLOUD CX-462 AUDIO MIXER
dvPROJ1				=		5001:2:0		//SONY VLP-FH30 PROJECTORS
dvLUTRON			=		5001:3:0		//LUTRON INTERFACE

//////////////////////ETHERNET DEVICES/////////////////////
dvTP1					=		11001:1:0		//TOUCH PANEL

//////////////////////IR DEVICES////////////////////////
dvKRAMER			=		5001:5:0		//KRAMER VP729 SCALER (IR1)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////SCREEN CONSTANTS///////////////////////////////
SCREEN1_UP     =  	 1		//SCREEN UP
SCREEN1_DOWN   =  	 2		//SCREEN DOWN
CAB_LIGHTS_ON  =  	 4		//Cab Lights on
CAB_LIGHTS_OFF =  	 3		//Cab Lights off

VGA_1		=		2		//KRAMER VGA 1 INPUT
VGA_2		=		1		//KRAMER VGA 2 INPUT
HDMI_1	=		3		//KRAMER HDMI 1 INPUT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER TPBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
																		21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36}
VOLATILE INTEGER MUTE1 = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER MICMUTE1 = 0				//Mute1 On=1, Off=2
VOLATILE INTEGER VOL_LEVEL1	= 30	//Volume1 level for bargraph1
VOLATILE INTEGER MIC_LEVEL1 = 30		//Mic1 level for bargraph1
VOLATILE INTEGER LIGHT_LEVEL1	= 100		//Light level for bargraph3

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

#INCLUDE 'FUNCTIONS'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

SEND_COMMAND dvCLOUD1,'SET BAUD,9600,N,8,1'		//Streight Cable,Digital(BackPanel),Remote(FrontPanel)
SEND_COMMAND dvPROJ1,"'SET BAUD,38400,E,8,1,DISABLE'"		//X-Over Cable,SONY FH-30 232 SETTINGS
SEND_COMMAND dvLUTRON,'SET BAUD,9600,N,8,1'		//Streight Cable,LUTRON RS232 STETTINGS for control device

CREATE_LEVEL dvTP1,1,VOL_LEVEL1	//Level for TPbargraph
CREATE_LEVEL dvTP1,3,LIGHT_LEVEL1	//Level for TPbargraph

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[dvLUTRON]
{
	 ONLINE:
			{
			send_string dvLUTRON, "'#INTEGRATIONID,1,0073F968,4',$0D,$0A"	//Set integration ID for dimming device s/n:0073F968 to 4
			send_string dvLUTRON, "'#INTEGRATIONID,1,0073F96A,4',$0D,$0A"	//Set integration ID for dimming device s/n:0073F968 to 4
			}

	 STRING:
			{
			SEND_STRING 0, DATA.TEXT
			}
}


BUTTON_EVENT[dvTP1,TPBUTTONS]
{
	 PUSH:
	 {
			TO[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 1:	pulse [dvKRAMER,VGA_2]		//VGA2 (SMARTBOARD)
									CALL 'Projector1_On'
									call 'mainLights25%'
									SEND_STRING dvCLOUD1, '<MU,SA2/>'		//SMARTBOARD IN2
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1

				 CASE 2:	pulse [dvKRAMER,HDMI_1]		//HDMI1 (POPUP1 HDMI)
									CALL 'Projector1_On'
									call 'mainLights25%'
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//POPUP IN1
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN2 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1

				 CASE 5:	pulse [dvKRAMER,VGA_1]		//VGA1 (POPUP LAPTOP)
									CALL 'Projector1_On'
									call 'mainLights25%'
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//POPUP IN1
									SEND_STRING dvCLOUD1, '<MU,LA40/>'		//POPUP IN1 LEVEL 50%
									SEND_LEVEL dvTP1,1,VOL_LEVEL1
									SEND_STRING dvCLOUD1, '<MI,LA40/>'		//MIC LEVEL 50%
									SEND_LEVEL dvTP1,2,MIC_LEVEL1

				 CASE 3:	CALL 'Projector1_Off'		//PROJECTOR OFF
									call 'mainLights100%'

				 CASE 4:	IF (MUTE1 == 0)
									{
										 SEND_STRING dvCLOUD1, '<MU,M/>'		//MAIN MUTE
										 MUTE1 = 1
										 ON [dvTP1,4]
									}
									ELSE
									{
										 SEND_STRING dvCLOUD1, '<MU,O/>'		//MAIN UNMUTE
										 MUTE1 = 0
										 OFF [dvTP1,4]
									}

				 CASE 6:	pulse [dvKRAMER,VGA_2]		//VGA2 (SMARTBOARD)
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//POPUP IN1

				 CASE 8:	pulse [dvKRAMER,HDMI_1]		//HDMI1 (POPUP1 HDMI)
									SEND_STRING dvCLOUD1, '<MU,SA1/>'		//POPUP IN1

				 CASE 9:	pulse [dvKRAMER,VGA_1]		//VGA1 (POPUP LAPTOP)
									SEND_STRING dvCLOUD1, '<MU,SA2/>'		//SMARTBOARD IN2

				 case 14:	call 'mainLightsOn/Off'

				 case 16:	call 'mainLights25%'

				 case 17:	call 'mainLights0%'
			}
	 }
}

BUTTON_EVENT[dvTP1,TPBUTTONS]
{
	 HOLD[1,REPEAT]:
	 {
			PULSE[dvTP1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
				 CASE 10:	CALL 'Main1_VolUp'		//MAIN HALL VOLUME UP
				 CASE 11:	CALL 'Main1_VolDown'		//MAIN HALL VOLUME DOWN
				 CASE 12:	CALL 'Main1_MicUp'		//MAIN HALL MIC UP
				 CASE 13:	CALL 'Main1_MicDown'		//MAIN HALL MIC DOWN
			}
	 }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP1,4] = MUTE1
[dvTP1,14] = mainLights
[dvTP1,16] = mainLightsPresentation

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)