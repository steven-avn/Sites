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

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

/////////////////Constants for DVR///////////////////
INTEGER dvrPlayPause			=		1
INTEGER dvrStop						=		2
INTEGER dvrFFW						=		4
INTEGER dvrRew						=		5
INTEGER dvrPrev						=		20
INTEGER dvrNext						=		21
INTEGER dvrSlowFFW				=		7
INTEGER dvrSlowRew				=		6
INTEGER dvrPower					=		9
INTEGER dvrMenu						=		44
INTEGER dvrEnter					= 	49
INTEGER dvrUp							=		45
INTEGER dvrDwn						= 	46
INTEGER dvrLeft						=		47
INTEGER dvrRight					=		48
INTEGER dvrReturn					=		50
INTEGER dvrRecord					=		8
INTEGER dvrMode						= 	26
INTEGER dvrZoom						=		27
INTEGER dvrFreeze					= 	28
INTEGER dvrZoomIn					=		22
INTEGER dvrZoomOut				=		23
INTEGER dvrScrolUp				=		24
INTEGER dvrScrolDn				=		25
INTEGER dvrd1							=		11
INTEGER dvrd2							=		12
INTEGER dvrd3							=		13
INTEGER dvrd4							=		14
INTEGER dvrd5							=		15
INTEGER dvrd6							=		16
INTEGER dvrd7							=		17
INTEGER dvrd8							=		18
INTEGER dvrd9							=		19
INTEGER dvrd0							=		10
INTEGER dvrdPlus10				=		29


