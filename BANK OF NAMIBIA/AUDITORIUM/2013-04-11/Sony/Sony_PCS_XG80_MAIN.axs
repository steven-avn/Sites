(*********************************************************************)
(*  AMX Corporation                                                  *)
(*  Copyright (c) 2004-2008 AMX Corporation. All rights reserved.    *)
(*********************************************************************)
(* Copyright Notice :                                                *)
(* Copyright, AMX, Inc., 2004-2008                                   *)
(*    Private, proprietary information, the sole property of AMX.    *)
(*    The contents, ideas, and concepts expressed herein are not to  *)
(*    be disclosed except within the confines of a confidential      *)
(*    relationship and only then on a need to know basis.            *)
(*********************************************************************)
PROGRAM_NAME='Sony_PCS_XG80_MAIN'
(***********************************************************)
(* System Type : NetLinx                                   *)
(* Creation Date: 7/29/2008 3:24:54 PM                     *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)

(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE
//dvSony_PCS_XG80  =5001:2:0 //real serial device
dvSony_PCS_XG80  = 0:5:0   //real IP device
dvTP1  =10001:1:0

vdvSony_PCS_XG80_1=41001:1:0 //virtual device 1
vdvSony_PCS_XG80_2=41001:2:0 //virtual device 2
vdvSony_PCS_XG80_3=41001:3:0 //virtual device 3
vdvSony_PCS_XG80_4=41001:4:0 //virtual device 4
vdvSony_PCS_XG80_5=41001:5:0 //virtual device 5
DEFINE_VARIABLE 

INTEGER Sony_PCS_XG80_BUTTONS[]=
{
  // Main Page buttons
  1, //1-  Main Power
  2, //2-  Mic Mute
  3, //3-  Main Volume Up 
  4, //4-  Main Volume Down 
  5, //5-  Not used
  6, //6-  Camera 1
  7, //7-  Camera 2
  8, //8-  Aux
  9, //9-  S-Video
 10, //10- RGB
 11, //11- Not Used
 12, //12- Tilt Up 
 13, //13- Tilt Down 
 14, //14- Pan Right 
 15, //15- Pan Left 
 16, //16- - Near/Far-end camera control 
 17, //17- PiP 
 18, //18- Offline/Online indicator
 19, //19- Initialized indicator
 // End of Main Page buttons
 // Dial Page buttons
 20, //20- Line I/F 
 21, //21- IP Line 
 22, //22- Not used 
 23, //23- Not used
 24, //24- Not used
 25, //25- MultiPoint
 26, //26- LAN Bandwidth
 27, //27- 64k
 28, //28- 128k
 29, //29- 256k
 30, //30- 384k
 31, //31- 512k
 32, //32- 768k
 33, //33- 1024k
 34, //34- 2Mbps
 35, //35- 3072k
 36, //36- 4Mbps
 37, //37- Dial Line 1
 38, //38- Dial Line 2
 39, //39- Dial Line 3 
 40, //40- Not used
 41, //41- Not used
 42, //42- Not used 
 43, //43- Not used 
 44, //44- Not used 
 45, //45- Not used 
 46, //46- Not used 
 47, //47- Clear All Dial 
 48, //48- Dial
 49, //49- Redial 
 // End of Dial Page buttons
 // Keypad Buttons 
 50, //50- Key 0 
 51, //51- Key 1
 52, //52- Key 2
 53, //53- Key 3
 54, //54- Key 4
 55, //55- Key 5
 56, //56- Key 6
 57, //57- Key 7
 58, //58- Key 8
 59, //59- Key 9
 60, //60- Key *
 61, //61- Key # 
 // End of Keypad buttons
 // Information Page buttons 
 62, //62- IP address
 63, //63- Auto-answer Off/On 
 64, //64- Host Version text 
 65, //65- AMX Module Version text
 66, //66- Last Call Disconnect Reason/ Last Caller ID Received text
 67, //67- Date and Time text 
 68, //68- Reinitialize 
 // End of Information Page buttons
 // Advanced Options Page buttons
 69, //69- Not used
 70, //70- Video mode H.261
 71, //71- Video mode H.263
 72, //72- Video mode MPEG4
 73, //73- Video mode H.264
 74, //74- Video mode NO VIDEO
 75, //75- Audio mode G.711
 76, //76- Audio mode G.728
 77, //77- Audio mode G.722
 78, //78- Audio mode MPEG4
 79, //79- Audio mode Auto
 80, //80- Audio mode 15fps
 81, //81- Audio mode 30fps
 82, //82- Audio mode 60fps
 83, //83- FECC ON
 84, //84- FECC OFF
 85, //85- Not Used
 86, //86- Not Used 
 87, //87- Not Used 
 88, //88- Not Used 
 89, //89- Not Used
 90, //90- Not Used
 91, //91- Not Used
 92, //92- Not used 
 // End of Advanced Options Page buttons 
 // PhoneBook Page Buttons
 93, //93- A-I 
 94, //94- J-S 
 95, //95- T-Z
 96, //96- 0-9
 97, //97- Scroll Down 
 98, //98- Scroll Up 
 99, //99- Listing index 1
100, //100-Listing index 2
101, //101-Listing index 3
102, //102-Listing index 4
103, //103-Listing index 5
104, //104-Listing index 6
105, //105-Listing index 7
106, //106-Listing index 8
107, //107-Listing index 9
108, //108-Dial
109, //109-Line 1 Name 
110, //110-Line 2 Name 
111, //111-Line 3 Name
112, //112-Line 4 Name
113, //113-Line 5 Name
     // End of PhoneBook Page Buttons
     // PhoneBook Entry buttons 
114, //114-General Message Text Box 
115, //115-Empty/Not used 
116, //116-Not used
 // End of PhoneBook Entry buttons 
 // Remote Control Emulator page buttons 
117, //117-Phonebook
118, //118-Power 
119, //119-Mic 
120, //120-Connect
121, //121-VideoInput
122, //122-Disconnect
123, //123-Up 
124, //124-Down 
125, //125-Left 
126, //126-Right 
127, //127-Enter 
128, //128-Return 
129, //129-Menu 
130, //Not in use
131, //131-Zoom In 
132, //132-Zoom Out 
133, //133- Last Call Disconnected Reason/ Last Caller ID Received notification
134, //134- Active call notification
// End of Remote Control Emulator buttons.
// more button....
135, //135- Options Button on Dial Page.... 
136, //Backspace
137, //137- Not used
138, //138- Not used
139, //139- Not used
140, //140- Not used
141, //141- Not used
142, //142- Not used
143, //143- Not used
144, //144- Not used
145, //145- LanBandwidth text box
146, //146- Not used
147, //147- Cancel Call
148, //148- Information button 
149, //149- hangup ALL
150, //150- CallerID TextBox
151, //151- Reject incoming call 
152, //152- Not used 
153  //153- Answer  

}


DEV VirtualDeviceArray1[]={vdvSony_PCS_XG80_1,vdvSony_PCS_XG80_2,vdvSony_PCS_XG80_3,vdvSony_PCS_XG80_4,vdvSony_PCS_XG80_5}

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

DEFINE_MODULE 'Sony_PCS_XG80_UI' ui_code1(VirtualDeviceArray1, dvTP1, Sony_PCS_XG80_BUTTONS)
DEFINE_MODULE 'Sony_PCS_XG80_Comm_dr1_0_0' first_instance(VirtualDeviceArray1[1],dvSony_PCS_XG80)
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

DATA_EVENT[VirtualDeviceArray1[1]]
{
	ONLINE:
	{ /*
		#WARN'**********************************************************'
		#WARN'**   PROPERTY-IP_Address needs to be set to the         **'
		#WARN'**    address for the Sony PCS-XG80                     **'
		#WARN'**   PROPERTY-Login needs to be set                     **'
		#WARN'**    for the Sony PCS-XG80                             **'
		#WARN'**   PROPERTY-Password needs to be set                  **'
		#WARN'**    for the Sony PCS-XG80                             **'
		#WARN'**   PROPERTY-Multipoint needs to be set to 1           **'
		#WARN'**    for the Sony PCS-XG80 if it supports multipoint   **'
		#WARN'**    calling. If not set it to 0                       **' 
		#WARN'**   PROPERTY-Phonebook_Entries needs to be set         **'
		#WARN'**    for the expected number of entries to add         **'
		#WARN'**********************************************************'
		 */
		send_command VirtualDeviceArray1[1],"'PROPERTY-IP_Address,192.168.1.110'"
		send_command VirtualDeviceArray1[1],"'PROPERTY-Login,sonypcs'"
		//send_command VirtualDeviceArray1[1],"'PROPERTY-Password,'"
		//send_command VirtualDeviceArray1[1],"'PROPERTY-Multipoint,1'"
		send_command VirtualDeviceArray1[1],"'PROPERTY-Phonebook_Entries,99'"
		send_command VirtualDeviceArray1[1],"'REINIT'"
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
