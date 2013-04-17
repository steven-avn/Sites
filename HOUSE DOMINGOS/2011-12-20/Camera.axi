PROGRAM_NAME='Camera'
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

dvSAM_DVR									=				5001:11:0													//3RD SAMSUNG DVR (CAMERAS) WITH SAMSUNG TV

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////Constants for DVR///////////////////
integer dvrPlayPause			=		1
integer dvrStop						=		2
integer dvrFFW						=		4
integer dvrRew						=		5
integer dvrPrev						=		20
integer dvrNext						=		21
integer dvrSlowFFW				=		7
integer dvrSlowRew				=		6
integer dvrPower					=		9
integer dvrMenu						=		44
integer dvrEnter					= 	49
integer dvrUp							=		45
integer dvrDwn						= 	46
integer dvrLeft						=		47
integer dvrRight					=		48
integer dvrReturn					=		50
integer dvrRecord					=		8
integer dvrMode						= 	26
integer dvrZoom						=		27
integer dvrFreeze					= 	28
integer dvrZoomIn					=		22
integer dvrZoomOut				=		23
integer dvrScrolUp				=		24
integer dvrScrolDn				=		25
integer dvrd1							=		11
integer dvrd2							=		12
integer dvrd3							=		13
integer dvrd4							=		14
integer dvrd5							=		15
integer dvrd6							=		16
integer dvrd7							=		17
integer dvrd8							=		18
integer dvrd9							=		19
integer dvrd0							=		10
integer dvrdPlus10				=		29


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

//---------------ENTERTAINMENT AREA---------------//
button_event[dvTP,400]
button_event[dvTP,401]
button_event[dvTP,402]
button_event[dvTP,403]
button_event[dvTP,404]
button_event[dvTP,405]
button_event[dvTP,406]
button_event[dvTP,407]
button_event[dvTP,408]
button_event[dvTP,409]
button_event[dvTP,410]
button_event[dvTP,411]
button_event[dvTP,412]
button_event[dvTP,413]
button_event[dvTP,414]
button_event[dvTP,415]
button_event[dvTP,416]
button_event[dvTP,417]
button_event[dvTP,418]
button_event[dvTP,419]
button_event[dvTP,420]
button_event[dvTP,421]
button_event[dvTP,422]
button_event[dvTP,423]
button_event[dvTP,424]
button_event[dvTP,425]
button_event[dvTP,426]
button_event[dvTP,427]
button_event[dvTP,428]
button_event[dvTP,429]
button_event[dvTP,430]
button_event[dvTP,431]
button_event[dvTP,432]
button_event[dvTP,433]
button_event[dvTP,434]
 
{
  push:
  {
	to[dvTP,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 400: pulse[dvSAM_DVR,dvrd0]
			case 401: pulse[dvSAM_DVR,dvrd1]
			case 402: pulse[dvSAM_DVR,dvrd2]
			case 403: pulse[dvSAM_DVR,dvrd3]
			case 404: pulse[dvSAM_DVR,dvrd4]
			case 405: pulse[dvSAM_DVR,dvrd5]
			case 406: pulse[dvSAM_DVR,dvrd6]
			case 407: pulse[dvSAM_DVR,dvrd7]
			case 408: pulse[dvSAM_DVR,dvrd8]
			case 409: pulse[dvSAM_DVR,dvrd9]
			case 410: pulse[dvSAM_DVR,dvrdPlus10]
			//case 411: pulse[dvSAM_DVR,dvrPower]
			case 412: pulse[dvSAM_DVR,dvrUp]
			case 413: pulse[dvSAM_DVR,dvrDwn]
			case 414: pulse[dvSAM_DVR,dvrLeft]
			case 415: pulse[dvSAM_DVR,dvrRight]
			case 416: pulse[dvSAM_DVR,dvrEnter]
			case 417: pulse[dvSAM_DVR,dvrScrolDn]
			case 418: pulse[dvSAM_DVR,dvrScrolUp]
			case 419: pulse[dvSAM_DVR,dvrZoomOut]
			case 420: pulse[dvSAM_DVR,dvrZoomIn]
			case 421: pulse[dvSAM_DVR,dvrStop]
			case 422: pulse[dvSAM_DVR,dvrPlayPause]
			case 423: pulse[dvSAM_DVR,dvrRew]
			case 424: pulse[dvSAM_DVR,dvrFFW]
			case 425: pulse[dvSAM_DVR,dvrPrev]
			case 426: pulse[dvSAM_DVR,dvrSlowRew]
			case 427: pulse[dvSAM_DVR,dvrSlowFFW]
			case 428: pulse[dvSAM_DVR,dvrNext]
			case 429: pulse[dvSAM_DVR,dvrMenu]
			case 430: pulse[dvSAM_DVR,dvrReturn]
			case 431: pulse[dvSAM_DVR,dvrRecord]
			case 432: pulse[dvSAM_DVR,dvrMode]
			case 433: pulse[dvSAM_DVR,dvrZoom]
			case 434: pulse[dvSAM_DVR,dvrFreeze]
		}
  }
}

