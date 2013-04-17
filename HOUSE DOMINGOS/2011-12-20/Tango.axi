PROGRAM_NAME='Tango'
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

//---------------MAIN-----------------//
button_event[dvTP,9]				//Living Rm PVR
button_event[dvTP,10]				//Living Rm FM
button_event[dvTP,11]				//Living Rm iPod
//button_event[dvTP,6]				//Living Rm On/Off

button_event[dvTP,20]				//Entert Rm PVR
button_event[dvTP,21]				//Entert Rm FM
button_event[dvTP,22]				//Entert Rm iPod
button_event[dvTP,17]				//Entert Rm On/Off

button_event[dvTP,31]				//Bed Rm PVR
button_event[dvTP,32]				//Bed Rm FM
button_event[dvTP,33]				//Bed Rm iPod
button_event[dvTP,28]				//Bed Rm On/Off

//------------IPOD GENERAL-------------//
button_event[dvTP,74]				//living play
button_event[dvTP,75]				//living pause
button_event[dvTP,76]				//living stop
button_event[dvTP,77]				//living previous
button_event[dvTP,79]				//living next
button_event[dvTP,80]				//living fast rewind
button_event[dvTP,81]				//living fast forward
button_event[dvTP,88]				//living shuffle

button_event[dvTP,56]				//entert play
button_event[dvTP,51]				//entert pause
button_event[dvTP,52]				//entert stop
button_event[dvTP,53]				//entert previous
button_event[dvTP,54]				//entert next
button_event[dvTP,55]				//entert fast rewind
button_event[dvTP,57]				//entert fast forward
button_event[dvTP,58]				//entert shuffle

button_event[dvTP,65]				//bed play
button_event[dvTP,66]				//bed pause
button_event[dvTP,67]				//bed stop
button_event[dvTP,68]				//bed previous
button_event[dvTP,69]				//bed next
button_event[dvTP,70]				//bed fast rewind
button_event[dvTP,71]				//bed fast forward
button_event[dvTP,72]				//bed shuffle

//------------FM CONTROLS------------//
button_event[dvTP,64]				//Living preset 1
button_event[dvTP,73]				//Living preset 2
button_event[dvTP,82]				//Living preset 3
button_event[dvTP,83]				//Living preset 4
button_event[dvTP,84]				//Living preset 5
button_event[dvTP,86]				//Living preset 6

button_event[dvTP,87]				//Entert preset 1
button_event[dvTP,89]				//Entert preset 2
button_event[dvTP,90]				//Entert preset 3
button_event[dvTP,91]				//Entert preset 4
button_event[dvTP,92]				//Entert preset 5
button_event[dvTP,93]				//Entert preset 6


