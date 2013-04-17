PROGRAM_NAME='WD TV Live'
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

dvWD_Live_LR							=				5001:14:0													//6TH Western Digital TV Live (LIVINGROOM)
dvWD_Live_ER							=				5001:15:0													//7TH Western Digital TV Live (ENTERTAINMENT)
dvWD_Live_BR							=				5001:16:0													//8TH Western Digital TV Live (BEDROOM)

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////Constants for WesternDigital//////////////////////////
integer wdHome				=		1
integer wdPower				=		2
integer wdUp					=		3
integer wdDown				=		4
integer wdLeft				=		5
integer wdRight				=		6
integer wdEnter				=		17
integer wdBack				= 	7
integer wdOption			=		8
integer wdStop				=		9
integer wdPlayPause		=		10
integer wdRev					=		11
integer wdFF					=		12
integer wdPrev				=		13
integer wdNext				=		14
integer wdSearch			=		15
integer wdEject				=		16

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

set_pulse_time (2)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//------------------------Entertainment & Living Room--------------------------------//
button_event[dvTP,700]
button_event[dvTP,701]
button_event[dvTP,702]
button_event[dvTP,703]
button_event[dvTP,704]
button_event[dvTP,705]
button_event[dvTP,706]
button_event[dvTP,707]
button_event[dvTP,708]
button_event[dvTP,709]
button_event[dvTP,710]
button_event[dvTP,711]
button_event[dvTP,712]
button_event[dvTP,713]
button_event[dvTP,714]
button_event[dvTP,715]
button_event[dvTP,716]
button_event[dvTP,717]
button_event[dvTP,718]
button_event[dvTP,719]
button_event[dvTP,720]
button_event[dvTP,721]
button_event[dvTP,722]
button_event[dvTP,723]
button_event[dvTP,724]
button_event[dvTP,725]
button_event[dvTP,726]
button_event[dvTP,727]
button_event[dvTP,728]
button_event[dvTP,729]
button_event[dvTP,730]
button_event[dvTP,731]
button_event[dvTP,732]
button_event[dvTP,733]

{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 700: pulse[dvWD_Live_LR,wdPower]
			case 701: pulse[dvWD_Live_LR,wdHome]
			case 702: pulse[dvWD_Live_LR,wdUp]
			case 703: pulse[dvWD_Live_LR,wdDown]
			case 704: pulse[dvWD_Live_LR,wdLeft]
			case 705: pulse[dvWD_Live_LR,wdRight]
			case 706: pulse[dvWD_Live_LR,wdEnter]
			case 707: pulse[dvWD_Live_LR,wdBack]
			case 708: pulse[dvWD_Live_LR,wdOption]
			case 709: pulse[dvWD_Live_LR,wdStop]
			case 710: pulse[dvWD_Live_LR,wdPlayPause]
			case 711: pulse[dvWD_Live_LR,wdRev]
			case 712: pulse[dvWD_Live_LR,wdFF]
			case 713: pulse[dvWD_Live_LR,wdPrev]
			case 714: pulse[dvWD_Live_LR,wdNext]
			case 715: pulse[dvWD_Live_LR,wdSearch]
			case 716: pulse[dvWD_Live_LR,wdEject]
			case 717: pulse[dvWD_Live_ER,wdPower]
			case 718: pulse[dvWD_Live_ER,wdHome]
			case 719: pulse[dvWD_Live_ER,wdUp]
			case 720: pulse[dvWD_Live_ER,wdDown]
			case 721:	pulse[dvWD_Live_ER,wdLeft]
			case 722:	pulse[dvWD_Live_ER,wdRight]
			case 723:	pulse[dvWD_Live_ER,wdEnter]
			case 724:	pulse[dvWD_Live_ER,wdBack]
			case 725: pulse[dvWD_Live_ER,wdOption]
			case 726: pulse[dvWD_Live_ER,wdStop]
			case 727: pulse[dvWD_Live_ER,wdPlayPause]
			case 728: pulse[dvWD_Live_ER,wdRev]
			case 729: pulse[dvWD_Live_ER,wdFF]
			case 730: pulse[dvWD_Live_ER,wdPrev]
			case 731: pulse[dvWD_Live_ER,wdNext]
			case 732: pulse[dvWD_Live_ER,wdSearch]
			case 733: pulse[dvWD_Live_ER,wdEject]
		}
  }
}

//------------------------------------------Main BedRoom--------------------------------//
button_event[dvR4_1,734]
button_event[dvR4_1,735]
button_event[dvR4_1,736]
button_event[dvR4_1,737]
button_event[dvR4_1,738]
button_event[dvR4_1,739]
button_event[dvR4_1,740]
button_event[dvR4_1,741]
button_event[dvR4_1,742]
button_event[dvR4_1,743]
button_event[dvR4_1,744]
button_event[dvR4_1,745]
button_event[dvR4_1,746]
button_event[dvR4_1,747]
button_event[dvR4_1,748]
button_event[dvR4_1,749]
button_event[dvR4_1,750]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 734: pulse[dvWD_Live_BR,wdPower]
			case 735: pulse[dvWD_Live_BR,wdHome]
			case 736: pulse[dvWD_Live_BR,wdUp]
			case 737: pulse[dvWD_Live_BR,wdDown]
			case 738:	pulse[dvWD_Live_BR,wdLeft]
			case 739:	pulse[dvWD_Live_BR,wdRight]
			case 740:	pulse[dvWD_Live_BR,wdEnter]
			case 741:	pulse[dvWD_Live_BR,wdBack]
			case 742: pulse[dvWD_Live_BR,wdOption]
			case 743: pulse[dvWD_Live_BR,wdStop]
			case 744: pulse[dvWD_Live_BR,wdPlayPause]
			case 745: pulse[dvWD_Live_BR,wdRev]
			case 746: pulse[dvWD_Live_BR,wdFF]
			case 747: pulse[dvWD_Live_BR,wdPrev]
			case 748: pulse[dvWD_Live_BR,wdNext]
			case 749: pulse[dvWD_Live_BR,wdSearch]
			case 750: pulse[dvWD_Live_BR,wdEject]
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

