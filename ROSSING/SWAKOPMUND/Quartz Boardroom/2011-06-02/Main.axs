PROGRAM_NAME='Main'
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
		NI-2100: (IP)192.168.1.100 (DPS)5001
		WAP250: (IP)192.168.1.240 User:Admin Pass:1988 SSID:AMX Passphrase: Admin1988
		TP1: (IP)192.168.1.101 (DPS)10001
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvTV_Left		=	05001:5:0	//Proline TV on IR1 Left Side
dvTV_Right	=	05001:6:0	//Proline TV on IR2 Right Side

dvTP				=	10001:1:0	//MVP-5150 Touch Panel
dvPOLY			=	05001:7:0	//POLYCOM HDX 7000

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

set_pulse_time (1)
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

button_event[dvTP,1]		//BACK
button_event[dvTP,2]		//HOME	
button_event[dvTP,3]		//DIRECTORY
button_event[dvTP,4]		//CALL
button_event[dvTP,5]		//CALL END
button_event[dvTP,13]		//MUTE
button_event[dvTP,25]		//OK
button_event[dvTP,30]		//TV's OFF	
button_event[dvTP,29]		//TV's ON
button_event[dvTP,111]		//1
button_event[dvTP,112]		//2	
button_event[dvTP,113]		//3
button_event[dvTP,114]		//4
button_event[dvTP,115]		//5
button_event[dvTP,116]		//6	
button_event[dvTP,117]		//7
button_event[dvTP,118]		//8
button_event[dvTP,119]		//9
button_event[dvTP,120]		//0	
button_event[dvTP,121]		//*
button_event[dvTP,122]		//#	


{
  push:
  {
      to[dvTP,BUTTON.INPUT.CHANNEL]
          switch(BUTTON.INPUT.CHANNEL)
	    {
              case 29:	pulse[dvTV_Left,1]				//Switches TV_Left on
												pulse[dvTV_Right,1]				//Switches TV_Right on
              case 30:	pulse[dvTV_Left,2]				//Switches TV_Left off
												pulse[dvTV_Right,2]				//Switches TV_Right off
              case 1: 	pulse[dvPOLY,83]					//BACK
              case 2: 	pulse[dvPOLY,82]					//HOME
              case 3: 	pulse[dvPOLY,81]					//DIRECTORY
              case 4: 	pulse[dvPOLY,81]					//CALL
              case 5: 	pulse[dvPOLY,55]					//END CALL
              case 13:	pulse[dvPOLY,26]					//MUTE
              case 25:	pulse[dvPOLY,94]					//OK
              case 111: pulse[dvPOLY,11]					//1
              case 112: pulse[dvPOLY,12]					//2
              case 113: pulse[dvPOLY,13]					//3
              case 114: pulse[dvPOLY,14]					//4
              case 115: pulse[dvPOLY,15]					//5
              case 116: pulse[dvPOLY,16]					//6
              case 117: pulse[dvPOLY,17]					//7
              case 118: pulse[dvPOLY,18]					//8
              case 119: pulse[dvPOLY,19]					//9
              case 120: pulse[dvPOLY,10]					//0
              case 121: pulse[dvPOLY,93]					//*
              case 122: pulse[dvPOLY,92]					//#
          }
  }
}

button_event[dvTP,12]		//VOL UP
button_event[dvTP,14]		//VOL DN	
button_event[dvTP,15]		//ZOOM UP
button_event[dvTP,16]		//ZOOM DN
button_event[dvTP,21]		//UP	
button_event[dvTP,22]		//RIGHT
button_event[dvTP,23]		//DOWN
button_event[dvTP,24]		//LEFT

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
      case 12:	TO[dvPOLY,24]					//VOL UP
			case 14:	TO[dvPOLY,25]					//VOL DN
			case 15:	TO[dvPOLY,49]					//ZOOM UP
			case 16:	TO[dvPOLY,50]					//ZOOM DN
			case 21:	TO[dvPOLY,45]					//UP
			case 22:	TO[dvPOLY,48]					//RIGHT
			case 23:	TO[dvPOLY,46]					//DOWN
			case 24:	TO[dvPOLY,47]					//LEFT
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