{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
		//----------------------MAIN PAGE---------------------------//
			case 9: send_string dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			case 10: send_string dvBose, "$0b,$00,$01,$04,$25,$01,$2c,$01,$00,$00,$07"	//Living rm FM
			case 11: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$00,$00,$25"	//Living rm iPod
			//case 6: send_string dvBose,  "$0b,$00,$01,$04,$4c,$01,$2c,$01,$00,$00,$6e"	//Living rm On/Off
			
			case 20: send_string dvBose, "$0b,$00,$01,$04,$12,$01,$2c,$01,$01,$01,$30"	//Entert rm PVR
			case 21: send_string dvBose, "$0b,$00,$01,$04,$06,$01,$2c,$01,$01,$01,$24"	//Entert rm FM
			case 22: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$01,$01,$25"	//Entert rm iPod
			case 17: send_string dvBose, "$0b,$00,$01,$04,$4c,$01,$2c,$01,$01,$01,$6e"	//Entert rm On/Off
			
			case 31: send_string dvBose, "$0b,$00,$01,$04,$12,$01,$2c,$01,$02,$01,$33"	//Bed rm PVR
			case 32: send_string dvBose, "$0b,$00,$01,$04,$06,$01,$2c,$01,$02,$01,$27"	//Bed rm FM
			case 33: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$02,$01,$26"	//Bed rm iPod
			case 28: send_string dvBose, "$0b,$00,$01,$04,$4c,$01,$2c,$01,$02,$01,$6d"	//Bed rm On/Off
		//-----------------------IPOD GENERAL-------------------------//
			case 74: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$00,$00,$77"	//living play
			case 75: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$00,$00,$74"	//living pause
			case 76: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$00,$00,$38"	//living stop
			case 77: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$00,$00,$7b"	//living previous
			case 79: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$00,$00,$78"	//living next
			case 80: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$00,$00,$75"	//living fast rewind
			case 81: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$00,$00,$7a"	//living fast forward
			case 88: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$00,$00,$7f"	//living shuffle
			
			case 56: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$01,$01,$77"	//entert play
			case 51: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$01,$01,$74"	//entert pause
			case 52: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$01,$01,$38"	//entert stop
			case 53: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$01,$01,$7b"	//entert previous
			case 54: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$01,$01,$78"	//entert next
			case 55: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$01,$01,$75"	//entert fast rewind
			case 57: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$01,$01,$7a"	//entert fast forward
			case 58: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$01,$01,$7f"	//entert shuffle
			
			case 65: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$02,$01,$74"	//bed play
			case 66: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$02,$01,$77"	//bed pause
			case 67: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$02,$01,$3b"	//bed stop
			case 68: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$02,$01,$78"	//bed previous
			case 69: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$02,$01,$7b"	//bed next
			case 70: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$02,$01,$76"	//bed fast rewind
			case 71: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$02,$01,$79"	//bed fast forward
			case 72: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$02,$01,$7c"	//bed shuffle

		//-----------------------FM CONTROLS-------------------------//
			case 64: send_string dvBose, "$0b,$00,$01,$04,$41,$01,$2c,$01,$00,$00,$38"	//Living preset 1
			case 73: send_string dvBose, "$0b,$00,$01,$04,$42,$01,$2c,$01,$00,$00,$39"	//Living preset 2
			case 82: send_string dvBose, "$0b,$00,$01,$04,$43,$01,$2c,$01,$00,$00,$38"	//Living preset 3
			case 83: send_string dvBose, "$0b,$00,$01,$04,$44,$01,$2c,$01,$00,$00,$39"	//Living preset 4
			case 84: send_string dvBose, "$0b,$00,$01,$04,$45,$01,$2c,$01,$00,$00,$38"	//Living preset 5
			case 86: send_string dvBose, "$0b,$00,$01,$04,$46,$01,$2c,$01,$00,$00,$39"	//Living preset 6
			
			case 87: send_string dvBose, "$0b,$00,$01,$04,$41,$01,$2c,$01,$01,$01,$38"	//Entert preset 1
			case 89: send_string dvBose, "$0b,$00,$01,$04,$42,$01,$2c,$01,$01,$01,$39"	//Entert preset 2
			case 90: send_string dvBose, "$0b,$00,$01,$04,$43,$01,$2c,$01,$01,$01,$38"	//Entert preset 3
			case 91: send_string dvBose, "$0b,$00,$01,$04,$44,$01,$2c,$01,$01,$01,$39"	//Entert preset 4
			case 92: send_string dvBose, "$0b,$00,$01,$04,$45,$01,$2c,$01,$01,$01,$38"	//Entert preset 5
			case 93: send_string dvBose, "$0b,$00,$01,$04,$46,$01,$2c,$01,$01,$01,$39"	//Entert preset 6
		}
  }
}

//-----------------MAIN VOLUME CONTROLS------------------//
button_event[dvTP,7]				//Living Rm Volume Up
button_event[dvTP,8]				//Living Rm Volume Down

button_event[dvTP,18]				//Entert Rm Volume Up
button_event[dvTP,19]				//Entert Rm Volume Down

button_event[dvTP,30]				//Bed Rm Volume Up
button_event[dvTP,29]				//Bed Rm Volume Down

