PROGRAM_NAME='Apacer'
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

/////////////////Constants for Apacer/WesternDigital//////////////////////////
VOLATILE INTEGER wdHome				=		1
VOLATILE INTEGER wdPower			=		2
VOLATILE INTEGER wdUp					=		3
VOLATILE INTEGER wdDown				=		4
VOLATILE INTEGER wdLeft				=		5
VOLATILE INTEGER wdRight			=		6
VOLATILE INTEGER wdEnter			=		17
VOLATILE INTEGER wdBack				= 	7
VOLATILE INTEGER wdOption			=		8
VOLATILE INTEGER wdStop				=		9
VOLATILE INTEGER wdPause			=		10
VOLATILE INTEGER wdRev				=		11
VOLATILE INTEGER wdFF					=		12
VOLATILE INTEGER wdPrev				=		13
VOLATILE INTEGER wdNext				=		14

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER APACER_BUTTONS[] =	 {4,5,6,9,11,12,64,65,66,67,68,69,70,71}
VOLATILE INTEGER R4_APACER_BUTTONS[] =	 {735,736,737,738,739,740,741,742,
																					743,744,745,746,474,748,749}

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

SET_PULSE_TIME (2)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//-----------------------PATIO TOUCH PANEL------------------------------//
BUTTON_EVENT[dvTP,APACER_BUTTONS]
{
  PUSH:
  {
	TO[dvTP,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 71:PULSE[dvApacerDown,wdHome]
			CASE 66:PULSE[dvApacerDown,wdUp]
			CASE 68:PULSE[dvApacerDown,wdDown]
			CASE 69:PULSE[dvApacerDown,wdLeft]
			CASE 67:PULSE[dvApacerDown,wdRight]
			CASE 70:PULSE[dvApacerDown,wdEnter]
			CASE 65:PULSE[dvApacerDown,wdBack]
			CASE 64:PULSE[dvApacerDown,wdOption]
			CASE 4: PULSE[dvApacerDown,wdStop]
			CASE 5: PULSE[dvApacerDown,wdPause]
			CASE 6: PULSE[dvApacerDown,wdRev]
			CASE 12:PULSE[dvApacerDown,wdFF]
			CASE 9: PULSE[dvApacerDown,wdPrev]
			CASE 11:PULSE[dvApacerDown,wdNext]
		}
  }
}

//------------------------FAMILY TV ROOM--------------------------------//
BUTTON_EVENT[dvR4_FamTvRm,R4_APACER_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_FamTvRm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 735: PULSE[dvApacerDown,wdHome]
			CASE 736: PULSE[dvApacerDown,wdUp]
			CASE 737: PULSE[dvApacerDown,wdDown]
			CASE 738:	PULSE[dvApacerDown,wdLeft]
			CASE 739:	PULSE[dvApacerDown,wdRight]
			CASE 740:	PULSE[dvApacerDown,wdEnter]
			CASE 741:	PULSE[dvApacerDown,wdBack]
			CASE 742: PULSE[dvApacerDown,wdOption]
			CASE 743: PULSE[dvApacerDown,wdStop]
			CASE 744: PULSE[dvApacerDown,wdPause]
			CASE 745: PULSE[dvApacerDown,wdRev]
			CASE 746: PULSE[dvApacerDown,wdFF]
			CASE 747: PULSE[dvApacerDown,wdPrev]
			CASE 748: PULSE[dvApacerDown,wdNext]
		}
  }
}

//------------------------MAIN BEDROOM--------------------------------//
BUTTON_EVENT[dvR4_MainBedrm,R4_APACER_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_MainBedrm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 735: PULSE[dvApacerUp,wdHome]
			CASE 736: PULSE[dvApacerUp,wdUp]
			CASE 737: PULSE[dvApacerUp,wdDown]
			CASE 738:	PULSE[dvApacerUp,wdLeft]
			CASE 739:	PULSE[dvApacerUp,wdRight]
			CASE 740:	PULSE[dvApacerUp,wdEnter]
			CASE 741:	PULSE[dvApacerUp,wdBack]
			CASE 742: PULSE[dvApacerUp,wdOption]
			CASE 743: PULSE[dvApacerUp,wdStop]
			CASE 744: PULSE[dvApacerUp,wdPause]
			CASE 745: PULSE[dvApacerUp,wdRev]
			CASE 746: PULSE[dvApacerUp,wdFF]
			CASE 747: PULSE[dvApacerUp,wdPrev]
			CASE 748: PULSE[dvApacerUp,wdNext]
		}
  }
}

//------------------------BEDROOM 1--------------------------------//
BUTTON_EVENT[dvR4_Bedrm1,R4_APACER_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_Bedrm1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 735: PULSE[dvApacerUp,wdHome]
			CASE 736: PULSE[dvApacerUp,wdUp]
			CASE 737: PULSE[dvApacerUp,wdDown]
			CASE 738:	PULSE[dvApacerUp,wdLeft]
			CASE 739:	PULSE[dvApacerUp,wdRight]
			CASE 740:	PULSE[dvApacerUp,wdEnter]
			CASE 741:	PULSE[dvApacerUp,wdBack]
			CASE 742: PULSE[dvApacerUp,wdOption]
			CASE 743: PULSE[dvApacerUp,wdStop]
			CASE 744: PULSE[dvApacerUp,wdPause]
			CASE 745: PULSE[dvApacerUp,wdRev]
			CASE 746: PULSE[dvApacerUp,wdFF]
			CASE 747: PULSE[dvApacerUp,wdPrev]
			CASE 748: PULSE[dvApacerUp,wdNext]
		}
  }
}

//------------------------BEDROOM 2--------------------------------//
BUTTON_EVENT[dvR4_Bedrm2,R4_APACER_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_Bedrm2,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 735: PULSE[dvApacerUp,wdHome]
			CASE 736: PULSE[dvApacerUp,wdUp]
			CASE 737: PULSE[dvApacerUp,wdDown]
			CASE 738:	PULSE[dvApacerUp,wdLeft]
			CASE 739:	PULSE[dvApacerUp,wdRight]
			CASE 740:	PULSE[dvApacerUp,wdEnter]
			CASE 741:	PULSE[dvApacerUp,wdBack]
			CASE 742: PULSE[dvApacerUp,wdOption]
			CASE 743: PULSE[dvApacerUp,wdStop]
			CASE 744: PULSE[dvApacerUp,wdPause]
			CASE 745: PULSE[dvApacerUp,wdRev]
			CASE 746: PULSE[dvApacerUp,wdFF]
			CASE 747: PULSE[dvApacerUp,wdPrev]
			CASE 748: PULSE[dvApacerUp,wdNext]
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