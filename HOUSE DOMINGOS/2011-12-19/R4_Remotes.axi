PROGRAM_NAME='R4_Remotes'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 12/03/2010  AT: 09:00:00        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
dvMatrixAudioSerial = 				5001:2:0 // Serial device...COMMENT OUT IF USING IP

dvR4_1				=				10030:1:0					//Mio-R4 Remote Main Bedroom
dvR4_RM1			=				10031:1:0					//Mio-R4 Remote Daughter's Bedroom
dvR4_RM2			=				10032:1:0					//Mio-R4 Remote Son's Bedroom
dvR4_RM3			=				10033:1:0					//Mio-R4 Remote Downstairs 1 Bedroom
dvR4_RM4			=				10034:1:0					//Mio-R4 Remote Downstairs 2 Bedroom

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////Constants for DSTV//////////////////////////
integer cdExit		=		50
integer cdGuide		=		56
integer cdInfo		=		69
integer cdPower		=		9
integer cdMenu		=		44
integer cdOk			=		49
integer cdUp			=		45
integer cdDwn			= 	46
integer cdLeft		=		47
integer cdRight		=		48
integer cd1				=		11
integer cd2				=		12
integer cd3				=		13
integer cd4				=		14
integer cd5				=		15
integer cd6				=		16
integer cd7				=		17
integer cd8				=		18
integer cd9				=		19
integer cd0				=		10
integer cdRecall	=		55
integer cdChUp		=		22
integer cdChDn		=		23
integer cdTV			=		121
integer cdDMX			=		127		



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

#include 'AMX_MatrixAudio_MiSeries_MAIN'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//-------------DAUGHTER'S BEDROOM---------------//
button_event[dvR4_RM1,301]
button_event[dvR4_RM1,302]
button_event[dvR4_RM1,303]
button_event[dvR4_RM1,304]
button_event[dvR4_RM1,305]
button_event[dvR4_RM1,306]
button_event[dvR4_RM1,307]
button_event[dvR4_RM1,308]
button_event[dvR4_RM1,309]
button_event[dvR4_RM1,310]
button_event[dvR4_RM1,311]
button_event[dvR4_RM1,345]
button_event[dvR4_RM1,346]
button_event[dvR4_RM1,347]

{
  push:
  {
	to[dvR4_RM1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 301: pulse[dvHDPVR1,cd1]   //MTV
								wait 4
								pulse[dvHDPVR1,cd7]
								wait 7
								pulse[dvHDPVR1,cd5]
			case 301: pulse[dvHDPVR1,cd1]   //MTV
								wait 4
								pulse[dvHDPVR1,cd7]
								wait 7
								pulse[dvHDPVR1,cd5]
			case 24: send_command dvUTPRO_HDMI,"'CI1O8'"	//Input 1(DSTV) Output 8(MainBRm)
			case 50: send_command dvUTPRO_HDMI,"'CI3O8'"	//Input 3(TPA) Output 8(MainBRm)
			case 25: send_command dvUTPRO_HDMI,"'CI2O8'"	//Input 2(DVD) Output 8(MainBRm)
			case 26: to [dvHDMI_Bed,24]			//Sony TV Vol Up
			case 27: to [dvHDMI_Bed,25]			//Sony TV Vol Dn
		}
  }
}

button_event[dvTP,15]				//Volume Up
button_event[dvTP,16]				//Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 15:on[vdvMatrixAudio[4],24]
							wait 2
							{
								off[vdvMatrixAudio[4],24]
							}
			case 16:on[vdvMatrixAudio[4],25]
							wait 2
							{
								off[vdvMatrixAudio[4],25]
							}
		}
  }
}
 
//-------------SON'S BEDROOM---------------//
button_event[dvR4_RM2,312]
button_event[dvR4_RM2,313]
button_event[dvR4_RM2,314]
button_event[dvR4_RM2,315]
button_event[dvR4_RM2,316]
button_event[dvR4_RM2,317]
button_event[dvR4_RM2,318]
button_event[dvR4_RM2,319]
button_event[dvR4_RM2,320]
button_event[dvR4_RM2,321]
button_event[dvR4_RM2,322]
button_event[dvR4_RM2,348]
button_event[dvR4_RM2,349]
button_event[dvR4_RM2,350]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 23: pulse [dvHDMI_Bed,9]			//Switches Sony TV on/off
			case 24: send_command dvUTPRO_HDMI,"'CI1O8'"	//Input 1(DSTV) Output 8(MainBRm)
			case 50: send_command dvUTPRO_HDMI,"'CI3O8'"	//Input 3(TPA) Output 8(MainBRm)
			case 25: send_command dvUTPRO_HDMI,"'CI2O8'"	//Input 2(DVD) Output 8(MainBRm)
			case 26: to [dvHDMI_Bed,24]			//Sony TV Vol Up
			case 27: to [dvHDMI_Bed,25]			//Sony TV Vol Dn
		}
  }
}

button_event[dvTP,15]				//Volume Up
button_event[dvTP,16]				//Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 15:on[vdvMatrixAudio[4],24]
							wait 2
							{
								off[vdvMatrixAudio[4],24]
							}
			case 16:on[vdvMatrixAudio[4],25]
							wait 2
							{
								off[vdvMatrixAudio[4],25]
							}
		}
  }
}
 
