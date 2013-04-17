PROGRAM_NAME='jacuzi'
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

//----------------------------KEYPAD--------------------------//
BUTTON_EVENT[dvKP_Jacuzi,1]		//JACUZI LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsJacuzi == 0)
			{
				 CALL 'LightsRoofGarden_On';		//JACUZI LIGHTS ON
				 vLightsJacuzi = 1
			}
	 ELSE
			{
				 CALL 'LightsRoofGarden_Off';	 //JACUZI LIGHTS OFF
				 vLightsJacuzi = 0
			}
	}
}

BUTTON_EVENT[dvKP_Jacuzi,2]		//OUTSIDE LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsOutside == 0)
			{
				 CALL 'lightsOutside_On';		//OUTSIDE LIGHTS ON
				 vLightsOutside = 1;
			}
	 ELSE
			{
				 CALL 'lightsOutside_Off';		//OUTSIDE LIGHTS OFF
				 vLightsOutside = 0;
			}
	}
}

BUTTON_EVENT[dvKP_Jacuzi,12]	//ON/OFF
{
	 PUSH:
	 {
			ON [vdvMatrixAudio[16],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_Jacuzi,7]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[16],1,178;
  }
}

BUTTON_EVENT[dvKP_Jacuzi,8]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
  }
}

BUTTON_EVENT[dvKP_Jacuzi,11]		//MUTE
{
	 PUSH:
	 {
				 ON [vdvMatrixAudio[16],199];		//MUTE
	 }
}

BUTTON_EVENT[dvKP_Jacuzi,13]		// VOLUME DOWN
{
	 PUSH:
	 {
				ON[vdvMatrixAudio[16],25]
					 WAIT 4
					 {
						 OFF[vdvMatrixAudio[16],25]
					 }
	 }
}

BUTTON_EVENT[dvKP_Jacuzi,14]		// VOLUME UP
{
	 PUSH:
	 {
				ON[vdvMatrixAudio[16],24]
					 WAIT 8
					 {
						 OFF[vdvMatrixAudio[16],24]
					 }
	 }
}

//BUTTON_EVENT[dvKP_Jacuzi,14]		//VOLUME UP
//BUTTON_EVENT[dvKP_Jacuzi,13]		//VOLUME DOWN
//{
//	 HOLD[1,REPEAT]:
//	 {
//	 PULSE[dvKP_Jacuzi,BUTTON.INPUT.CHANNEL]
//			SWITCH(BUTTON.INPUT.CHANNEL)
//			{
//			CASE 14: ON[vdvMatrixAudio[16],24]
//							 WAIT 2
//							 {
//								 OFF[vdvMatrixAudio[16],24]
//								 WAIT 2
//								 OFF[vdvMatrixAudio[16],24]
//							 }
//			CASE 13: ON[vdvMatrixAudio[16],25]
//							 WAIT 2
//							 {
//								 OFF[vdvMatrixAudio[16],25]
//							 }
//			}
//	 }
//}

//--------------------------TOUCH PANEL-----------------------------//
BUTTON_EVENT[dvTP,824]		//JACUZI LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsJacuzi == 0)
			{
				 CALL 'LightsRoofGarden_On';		//JACUZI LIGHTS ON
				 vLightsJacuzi = 1
			}
	 ELSE
			{
				 CALL 'LightsRoofGarden_Off';	 //JACUZI LIGHTS OFF
				 vLightsJacuzi = 0
			}
	}
}

BUTTON_EVENT[dvTP,81]	// MUSIC SERVER
{
  PUSH:
  {
			CALL 'XivaMainBedroom';		// MAIN BEDROOM
			SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUTSELECT-5'";		// Input 5(iMERGE 1) Output 1(main BEDROOM)
			SEND_LEVEL vdvMATRIXAUDIO[16],1,178;
  }
}

BUTTON_EVENT[dvTP,82]	// RADIO
{
  PUSH:
  {
		SEND_COMMAND vdvMATRIXAUDIO[16],"'INPUT-INTERNAL TUNER,1'";
		SEND_LEVEL vdvMATRIXAUDIO[16],1,179;
  }
}

//------------------VOLUME CONTROL-----------------//
BUTTON_EVENT[dvTP,80]		//MUTE
{
  PUSH:
  {
				 ON [vdvMatrixAudio[16],199];		//MUTE
  }
}

BUTTON_EVENT[dvTP,78]		//VOLUME UP
BUTTON_EVENT[dvTP,79]		//VOLUME DOWN
{
	 HOLD[1,REPEAT]:
	 {
	 PULSE[dvTP,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
			CASE 78: ON[vdvMatrixAudio[16],24]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[16],24]
							 }
			CASE 79: ON[vdvMatrixAudio[16],25]
							 WAIT 2
							 {
								 OFF[vdvMatrixAudio[16],25]
							 }
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