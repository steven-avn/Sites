PROGRAM_NAME='AMX_MatrixAudio_MiSeries_MAIN'

(********************************************************************)
(* FILE CREATED ON: 03/02/05  AT: 15:38:46                          *)
(********************************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/10/2007  AT: 13:56:54        *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 1                                *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 03/02/05                                *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)
// Cable needed is FG#10-752
/*NXI		NI		    S8
1 GND		5 GND		5 GND
2 RXD		2 RXD		2 TXD  
3 TXD		3 TXD		3 RXD
*/
DEFINE_DEVICE

// Select one method of control or the other, but not both at the same time...
// RS232 (Serial) is preferred.

//dvMatrixAudioSerial = 5001:1:0 // Serial device...COMMENT OUT IF USING IP

//////////////////////////////////////////////////////
// Do not modify below conditional compile statement//
#if_not_defined dvMatrixAudioSerial									//
#define IP																					//
dvMatrixAudioIP  = 0:5:0     // IP device 					//
#end_if																							//
//////////////////////////////////////////////////////

//dvTP   =10001:1:0

vdvMatrixAudio1=41001:1:0 //virtual device 1
vdvMatrixAudio2=41001:2:0 //virtual device 2
vdvMatrixAudio3=41001:3:0 //virtual device 3
vdvMatrixAudio4=41001:4:0 //virtual device 4
vdvMatrixAudio5=41001:5:0 //virtual device 5
vdvMatrixAudio6=41001:6:0 //virtual device 6
vdvMatrixAudio7=41001:7:0 //virtual device 7
vdvMatrixAudio8=41001:8:0 //virtual device 8
vdvMatrixAudio9=41001:9:0 //virtual device 9
vdvMatrixAudio10=41001:10:0 //virtual device 10
vdvMatrixAudio11=41001:11:0 //virtual device 11
vdvMatrixAudio12=41001:12:0 //virtual device 12
vdvMatrixAudio13=41001:13:0 //virtual device 13
vdvMatrixAudio14=41001:14:0 //virtual device 14
vdvMatrixAudio15=41001:15:0 //virtual device 15
vdvMatrixAudio16=41001:16:0 //virtual device 16

DEFINE_CONSTANT

INTEGER MatrixAudio_BUTTONS[]=
{
  1, //1-  Room 1
  2, //2-  Room 2
  3, //3-  Room 3 
  4, //4-  Room 4
  5, //5-  Room 5
  6, //6-  Room 6
  7, //7-  Room 7
  8, //8-  Room 8
  9, //9-  Room 9
 10, //10- Room 10
 11, //11- Room 11
 12, //12- Room 12
 13, //13- Room 13 
 14, //14- Room 14
 15, //15- Room 15
 16, //16- Room 16 
 17, //17- Input 1
 18, //18- Input 2
 19, //19- Input 3 
 20, //20- Input 4 
 21, //21- Input 5 
 22, //22- Input 6 
 23, //23- Input 7 
 24, //24- Input 8 
 25, //25- Keypad Lock/Unlock 
 26, //26- Room Name  
 27, //27- Cursor up 
 28, //28- Cursor down 
 29, //29- Cursor Left 
 30, //30- Cursor right 
 31, //31- Select
 32, //32- Play
 33, //33- Page Volume Up 
 34, //34- Page Volume down
 35, //35- Page Volume text box 
 36, //36- Page Enable/Disable.
 37, //37- Tuner Freq Up 
 38, //38- Tuner Freq Down 
 39, //39- Seek/Tune Mode 
 40, //40- AM/FM
 41, //41- Freq text box
 42, //42- Mute
 43, //43- Volume Up
 44, //44- Volume Down 
 45, //45- Volume text box
 46, //46- Save Preset
 47, //47- Preset Up
 48, //48- Preset Down 
 49, //49- NOT USED
 50, //50- Menu
 51, //51- Online 
 52, //52- Initialized
 53, //53- Source Power (Enable/Disable)
 54, //54- Preset Save 1
 55, //55- Preset Save 2
 56, //56- Preset Save 3
 57, //57- Preset Save 4
 58, //58- Preset Save 5
 59, //59- Preset Save 6
 60, //60- Preset Save 7
 61, //61- Preset Save 8
 62, //62- Preset Save 9
 63, //63- Preset Save 10
 64, //64- Preset Save Freq
 65, //65- Sirius Radio Signal Strength
 66, //66- Sirius Radio Status
 67, //67- Sirius Channel Name
 68, //68- Sirius Song Title
 69, //69- Sirius Song Artist
 70, //70- Sirius Category Up
 71, //71- Sirius Category Down
 72  //72- Sirius Category Name
}

DEFINE_VARIABLE 

DEV vdvMatrixAudio[] = {vdvMatrixAudio1,vdvMatrixAudio2,vdvMatrixAudio3,vdvMatrixAudio4,
                           vdvMatrixAudio5,vdvMatrixAudio6,vdvMatrixAudio7,vdvMatrixAudio8,
							vdvMatrixAudio9,vdvMatrixAudio10,vdvMatrixAudio11,vdvMatrixAudio12,
							vdvMatrixAudio13,vdvMatrixAudio14,vdvMatrixAudio15,vdvMatrixAudio16}

DEFINE_START

#if_not_defined IP 
	DEFINE_MODULE 'AMX_Matrix_MiSeries_Comm_dr1_0_1' comm_code(vdvMatrixAudio1,dvMatrixAudioSerial)
#else
	#warn 'Remember to set the IP_Address module property value to match the device IP address.'
	#warn 'The IP address is changed in the AMX_MatrixAudio_MiSeries_UI.axs by updating the IP constant.'
	DEFINE_MODULE 'AMX_Matrix_MiSeries_Comm_dr1_0_1' comm_code(vdvMatrixAudio1,dvMatrixAudioIP)
#end_if
//DEFINE_MODULE 'AMX_MatrixAudio_MiSeries_UI' ui_code(vdvMatrixAudio, dvTP, MatrixAudio_BUTTONS)
