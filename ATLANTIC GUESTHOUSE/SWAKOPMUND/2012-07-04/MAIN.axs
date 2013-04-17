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
		CLIENT: MAERUA LIFESTYLE CENTRE SWAKOPMUND
		MASTER (NI-2100) IP: 192.168.1.101
		iPAD (iPAD) IP: 192.168.1.102
		GREENBOX HYBRID: IP: 192.168.1.111
		network passphrase: atlantic
		
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

////////////////////////RELAYS////////////////////////////

dvRelays = 5001:4:0		//Relays for screen & curtains

//////////////////////RS232 DEVICES////////////////////////

dvAmp1 = 5001:1:0		//PTN-MA Amplifier 1 
dvAmp2 = 5001:2:0		//PTN-MA Amplifier 2
dvMatrix = 5001:3:0		//PTN MVG44 VGA/AUDIO matrix

//////////////////////ETHERNET DEVICES/////////////////////

dvTP = 11001:1:0		//iPad

//////////////////////IR DEVICES///////////////////////////

dvProjector = 5001:5:0		//Sony projector EX-100
dvHDPVR1 = 5001:6:0		//HDPVR
dvTV1 = 5001:7:0		//Samsung TV Room1 
dvTV2 = 5001:8:0		//Samsung TV Room2

//////////////////////IO DEVICES///////////////////////////

dvPIR		=		5001:9:0		//Motion sensors

