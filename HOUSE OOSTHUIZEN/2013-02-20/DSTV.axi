PROGRAM_NAME='DSTV'
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

/////////////////Constants for DSTV//////////////////////////
INTEGER cdExit		=		50
INTEGER cdGuide		=		56
INTEGER cdInfo		=		69
INTEGER cdPower		=		9
INTEGER cdMenu		=		44
INTEGER cdOk			=		49
INTEGER cdUp			=		45
INTEGER cdDwn			= 	46
INTEGER cdLeft		=		47
INTEGER cdRight		=		48
INTEGER cd1				=		11
INTEGER cd2				=		12
INTEGER cd3				=		13
INTEGER cd4				=		14
INTEGER cd5				=		15
INTEGER cd6				=		16
INTEGER cd7				=		17
INTEGER cd8				=		18
INTEGER cd9				=		19
INTEGER cd0				=		10
INTEGER cdRecall	=		55
INTEGER cdChUp		=		22
INTEGER cdChDn		=		23
INTEGER cdVolUp		=		126
INTEGER cdVolDn		=		127
INTEGER cdTV			=		121
INTEGER cdLang		=		132
INTEGER cdPower		=		9
INTEGER cdPlay		=		1
INTEGER cdStop		=		2
INTEGER cdFF			=		4
INTEGER cdRew			=		5
INTEGER cdRec			=		8
INTEGER cdWhite		=		63	// SLOW MOTION
INTEGER cdRed			=		60	// PVR MENU/PLAYLIST
INTEGER cdBlue		=		129	// BOOKMARKS
INTEGER cdYellow	=		130	// SCROLL
INTEGER cdGreen		=		131	// PAY PER VIEW

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE

INTEGER DSTV_BUTTONS[] =  {1,2,3,4,5,6,7,8,9,10,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,
													 116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,
													 132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,
													 148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,
													 164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179
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

SET_PULSE_TIME (2)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

//--------------------------TOUCH PANEL------------------//
BUTTON_EVENT[dvTP_DSTV,DSTV_BUTTONS]
{
  PUSH:
	 {
			TO[dvTP_DSTV,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
//-------------------HDPVR 1--------------------//
				 CASE 1: PULSE[dvHDPVR1,cdLang];
				 CASE 2: PULSE[dvHDPVR1,cdVolUp];
				 CASE 3: PULSE[dvHDPVR1,cdVolDn];
				 CASE 100: PULSE[dvHDPVR1,cdPower];
				 CASE 101: PULSE[dvHDPVR1,cdGuide];
				 CASE 102: PULSE[dvHDPVR1,cdMenu];
				 CASE 103: PULSE[dvHDPVR1,cdInfo];
				 CASE 104: PULSE[dvHDPVR1,cdUp];
				 CASE 105: PULSE[dvHDPVR1,cdDwn];
				 CASE 106: PULSE[dvHDPVR1,cdRight];
				 CASE 107: PULSE[dvHDPVR1,cdLeft];
				 CASE 108: PULSE[dvHDPVR1,cdOk];
				 CASE 109: PULSE[dvHDPVR1,cdRecall];
				 CASE 110: PULSE[dvHDPVR1,cdExit];
				 CASE 111: PULSE[dvHDPVR1,cd1];
				 CASE 112: PULSE[dvHDPVR1,cd2];
				 CASE 113: PULSE[dvHDPVR1,cd3];
				 CASE 114: PULSE[dvHDPVR1,cd4];
				 CASE 115: PULSE[dvHDPVR1,cd5];
				 CASE 116: PULSE[dvHDPVR1,cd6];
				 CASE 117: PULSE[dvHDPVR1,cd7];
				 CASE 118: PULSE[dvHDPVR1,cd8];
				 CASE 119: PULSE[dvHDPVR1,cd9];
				 CASE 120: PULSE[dvHDPVR1,cd0];
				 CASE 121: PULSE[dvHDPVR1,cdChUp];
				 CASE 122: PULSE[dvHDPVR1,cdChDn];
				 CASE 123: PULSE[dvHDPVR1,cdPlay];
				 CASE 124: PULSE[dvHDPVR1,cdStop];
				 CASE 125: PULSE[dvHDPVR1,cdFF];
				 CASE 126: PULSE[dvHDPVR1,cdRew];
				 CASE 127: PULSE[dvHDPVR1,cdRec];
				 CASE 128: PULSE[dvHDPVR1,cdWhite];
				 CASE 129: PULSE[dvHDPVR1,cdRed];
				 CASE 130: PULSE[dvHDPVR1,cdGreen];
				 CASE 131: PULSE[dvHDPVR1,cdBlue];
				 CASE 132: PULSE[dvHDPVR1,cdYellow];
				 CASE 133: PULSE[dvHDPVR1,cdTV];
	 
	 //-------------------HDPVR 2--------------------//
				 CASE 4: PULSE[dvHDPVR2,cdLang];
				 CASE 5: PULSE[dvHDPVR2,cdVolUp];
				 CASE 6: PULSE[dvHDPVR2,cdVolDn];
				 CASE 140: PULSE[dvHDPVR2,cdPower];
				 CASE 141: PULSE[dvHDPVR2,cdGuide];
				 CASE 142: PULSE[dvHDPVR2,cdMenu];
				 CASE 143: PULSE[dvHDPVR2,cdInfo];
				 CASE 144: PULSE[dvHDPVR2,cdUp];
				 CASE 145: PULSE[dvHDPVR2,cdDwn];
				 CASE 146: PULSE[dvHDPVR2,cdRight];
				 CASE 147: PULSE[dvHDPVR2,cdLeft];
				 CASE 148: PULSE[dvHDPVR2,cdOk];
				 CASE 149: PULSE[dvHDPVR2,cdRecall];
				 CASE 150: PULSE[dvHDPVR2,cdExit];
				 CASE 151: PULSE[dvHDPVR2,cd1];
				 CASE 152: PULSE[dvHDPVR2,cd2];
				 CASE 153: PULSE[dvHDPVR2,cd3];
				 CASE 154: PULSE[dvHDPVR2,cd4];
				 CASE 155: PULSE[dvHDPVR2,cd5];
				 CASE 156: PULSE[dvHDPVR2,cd6];
				 CASE 157: PULSE[dvHDPVR2,cd7];
				 CASE 158: PULSE[dvHDPVR2,cd8];
				 CASE 159: PULSE[dvHDPVR2,cd9];
				 CASE 160: PULSE[dvHDPVR2,cd0];
				 CASE 161: PULSE[dvHDPVR2,cdChUp];
				 CASE 162: PULSE[dvHDPVR2,cdChDn];
				 CASE 163: PULSE[dvHDPVR2,cdPlay];
				 CASE 164: PULSE[dvHDPVR2,cdStop];
				 CASE 165: PULSE[dvHDPVR2,cdFF];
				 CASE 166: PULSE[dvHDPVR2,cdRew];
				 CASE 167: PULSE[dvHDPVR2,cdRec];
				 CASE 168: PULSE[dvHDPVR2,cdWhite];
				 CASE 169: PULSE[dvHDPVR2,cdRed];
				 CASE 170: PULSE[dvHDPVR2,cdGreen];
				 CASE 171: PULSE[dvHDPVR2,cdBlue];
				 CASE 172: PULSE[dvHDPVR2,cdYellow];
				 CASE 173: PULSE[dvHDPVR2,cdTV];
			}
	 }
}

//-------------------------REMOTE-----------------------//

//-------------------------BEDROOM 1-----------------------//
BUTTON_EVENT[dvR4_Bedrm1,DSTV_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_Bedrm1,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
//-------------------HDPVR 1--------------------//
				 CASE 100: PULSE[dvHDPVR1,cdLang];
				 CASE 101: PULSE[dvHDPVR1,cdGuide];
				 CASE 102: PULSE[dvHDPVR1,cdMenu];
				 CASE 103: PULSE[dvHDPVR1,cdInfo];
				 CASE 104: PULSE[dvHDPVR1,cdUp];
				 CASE 105: PULSE[dvHDPVR1,cdDwn];
				 CASE 106: PULSE[dvHDPVR1,cdRight];
				 CASE 107: PULSE[dvHDPVR1,cdLeft];
				 CASE 108: PULSE[dvHDPVR1,cdOk];
				 CASE 109: PULSE[dvHDPVR1,cdRecall];
				 CASE 110: PULSE[dvHDPVR1,cdExit];
				 CASE 111: PULSE[dvHDPVR1,cd1];
				 CASE 112: PULSE[dvHDPVR1,cd2];
				 CASE 113: PULSE[dvHDPVR1,cd3];
				 CASE 114: PULSE[dvHDPVR1,cd4];
				 CASE 115: PULSE[dvHDPVR1,cd5];
				 CASE 116: PULSE[dvHDPVR1,cd6];
				 CASE 117: PULSE[dvHDPVR1,cd7];
				 CASE 118: PULSE[dvHDPVR1,cd8];
				 CASE 119: PULSE[dvHDPVR1,cd9];
				 CASE 120: PULSE[dvHDPVR1,cd0];
				 CASE 121: PULSE[dvHDPVR1,cdChUp];
				 CASE 122: PULSE[dvHDPVR1,cdChDn];
				 CASE 123: PULSE[dvHDPVR1,cdPlay];
				 CASE 124: PULSE[dvHDPVR1,cdStop];
				 CASE 125: PULSE[dvHDPVR1,cdFF];
				 CASE 126: PULSE[dvHDPVR1,cdRew];
				 CASE 127: PULSE[dvHDPVR1,cdRec];
				 CASE 128: PULSE[dvHDPVR1,cdWhite];
				 CASE 129: PULSE[dvHDPVR1,cdRed];
				 CASE 130: PULSE[dvHDPVR1,cdGreen];
				 CASE 131: PULSE[dvHDPVR1,cdBlue];
				 CASE 132: PULSE[dvHDPVR1,cdYellow];
				 CASE 139: PULSE[dvHDPVR1,cdTV];
				 CASE 4: PULSE[dvHDPVR2,cdLang];
				 
				CASE 133:	 PULSE[dvHDPVR1,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 134:	 PULSE[dvHDPVR1,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR1,cd4]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 135:	 PULSE[dvHDPVR1,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd3]
				CASE 136:	 PULSE[dvHDPVR1,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR1,cd2]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 137:	 PULSE[dvHDPVR1,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 138:	 PULSE[dvHDPVR1,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd2]

	 //-------------------HDPVR 2--------------------//
				 CASE 140: PULSE[dvHDPVR2,cdLang];
				 CASE 141: PULSE[dvHDPVR2,cdGuide];
				 CASE 142: PULSE[dvHDPVR2,cdMenu];
				 CASE 143: PULSE[dvHDPVR2,cdInfo];
				 CASE 144: PULSE[dvHDPVR2,cdUp];
				 CASE 145: PULSE[dvHDPVR2,cdDwn];
				 CASE 146: PULSE[dvHDPVR2,cdRight];
				 CASE 147: PULSE[dvHDPVR2,cdLeft];
				 CASE 148: PULSE[dvHDPVR2,cdOk];
				 CASE 149: PULSE[dvHDPVR2,cdRecall];
				 CASE 150: PULSE[dvHDPVR2,cdExit];
				 CASE 151: PULSE[dvHDPVR2,cd1];
				 CASE 152: PULSE[dvHDPVR2,cd2];
				 CASE 153: PULSE[dvHDPVR2,cd3];
				 CASE 154: PULSE[dvHDPVR2,cd4];
				 CASE 155: PULSE[dvHDPVR2,cd5];
				 CASE 156: PULSE[dvHDPVR2,cd6];
				 CASE 157: PULSE[dvHDPVR2,cd7];
				 CASE 158: PULSE[dvHDPVR2,cd8];
				 CASE 159: PULSE[dvHDPVR2,cd9];
				 CASE 160: PULSE[dvHDPVR2,cd0];
				 CASE 161: PULSE[dvHDPVR2,cdChUp];
				 CASE 162: PULSE[dvHDPVR2,cdChDn];
				 CASE 163: PULSE[dvHDPVR2,cdPlay];
				 CASE 164: PULSE[dvHDPVR2,cdStop];
				 CASE 165: PULSE[dvHDPVR2,cdFF];
				 CASE 166: PULSE[dvHDPVR2,cdRew];
				 CASE 167: PULSE[dvHDPVR2,cdRec];
				 CASE 168: PULSE[dvHDPVR2,cdWhite];
				 CASE 169: PULSE[dvHDPVR2,cdRed];
				 CASE 170: PULSE[dvHDPVR2,cdGreen];
				 CASE 171: PULSE[dvHDPVR2,cdBlue];
				 CASE 172: PULSE[dvHDPVR2,cdYellow];
				 CASE 179: PULSE[dvHDPVR2,cdTV];
				 
				CASE 173:	 PULSE[dvHDPVR2,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 174:	 PULSE[dvHDPVR2,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR2,cd4]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 175:	 PULSE[dvHDPVR2,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd3]
				CASE 176:	 PULSE[dvHDPVR2,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR2,cd2]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 177:	 PULSE[dvHDPVR2,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 178:	 PULSE[dvHDPVR2,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd2]

			}
	 }
}

//-------------------------BEDROOM 2-----------------------//
BUTTON_EVENT[dvR4_Bedrm2,DSTV_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_Bedrm2,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
//-------------------HDPVR 1--------------------//
				 CASE 100: PULSE[dvHDPVR1,cdLang];
				 CASE 101: PULSE[dvHDPVR1,cdGuide];
				 CASE 102: PULSE[dvHDPVR1,cdMenu];
				 CASE 103: PULSE[dvHDPVR1,cdInfo];
				 CASE 104: PULSE[dvHDPVR1,cdUp];
				 CASE 105: PULSE[dvHDPVR1,cdDwn];
				 CASE 106: PULSE[dvHDPVR1,cdRight];
				 CASE 107: PULSE[dvHDPVR1,cdLeft];
				 CASE 108: PULSE[dvHDPVR1,cdOk];
				 CASE 109: PULSE[dvHDPVR1,cdRecall];
				 CASE 110: PULSE[dvHDPVR1,cdExit];
				 CASE 111: PULSE[dvHDPVR1,cd1];
				 CASE 112: PULSE[dvHDPVR1,cd2];
				 CASE 113: PULSE[dvHDPVR1,cd3];
				 CASE 114: PULSE[dvHDPVR1,cd4];
				 CASE 115: PULSE[dvHDPVR1,cd5];
				 CASE 116: PULSE[dvHDPVR1,cd6];
				 CASE 117: PULSE[dvHDPVR1,cd7];
				 CASE 118: PULSE[dvHDPVR1,cd8];
				 CASE 119: PULSE[dvHDPVR1,cd9];
				 CASE 120: PULSE[dvHDPVR1,cd0];
				 CASE 121: PULSE[dvHDPVR1,cdChUp];
				 CASE 122: PULSE[dvHDPVR1,cdChDn];
				 CASE 123: PULSE[dvHDPVR1,cdPlay];
				 CASE 124: PULSE[dvHDPVR1,cdStop];
				 CASE 125: PULSE[dvHDPVR1,cdFF];
				 CASE 126: PULSE[dvHDPVR1,cdRew];
				 CASE 127: PULSE[dvHDPVR1,cdRec];
				 CASE 128: PULSE[dvHDPVR1,cdWhite];
				 CASE 129: PULSE[dvHDPVR1,cdRed];
				 CASE 130: PULSE[dvHDPVR1,cdGreen];
				 CASE 131: PULSE[dvHDPVR1,cdBlue];
				 CASE 132: PULSE[dvHDPVR1,cdYellow];
				 CASE 139: PULSE[dvHDPVR1,cdTV];
				 
				CASE 133:	 PULSE[dvHDPVR1,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 134:	 PULSE[dvHDPVR1,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR1,cd4]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 135:	 PULSE[dvHDPVR1,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd3]
				CASE 136:	 PULSE[dvHDPVR1,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR1,cd2]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 137:	 PULSE[dvHDPVR1,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 138:	 PULSE[dvHDPVR1,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd2]

	 //-------------------HDPVR 2--------------------//
				 CASE 140: PULSE[dvHDPVR2,cdLang];
				 CASE 141: PULSE[dvHDPVR2,cdGuide];
				 CASE 142: PULSE[dvHDPVR2,cdMenu];
				 CASE 143: PULSE[dvHDPVR2,cdInfo];
				 CASE 144: PULSE[dvHDPVR2,cdUp];
				 CASE 145: PULSE[dvHDPVR2,cdDwn];
				 CASE 146: PULSE[dvHDPVR2,cdRight];
				 CASE 147: PULSE[dvHDPVR2,cdLeft];
				 CASE 148: PULSE[dvHDPVR2,cdOk];
				 CASE 149: PULSE[dvHDPVR2,cdRecall];
				 CASE 150: PULSE[dvHDPVR2,cdExit];
				 CASE 151: PULSE[dvHDPVR2,cd1];
				 CASE 152: PULSE[dvHDPVR2,cd2];
				 CASE 153: PULSE[dvHDPVR2,cd3];
				 CASE 154: PULSE[dvHDPVR2,cd4];
				 CASE 155: PULSE[dvHDPVR2,cd5];
				 CASE 156: PULSE[dvHDPVR2,cd6];
				 CASE 157: PULSE[dvHDPVR2,cd7];
				 CASE 158: PULSE[dvHDPVR2,cd8];
				 CASE 159: PULSE[dvHDPVR2,cd9];
				 CASE 160: PULSE[dvHDPVR2,cd0];
				 CASE 161: PULSE[dvHDPVR2,cdChUp];
				 CASE 162: PULSE[dvHDPVR2,cdChDn];
				 CASE 163: PULSE[dvHDPVR2,cdPlay];
				 CASE 164: PULSE[dvHDPVR2,cdStop];
				 CASE 165: PULSE[dvHDPVR2,cdFF];
				 CASE 166: PULSE[dvHDPVR2,cdRew];
				 CASE 167: PULSE[dvHDPVR2,cdRec];
				 CASE 168: PULSE[dvHDPVR2,cdWhite];
				 CASE 169: PULSE[dvHDPVR2,cdRed];
				 CASE 170: PULSE[dvHDPVR2,cdGreen];
				 CASE 171: PULSE[dvHDPVR2,cdBlue];
				 CASE 172: PULSE[dvHDPVR2,cdYellow];
				 
				CASE 173:	 PULSE[dvHDPVR2,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 174:	 PULSE[dvHDPVR2,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR2,cd4]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 175:	 PULSE[dvHDPVR2,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd3]
				CASE 176:	 PULSE[dvHDPVR2,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR2,cd2]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 177:	 PULSE[dvHDPVR2,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 178:	 PULSE[dvHDPVR2,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd2]
				 CASE 179: PULSE[dvHDPVR2,cdTV];
			}
	 }
}

//-------------------------FAM TV ROOM-----------------------//
BUTTON_EVENT[dvR4_FamTvRm,DSTV_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_FamTvRm,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
//-------------------HDPVR 1--------------------//
				 CASE 100: PULSE[dvHDPVR1,cdLang];
				 CASE 101: PULSE[dvHDPVR1,cdGuide];
				 CASE 102: PULSE[dvHDPVR1,cdMenu];
				 CASE 103: PULSE[dvHDPVR1,cdInfo];
				 CASE 104: PULSE[dvHDPVR1,cdUp];
				 CASE 105: PULSE[dvHDPVR1,cdDwn];
				 CASE 106: PULSE[dvHDPVR1,cdRight];
				 CASE 107: PULSE[dvHDPVR1,cdLeft];
				 CASE 108: PULSE[dvHDPVR1,cdOk];
				 CASE 109: PULSE[dvHDPVR1,cdRecall];
				 CASE 110: PULSE[dvHDPVR1,cdExit];
				 CASE 111: PULSE[dvHDPVR1,cd1];
				 CASE 112: PULSE[dvHDPVR1,cd2];
				 CASE 113: PULSE[dvHDPVR1,cd3];
				 CASE 114: PULSE[dvHDPVR1,cd4];
				 CASE 115: PULSE[dvHDPVR1,cd5];
				 CASE 116: PULSE[dvHDPVR1,cd6];
				 CASE 117: PULSE[dvHDPVR1,cd7];
				 CASE 118: PULSE[dvHDPVR1,cd8];
				 CASE 119: PULSE[dvHDPVR1,cd9];
				 CASE 120: PULSE[dvHDPVR1,cd0];
				 CASE 121: PULSE[dvHDPVR1,cdChUp];
				 CASE 122: PULSE[dvHDPVR1,cdChDn];
				 CASE 123: PULSE[dvHDPVR1,cdPlay];
				 CASE 124: PULSE[dvHDPVR1,cdStop];
				 CASE 125: PULSE[dvHDPVR1,cdFF];
				 CASE 126: PULSE[dvHDPVR1,cdRew];
				 CASE 127: PULSE[dvHDPVR1,cdRec];
				 CASE 128: PULSE[dvHDPVR1,cdWhite];
				 CASE 129: PULSE[dvHDPVR1,cdRed];
				 CASE 130: PULSE[dvHDPVR1,cdGreen];
				 CASE 131: PULSE[dvHDPVR1,cdBlue];
				 CASE 132: PULSE[dvHDPVR1,cdYellow];
				 CASE 139: PULSE[dvHDPVR1,cdTV];
				 
				CASE 133:	 PULSE[dvHDPVR1,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 134:	 PULSE[dvHDPVR1,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR1,cd4]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 135:	 PULSE[dvHDPVR1,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd3]
				CASE 136:	 PULSE[dvHDPVR1,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR1,cd2]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 137:	 PULSE[dvHDPVR1,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 138:	 PULSE[dvHDPVR1,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd2]

	 //-------------------HDPVR 2--------------------//
				 CASE 140: PULSE[dvHDPVR2,cdLang];
				 CASE 141: PULSE[dvHDPVR2,cdGuide];
				 CASE 142: PULSE[dvHDPVR2,cdMenu];
				 CASE 143: PULSE[dvHDPVR2,cdInfo];
				 CASE 144: PULSE[dvHDPVR2,cdUp];
				 CASE 145: PULSE[dvHDPVR2,cdDwn];
				 CASE 146: PULSE[dvHDPVR2,cdRight];
				 CASE 147: PULSE[dvHDPVR2,cdLeft];
				 CASE 148: PULSE[dvHDPVR2,cdOk];
				 CASE 149: PULSE[dvHDPVR2,cdRecall];
				 CASE 150: PULSE[dvHDPVR2,cdExit];
				 CASE 151: PULSE[dvHDPVR2,cd1];
				 CASE 152: PULSE[dvHDPVR2,cd2];
				 CASE 153: PULSE[dvHDPVR2,cd3];
				 CASE 154: PULSE[dvHDPVR2,cd4];
				 CASE 155: PULSE[dvHDPVR2,cd5];
				 CASE 156: PULSE[dvHDPVR2,cd6];
				 CASE 157: PULSE[dvHDPVR2,cd7];
				 CASE 158: PULSE[dvHDPVR2,cd8];
				 CASE 159: PULSE[dvHDPVR2,cd9];
				 CASE 160: PULSE[dvHDPVR2,cd0];
				 CASE 161: PULSE[dvHDPVR2,cdChUp];
				 CASE 162: PULSE[dvHDPVR2,cdChDn];
				 CASE 163: PULSE[dvHDPVR2,cdPlay];
				 CASE 164: PULSE[dvHDPVR2,cdStop];
				 CASE 165: PULSE[dvHDPVR2,cdFF];
				 CASE 166: PULSE[dvHDPVR2,cdRew];
				 CASE 167: PULSE[dvHDPVR2,cdRec];
				 CASE 168: PULSE[dvHDPVR2,cdWhite];
				 CASE 169: PULSE[dvHDPVR2,cdRed];
				 CASE 170: PULSE[dvHDPVR2,cdGreen];
				 CASE 171: PULSE[dvHDPVR2,cdBlue];
				 CASE 172: PULSE[dvHDPVR2,cdYellow];
				 CASE 179: PULSE[dvHDPVR2,cdTV];
				 
				CASE 173:	 PULSE[dvHDPVR2,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 174:	 PULSE[dvHDPVR2,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR2,cd4]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 175:	 PULSE[dvHDPVR2,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd3]
				CASE 176:	 PULSE[dvHDPVR2,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR2,cd2]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 177:	 PULSE[dvHDPVR2,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 178:	 PULSE[dvHDPVR2,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd2]

			}
	 }
}

//-------------------------MAIN BEDROOM-----------------------//
BUTTON_EVENT[dvR4_MainBedrm,DSTV_BUTTONS]
{
  PUSH:
	 {
			TO[dvR4_MainBedrm,BUTTON.INPUT.CHANNEL]
			SWITCH(BUTTON.INPUT.CHANNEL)
			{
//-------------------HDPVR 1--------------------//
				 CASE 100: PULSE[dvHDPVR1,cdLang];
				 CASE 101: PULSE[dvHDPVR1,cdGuide];
				 CASE 102: PULSE[dvHDPVR1,cdMenu];
				 CASE 103: PULSE[dvHDPVR1,cdInfo];
				 CASE 104: PULSE[dvHDPVR1,cdUp];
				 CASE 105: PULSE[dvHDPVR1,cdDwn];
				 CASE 106: PULSE[dvHDPVR1,cdRight];
				 CASE 107: PULSE[dvHDPVR1,cdLeft];
				 CASE 108: PULSE[dvHDPVR1,cdOk];
				 CASE 109: PULSE[dvHDPVR1,cdRecall];
				 CASE 110: PULSE[dvHDPVR1,cdExit];
				 CASE 111: PULSE[dvHDPVR1,cd1];
				 CASE 112: PULSE[dvHDPVR1,cd2];
				 CASE 113: PULSE[dvHDPVR1,cd3];
				 CASE 114: PULSE[dvHDPVR1,cd4];
				 CASE 115: PULSE[dvHDPVR1,cd5];
				 CASE 116: PULSE[dvHDPVR1,cd6];
				 CASE 117: PULSE[dvHDPVR1,cd7];
				 CASE 118: PULSE[dvHDPVR1,cd8];
				 CASE 119: PULSE[dvHDPVR1,cd9];
				 CASE 120: PULSE[dvHDPVR1,cd0];
				 CASE 121: PULSE[dvHDPVR1,cdChUp];
				 CASE 122: PULSE[dvHDPVR1,cdChDn];
				 CASE 123: PULSE[dvHDPVR1,cdPlay];
				 CASE 124: PULSE[dvHDPVR1,cdStop];
				 CASE 125: PULSE[dvHDPVR1,cdFF];
				 CASE 126: PULSE[dvHDPVR1,cdRew];
				 CASE 127: PULSE[dvHDPVR1,cdRec];
				 CASE 128: PULSE[dvHDPVR1,cdWhite];
				 CASE 129: PULSE[dvHDPVR1,cdRed];
				 CASE 130: PULSE[dvHDPVR1,cdGreen];
				 CASE 131: PULSE[dvHDPVR1,cdBlue];
				 CASE 132: PULSE[dvHDPVR1,cdYellow];
				 CASE 139: PULSE[dvHDPVR1,cdTV];
				 
				CASE 133:	 PULSE[dvHDPVR1,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 134:	 PULSE[dvHDPVR1,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR1,cd4]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 135:	 PULSE[dvHDPVR1,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd0]
								   WAIT 7
								   PULSE[dvHDPVR1,cd3]
				CASE 136:	 PULSE[dvHDPVR1,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR1,cd2]
								   WAIT 7
								   PULSE[dvHDPVR1,cd4]
				CASE 137:	 PULSE[dvHDPVR1,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd1]
				CASE 138:	 PULSE[dvHDPVR1,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR1,cd1]
								   WAIT 7
								   PULSE[dvHDPVR1,cd2]

	 //-------------------HDPVR 2--------------------//
				 CASE 140: PULSE[dvHDPVR2,cdLang];
				 CASE 141: PULSE[dvHDPVR2,cdGuide];
				 CASE 142: PULSE[dvHDPVR2,cdMenu];
				 CASE 143: PULSE[dvHDPVR2,cdInfo];
				 CASE 144: PULSE[dvHDPVR2,cdUp];
				 CASE 145: PULSE[dvHDPVR2,cdDwn];
				 CASE 146: PULSE[dvHDPVR2,cdRight];
				 CASE 147: PULSE[dvHDPVR2,cdLeft];
				 CASE 148: PULSE[dvHDPVR2,cdOk];
				 CASE 149: PULSE[dvHDPVR2,cdRecall];
				 CASE 150: PULSE[dvHDPVR2,cdExit];
				 CASE 151: PULSE[dvHDPVR2,cd1];
				 CASE 152: PULSE[dvHDPVR2,cd2];
				 CASE 153: PULSE[dvHDPVR2,cd3];
				 CASE 154: PULSE[dvHDPVR2,cd4];
				 CASE 155: PULSE[dvHDPVR2,cd5];
				 CASE 156: PULSE[dvHDPVR2,cd6];
				 CASE 157: PULSE[dvHDPVR2,cd7];
				 CASE 158: PULSE[dvHDPVR2,cd8];
				 CASE 159: PULSE[dvHDPVR2,cd9];
				 CASE 160: PULSE[dvHDPVR2,cd0];
				 CASE 161: PULSE[dvHDPVR2,cdChUp];
				 CASE 162: PULSE[dvHDPVR2,cdChDn];
				 CASE 163: PULSE[dvHDPVR2,cdPlay];
				 CASE 164: PULSE[dvHDPVR2,cdStop];
				 CASE 165: PULSE[dvHDPVR2,cdFF];
				 CASE 166: PULSE[dvHDPVR2,cdRew];
				 CASE 167: PULSE[dvHDPVR2,cdRec];
				 CASE 168: PULSE[dvHDPVR2,cdWhite];
				 CASE 169: PULSE[dvHDPVR2,cdRed];
				 CASE 170: PULSE[dvHDPVR2,cdGreen];
				 CASE 171: PULSE[dvHDPVR2,cdBlue];
				 CASE 172: PULSE[dvHDPVR2,cdYellow];
				 CASE 179: PULSE[dvHDPVR2,cdTV];
				 
				CASE 173:	 PULSE[dvHDPVR2,cd1]		// MNET HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 174:	 PULSE[dvHDPVR2,cd1]		// KYKNET
								   WAIT 4
								   PULSE[dvHDPVR2,cd4]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 175:	 PULSE[dvHDPVR2,cd1]		// MM1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd0]
								   WAIT 7
								   PULSE[dvHDPVR2,cd3]
				CASE 176:	 PULSE[dvHDPVR2,cd1]		// E!
								   WAIT 4
								   PULSE[dvHDPVR2,cd2]
								   WAIT 7
								   PULSE[dvHDPVR2,cd4]
				CASE 177:	 PULSE[dvHDPVR2,cd2]		// S1 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd1]
				CASE 178:	 PULSE[dvHDPVR2,cd2]		// S2 HD
								   WAIT 4
								   PULSE[dvHDPVR2,cd1]
								   WAIT 7
								   PULSE[dvHDPVR2,cd2]

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