//---------------------MAIN BEDROOM------------------//
button_event[dvR4_1,400]
button_event[dvR4_1,401]
button_event[dvR4_1,402]
button_event[dvR4_1,403]
button_event[dvR4_1,404]
button_event[dvR4_1,405]
button_event[dvR4_1,406]
button_event[dvR4_1,407]
button_event[dvR4_1,408]
button_event[dvR4_1,409]
button_event[dvR4_1,410]
button_event[dvR4_1,411]
button_event[dvR4_1,412]
button_event[dvR4_1,413]
button_event[dvR4_1,414]
button_event[dvR4_1,415]
button_event[dvR4_1,416]
button_event[dvR4_1,417]
button_event[dvR4_1,418]
button_event[dvR4_1,419]
button_event[dvR4_1,420]
button_event[dvR4_1,421]
button_event[dvR4_1,422]
button_event[dvR4_1,423]
button_event[dvR4_1,424]
button_event[dvR4_1,425]
button_event[dvR4_1,426]
button_event[dvR4_1,427]
button_event[dvR4_1,428]
button_event[dvR4_1,429]
button_event[dvR4_1,430]
button_event[dvR4_1,431]
button_event[dvR4_1,432]
button_event[dvR4_1,433]
button_event[dvR4_1,434]

{
  push:
  {
	to[dvR4_1,BUTTON.INPUT.CHANNEL]
		switch(BUTTON.INPUT.CHANNEL)
		{
			case 400: pulse[dvSAM_DVR,dvrd0]
			case 401: pulse[dvSAM_DVR,dvrd1]
			case 402: pulse[dvSAM_DVR,dvrd2]
			case 403: pulse[dvSAM_DVR,dvrd3]
			case 404: pulse[dvSAM_DVR,dvrd4]
			case 405: pulse[dvSAM_DVR,dvrd5]
			case 406: pulse[dvSAM_DVR,dvrd6]
			case 407: pulse[dvSAM_DVR,dvrd7]
			case 408: pulse[dvSAM_DVR,dvrd8]
			case 409: pulse[dvSAM_DVR,dvrd9]
			case 410: pulse[dvSAM_DVR,dvrdPlus10]
			//case 411: pulse[dvSAM_DVR,dvrPower]
			case 412: pulse[dvSAM_DVR,dvrUp]
			case 413: pulse[dvSAM_DVR,dvrDwn]
			case 414: pulse[dvSAM_DVR,dvrLeft]
			case 415: pulse[dvSAM_DVR,dvrRight]
			case 416: pulse[dvSAM_DVR,dvrEnter]
			case 417: pulse[dvSAM_DVR,dvrScrolDn]
			case 418: pulse[dvSAM_DVR,dvrScrolUp]
			case 419: pulse[dvSAM_DVR,dvrZoomOut]
			case 420: pulse[dvSAM_DVR,dvrZoomIn]
			case 421: pulse[dvSAM_DVR,dvrStop]
			case 422: pulse[dvSAM_DVR,dvrPlayPause]
			case 423: pulse[dvSAM_DVR,dvrRew]
			case 424: pulse[dvSAM_DVR,dvrFFW]
			case 425: pulse[dvSAM_DVR,dvrPrev]
			case 426: pulse[dvSAM_DVR,dvrSlowRew]
			case 427: pulse[dvSAM_DVR,dvrSlowFFW]
			case 428: pulse[dvSAM_DVR,dvrNext]
			case 429: pulse[dvSAM_DVR,dvrMenu]
			case 430: pulse[dvSAM_DVR,dvrReturn]
			case 431: pulse[dvSAM_DVR,dvrRecord]
			case 432: pulse[dvSAM_DVR,dvrMode]
			case 433: pulse[dvSAM_DVR,dvrZoom]
			case 434: pulse[dvSAM_DVR,dvrFreeze]
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