//-------------DOWNST 1 BEDROOM---------------//
button_event[dvR4_RM3,323]
button_event[dvR4_RM3,324]
button_event[dvR4_RM3,325]
button_event[dvR4_RM3,326]
button_event[dvR4_RM3,327]
button_event[dvR4_RM3,328]
button_event[dvR4_RM3,329]
button_event[dvR4_RM3,330]
button_event[dvR4_RM3,331]
button_event[dvR4_RM3,332]
button_event[dvR4_RM3,333]
button_event[dvR4_RM3,351]
button_event[dvR4_RM3,352]
button_event[dvR4_RM3,353]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 23: pulse [dvHDMI_Bed,9]			//Switches Sony TV on/off
			case 24: send_command dvUTPRO_HDMI,"'CI1O8'"	//Input 1(DSTV) Output 8(MainBRm)
			case 50: send_command dvUTPRO_HDMI,"'CI3O8'"	//Input 3(TPA) Output 8(MainBRm)
			case 25: send_command dvUTPRO_HDMI,"'CI2O8'"	//Input 2(DVD) Output 8(MainBRm)
			case 26: to [dvHDMI_Bed,24]			//Sony TV Vol Up
			case 27: to [dvHDMI_Bed,25]			//Sony TV Vol Dn
		}
  }
}

button_event[dvTP,15]				//Volume Up
button_event[dvTP,16]				//Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 15:on[vdvMatrixAudio[4],24]
							wait 2
							{
								off[vdvMatrixAudio[4],24]
							}
			case 16:on[vdvMatrixAudio[4],25]
							wait 2
							{
								off[vdvMatrixAudio[4],25]
							}
		}
  }
}
 
//-------------DOWNST 2 BEDROOM---------------//
button_event[dvR4_RM4,334]
button_event[dvR4_RM4,335]
button_event[dvR4_RM4,336]
button_event[dvR4_RM4,337]
button_event[dvR4_RM4,338]
button_event[dvR4_RM4,339]
button_event[dvR4_RM4,340]
button_event[dvR4_RM4,341]
button_event[dvR4_RM4,342]
button_event[dvR4_RM4,343]
button_event[dvR4_RM4,344]
button_event[dvR4_RM4,354]
button_event[dvR4_RM4,355]
button_event[dvR4_RM4,356]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 23: pulse [dvHDMI_Bed,9]			//Switches Sony TV on/off
			case 24: send_command dvUTPRO_HDMI,"'CI1O8'"	//Input 1(DSTV) Output 8(MainBRm)
			case 50: send_command dvUTPRO_HDMI,"'CI3O8'"	//Input 3(TPA) Output 8(MainBRm)
			case 25: send_command dvUTPRO_HDMI,"'CI2O8'"	//Input 2(DVD) Output 8(MainBRm)
			case 26: to [dvHDMI_Bed,24]			//Sony TV Vol Up
			case 27: to [dvHDMI_Bed,25]			//Sony TV Vol Dn
		}
  }
}

button_event[dvTP,15]				//Volume Up
button_event[dvTP,16]				//Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 15:on[vdvMatrixAudio[4],24]
							wait 2
							{
								off[vdvMatrixAudio[4],24]
							}
			case 16:on[vdvMatrixAudio[4],25]
							wait 2
							{
								off[vdvMatrixAudio[4],25]
							}
		}
  }
}
 

//-------------MASTER BEDROOM---------------//
button_event[dvR4_1,23]
button_event[dvR4_1,24]
button_event[dvR4_1,25]
button_event[dvR4_1,26]
button_event[dvR4_1,27]
button_event[dvR4_1,50]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 23: pulse [dvHDMI_Bed,9]			//Switches Sony TV on/off
			case 24: send_command dvUTPRO_HDMI,"'CI1O8'"	//Input 1(DSTV) Output 8(MainBRm)
			case 50: send_command dvUTPRO_HDMI,"'CI3O8'"	//Input 3(TPA) Output 8(MainBRm)
			case 25: send_command dvUTPRO_HDMI,"'CI2O8'"	//Input 2(DVD) Output 8(MainBRm)
			case 26: to [dvHDMI_Bed,24]			//Sony TV Vol Up
			case 27: to [dvHDMI_Bed,25]			//Sony TV Vol Dn
		}
  }
}

button_event[dvTP,15]				//Volume Up
button_event[dvTP,16]				//Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 15:on[vdvMatrixAudio[4],24]
							wait 2
							{
								off[vdvMatrixAudio[4],24]
							}
			case 16:on[vdvMatrixAudio[4],25]
							wait 2
							{
								off[vdvMatrixAudio[4],25]
							}
		}
  }
}
 

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

//SEND_LEVEL dvTP,1,VOL_LEVEL_LIVINGR     			 	//SHOW VOLUME LEVEL ON BARGRAPH
//SEND_LEVEL dvTP,2,VOL_LEVEL_ENTERTR     			 	//SHOW VOLUME LEVEL ON BARGRAPH
//SEND_LEVEL dvTP,3,VOL_LEVEL_MAINBDR     			 	//SHOW VOLUME LEVEL ON BARGRAPH

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)