(***********************************************************)
(*          CONNECT LEVEL DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONNECT_LEVEL
                 
(dvTP,1,dvAmp1,2,dvAmp2,3)		//Connects levels

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

volatile integer mute1
volatile integer mute2
volatile integer WAIT_TIME = 12000		//WAIT TIME IS 20 MIN (12000)
volatile integer VOL_LEVEL1	= 70	//Volume1 level for bargraph1
volatile integer VOL_LEVEL2 = 70		//Volume2 level for bargraph2

volatile integer EVENTBUTTONS[]	=	 {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
																		18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34}

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

#include 'Green Box Systems Wired Initialisation.AXI'
#include 'DSTV'
#include 'FUNCTIONS'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

send_command dvMatrix,'SET BAUD,9600,N,8,1'	
send_command dvAmp1,'SET BAUD,9600,N,8,1'
send_command dvAmp2,'SET BAUD,9600,N,8,1'

create_level dvTP,1,VOL_LEVEL1	//Level1 for TPbargraph
create_level dvTP,2,VOL_LEVEL2	//Level2 for TPbargraph

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//////////////////////CHANNEL EVENT FOR MOTION DETECTOR////////////////////////

channel_event[dvPIR,1]
{
	off:
	{
		call '1SingleLightsOn'		//SWITCHES LIGHTS 1 ON
		cancel_all_wait
	}

	on:
	{
		wait WAIT_TIME				//STARTS WAIT TIME (6000)(10MIN)
		call '1SingleLightsOff'//SWITCHES LIGHTS 1 OFF
	}
}

channel_event[dvPIR,2]
{
	off:
	{
		call '2SingleLightsOn'		//SWITCHES LIGHTS 2 ON
		cancel_all_wait
	}

	on:
	{
		wait WAIT_TIME				//STARTS WAIT TIME (6000)(10MIN)
		call '2SingleLightsOff'//SWITCHES LIGHTS 2 OFF
	}
}

/////////////////////EVENTS FOR TOUCHPANEL FOR BOARDROOM///////////////////////
button_event[dvTP,EVENTBUTTONS]
{
	 push:
	 {
			 to[dvTP,BUTTON.INPUT.CHANNEL]
				 switch(BUTTON.INPUT.CHANNEL)
			 {
						/******** Room 1 Laptop ********/
				 case 1: 	call 'Projector_On'		//Projector On
									call 'TV1_On'		//TV on
									call '1SingleLightsPresentation'
									send_string dvMatrix, "'2V1.'"		//Laptop 1 IN2 TO OUT1
									send_string dvMatrix, "'3V1.'"		//Laptop 1 IN3 TO OUT1
									send_string dvAMP1, "'2A1.'"		//Laptop IN1 TO OUT1
									wait 5;
									send_string dvAMP1, "'0A1.'"		//unmute room 1
									mute1 = 0
									

						/******** Room 1 DSTV ********/
				 case 2: 	call 'Projector_On'		//Projector On
									call 'TV1_On'		//TV on
									call '1SingleLightsPresentation'
									send_string dvMatrix, "'1V1.'"		//DSTV IN1 TO OUT1
									send_string dvAMP1, "'1A1.'"		//DSTV IN2 TO OUT1
									wait 5;
									send_string dvAMP1, "'0A1.'"		//unmute room 1
									mute1 = 0
									
									
						/******** Room 2 Laptop ********/
				 case 3: 	call 'TV2_On'		//TV on
									call '2SingleLightsPresentation'
									send_string dvMatrix, "'4V3.'"		//Laptop IN3 TO OUT3
									send_string dvAMP2, "'2A1.'"		//Laptop IN1 TO OUT1
									wait 5
								  send_string dvAMP2, "'0A1.'"		//unmute room 2
									mute2 = 0
									

				 case 4:	call '1SingleLightsOff'	// Room 1 All Lights Off

				 case 14:	call '2SingleLightsOff'	// Room 2 All Lights Off

				 case 27:	call 'AllLightsOff'	// Room 1 & 2 All Lights Off
				
						/******** Combined Rooms Laptop ********/
				 case 5: 	call 'Projector_On'		//Projector On
									call 'TV1_On'		//TV on
									call 'TV2_On'		//TV on
									call 'CombinePresentation'
									send_string dvMatrix, "'2V1.'"		//Laptop IN2 TO OUT1
									send_string dvMatrix, "'2V2.'"		//Laptop IN2 TO OUT2
									send_string dvMatrix, "'2V3.'"		//Laptop IN2 TO OUT3
									send_string dvMatrix, "'3V1.'"		//Laptop IN2 TO OUT1
									send_string dvMatrix, "'3V2.'"		//Laptop IN2 TO OUT2
									send_string dvMatrix, "'3V3.'"		//Laptop IN2 TO OUT3
									send_string dvAMP1, "'2A1.'"		//Laptop IN1 TO OUT1
									send_string dvAMP2, "'2A1.'"		//Loop IN2 TO OUT1
									wait 5;
									send_string dvAMP1, "'0A1.'"		//unmute room 1
									mute1 = 0
								  send_string dvAMP2, "'0A1.'"		//unmute room 2
									mute2 = 0
									

						/******** Combined Rooms DSTV ********/
				 case 6: 	call 'Projector_On'		//Projector On
									call 'TV1_On'		//TV on
									call 'TV2_On'		//TV on
									call 'CombinePresentation'
									send_string dvMatrix, "'1V1.'"		//DSTV IN1 TO OUT1
									send_string dvMatrix, "'1V2.'"		//DSTV IN1 TO OUT2
									send_string dvMatrix, "'1V3.'"		//DSTV IN1 TO OUT3
									send_string dvAMP1, "'1A1.'"		//DSTV IN2 TO OUT1
									send_string dvAMP2, "'1A1.'"		//Loop IN2 TO OUT1
									wait 5;
									send_string dvAMP1, "'0A1.'"		//unmute room 1
									mute1 = 0
								  send_string dvAMP2, "'0A1.'"		//unmute room 2
									mute2 = 0
									

									
				 case 7: call 'Room1Mute'
				 case 8: call 'Room2Mute'

				 case 9: 	call '1SingleLightsOn'
				 case 10: call '2SingleLightsOn'
				 case 11: call '1SingleLightsPresentation'
				 case 12: call '2SingleLightsPresentation'
				 case 33: call 'CombinePresentation'
				 case 34: call 'CombineOn'
				 
				 case 13: call 'Room1Mute'
									call 'Room2Mute'

						/******** Room 1 Power Off ********/
				 case 15: call 'Projector_Off'
									pulse [dvProjector,6]
									wait 20
									pulse [dvProjector,6]
									call 'Room1Mute'
									call 'TV1_Off'
									call '1SingleLightsOn'

						/******** Room 2 Power Off ********/
				 case 16: call 'Room2Mute'
									call 'TV2_Off'
									call '2SingleLightsOn'
									
									
				 case 17: call 'Rm1CurtainOpen'

				 case 18: call 'Rm1CurtainClose'
									
				 case 19: call 'Rm2CurtainOpen'

				 case 20: call 'Rm2CurtainClose'

				 case 28: call 'Rm1CurtainOpen'
									call 'Rm2CurtainOpen'

				 case 29: call 'Rm1CurtainClose'
									call 'Rm2CurtainClose'

				 case 30: send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(0)"

				 case 31: send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(0)"


				 case 32: send_command vGBS_DEV_ARRAY[2],"'L:[3]:',ITOA(0)"
									send_command vGBS_DEV_ARRAY[2],"'L:[4]:',ITOA(0)"
			}
	 }
}

//---------------------------------MAIN VOLUME CONTROLS---------------------------//
button_event[dvTP,EVENTBUTTONS]
{
  hold[1,repeat]:
  {
	pulse[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 21: call 'Room1VolUp'
			case 22: call 'Room1VolDown'
			case 23: call 'Room2VolUp'
			case 24: call 'Room2VolDown'
			
			case 25: call 'Room1VolUp'
							 call 'Room2VolUp'
			case 26: call 'Room1VolDown'
							 call 'Room2VolDown'
		}
  }
}

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

[dvTP,8] = mute2;
[dvTP,7] = mute1;
[dvTP,13] = mute2;
[dvTP,13] = mute1;
(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)