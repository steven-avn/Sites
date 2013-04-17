PROGRAM_NAME='Boardroom_Main'
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
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
////////////////////Relay Devices//////////////////////////
dvAircon_R1	=	5001:4:0	//Aircon on Relay1
dvLights_R2	=	05001:4:0	//Lights on Relay2
/////////////////////IR Devices////////////////////////////
dvTV_IR1	=	05001:5:0	//Samsung TV on IR1
dvSmartBrd_IR2	=	05001:6:0	//SmartBoard on IR2
dvPolycom	=	05001:7:0	//Polycom on IR3
////////////////////Keypad/////////////////////////////////
dvKP		=	00085:1:1	//Metreu 7-b KeyPad

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

button_event[dvKP,1]		//SmartBoard on/off
button_event[dvKP,2]		//SmartBoard Input Select
button_event[dvKP,3]		//Light on/off
button_event[dvKP,4]		//Aircon on/off	
button_event[dvKP,5]		//Polycom on/off
button_event[dvKP,6]		//LCD TV on/off	
button_event[dvKP,7]		//LCD TV Vol Up
button_event[dvKP,8]		//LCD TV Vol Dwn


{
  push:
  {
      to[dvKP,BUTTON.INPUT.CHANNEL]
          switch(BUTTON.INPUT.CHANNEL)
	    {
              case 1: pulse[dvSmartBrd_IR2,1]	//Switches SB on/off
              case 2: pulse[dvSmartBrd_IR2,2]	//Switches Input on SB
              case 3: pulse[dvLights_R2,2]	//Switches Lights on/off
              case 4: pulse[dvAircon_R1,1]	//Switches Aircon on/off
              case 5: pulse[dvPolycom,9]	//Switches Polycom on/off
              case 6: pulse[dvTV_IR1,1]		//Switches TV on/off
              case 7: to[dvTV_IR1,8]		//Vol Up on TV
              case 8: to[dvTV_IR1,7]		//Vol Dwn on TV
              
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

