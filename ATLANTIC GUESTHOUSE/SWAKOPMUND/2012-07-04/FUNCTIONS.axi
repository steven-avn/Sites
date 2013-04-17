PROGRAM_NAME='FUNCTIONS'
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

volatile integer projectorPower = 0
volatile integer TVPower1 = 0
volatile integer TVPower2 = 0

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


define_call 'Projector_On'		//Projector On
{
	 if(projectorPower == 0)
	 {
			pulse [dvProjector,6]
			call 'ScreenDOWN'		//screen down
			projectorPower = 1
	 }
}

define_call 'Projector_Off'		//Projector Off
{
	 if(projectorPower == 1)
	 {
			call 'ScreenUP'		//screen up
			pulse [dvProjector,6]
			wait 50
			pulse [dvProjector,6]
			projectorPower = 0
	 }
}

define_call 'TV1_On'		//TV1 On
{
	 if(TVPower1 == 0)
	 {
			pulse [dvTV1,9]
			TVPower1 = 1
	 }
}

define_call 'TV1_Off'		//TV1 Off
{
	 if(TVPower1 == 1)
	 {
			pulse [dvTV1,9]
			TVPower1 = 0
	 }
}

define_call 'TV2_On'		//TV2 On
{
	 if(TVPower2 == 0)
	 {
			pulse [dvTV2,9]
			TVPower2 = 1
	 }
}

define_call 'TV2_Off'		//TV2 Off
{
	 if(TVPower2 == 1)
	 {
			pulse [dvTV2,9]
			TVPower2 = 0
	 }
}


define_call 'Room1VolUp'
{
	 send_string dvAMP1, "'603%'"		//volume up room 1
	 while (VOL_LEVEL1 >= 0 && VOL_LEVEL1 < 99)
	 {
			VOL_LEVEL1 = VOL_LEVEL1 + 2
			send_level dvTP,1,VOL_LEVEL1
	 }
}

define_call 'Room1VolDown'
{
	 send_string dvAMP1, "'604%'"		//volume down room 1
	 while (VOL_LEVEL1 >= 0 && VOL_LEVEL1 < 99)
	 {
			VOL_LEVEL1 = VOL_LEVEL1 - 2
			send_level dvTP,1,VOL_LEVEL1
	 }
}

define_call 'Room2VolUp'
{
	 send_string dvAMP2, "'603%'"		//volume up room 2
	 while (VOL_LEVEL2 >= 0 && VOL_LEVEL2 < 99)
	 {
			VOL_LEVEL2 = VOL_LEVEL2 + 2
			send_level dvTP,1,VOL_LEVEL1
	 }
}

define_call 'Room2VolDown'
{
	 send_string dvAMP2, "'604%'"		//volume down room 2
	 while (VOL_LEVEL2 >= 0 && VOL_LEVEL2 < 99)
	 {
			VOL_LEVEL2 = VOL_LEVEL2 - 2
			send_level dvTP,1,VOL_LEVEL1
	 }
}

define_call 'Room1Mute'
{
	 if(mute1 == 0)		//Room 1 Mute/Unmute
	 {
			send_string dvAMP1, "'2A0.'"		//mute room 1
			mute1 = 1
			on[dvTP,5]
	 }
	 else
	 {
			send_string dvAMP1, "'0A1.'"		//unmute room 1
			mute1 = 0
			off[dvTP,5]
	 }
}

define_call 'Room2Mute'
{
	 if(mute2 == 0)		//Room 2 Mute/Unmute
	 {
			send_string dvAMP2, "'2A0.'"		//mute room 2
			mute2 = 1
			on[dvTP,6]
	 }
	 else
	 {
			send_string dvAMP2, "'0A1.'"		//unmute room 2
			mute2 = 0
			off[dvTP,6]
	 }
}

define_call 'Rm1CurtainOpen'
{
	 pulse [dvRelays,3]
}

define_call 'Rm1CurtainClose'
{
	 pulse [dvRelays,4]
}

define_call 'ScreenUP'
{
	 on [dvRelays,1]
	 wait 200
	 off [dvRelays,1]
}

define_call 'ScreenDOWN'
{
	 on [dvRelays,2]
	 wait 200
	 off [dvRelays,2]
}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)