(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER PVR_BUTTONS[] =  {400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,
													 416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,
													 432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447
												 }

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
BUTTON_EVENT[dvTP_PVR,PVR_BUTTONS]
{
  PUSH:
  {
	TO[dvTP_PVR,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 400: PULSE[dvCameraPVR,dvrd0]
			CASE 401: PULSE[dvCameraPVR,dvrd1]
			CASE 402: PULSE[dvCameraPVR,dvrd2]
			CASE 403: PULSE[dvCameraPVR,dvrd3]
			CASE 404: PULSE[dvCameraPVR,dvrd4]
			CASE 405: PULSE[dvCameraPVR,dvrd5]
			CASE 406: PULSE[dvCameraPVR,dvrd6]
			CASE 407: PULSE[dvCameraPVR,dvrd7]
			CASE 408: PULSE[dvCameraPVR,dvrd8]
			CASE 409: PULSE[dvCameraPVR,dvrd9]
			CASE 410: PULSE[dvCameraPVR,dvrdPlus10]
			CASE 411: PULSE[dvCameraPVR,dvrPower]
			CASE 412: PULSE[dvCameraPVR,dvrUp]
			CASE 413: PULSE[dvCameraPVR,dvrDwn]
			CASE 414: PULSE[dvCameraPVR,dvrLeft]
			CASE 415: PULSE[dvCameraPVR,dvrRight]
			CASE 416: PULSE[dvCameraPVR,dvrEnter]
			CASE 417: PULSE[dvCameraPVR,dvrScrolDn]
			CASE 418: PULSE[dvCameraPVR,dvrScrolUp]
			CASE 419: PULSE[dvCameraPVR,dvrZoomOut]
			CASE 420: PULSE[dvCameraPVR,dvrZoomIn]
			CASE 421: PULSE[dvCameraPVR,dvrStop]
			CASE 422: PULSE[dvCameraPVR,dvrPlayPause]
			CASE 423: PULSE[dvCameraPVR,dvrRew]
			CASE 424: PULSE[dvCameraPVR,dvrFFW]
			CASE 425: PULSE[dvCameraPVR,dvrPrev]
			CASE 426: PULSE[dvCameraPVR,dvrSlowRew]
			CASE 427: PULSE[dvCameraPVR,dvrSlowFFW]
			CASE 428: PULSE[dvCameraPVR,dvrNext]
			CASE 429: PULSE[dvCameraPVR,dvrMenu]
			CASE 430: PULSE[dvCameraPVR,dvrReturn]
			CASE 431: PULSE[dvCameraPVR,dvrRecord]
			CASE 432: PULSE[dvCameraPVR,dvrMode]
			CASE 433: PULSE[dvCameraPVR,dvrZoom]
			CASE 434: PULSE[dvCameraPVR,dvrFreeze]
		}
  }
}

//---------------------BEDROOM 1------------------//
BUTTON_EVENT[dvR4_Bedrm1,PVR_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_Bedrm1,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 400: PULSE[dvCameraPVR,dvrd0]
			CASE 401: PULSE[dvCameraPVR,dvrd1]
			CASE 402: PULSE[dvCameraPVR,dvrd2]
			CASE 403: PULSE[dvCameraPVR,dvrd3]
			CASE 404: PULSE[dvCameraPVR,dvrd4]
			CASE 405: PULSE[dvCameraPVR,dvrd5]
			CASE 406: PULSE[dvCameraPVR,dvrd6]
			CASE 407: PULSE[dvCameraPVR,dvrd7]
			CASE 408: PULSE[dvCameraPVR,dvrd8]
			CASE 409: PULSE[dvCameraPVR,dvrd9]
			CASE 410: PULSE[dvCameraPVR,dvrdPlus10]
			CASE 411: PULSE[dvCameraPVR,dvrPower]
			CASE 412: PULSE[dvCameraPVR,dvrUp]
			CASE 413: PULSE[dvCameraPVR,dvrDwn]
			CASE 414: PULSE[dvCameraPVR,dvrLeft]
			CASE 415: PULSE[dvCameraPVR,dvrRight]
			CASE 416: PULSE[dvCameraPVR,dvrEnter]
			CASE 417: PULSE[dvCameraPVR,dvrScrolDn]
			CASE 418: PULSE[dvCameraPVR,dvrScrolUp]
			CASE 419: PULSE[dvCameraPVR,dvrZoomOut]
			CASE 420: PULSE[dvCameraPVR,dvrZoomIn]
			CASE 421: PULSE[dvCameraPVR,dvrStop]
			CASE 422: PULSE[dvCameraPVR,dvrPlayPause]
			CASE 423: PULSE[dvCameraPVR,dvrRew]
			CASE 424: PULSE[dvCameraPVR,dvrFFW]
			CASE 425: PULSE[dvCameraPVR,dvrPrev]
			CASE 426: PULSE[dvCameraPVR,dvrSlowRew]
			CASE 427: PULSE[dvCameraPVR,dvrSlowFFW]
			CASE 428: PULSE[dvCameraPVR,dvrNext]
			CASE 429: PULSE[dvCameraPVR,dvrMenu]
			CASE 430: PULSE[dvCameraPVR,dvrReturn]
			CASE 431: PULSE[dvCameraPVR,dvrRecord]
			CASE 432: PULSE[dvCameraPVR,dvrMode]
			CASE 433: PULSE[dvCameraPVR,dvrZoom]
			CASE 434: PULSE[dvCameraPVR,dvrFreeze]
		}
  }
}

//---------------------BEDROOM 2------------------//
BUTTON_EVENT[dvR4_Bedrm2,PVR_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_Bedrm2,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 400: PULSE[dvCameraPVR,dvrd0]
			CASE 401: PULSE[dvCameraPVR,dvrd1]
			CASE 402: PULSE[dvCameraPVR,dvrd2]
			CASE 403: PULSE[dvCameraPVR,dvrd3]
			CASE 404: PULSE[dvCameraPVR,dvrd4]
			CASE 405: PULSE[dvCameraPVR,dvrd5]
			CASE 406: PULSE[dvCameraPVR,dvrd6]
			CASE 407: PULSE[dvCameraPVR,dvrd7]
			CASE 408: PULSE[dvCameraPVR,dvrd8]
			CASE 409: PULSE[dvCameraPVR,dvrd9]
			CASE 410: PULSE[dvCameraPVR,dvrdPlus10]
			CASE 411: PULSE[dvCameraPVR,dvrPower]
			CASE 412: PULSE[dvCameraPVR,dvrUp]
			CASE 413: PULSE[dvCameraPVR,dvrDwn]
			CASE 414: PULSE[dvCameraPVR,dvrLeft]
			CASE 415: PULSE[dvCameraPVR,dvrRight]
			CASE 416: PULSE[dvCameraPVR,dvrEnter]
			CASE 417: PULSE[dvCameraPVR,dvrScrolDn]
			CASE 418: PULSE[dvCameraPVR,dvrScrolUp]
			CASE 419: PULSE[dvCameraPVR,dvrZoomOut]
			CASE 420: PULSE[dvCameraPVR,dvrZoomIn]
			CASE 421: PULSE[dvCameraPVR,dvrStop]
			CASE 422: PULSE[dvCameraPVR,dvrPlayPause]
			CASE 423: PULSE[dvCameraPVR,dvrRew]
			CASE 424: PULSE[dvCameraPVR,dvrFFW]
			CASE 425: PULSE[dvCameraPVR,dvrPrev]
			CASE 426: PULSE[dvCameraPVR,dvrSlowRew]
			CASE 427: PULSE[dvCameraPVR,dvrSlowFFW]
			CASE 428: PULSE[dvCameraPVR,dvrNext]
			CASE 429: PULSE[dvCameraPVR,dvrMenu]
			CASE 430: PULSE[dvCameraPVR,dvrReturn]
			CASE 431: PULSE[dvCameraPVR,dvrRecord]
			CASE 432: PULSE[dvCameraPVR,dvrMode]
			CASE 433: PULSE[dvCameraPVR,dvrZoom]
			CASE 434: PULSE[dvCameraPVR,dvrFreeze]
		}
  }
}

