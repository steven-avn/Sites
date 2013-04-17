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
	CLIENT: Polytechnic
	MASTER SYSTEM 0 (DVX-2100HD) IP: 192.168.0.100
*) 
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

SWITCHER				 	= 	5002:1:0		//AUDIO/VIDEO SWITCHER
AUDIO_INPUT_1			=		5002:1:0		//AUDIO INPUT 1
AUDIO_INPUT_2			=		5002:2:0		//AUDIO INPUT 2
AUDIO_OUTPUT_LINE	=		5002:2:1		//AUDIO LINE OUTPUT PORT 2
AUDIO_OUTPUT			=		5002:1:1		//AUDIO OUTPUT PORT 1
MIC_1							=		5002:7:0   // MIC INPUT 1
MIC_2							=		5002:8:0   // MIC INPUT 2

// NEC Projector Module Code
	vdvNECNPV260W = 41001:1:0  	// Virtual Duet device
	dvNECNPV260WTp = 10001:1:0 	// Touch panel
	//dvNECNPV260W = 5001:1:0 		// Serial connection
	dvNECNPV260W = 0:3:0 		// IP Connection
	dvKP = 85:1:0

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER KPBUTTONS[]	=	 {1,2,3,4,5,6,7,8}
VOLATILE INTEGER PROJECTOR_POWER = 0
VOLATILE INTEGER LIGHTS_POWER = 0
VOLATILE INTEGER InputSelected = 0		//0=NONE, 1=PC, 2=LAPTOP

// NEC Projector Module Code
	DEV vdvDev[] = {vdvNECNPV260W}
	// ----------------------------------------------------------
	// CURRENT DEVICE NUMBER ON TP NAVIGATION BAR
	INTEGER nNECNPV260W = 1
	// ----------------------------------------------------------
	// DEFINE THE PAGES THAT YOUR COMPONENTS ARE USING IN THE 
	// SUB NAVIGATION BAR HERE
	INTEGER nNECNPV260WPages[] = { 1 }
	INTEGER nLampPages[] = { 2 }
	INTEGER nDisplayPages[] = { 3,4,5 }
	INTEGER nSourceSelectPages[] = { 6 }
	INTEGER nVolumePages[] = { 7 }
	INTEGER nMenuPages[] = { 8,9,10 }
	INTEGER nModulePages[] = { 11 }
	INTEGER nZonePages[] = {12}

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

// NEC Projector Module Code
	// ----------------------------------------------------------
	// DEVICE MODULE GROUPS SHOULD ALL HAVE THE SAME DEVICE NUMBER
	DEFINE_MODULE 'NEC NPV260W DisplayComponent' display(vdvDev, dvNECNPV260WTp, nNECNPV260W, nDisplayPages)
	DEFINE_MODULE 'NEC NPV260W LampComponent' lamp(vdvDev, dvNECNPV260WTp, nNECNPV260W, nLampPages)
	DEFINE_MODULE 'NEC NPV260W MenuComponent' menu(vdvDev, dvNECNPV260WTp, nNECNPV260W, nMenuPages)
	DEFINE_MODULE 'NEC NPV260W ModuleComponent' module(vdvDev, dvNECNPV260WTp, nNECNPV260W, nModulePages)
	DEFINE_MODULE 'NEC NPV260W SourceSelectComponent' sourceselect(vdvDev, dvNECNPV260WTp, nNECNPV260W, nSourceSelectPages)
	DEFINE_MODULE 'NEC NPV260W VideoProjectorComponent' NECNPV260W(vdvDev, dvNECNPV260WTp, nNECNPV260W, nNECNPV260WPages)
	DEFINE_MODULE 'NEC NPV260W VolumeComponent' volume(vdvDev, dvNECNPV260WTp, nNECNPV260W, nVolumePages)
	// Define your communications module here like so:
	 DEFINE_MODULE 'NEC_NPV260W_Comm_dr1_0_0' comm(vdvNECNPV260W, dvNECNPV260W)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

// NEC Projector Module Code
	DATA_EVENT[vdvNECNPV260W]
	{
			ONLINE:
			{
		//#WARN'***************************************************'
		//#WARN'**   Verify PROPERTY-Poll_Time for the module    **'
		//#WARN'**   Verify PROPERTY-Baud_Rate for the module    **'
		//#WARN'**   Verify PROPERTY-IP_Address for the module   **'
		//#WARN'***************************************************'           
		//send_command vdvNECNPV260W, 'PROPERTY-Poll_Time,10000'
		//send_command vdvNECNPV260W, 'PROPERTY-Baud_Rate,38400'
		send_command vdvNECNPV260W, 'PROPERTY-IP_Address,192.168.0.10'
		send_command vdvNECNPV260W, 'REINIT'
			}
	}

BUTTON_EVENT [dvKP,1]
{
	PUSH:
	{
		ON [vdvNECNPV260W,255];
	}
}

BUTTON_EVENT [dvKP,2]
{
	PUSH:
	{
		OFF [vdvNECNPV260W,255];
	}
}

//BUTTON_EVENT[dvKP,KPBUTTONS]
//{
//  PUSH:
//	 {
//		TO[dvKP,BUTTON.INPUT.CHANNEL]
//			SWITCH(BUTTON.INPUT.CHANNEL)
//			{
//				 CASE  1: 
//				 CASE  2: IF (PROJECTOR_POWER == 0)		//PROJECTOR ON/OFF
//									{			
//										 CALL 'Projector_On'		//PROJECTOR ON
//									}
//									ELSE
//									{
//										 CALL 'Projector_Off'		//PROJECTOR OFF
//									}
//				 CASE  3: 
//				 CASE  4: 
//			}
//	 }
//}
//
//BUTTON_EVENT[dvKP,KPBUTTONS]
//{
//  HOLD[1,REPEAT]:
//	 {
//		TO[dvKP,BUTTON.INPUT.CHANNEL]
//			SWITCH(BUTTON.INPUT.CHANNEL)
//			{
//				 CASE 5:	ON[MIC_1,140]		//MIC1 VOLUME UP
//								 WAIT 10
//								 OFF[MIC_1,140]
//				 CASE 6: ON[MIC_1,141]		//MIC2 VOLUME DOWN
//								 WAIT 10
//								 OFF[MIC_1,141]
//				 CASE 7: IF (InputSelected == 1)
//									{
//										 ON[AUDIO_OUTPUT,140]		//MAIN VOLUME 1 UP
//										 WAIT 10
//										 OFF[AUDIO_OUTPUT,140]
//									}
//									ELSE
//									{
//										 ON[AUDIO_OUTPUT_LINE,140]		//MAIN VOLUME 2 UP
//										 WAIT 10
//										 OFF[AUDIO_OUTPUT_LINE,140]
//									}
//				 CASE 8: IF (InputSelected == 1)
//									{
//										 ON[AUDIO_OUTPUT,141]		//MAIN VOLUME 1 DOWN
//										 WAIT 10
//										 OFF[AUDIO_OUTPUT,141]
//									}
//									ELSE
//									{
//										 ON[AUDIO_OUTPUT_LINE,141]		//MAIN VOLUME 2 DOWN
//										 WAIT 10
//										 OFF[AUDIO_OUTPUT_LINE,141]
//									}
//			}	
//	 }
//}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)