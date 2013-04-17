PROGRAM_NAME='guestFlat'
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

//-------------------GUEST LOUNGE---------------------//
BUTTON_EVENT[dvKP_GuestLounge,1]		//GUEST KITCHEN LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsGuestLounge == 0)
			{
				 CALL 'lightsFlatLounge_On';		//GUEST KITCHEN LIGHTS ON
				 vLightsGuestLounge = 1;
			}
	 ELSE
			{
				 CALL 'lightsFlatLounge_Off';		//GUEST KITCHEN LIGHTS OFF
				 vLightsGuestLounge = 0;
			}
	}
}

//-------------------GUEST BEDROOM 1---------------------//
BUTTON_EVENT[dvKP_GuestBedRm1,1]		//GUEST BEDROOM 1 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsGuestBedRm1 == 0)
			{
				 CALL 'lightsFlatBedRm1_On';		//GUEST BEDROOM 1 LIGHTS ON
				 vLightsGuestBedRm1 = 1;
			}
	 ELSE
			{
				 CALL 'lightsFlatBedRm1_Off';		//GUEST BEDROOM 1 LIGHTS OFF
				 vLightsGuestBedRm1 = 0;
			}
	}
}

//-------------------GUEST BEDROOM 2---------------------//
BUTTON_EVENT[dvKP_GuestBedRm2,1]		//GUEST BEDROOM 2 LIGHTS ON/OFF
{
  PUSH:
  {
	 IF (vLightsGuestBedRm2 == 0)
			{
				 CALL 'lightsFlatBedRm2_On';		//GUEST BEDROOM 2 LIGHTS ON
				 vLightsGuestBedRm2 = 1;
			}
	 ELSE
			{
				 CALL 'lightsFlatBedRm2_Off';		//GUEST BEDROOM 2 LIGHTS OFF
				 vLightsGuestBedRm2 = 0;
			}
	}
}

BUTTON_EVENT[dvR4_Flat,801]		//GUEST KITCHEN LIGHTS ON
{
  PUSH:
  {
			CALL 'lightsFlatLounge_On';		//GUEST KITCHEN LIGHTS ON
			vLightsGuestLounge = 1;
			ON [dvR4_Flat,801];
			OFF [dvR4_Flat,802];
  }
}

BUTTON_EVENT[dvR4_Flat,802]		//GUEST KITCHEN LIGHTS OFF
{
  PUSH:
  {
			CALL 'lightsFlatLounge_Off';		//GUEST KITCHEN LIGHTS OFF
			vLightsGuestLounge = 0;
			ON [dvR4_Flat,802];
			OFF [dvR4_Flat,801];
  }
}

BUTTON_EVENT[dvR4_Flat,803]		//GUEST BEDROOM 1 LIGHTS ON
{
  PUSH:
  {
			CALL 'lightsFlatBedRm1_On';		//GUEST BEDROOM 1 LIGHTS ON
			vLightsGuestBedRm1 = 1;
			ON [dvR4_Flat,803];
			OFF [dvR4_Flat,804];
  }
}

BUTTON_EVENT[dvR4_Flat,804]		//GUEST BEDROOM 1 LIGHTS OFF
{
  PUSH:
  {
			CALL 'lightsFlatBedRm1_Off';		//GUEST BEDROOM 1 LIGHTS OFF
			vLightsGuestBedRm1 = 0;
			ON [dvR4_Flat,804];
			OFF [dvR4_Flat,803];
  }
}

BUTTON_EVENT[dvR4_Flat,805]		//GUEST BEDROOM 2 LIGHTS ON
{
  PUSH:
  {
			CALL 'lightsFlatBedRm2_On';		//GUEST BEDROOM 2 LIGHTS ON
			vLightsGuestBedRm2 = 1;
			ON [dvR4_Flat,805];
			OFF [dvR4_Flat,806];
  }
}

BUTTON_EVENT[dvR4_Flat,806]		//GUEST BEDROOM 2 LIGHTS OFF
{
  PUSH:
  {
			CALL 'lightsFlatBedRm2_Off';		//GUEST BEDROOM 2 LIGHTS OFF
			vLightsGuestBedRm2 = 0;
			ON [dvR4_Flat,806];
			OFF [dvR4_Flat,805];
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