{
  hold[1,repeat]:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 7: send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$00,$00,$21"	//Living rm Vol Up
			case 8: send_string dvBose, "$0b,$00,$01,$04,$02,$01,$2c,$01,$00,$00,$20"	//Living rm Vol Dn
			
			case 18: send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$01,$01,$21"	//Entert rm Vol Up
			case 19: send_string dvBose, "$0b,$00,$01,$04,$02,$01,$2c,$01,$01,$01,$20"	//Entert rm Vol Dn
			
			case 30: send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$02,$01,$22"	//Bed rm Vol Up
			case 29: send_string dvBose, "$0b,$00,$01,$04,$02,$01,$2c,$01,$02,$01,$23"	//Bed rm Vol Dn
		}
  }
}

//----------------MAIN R4--------------//
button_event[dvR4_1,31]				//Bed Rm PVR
button_event[dvR4_1,32]				//Bed Rm FM
button_event[dvR4_1,33]				//Bed Rm iPod
button_event[dvR4_1,28]				//Bed Rm On/Off

//------------IPOD GENERAL-------------//
button_event[dvR4_1,65]				//bed play
button_event[dvR4_1,66]				//bed pause
button_event[dvR4_1,67]				//bed stop
button_event[dvR4_1,68]				//bed previous
button_event[dvR4_1,69]				//bed next
button_event[dvR4_1,70]				//bed fast rewind
button_event[dvR4_1,71]				//bed fast forward
button_event[dvR4_1,72]				//bed shuffle

//------------FM CONTROLS------------//
button_event[dvR4_1,94]				//bed preset 1
button_event[dvR4_1,59]				//bed preset 2
button_event[dvR4_1,60]				//bed preset 3
button_event[dvR4_1,61]				//bed preset 4
button_event[dvR4_1,62]				//bed preset 5
button_event[dvR4_1,63]				//bed preset 6

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
		//----------------------MAIN PAGE---------------------------//
			case 31: send_string dvBose, "$0b,$00,$01,$04,$12,$01,$2c,$01,$02,$01,$33"	//Bed rm PVR
			case 32: send_string dvBose, "$0b,$00,$01,$04,$06,$01,$2c,$01,$02,$01,$27"	//Bed rm FM
			case 33: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$02,$01,$26"	//Bed rm iPod
			case 28: send_string dvBose, "$0b,$00,$01,$04,$4c,$01,$2c,$01,$02,$01,$6d"	//Bed rm On/Off
		//-----------------------IPOD GENERAL-------------------------//
			case 65: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$02,$01,$74"	//bed play
			case 66: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$02,$01,$77"	//bed pause
			case 67: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$02,$01,$3b"	//bed stop
			case 68: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$02,$01,$78"	//bed previous
			case 69: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$02,$01,$7b"	//bed next
			case 70: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$02,$01,$76"	//bed fast rewind
		//-----------------------FM CONTROLS-------------------------//
			case 94: send_string dvBose, "$0b,$00,$01,$04,$41,$01,$2c,$01,$02,$01,$38"	//bed preset 1
			case 59: send_string dvBose, "$0b,$00,$01,$04,$42,$01,$2c,$01,$02,$01,$39"	//bed preset 2
			case 60: send_string dvBose, "$0b,$00,$01,$04,$43,$01,$2c,$01,$02,$01,$38"	//bed preset 3
			case 61: send_string dvBose, "$0b,$00,$01,$04,$44,$01,$2c,$01,$02,$01,$39"	//bed preset 4
			case 62: send_string dvBose, "$0b,$00,$01,$04,$45,$01,$2c,$01,$02,$01,$38"	//bed preset 5
			case 63: send_string dvBose, "$0b,$00,$01,$04,$46,$01,$2c,$01,$02,$01,$39"	//bed preset 6
		}
  }
}

//-----------------MAIN R4 VOLUME CONTROLS------------------//
button_event[dvR4_1,30]				//Bed Rm Volume Up
button_event[dvR4_1,29]				//Bed Rm Volume Down

{
  hold[1,repeat]:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 30: send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$02,$01,$22"	//Bed rm Vol Up
			case 29: send_string dvBose, "$0b,$00,$01,$04,$02,$01,$2c,$01,$02,$01,$23"	//Bed rm Vol Dn
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