//---------------------MAIN BEDROOM------------------//
BUTTON_EVENT[dvR4_MainBedrm,PVR_BUTTONS]
{
  PUSH:
  {
	TO[dvR4_MainBedrm,BUTTON.INPUT.CHANNEL]
		SWITCH(BUTTON.INPUT.CHANNEL)
		{
			CASE 400: PULSE[dvCameraPVR,dvrd0]
			CASE 401: PULSE[dvCameraPVR,dvrd1]
			CASE 402: PULSE[dvCameraPVR,dvrd2]
			CASE 403: PULSE[dvCameraPVR,dvrd3]
			CASE 404: PULSE[dvCameraPVR,dvrd4]
			CASE 405: PULSE[dvCameraPVR,dvrd5]
			CASE 406: PULSE[dvCameraPVR,dvrd6]
			CASE 407: PULSE[dvCameraPVR,dvrd7]
			CASE 408: PULSE[dvCameraPVR,dvrd8]
			CASE 409: PULSE[dvCameraPVR,dvrd9]
			CASE 410: PULSE[dvCameraPVR,dvrdPlus10]
			CASE 411: PULSE[dvCameraPVR,dvrPower]
			CASE 412: PULSE[dvCameraPVR,dvrUp]
			CASE 413: PULSE[dvCameraPVR,dvrDwn]
			CASE 414: PULSE[dvCameraPVR,dvrLeft]
			CASE 415: PULSE[dvCameraPVR,dvrRight]
			CASE 416: PULSE[dvCameraPVR,dvrEnter]
			CASE 417: PULSE[dvCameraPVR,dvrScrolDn]
			CASE 418: PULSE[dvCameraPVR,dvrScrolUp]
			CASE 419: PULSE[dvCameraPVR,dvrZoomOut]
			CASE 420: PULSE[dvCameraPVR,dvrZoomIn]
			CASE 421: PULSE[dvCameraPVR,dvrStop]
			CASE 422: PULSE[dvCameraPVR,dvrPlayPause]
			CASE 423: PULSE[dvCameraPVR,dvrRew]
			CASE 424: PULSE[dvCameraPVR,dvrFFW]
			CASE 425: PULSE[dvCameraPVR,dvrPrev]
			CASE 426: PULSE[dvCameraPVR,dvrSlowRew]
			CASE 427: PULSE[dvCameraPVR,dvrSlowFFW]
			CASE 428: PULSE[dvCameraPVR,dvrNext]
			CASE 429: PULSE[dvCameraPVR,dvrMenu]
			CASE 430: PULSE[dvCameraPVR,dvrReturn]
			CASE 431: PULSE[dvCameraPVR,dvrRecord]
			CASE 432: PULSE[dvCameraPVR,dvrMode]
			CASE 433: PULSE[dvCameraPVR,dvrZoom]
			CASE 434: PULSE[dvCameraPVR,dvrFreeze]
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