PROGRAM_NAME='BOSE'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE


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

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//-----------------------------------MAIN-----------------------------------------//
button_event[dvTP,9]																															//Living Rm PVR
button_event[dvTP,10]																															//Living Rm FM
button_event[dvTP,11]																															//Living Rm iPod

//------------------------------IPOD GENERAL--------------------------------------//
button_event[dvTP,74]																															//living play
button_event[dvTP,75]																															//living pause
button_event[dvTP,76]																															//living stop
button_event[dvTP,77]																															//living previous
button_event[dvTP,79]																															//living next
button_event[dvTP,80]																															//living fast rewind
button_event[dvTP,81]																															//living fast forward
button_event[dvTP,88]																															//living shuffle
button_event[dvTP,4]																															//living Up
button_event[dvTP,5]																															//living Left
button_event[dvTP,6]																															//living Down
button_event[dvTP,18]																															//living Right

//-------------------------------FM CONTROLS--------------------------------------//
button_event[dvTP,64]																															//Living preset 1
button_event[dvTP,73]																															//Living preset 2
button_event[dvTP,82]																															//Living preset 3
button_event[dvTP,83]																															//Living preset 4
button_event[dvTP,84]																															//Living preset 5
button_event[dvTP,86]																															//Living preset 6

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
		//--------------------------------MAIN PAGE-----------------------------------//
			case 9:	 send_string dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			case 10: send_string dvBose, "$0b,$00,$01,$04,$25,$01,$2c,$01,$00,$00,$07"	//Living rm FM
			case 11: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$00,$00,$25"	//Living rm iPod

		//--------------------------------IPOD GENERAL--------------------------------//
			case 74: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$00,$00,$77"	//living play
			case 75: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$00,$00,$74"	//living pause
			case 76: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$00,$00,$38"	//living stop
			case 77: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$00,$00,$7b"	//living previous
			case 79: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$00,$00,$78"	//living next
			case 80: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$00,$00,$75"	//living fast rewind
			case 81: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$00,$00,$7a"	//living fast forward
			case 88: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$00,$00,$7f"	//living shuffle
			case 4:  send_string dvBose, "$0b,$00,$01,$04,$c0,$01,$2c,$01,$00,$00,$e2"	//Living rm Up
			case 5:  send_string dvBose, "$0b,$00,$01,$04,$60,$01,$2c,$01,$00,$00,$42"	//Living rm Right
			case 6:  send_string dvBose, "$0b,$00,$01,$04,$20,$01,$2c,$01,$00,$00,$02"	//Living rm Down
			case 18: send_string dvBose, "$0b,$00,$01,$04,$a0,$01,$2c,$01,$00,$00,$82"	//Living rm Left

		//---------------------------------FM CONTROLS--------------------------------//
			case 82: send_string dvBose, "$0b,$00,$01,$04,$41,$01,$2c,$01,$00,$00,$63"	//Living preset 1
			case 83: send_string dvBose, "$0b,$00,$01,$04,$42,$01,$2c,$01,$00,$00,$60"	//Living preset 2
			case 84: send_string dvBose, "$0b,$00,$01,$04,$43,$01,$2c,$01,$00,$00,$61"	//Living preset 3
		}
  }
}

//---------------------------------MAIN VOLUME CONTROLS---------------------------//
button_event[dvTP,7]																															//Living Rm Volume Up
button_event[dvTP,8]																															//Living Rm Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 7: send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$00,$00,$21"		//Living rm Vol Up
			case 8: send_string dvBose, "$0b,$00,$01,$04,$02,$01,$2c,$01,$00,$00,$20"		//Living rm Vol Dn
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

