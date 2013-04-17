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

// MAIN
button_event[dvR4_1,1]		// Input 2 (PVR)
button_event[dvR4_1,2]		// FM source
button_event[dvR4_1,3]		// iPod source

// IPOD GENERAL
button_event[dvR4_1,4]		// play
button_event[dvR4_1,5]		// pause
button_event[dvR4_1,6]		// stop
button_event[dvR4_1,7]		// previous
button_event[dvR4_1,8]		// next
button_event[dvR4_1,9]		// fast rewind
button_event[dvR4_1,10]		// fast forward
button_event[dvR4_1,11]		// shuffle
button_event[dvR4_1,12]		// Up
button_event[dvR4_1,13]		// Left
button_event[dvR4_1,14]		// Down
button_event[dvR4_1,15]		// Right

// FM CONTROLS
button_event[dvR4_1,16]		// tuner preset 1
button_event[dvR4_1,17]		// tuner preset 2
button_event[dvR4_1,18]		// tuner preset 3
button_event[dvR4_1,19]		// tuner preset 4
button_event[dvR4_1,20]		// tuner preset 5
{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
		// MAIN PAGE
			case 1:	send_string dvBose, "$0b,$00,$01,$04,$12,$01,$2c,$01,$00,$00,$30" // Input 2 (PVR)
			case 2: send_string dvBose, "$0b,$00,$01,$04,$25,$01,$2c,$01,$00,$00,$07"	// FM source
			case 3: send_string dvBose, "$0b,$00,$01,$04,$07,$01,$2c,$01,$00,$00,$25"	// iPod source

		// IPOD GENERAL
			case 4: send_string dvBose, "$0b,$00,$01,$04,$55,$01,$2c,$01,$00,$00,$77"	// play
			case 5: send_string dvBose, "$0b,$00,$01,$04,$56,$01,$2c,$01,$00,$00,$74"	// pause
			case 6: send_string dvBose, "$0b,$00,$01,$04,$1a,$01,$2c,$01,$00,$00,$38"	// stop
			case 7: send_string dvBose, "$0b,$00,$01,$04,$59,$01,$2c,$01,$00,$00,$7b"	// previous
			case 8: send_string dvBose, "$0b,$00,$01,$04,$5a,$01,$2c,$01,$00,$00,$78"	// next
			case 9: send_string dvBose, "$0b,$00,$01,$04,$57,$01,$2c,$01,$00,$00,$75"	// fast rewind
			case 10:send_string dvBose, "$0b,$00,$01,$04,$58,$01,$2c,$01,$00,$00,$7a"	// fast forward
			case 11:send_string dvBose, "$0b,$00,$01,$04,$5d,$01,$2c,$01,$00,$00,$7f"	// shuffle
			case 12:send_string dvBose, "$0b,$00,$01,$04,$c0,$01,$2c,$01,$00,$00,$e2"	// Up
			case 13:send_string dvBose, "$0b,$00,$01,$04,$60,$01,$2c,$01,$00,$00,$42"	// Right
			case 14:send_string dvBose, "$0b,$00,$01,$04,$20,$01,$2c,$01,$00,$00,$02"	// Down
			case 15:send_string dvBose, "$0b,$00,$01,$04,$a0,$01,$2c,$01,$00,$00,$82"	// Left

		// FM CONTROLS
			case 16:send_string dvBose, "$0b,$00,$01,$04,$41,$01,$2c,$01,$00,$00,$63"	// tuner preset 1
			case 17:send_string dvBose, "$0b,$00,$01,$04,$42,$01,$2c,$01,$00,$00,$60"	// tuner preset 2
			case 18:send_string dvBose, "$0b,$00,$01,$04,$43,$01,$2c,$01,$00,$00,$61"	// tuner preset 3
			case 19:send_string dvBose, "$0b,$00,$01,$04,$44,$01,$2c,$01,$00,$00,$66"	// tuner preset 4
			case 20:send_string dvBose, "$0b,$00,$01,$04,$45,$01,$2c,$01,$00,$00,$67"	// tuner preset 5
		}
  }
}

// MAIN VOLUME CONTROLS
button_event[dvR4_1,21]		//Volume Up
button_event[dvR4_1,22]		//Volume Down

{
  hold[1,repeat]:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 21:send_string dvBose, "$0b,$00,$01,$04,$03,$01,$2c,$01,$00,$00,$21"	// Vol Up
			case 22:send_string dvBose, "$0b,$00,$01,$04,$02,$01,$2c,$01,$00,$00,$20"	// Vol Dn
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