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
BUTTON_EVENT[dvTP,9]				//Living Rm PVR
BUTTON_EVENT[dvTP,10]				//Living Rm FM
BUTTON_EVENT[dvTP,11]				//Living Rm iPod
//BUTTON_EVENT[dvTP,6]				//Living Rm On/Off

BUTTON_EVENT[dvTP,20]				//Entert Rm PVR
BUTTON_EVENT[dvTP,21]				//Entert Rm FM
BUTTON_EVENT[dvTP,22]				//Entert Rm iPod
BUTTON_EVENT[dvTP,17]				//Entert Rm On/Off

BUTTON_EVENT[dvTP,31]				//Bed Rm PVR
BUTTON_EVENT[dvTP,32]				//Bed Rm FM
BUTTON_EVENT[dvTP,33]				//Bed Rm iPod
BUTTON_EVENT[dvTP,28]				//Bed Rm On/Off

//------------IPOD GENERAL-------------//
BUTTON_EVENT[dvTP,74]				//living play
BUTTON_EVENT[dvTP,75]				//living pause
BUTTON_EVENT[dvTP,76]				//living stop
BUTTON_EVENT[dvTP,77]				//living previous
BUTTON_EVENT[dvTP,79]				//living next
BUTTON_EVENT[dvTP,80]				//living fast rewind
BUTTON_EVENT[dvTP,81]				//living fast forward
BUTTON_EVENT[dvTP,88]				//living shuffle

BUTTON_EVENT[dvTP,56]				//entert play
BUTTON_EVENT[dvTP,51]				//entert pause
BUTTON_EVENT[dvTP,52]				//entert stop
BUTTON_EVENT[dvTP,53]				//entert previous
BUTTON_EVENT[dvTP,54]				//entert next
BUTTON_EVENT[dvTP,55]				//entert fast rewind
BUTTON_EVENT[dvTP,57]				//entert fast forward
BUTTON_EVENT[dvTP,58]				//entert shuffle

BUTTON_EVENT[dvTP,65]				//bed play
BUTTON_EVENT[dvTP,66]				//bed pause
BUTTON_EVENT[dvTP,67]				//bed stop
BUTTON_EVENT[dvTP,68]				//bed previous
BUTTON_EVENT[dvTP,69]				//bed next
BUTTON_EVENT[dvTP,70]				//bed fast rewind
BUTTON_EVENT[dvTP,71]				//bed fast forward
BUTTON_EVENT[dvTP,72]				//bed shuffle

//------------FM CONTROLS------------//
BUTTON_EVENT[dvTP,64]				//Living preset 1
BUTTON_EVENT[dvTP,73]				//Living preset 2
BUTTON_EVENT[dvTP,82]				//Living preset 3
BUTTON_EVENT[dvTP,83]				//Living preset 4
BUTTON_EVENT[dvTP,84]				//Living preset 5
BUTTON_EVENT[dvTP,86]				//Living preset 6

BUTTON_EVENT[dvTP,87]				//Entert preset 1
BUTTON_EVENT[dvTP,89]				//Entert preset 2
BUTTON_EVENT[dvTP,90]				//Entert preset 3
BUTTON_EVENT[dvTP,91]				//Entert preset 4
BUTTON_EVENT[dvTP,92]				//Entert preset 5
BUTTON_EVENT[dvTP,93]				//Entert preset 6


{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
		//----------------------MAIN PAGE---------------------------//
			CASE 9: send_string dvBose,  "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30"	//Living rm PVR
			CASE 10: send_string dvBose, "$0b,$00,$01,$04,$25,$01,$2c,$01,$00,$00,$07"	//Living rm FM
			CASE 11: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$00,$00,$25"	//Living rm iPod
			//CASE 6: send_string dvBose,  "$0b,$00,$01,$04,$4c,$01,$2c,$01,$00,$00,$6e"	//Living rm On/Off
			
			CASE 20: send_string dvBose, "$0b,$00,$01,$04,$12,$01,$2c,$01,$01,$01,$30"	//Entert rm PVR
			CASE 21: send_string dvBose, "$0b,$00,$01,$04,$06,$01,$2c,$01,$01,$01,$24"	//Entert rm FM
			CASE 22: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$01,$01,$25"	//Entert rm iPod
			CASE 17: send_string dvBose, "$0b,$00,$01,$04,$4c,$01,$2c,$01,$01,$01,$6e"	//Entert rm On/Off
			
			CASE 31: send_string dvBose, "$0b,$00,$01,$04,$12,$01,$2c,$01,$02,$01,$33"	//Bed rm PVR
			CASE 32: send_string dvBose, "$0b,$00,$01,$04,$06,$01,$2c,$01,$02,$01,$27"	//Bed rm FM
			CASE 33: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$02,$01,$26"	//Bed rm iPod
			CASE 28: send_string dvBose, "$0b,$00,$01,$04,$4c,$01,$2c,$01,$02,$01,$6d"	//Bed rm On/Off
		//-----------------------IPOD GENERAL-------------------------//
			CASE 74: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$00,$00,$77"	//living play
			CASE 75: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$00,$00,$74"	//living pause
			CASE 76: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$00,$00,$38"	//living stop
			CASE 77: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$00,$00,$7b"	//living previous
			CASE 79: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$00,$00,$78"	//living next
			CASE 80: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$00,$00,$75"	//living fast rewind
			CASE 81: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$00,$00,$7a"	//living fast forward
			CASE 88: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$00,$00,$7f"	//living shuffle
			
			CASE 56: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$01,$01,$77"	//entert play
			CASE 51: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$01,$01,$74"	//entert pause
			CASE 52: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$01,$01,$38"	//entert stop
			CASE 53: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$01,$01,$7b"	//entert previous
			CASE 54: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$01,$01,$78"	//entert next
			CASE 55: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$01,$01,$75"	//entert fast rewind
			CASE 57: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$01,$01,$7a"	//entert fast forward
			CASE 58: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$01,$01,$7f"	//entert shuffle
			
			CASE 65: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$02,$01,$74"	//bed play
			CASE 66: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$02,$01,$77"	//bed pause
			CASE 67: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$02,$01,$3b"	//bed stop
			CASE 68: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$02,$01,$78"	//bed previous
			CASE 69: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$02,$01,$7b"	//bed next
			CASE 70: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$02,$01,$76"	//bed fast rewind
			CASE 71: send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$02,$01,$79"	//bed fast forward
			CASE 72: send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$02,$01,$7c"	//bed shuffle

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
			case 7: send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$00,$00,$21"		//Living rm Vol Up
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