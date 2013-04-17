MODULE_NAME='Sony_PCS_XG80_UI' (DEV vdvSony_PCS_XG80[], DEV dvTP, INTEGER nBUTTONS[])

(********************************************************************)
(* FILE CREATED ON: 03/23/05  AT: 10:03:58                          *)
(********************************************************************)
(********************************************************************)
(*  FILE_LAST_MODIFIED_ON: 03/23/05 AT: 10:03:58           *)
(***********************************************************)
(*  ORPHAN_FILE_PLATFORM: 1                                *)
(***********************************************************)
(*!!FILE REVISION: Rev 0                                   *)
(*  REVISION DATE: 03/23/05                                *)
(*                                                         *)
(*  COMMENTS:                                              *)
(*                                                         *)
(***********************************************************)
(*}}PS_SOURCE_INFO                                         *)
(***********************************************************)

DEFINE_CONSTANT

// Modify this constant as needed in order to match your device 

//////////////////////////////////////////////////////////////////////////////////
INTEGER DISCONNECTED = 0
INTEGER CONNECTED    = 1
INTEGER RINGING      = 2

LONG PULSE_TIME = 3  // set a pulse time of 0.3 seconds
INTEGER MAIN_VOLUME = 1 // level number for the Main Volume.
INTEGER MAX_CALLS_SUPPORTED = 5
INTEGER MAX_PHONEBOOK_ENTRIES = 1000
INTEGER A = $41
INTEGER I = $49
INTEGER S = $53
INTEGER Z = $5A
CHAR SOURCE[4][9]={'CAMERA','SVIDEO','VGA','COMPONENT'}
CHAR FAREND_LABELS[5][80] = {'CAMERA','S-VIDEO IN', 'RGB IN','VIDEO IN'}
CHAR LINEIF[5][10]={'IP','','','','MultiPoint'}
INTEGER IP = 1
INTEGER MULTI = 5 
CHAR LANBAND[11][7]={'64','128','256','384','512','768','1024','2048','3072','4096','8192'}
CHAR DISCONNECT_REASON[6][40]={'Unknown network error. Try again later','GateKeeper error','Connection is refused.','Normal disconnection','LAN Setup error.','DNS error'}
(********************************************************************)
DEFINE_TYPE

STRUCT PhoneBookEntry
{
	char sName[80]
	char sNumber[MAX_CALLS_SUPPORTED+1][80]
	integer nLineIF       
	char sLanBand[10]     // see LANBAND[][]
	integer nIndex        // entry index 
}
(********************************************************************)
DEFINE_VARIABLE

VOLATILE INTEGER nButtonIndex = 0          // stores the current button index selected by user. 
VOLATILE INTEGER bActiveCall  = false      // remembers if we are in an active call or not 
VOLATILE INTEGER port = 1;
// Main Page Variables
VOLATILE INTEGER bPower   = false          // stores the power state of the device 
VOLATILE INTEGER bMicMute = false          // stores the mic mute state (false=unmuted true=muted)
VOLATILE INTEGER nVolume  = 0              // stores the current volume level (0..255)
VOLATILE INTEGER bFarSide = false          // NearSide=false FarSide=true
VOLATILE INTEGER nSource[2]={0,0}          // stores the current near-side video source selected. Index 1 stores the MainVideo and index 2 stores the SubVideo
                                           // 1=Cam1 2=Cam2 3=Aux1 4=Aux2 5=IR1 6=IR2
VOLATILE INTEGER nLine = 1                 // stores the current dial line selected (1..5)
VOLATILE INTEGER nLineState[MAX_CALLS_SUPPORTED] = {0,0,0,0,0}// 0=DISCONNECTED 1=CONNECTED 2=RINGING
VOLATILE INTEGER nLineIFSetting = 0        // stores the current LINEIF setting to use for a call
VOLATILE INTEGER nFrames = 2               // stores the frames rate 0=30fps 1=60fps 2=auto
VOLATILE INTEGER nLanBandwidth = 0         // stores the current LANBANDwidth to use for a call
VOLATILE CHAR cCommandBuffer[10] = ''       // remembers if we are entering a name or a number  
VOLATILE CHAR cNumberToDial[MAX_CALLS_SUPPORTED][30]={'','','','',''} // stores whatever number the user wants to dial
VOLATILE CHAR cEntryName[30] = '' // stores the phonebook entry name to save 
VOLATILE CHAR cCurrentPage[30] ='' // stores the name of the current page I'm on 
VOLATILE INTEGER nLetterGroup = 1 // A..I=1  J..S=2 T..Z=3 other=4
VOLATILE INTEGER nGroupMembers = 0 // remembers how many entries belong to a certain group 
VOLATILE INTEGER nVideoProtocol = 3 // 0=H.263 1=H.261 2=mpeg4 3=H.264 4=auto
VOLATILE INTEGER nAudioProtocol = 3 // 0=G.728 1=G.722 2=G.711 3=Mono48 4=Mono96 5=Stereo48 6=Stereo96 7=AUTO
VOLATILE INTEGER bFecc = true // 0=off 1=on 
VOLATILE PhoneBookEntry _PhoneBookEntry[MAX_PHONEBOOK_ENTRIES] // stores all phonebook entries
VOLATILE PhoneBookEntry _PhoneBookGroupEntry[MAX_PHONEBOOK_ENTRIES] // stores the entry to display on the Phone Book page
VOLATILE PhoneBookEntry _Empty ={'',{'','','',''},0,'',0}
VOLATILE PhoneBookEntry _NewEntry
VOLATILE INTEGER bNewEntry = false // remembers if we are entering a new entry into the phonebook
VOLATILE integer nPhoneBookEntryCursor = 0 // remembers on which entry we are on...1=First..9=Last
VOLATILE integer nPhoneBookEntryOffset = 0 // remembers what entry is at the top while scrolling up/down through the phonebook entries
VOLATILE CHAR sSearchKey[]='mySearch' // stores the searchKey used to initiate/close a search...simple label.
VOLATILE INTEGER indexEntry, LineIfSettingEntry, LanBandwidthEntry // temporary storage for a phonebook entry's advanced options
VOLATILE INTEGER bDebug = false 
VOLATILE CHAR NEAREND_LABELS[4][80] = {'CAMERA','S-VIDEO IN', 'RGB IN','VIDEO IN'}					
// 
(********************************************************************)
DEFINE_FUNCTION fnHighlightSelectedLine(integer line)
{
	stack_var integer count
	for(count=1;count<=MAX_CALLS_SUPPORTED;count++)
		OFF[dvTP,nButtons[36+count]]
	ON[dvTP,nButtons[36+line]]
}
(********************************************************************) 
DEFINE_FUNCTION fnClearAllLines()
{
	stack_var integer count
	for(count=1;count<=MAX_CALLS_SUPPORTED;count++)
	{
		cNumberToDial[count]=''
		send_command dvTP,"'@TXT',nButtons[36+count],cNumberToDial[count]"
	}
}

(********************************************************************)
/*This method will hide or show the extra dial lines (lines 1..3). 
*/
DEFINE_FUNCTION fnHideExtraDialNumbers(integer bState, integer nStartIndex)
{
	stack_var integer count 
	for(count=1;count<nStartIndex;count++)
	{
		send_command dvTP,"'^SHO-',itoa(nButtons[36+count]),',1'" //
	}
	
	for(count=nStartIndex;count<=MAX_CALLS_SUPPORTED;count++)
	{
		send_command dvTP,"'^SHO-',itoa(nButtons[36+count]),',',itoa(!bState)" //
	}
}
(********************************************************************)
/*This method will determine what buttons and text to be displayed in the Dial page
 based on the current dial configuration.*/
DEFINE_FUNCTION fnDetermineCorrectDialButtonsToShow(integer nTLineIF)
{
	if(bDebug)send_string 0,"'fnDetermineCorrectDialButtonsToShow(',itoa(nTLineIF),') called'"
	if(nTLineIF==IP) 
	{
		fnHideExtraDialNumbers(true,2)
		fnClearAllLines()
		send_command dvTP,"'@TXT',nButtons[20],'IP'"
		send_command dvTP,"'^SHO-',itoa(nButtons[26]),',1'" //show the lanbandwidth button   
		send_command dvTP,"'^SHO-',itoa(nButtons[145]),',1'" //show the Lanbandwidth Text box   
	}
	else if(nTLineIF==MULTI)
	{
		fnHideExtraDialNumbers(false,1)
		send_command dvTP,"'@TXT',nButtons[20],'MultiPoint'"
		send_command dvTP,"'^SHO-',itoa(nButtons[26]),',1'" //show the lanbandwidth button   
		send_command dvTP,"'^SHO-',itoa(nButtons[145]),',1'" //show the Lanbandwidth Text box   
	}
}
(********************************************************************)
/*This method will load the TouchPanel PhoneBookEntry based on the letter group currently selected.
letter_group 1=A..I letter_group 2=J-S letter_group 3=T-Z letter_group4=rest..*/
DEFINE_FUNCTION fnLoadPhoneBookEntry()
{
	stack_var integer count,index
	index=1
	nGroupMembers = 0
	for(count=1;count<=MAX_PHONEBOOK_ENTRIES;count++)
		_PhoneBookGroupEntry[count]=_Empty
	if(nLetterGroup==1)
	{ // get A..I
		for(count=1;count<=MAX_PHONEBOOK_ENTRIES;count++)
		if(_PhoneBookEntry[count].sName[1]>=A && _PhoneBookEntry[count].sName[1]<=I)
		{
			_PhoneBookGroupEntry[index]=_PhoneBookEntry[count]
			index++
			nGroupMembers++
		}
	}
	else if(nLetterGroup==2)
	{ // get J..S
		for(count=1;count<=MAX_PHONEBOOK_ENTRIES;count++)
		if(_PhoneBookEntry[count].sName[1]>I && _PhoneBookEntry[count].sName[1]<=S)
		{
			_PhoneBookGroupEntry[index]=_PhoneBookEntry[count]
			index++
			nGroupMembers++
		}
	}
	else if(nLetterGroup==3)
	{ // get T..Z
		for(count=1;count<=MAX_PHONEBOOK_ENTRIES;count++)
		if(_PhoneBookEntry[count].sName[1]>S && _PhoneBookEntry[count].sName[1]<=Z)
		{
			_PhoneBookGroupEntry[index]=_PhoneBookEntry[count]
			index++
			nGroupMembers++
		}
	}
	else if(nLetterGroup==4)
	{ // get rest
		for(count=1;count<=MAX_PHONEBOOK_ENTRIES;count++)
		if(_PhoneBookEntry[count].sName[1]<A)
		{
			_PhoneBookGroupEntry[index]=_PhoneBookEntry[count]
			index++
			nGroupMembers++
		}
	}
	for(index=1;index<=9;index++)
		send_command dvTP,"'@TXT',nButtons[98+index],''"
	send_command dvTP,"'@PPK-Wait'"
	for(index=1;index<=9;index++)
	{
		if(_PhoneBookGroupEntry[index].sName!=_Empty.sName) send_command dvTP,"'@TXT',nButtons[98+index],_PhoneBookGroupEntry[index].sName"
	}
}
(********************************************************************)
DEFINE_FUNCTION fnLoadPhoneBookEntryOptions(integer index, integer IFSetting, integer nNumOfChannels, integer Bandwidth, integer LineMix[])
{
	stack_var integer count
	if(index>0)
	for(count=1;count<=nGroupMembers;count++)
	{
		if(_PhoneBookGroupEntry[count].nIndex==index)
		{
			_PhoneBookGroupEntry[count].nLineIF=IFSetting
			_PhoneBookGroupEntry[count].sLanBand=itoa(Bandwidth)
		}
	}
}
(********************************************************************)
DEFINE_FUNCTION fnGetPhoneBookEntryOptions()
{
	if(nPhoneBookEntryCursor){
	send_command vdvSony_PCS_XG80[1],"'?PHONEBOOK_ENTRY_OPTIONS-',itoa(_PhoneBookGroupEntry[nPhoneBookEntryCursor+nPhoneBookEntryOffset].nIndex),',LINEIF'"
	send_command vdvSony_PCS_XG80[1],"'?PHONEBOOK_ENTRY_OPTIONS-',itoa(_PhoneBookGroupEntry[nPhoneBookEntryCursor+nPhoneBookEntryOffset].nIndex),',LANBAND'"
  }
}
(********************************************************************)
DEFINE_FUNCTION fnGetDefaultDialConfig()
{
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-LANBAND'"
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-LINEIF'"
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-AUDIO'"
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-VIDEO'"
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-FECC'"
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-FRAME'"
	send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-PREFIXLAN'"
	send_command vdvSony_PCS_XG80[1],"'?FWVERSION'"
	send_command vdvSony_PCS_XG80[1],"'?VERSION'"
}
(********************************************************************)
DEFINE_FUNCTION fnUpdateDefaultDialConfig(integer nTmpLineIf)
{
	if(bDebug)send_string 0,"'fnUpdateDefaultDialConfig(',itoa(nTmpLineIf),') called'"
	if(nTmpLineIf==2) fnDetermineCorrectDialButtonsToShow(IP)
	else if(nTmpLineIf==3) fnDetermineCorrectDialButtonsToShow(MULTI)
}
(********************************************************************)
DEFINE_FUNCTION fnClearPhoneBookStorage()
{
	stack_var integer count 
	for(count=1;count<=MAX_PHONEBOOK_ENTRIES;count++)
	{
		_PhoneBookEntry[count]=_Empty
	    _PhoneBookGroupEntry[count]=_Empty
	}
}
(********************************************************************)
DEFINE_FUNCTION fnRefreshPhoneBook()
{	
	if(bDebug)send_string 0,"'fnRefreshPhoneBook() called'"
	send_command vdvSony_PCS_XG80[1],"'PHONEBOOKSEARCH-',sSearchKey,',ID=*'" 
}
(********************************************************************)
//This  method displayed the entry name text while scrolling through the phonebook.
DEFINE_FUNCTION fnUpdateScroll(integer nOffset)
{
	stack_var integer cnt 
	for(cnt=1;cnt<=9;cnt++) 
		send_command dvTP,"'@TXT',nButtons[cnt+98],_PhoneBookGroupEntry[nOffset+cnt].sName"
}
(********************************************************************)

(********************************************************************)
// This method will find an empty index to use for the new phonebook entry
DEFINE_FUNCTION integer fnGetEmptyIndex()
{
	stack_var integer cnt, slot[MAX_PHONEBOOK_ENTRIES] 
	for(cnt=1;cnt<=MAX_PHONEBOOK_ENTRIES;cnt++)
		if(_PhoneBookEntry[cnt].nIndex>0) slot[_PhoneBookEntry[cnt].nIndex]=true;
	for(cnt=1;cnt<=MAX_PHONEBOOK_ENTRIES;cnt++)
	    if(slot[cnt]==false) return cnt;
	return 0
}
(********************************************************************)
// Find a caller's name based on the number receivd from the caller ID. 
// Name and Number must be in the phonebook...You may have to modify this method if in your phonebook you save your numbers by prepending a 9 (or similar...) in order to get a line out.
DEFINE_FUNCTION char[80] findCallerName(char sNum[])
{	
	stack_var integer cnt
	for(cnt=1;cnt<=MAX_PHONEBOOK_ENTRIES;cnt++)
	{
		if(_PhoneBookEntry[cnt].sNumber[1]==sNum ||
		   _PhoneBookEntry[cnt].sNumber[2]==sNum ||
		   _PhoneBookEntry[cnt].sNumber[3]==sNum) return _PhoneBookEntry[cnt].sName
	}
	return 'Name not listed.'
}
(********************************************************************)
//This method displays the overall dialer state.
DEFINE_FUNCTION updateDialerState()
{
	integer cnt
	for(cnt=1 ; cnt<=MAX_CALLS_SUPPORTED ; cnt++) 
	{
		if(nLineState[cnt]==CONNECTED)
		{
			send_command dvTP,"'@TXT',nButtons[134],'Connected'"
			return;
		}
	}
	send_command dvTP,"'@TXT',nButtons[134],'No Active Calls'"
}
//This  method displays the labels.
DEFINE_FUNCTION updateLabels(integer farend, integer index)
{
	integer cnt
	if(index==0)
	for(cnt=1 ; cnt<=4 ; cnt++) 
	{
		if(farend) send_command dvTP,"'@TXT',nButtons[cnt+5],FAREND_LABELS[cnt]"
		else send_command dvTP,"'@TXT',nButtons[cnt+5],NEAREND_LABELS[cnt]"
	}
	else
	{
		if(farend) send_command dvTP,"'@TXT',nButtons[index+5],FAREND_LABELS[index]"
		else send_command dvTP,"'@TXT',nButtons[index+5],NEAREND_LABELS[index]"
	}
}
(********************************************************************)
DEFINE_START

set_pulse_time(PULSE_TIME)
#include 'AdvancedChannelDefinitions.axi'
#include 'SNAPI.axi'
(********************************************************************)
DEFINE_EVENT

DATA_EVENT[dvTP]
{
	ONLINE:
		{
			stack_var integer cnt
			for(cnt=0;cnt<9;cnt++)
				send_command dvTP,"'@TXT',nButtons[99+cnt],''"
			send_command dvTP,"'@TXT',nButtons[66],''"
			send_command dvTP,'PAGE-Main'
			send_command dvTP,"'PPOF-Message'"
			send_command vdvSony_PCS_XG80[1],'?DIALERSTATUS'
			send_command vdvSony_PCS_XG80[2],'?DIALERSTATUS'
			send_command vdvSony_PCS_XG80[3],'?DIALERSTATUS'
			send_command vdvSony_PCS_XG80[1],'?PROPERTY-IP_Address'
			send_command vdvSony_PCS_XG80[1],'?PROPERTY-Call_1_Name'
			send_command vdvSony_PCS_XG80[1],'?PROPERTY-Call_2_Name'
			send_command vdvSony_PCS_XG80[1],'?PROPERTY-Call_3_Name'
			send_command vdvSony_PCS_XG80[1],'?PROPERTY-Call_4_Name'
			send_command vdvSony_PCS_XG80[1],'?PROPERTY-Call_5_Name'
			
			
			CANCEL_WAIT 'Refresh'
			WAIT 30 'Refresh'
			{   // get the current default dial configuration
				fnGetDefaultDialConfig()
				updateLabels(bFarSide,0)
				if([vdvSony_PCS_XG80[1],INITIALIZED])
				{
					fnRefreshPhoneBook()
				}
			}
		}
	STRING:
		{
			if((find_string(data.text,'KEYP-',1) || find_string(data.text,'KEYB-',1)) && !find_string(data.text,'ABORT',1))
			{
				remove_string(data.text,'-',1)
				switch(cCommandBuffer)
				{
					case 'Number': cNumberToDial[nLine]=data.text
								   send_command dvTP,"'@TXT',nButtons[36+nLine],cNumberToDial[nLine]" 
								  
						break
					case 'Name': cEntryName=data.text
						         send_command dvTP,"'@TXT',nButtons[114],cEntryName"
						break
				}
				cCommandBuffer=''
			}
			else if(find_string(data.text,'PAGE-',1))
			{
				remove_string(data.text,'-',1)
				cCurrentPage=data.text
				if(cCurrentPage!='PhoneBookEntry') bNewEntry = false;
				if(cCurrentPage=='Dialer') 
				{
					stack_var integer cnt
					fnUpdateDefaultDialConfig(nLineIFSetting)
					nPhoneBookEntryCursor=0;
				}
			}
		}
}
CHANNEL_EVENT[vdvSony_PCS_XG80[1],INITIALIZED]
{
	ON: 
	{
		//send_command vdvSony_PCS_XG80[1],"'?LABELS'"
		send_command vdvSony_PCS_XG80[1],'?PROPERTY-IP_Address'
		fnGetDefaultDialConfig()
	}
	OFF:
	{
		send_level dvTP,nButtons[114],0
	}
}
//DATA_EVENT[vdvSony_PCS_XG80[1]]
//{
//	ONLINE:
//	{
//		send_command vdvSony_PCS_XG80[1],"'PROPERTY-IP_Address,',IPADDRESS"
//		send_command vdvSony_PCS_XG80[1],"'PROPERTY-Login,',LOGIN"
//		send_command vdvSony_PCS_XG80[1],"'PROPERTY-Password,',PASSWORD"
//		send_command vdvSony_PCS_XG80[1],"'REINIT'"
//  }
//}
DATA_EVENT[vdvSony_PCS_XG80]
{

	COMMAND:
		{
			if(bDebug)
				SEND_STRING 0,"itoa(DATA.DEVICE.NUMBER),':',itoa(DATA.DEVICE.PORT),' UI RECEIVED FROM COMM:',DATA.TEXT"
			port = DATA.DEVICE.PORT
			switch(remove_string(data.text,'-',1))
			{
				case 'INCOMINGCALL-':
					{
						if(length_string(data.text)>1)
						{
							send_command dvTP,"'@TXT',nButtons[66],data.text"
							send_command dvTP,"'@TXT',nButtons[150],findCallerName(data.text),$0d,$0a,data.text"
							on[dvTP,nButtons[133]]
							send_command dvTP,"'@PPN-Incoming'"
						}
					}
					break
				CASE 'DEBUG-':
				{
					if(atoi(data.text)>=2)bDebug=true
					else bDebug=false
				}
				break
				CASE 'DEFAULT_DIAL_CONFIG-':
					{
						if(find_string(data.text,'LINEIF',1))
						{
							nLineIFSetting=atoi(data.text)
							fnUpdateDefaultDialConfig(nLineIFSetting)
						}
						else if(find_string(data.text,'LANBAND',1))
						{
							nLanBandwidth=atoi(data.text)
							send_command dvTP,"'@TXT',nButtons[26],LANBAND[nLanBandwidth+1],'k'"
						}
						else if(find_string(data.text,'VIDEO',1))
						{
							nVideoProtocol = atoi(data.text)
						}
						else if(find_string(data.text,'AUDIO',1))
						{
							nAudioProtocol = atoi(data.text)
						}
						else if(find_string(data.text,'FECC',1))
						{
							bFecc = atoi(data.text)
						}
						else if(find_string(data.text,'FRAME',1))
						{
							nFrames = atoi(data.text)
						}
						
					}
					break
				case 'DIALERSTATUS-':
					{
						send_command dvTP,"'@TXT',nButtons[134],data.text"
						if(data.text=='DISCONNECTED') 
						{
							if(nLineState[port] == RINGING)
								send_command dvTP,"'@PPK-Incoming'"
							nLineState[port] = DISCONNECTED
							updateDialerState()
							send_command vdvSony_PCS_XG80[1],"'?PROPERTY-Call_',itoa(port),'_Name'"
						}
						else if(data.text=='CONNECTED') 
						{
							nLineState[port] = CONNECTED 
							updateDialerState()
							send_command dvTP,"'@PPK-Incoming'"
							send_command vdvSony_PCS_XG80[1],"'?PROPERTY-Call_',itoa(port),'_Name'"
						}
						else if(data.text=='RINGING') 
						{
							nLineState[port] = RINGING 
						}
					}
					break
				case 'DISCONNECT-':
					{
						remove_string(data.text,',',1)
						if(atoi(data.text)==181)send_command dvTP,"'@TXT',nButtons[66],DISCONNECT_REASON[2]"
						else if(atoi(data.text)>=1 && atoi(data.text)<=15)send_command dvTP,"'@TXT',nButtons[66],DISCONNECT_REASON[5]"
						else if(atoi(data.text)==16 || atoi(data.text)==261)send_command dvTP,"'@TXT',nButtons[66],DISCONNECT_REASON[4]"
						else if(atoi(data.text)==178 || atoi(data.text)==200)send_command dvTP,"'@TXT',nButtons[66],DISCONNECT_REASON[3]"
						else if(atoi(data.text)==179)send_command dvTP,"'@TXT',nButtons[66],DISCONNECT_REASON[6]"
						else send_command dvTP,"'@TXT',nButtons[66],DISCONNECT_REASON[1]"
						off[dvTP,nButtons[133]]
					}
					break
				case 'FWVERSION-':
					{
						send_command dvTP,"'@TXT',nButtons[64],data.text"
					}
					break
				case 'INDEXING-':
					{
						send_command dvTP,"'PPON-Message'"
						//send_command dvTP,"'@TXT',nButtons[114],'Indexing Phonebook entry ',data.text"
						send_command dvTP,"'@TXT',nButtons[114],'Initializing...'"
						send_level dvTP,nButtons[114],atoi(data.text)
						CANCEL_WAIT 'LastIdx'
						WAIT 40 'LastIdx'
							send_command dvTP,"'PPOF-Message'"
					}
					break
				case 'INPUT-':
					{
						
						if(find_string(data.text,SOURCE[1],1)) 
							nSource[port]=atoi(data.text)
						else if(find_string(data.text,SOURCE[2],1)) 
							nSource[port]=atoi(data.text)+1
						else if(find_string(data.text,SOURCE[3],1)) 
							nSource[port]=atoi(data.text)+2
						else if(find_string(data.text,SOURCE[4],1)) 
							nSource[port]=atoi(data.text)+3
					}
					break
				case 'LABEL-':
				{
					integer index 
					index = atoi(data.text)
					remove_string(data.text,',',1)
					NEAREND_LABELS[index] = data.text
					updateLabels(bFarSide,index)
					break;
				}
				case 'PROPERTY-':
				{
					integer line
					if(find_string(data.text,'_Name',1))
					{
						line = atoi(data.text)
						remove_string(data.text,',',1)
						send_command dvTP,"'@TXT',nButtons[108+line],data.text"
						if(data.text=='none') 	
							send_command vdvSony_PCS_XG80[1],"'?PROPERTY-Call_',itoa(line),'_Number'"
					}
					else if(find_string(data.text,'_Number',1))
					{
						line = atoi(data.text)
						remove_string(data.text,',',1)
						send_command dvTP,"'@TXT',nButtons[108+line],findCallerName(data.text)"
					}
					else if(find_string(data.text,'IP_Address',1))
					{
						remove_string(data.text,',',1)
						send_command dvTP,"'@TXT',nButtons[62],data.text"
					}
				}
				case 'PHONEBOOKSEARCHRESULT-':
				{
					stack_var char sTmpSearchKey[80]
					stack_var integer nCounter
					sTmpSearchKey=remove_string(data.text,',',1)
					nCounter = atoi(data.text)
					if(sTmpSearchKey=="sSearchKey,','")
					{
						if(nCounter>0)
							send_command vdvSony_PCS_XG80[1],"'PHONEBOOKNEXT-',sSearchKey,',',ITOA(MAX_PHONEBOOK_ENTRIES)"
						else 
						{
							send_command vdvSony_PCS_XG80[1],"'PHONEBOOKCLOSESEARCH-',sSearchKey"
							fnClearPhoneBookStorage()
							fnLoadPhoneBookEntry()
				    }
					}
				}
				case 'PHONEBOOKRECORD-':
					{
						stack_var char sTmpSearchKey[80],sTmpName[80],sTmpNumber[500]
						stack_var integer nTmpResultNumber,nTmpIndex,nCounter
						sTmpSearchKey=remove_string(data.text,',',1)
						if(sTmpSearchKey=="sSearchKey,','")
						{// if its our searchKey
							nTmpIndex=atoi(data.text)
							remove_string(data.text,',',1)
							nTmpResultNumber=atoi(data.text)
							remove_string(data.text,',',1)
							sTmpName=remove_string(data.text,',',1)
							set_length_string(sTmpName,length_string(sTmpName)-1) // remove the ',' from the end
							sTmpNumber=data.text
							if(sTmpName[1]>=$61) sTmpName[1]=sTmpName[1]-$20// I want the first letter to be upper case
							_PhoneBookEntry[nTmpResultNumber].sName=sTmpName
							_PhoneBookEntry[nTmpResultNumber].nIndex=nTmpIndex
							nCounter=1
							while(find_string(sTmpNumber,';',1))
							{
								_PhoneBookEntry[nTmpResultNumber].sNumber[nCounter]=remove_string(sTmpNumber,';',1)
								set_length_string(_PhoneBookEntry[nTmpResultNumber].sNumber[nCounter],length_string(_PhoneBookEntry[nTmpResultNumber].sNumber[nCounter])-1) 
							    nCounter++
							}
							_PhoneBookEntry[nTmpResultNumber].sNumber[nCounter]=sTmpNumber
						    CANCEL_WAIT 'LastEntry'
							WAIT 5 'LastEntry'
							{
								send_command vdvSony_PCS_XG80[1],"'PHONEBOOKCLOSESEARCH-',sSearchKey"
								fnLoadPhoneBookEntry()
							}
						}
						
					}
					break
				case 'PHONEBOOK_ENTRY_OPTIONS-':
					{
						if(find_string(data.text,',LINEIF',1))
						{
							indexEntry = atoi(remove_string(data.text,',',1)) // remove the entry index
							LineIFSettingEntry=atoi(data.text)
							if(LineIFSettingEntry==2)fnDetermineCorrectDialButtonsToShow(IP)
							else if(LineIFSettingEntry==3)fnDetermineCorrectDialButtonsToShow(MULTI)
						}
						else if(find_string(data.text,'LINEIF',1))
						{
							indexEntry=0
							LineIFSettingEntry=atoi(data.text)
							if(LineIFSettingEntry==2)fnDetermineCorrectDialButtonsToShow(IP)
							else if(LineIFSettingEntry==3)fnDetermineCorrectDialButtonsToShow(MULTI)
						}
						else if(find_string(data.text,',LANBAND',1))
						{
							indexEntry = atoi(remove_string(data.text,',',1)) // remove the entry index
							LanBandwidthEntry=atoi(data.text)
						}
						else if(find_string(data.text,'LANBAND',1))
						{
							indexEntry=0
							LanBandwidthEntry=atoi(data.text)
						}
					}
					break
				case 'CLOCK-':
					{
						send_command dvTP,"'@TXT',nButtons[67],data.text"
					}
					break
				case 'VERSION-':
					{
						send_command dvTP,"'@TXT',nButtons[65],data.text"
					}
					break
			}
		}

}
BUTTON_EVENT[dvTP,nBUTTONS]
{

	PUSH:
		{
			nButtonIndex = get_last(nButtons)
			if(nButtonIndex>=1 && nButtonIndex<=19) // Main Page Buttons
			{
				switch(nButtonIndex)
				{
					case 1: pulse[vdvSony_PCS_XG80[1],POWER]
						break
					case 2: pulse[vdvSony_PCS_XG80[1],PRIVACY]
						break
					case 3: ON[vdvSony_PCS_XG80[1],VOLUMEUP]
						break
					case 4: ON[vdvSony_PCS_XG80[1],VOLUMEDN]
						break
					case 6:// cam 1
						send_command vdvSony_PCS_XG80[bFarSide+1],"'INPUT-',SOURCE[1],',1'"
						break;
					case 7:// aux 1
						send_command vdvSony_PCS_XG80[bFarSide+1],"'INPUT-',SOURCE[2],',1'"							
						break;
					case 8:// aux 1
						send_command vdvSony_PCS_XG80[bFarSide+1],"'INPUT-',SOURCE[3],',1'"							
						break;
					case 9:// Svideo
						send_command vdvSony_PCS_XG80[bFarSide+1],"'INPUT-',SOURCE[4],',1'"							
						break;
					case 10://RGB
						break
					case 12: on[vdvSony_PCS_XG80[bFarSide+1],TILTUP]
						break
					case 13: on[vdvSony_PCS_XG80[bFarSide+1],TILTDN]
						break
					case 14: on[vdvSony_PCS_XG80[bFarSide+1],PANRIGHT]
						break
					case 15: on[vdvSony_PCS_XG80[bFarSide+1],PANLEFT]
						break
					case 16: bFarSide = !bFarSide
					         updateLabels(bFarSide,0)
						break
					case 17: pulse[vdvSony_PCS_XG80[1],CYCLEPIP]
						break
				}
			}
			else if(nButtonIndex==148) // Information button on Main Page 
			{
				send_command vdvSony_PCS_XG80[1],"'?FWVERSION'"
				send_command vdvSony_PCS_XG80[1],"'?VERSION'"
				send_command vdvSony_PCS_XG80[1],"'?CLOCK'"
			}
			else if((nButtonIndex>=20 && nButtonIndex<=49) || (nButtonIndex>=137 && nButtonIndex<=144)) // Dial Page Buttons 
			{
				switch(nButtonIndex)
				{
					case 21:// IP line 
					case 25:// MultiPoint
					{
						stack_var integer nLineIF
						if(cCurrentPage=='Dialer')
						{
							nLineIF = nButtonIndex-20
							send_command dvTP,"'@TXT',nButtons[20],LINEIF[nLineIF]"
							if(nLineIF==IP)
								send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-LINEIF,2'"
							else if(nLineIF==MULTI)
							{
								send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-LINEIF,3'"
							}
					  }
						else
						{   // must be on the PhoneBookEntry page
							nLineIF = nButtonIndex-20
							send_command dvTP,"'@TXT',nButtons[20],LINEIF[nLineIF]"
							if(nLineIF==IP)
								send_command vdvSony_PCS_XG80[1],"'PHONEBOOK_ENTRY_OPTIONS-LINEIF,2'"
							else if(nLineIF==MULTI)
							{
								send_command vdvSony_PCS_XG80[1],"'PHONEBOOK_ENTRY_OPTIONS-LINEIF,3'"
							}
						}
					}
					break
					case 27:
					case 28:
					case 29:
					case 30:
					case 31:
					case 32:
					case 33:
					case 34:
					case 35:
					case 36: 
						{
							if(cCurrentPage=='Dialer')
							{
								send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-LANBAND,',itoa(nButtonIndex-27)"
							}
							else if(cCurrentPage=='PhoneBookEntry')
							{
								send_command vdvSony_PCS_XG80[1],"'PHONEBOOK_ENTRY_OPTIONS-LANBAND,',LANBAND[(nButtonIndex-27)+1]"
							}
							send_command dvTP,"'@TXT',nButtons[26],LANBAND[nButtonIndex-26],'k'" // update the lanbandwidth text field
						}
						break
					case 37: // Line 1 selected
					case 38:
					case 39:
					case 40:
					case 41:
						{
							nLine=nButtonIndex-36
							fnHighlightSelectedLine(nLine)
							cCommandBuffer='Number'
							send_command dvTP,"'@EKP'"
						}
						break
					case 47: // clear all 
						{
							fnClearAllLines()
						}
						break
					case 48: // dial 
						{
							send_command vdvSony_PCS_XG80[1],"'DIALNUMBER-',cNumberToDial[1],';',cNumberToDial[2],';',cNumberToDial[3],';',cNumberToDial[4],';',cNumberToDial[5]"
						}
						break
					case 49: // redial 
						{
							PULSE[vdvSony_PCS_XG80[1],REDIAL]
						}
						break
					
				}
			}
			else if(nButtonIndex==63) pulse[vdvSony_PCS_XG80[1],AUTOANSWER]
			else if(nButtonIndex>=50 && nButtonIndex<=61)// Keypad buttons
			{
				if(cCurrentPage=='Dialer')
				{ // issue DTMF tones
					if(nButtonIndex<60) send_command vdvSony_PCS_XG80[1],"'DTMF-',itoa(nButtonIndex-50)"
					else if(nButtonIndex==60) send_command vdvSony_PCS_XG80[1],"'DTMF-*'"
					else send_command vdvSony_PCS_XG80[1],"'DTMF-#'"
				}
				else if(cCurrentPage=='RemoteEmulator')
				{ // issue remote control simulator commands
					if(nButtonIndex<60) pulse[vdvSony_PCS_XG80[1],nButtonIndex-40]
					else if(nButtonIndex==60) pulse[vdvSony_PCS_XG80[1],REMOTE_ASTERISK_KEY]
					else pulse[vdvSony_PCS_XG80[1],REMOTE_POUND_KEY]
				}
			}
			else if(nButtonIndex==68)
			{
				send_command vdvSony_PCS_XG80[1],'REINIT'
			}
			else if(nButtonIndex>=70 && nButtonIndex<=92) // Advanced Options Page buttons
			{
				switch(nButtonIndex)
				{
					case 70:
					case 71:
					case 72:
					case 73:
					case 74:
						send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-VIDEO,',itoa(nButtonIndex-70)"
						send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-VIDEO'"
						break
					case 75:
					case 76:
					case 77:
					case 78:
						send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-AUDIO,',itoa(nButtonIndex-75)"
						send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-AUDIO'"
						break
					case 79:
					case 80:
					case 81:
					case 82:
						send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-FRAME,',itoa(nButtonIndex-79)"
						send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-FRAME'"
						break
					case 83:
					case 84:
						send_command vdvSony_PCS_XG80[1],"'DEFAULT_DIAL_CONFIG-FECC,',itoa(84-nButtonIndex)"
						send_command vdvSony_PCS_XG80[1],"'?DEFAULT_DIAL_CONFIG-FECC'"
						break
					
				}
			}
			else if(nButtonIndex>=93 && nButtonIndex<=113) // PhoneBook page buttons 
			{
				switch(nButtonIndex)
				{
					case 93:
					case 94:
					case 95:
					case 96: nLetterGroup = nButtonIndex-92
							 nPhoneBookEntryCursor = 0
							 nPhoneBookEntryOffset = 0
							 fnClearPhoneBookStorage()
							 send_command dvTP,"'@TXT',nButtons[114],''" // clear the name
							 send_command dvTP,"'@TXT',nButtons[37],''" // clear line 1
							 send_command dvTP,"'@TXT',nButtons[38],''" // clear line 2
							 send_command dvTP,"'@TXT',nButtons[39],''" // clear line 3
							 cancel_wait 'Refresh'
							 fnRefreshPhoneBook()
						break
					case 98: // Scroll Up 
						{
							if(_PhoneBookGroupEntry[nPhoneBookEntryOffset+8].sName!='')
								nPhoneBookEntryOffset++
							if(nPhoneBookEntryOffset>MAX_PHONEBOOK_ENTRIES) nPhoneBookEntryOffset=0
							fnUpdateScroll(nPhoneBookEntryOffset)
							nPhoneBookEntryCursor=0
						}
						break
					case 97: // Scroll Down 
						{
							nPhoneBookEntryOffset--
							if(nPhoneBookEntryOffset>MAX_PHONEBOOK_ENTRIES) nPhoneBookEntryOffset=0
							fnUpdateScroll(nPhoneBookEntryOffset)
							nPhoneBookEntryCursor=0
						}
						break
					case 99: // phonebook listing 1
					case 100:
					case 101:
					case 102:
					case 103:
					case 104:
					case 105:
					case 106:
					case 107: // phonebook listing 9
						{
							nPhoneBookEntryCursor=nButtonIndex-98
							fnGetPhoneBookEntryOptions()
						}
						break
					case 108: // Dial phonebook entry 
						{
							if(nPhoneBookEntryCursor)send_command vdvSony_PCS_XG80[1],"'DIALINDEX-',itoa(_PhoneBookGroupEntry[nPhoneBookEntryCursor+nPhoneBookEntryOffset].nIndex)"
						}
						break
					case 109: // Hangup line 1 
					case 110: // Hangup line 2 
					case 111: // Hangup line 3
					case 112: // Hangup line 4
					case 113: // Hangup line 5
					{
						off[vdvSony_PCS_XG80[nButtonIndex-108],HOOK]
					}
					break
				}
			}
			else if(nButtonIndex>=114 && nButtonIndex<=116) // PhoneBookEntry page buttons 
			{
				switch(nButtonIndex)
				{
					case 114: // Name Field
						{
							cCommandBuffer='Name'
							send_command dvTP,"'AKEYB'"
						}
						break
					case 116: // Save 
						{	
							if(nPhoneBookEntryCursor && !bNewEntry)
							{
								send_command vdvSony_PCS_XG80[1],"'PHONEBOOKUPDATE-',itoa(_PhoneBookGroupEntry[nPhoneBookEntryCursor+nPhoneBookEntryOffset].nIndex),',',cEntryName,',',cNumberToDial[1],';',cNumberToDial[2],';',cNumberToDial[3]"
							}
							else
							{  // New Entry 
								send_command vdvSony_PCS_XG80[1],"'PHONEBOOKUPDATE-',itoa(_NewEntry.nIndex),',',cEntryName,',',cNumberToDial[1],';',cNumberToDial[2],';',cNumberToDial[3]"
						    }
							nPhoneBookEntryCursor=0
							nPhoneBookEntryOffset=0
							fnClearPhoneBookStorage()
							CANCEL_WAIT 'Refresh'
							WAIT 20 'Refresh'
							{
								fnRefreshPhoneBook()
							}
						}
						break
				}
			}
			else if(nButtonIndex>=117 && nButtonIndex<=132) // RemoteControl emulator buttons 
			{
				switch(nButtonIndex)
				{
					case 117: ON[vdvSony_PCS_XG80[1],PHONEBOOK_CHANNEL]
						break
					case 118: ON[vdvSony_PCS_XG80[1],POWER_CHANNEL]
						break
					case 119: ON[vdvSony_PCS_XG80[1],MIC_CHANNEL]
						break
					case 120: PULSE[vdvSony_PCS_XG80[1],CONNECT]
						break
					case 121: ON[vdvSony_PCS_XG80[1],VIDEO_INPUT_CHANNEL]
						break
					case 122: PULSE[vdvSony_PCS_XG80[1],DISCONNECT]
						break
					case 123: PULSE[vdvSony_PCS_XG80[1],CURSOR_UP]
						break
					case 124: PULSE[vdvSony_PCS_XG80[1],CURSOR_DOWN]
						break
					case 125: PULSE[vdvSony_PCS_XG80[1],CURSOR_LEFT]
						break
					case 126: PULSE[vdvSony_PCS_XG80[1],CURSOR_RIGHT]
						break
					case 127: PULSE[vdvSony_PCS_XG80[1],CURSOR_ENTER]
						break
					case 128: PULSE[vdvSony_PCS_XG80[1],MENU_RETURN]
						break
					case 129: PULSE[vdvSony_PCS_XG80[1],MENU]
						break
					case 130: PULSE[vdvSony_PCS_XG80[1],DIAL]
						break
					case 131: ON[vdvSony_PCS_XG80[bFarSide+1],ZOOM_TELE]
						break
					case 132: ON[vdvSony_PCS_XG80[bFarSide+1],ZOOM_WIDE]
						break
				}
			}
			else if(nButtonIndex==136)
			{
				PULSE[vdvSony_PCS_XG80[1],BACK_SPACE]
			}	
			else if(nButtonIndex==151) PULSE[vdvSony_PCS_XG80[1],REJECT]
			//else if(nButtonIndex==152) send_command vdvSony_PCS_HG90[1],'ANSWER-CANCEL'
			else if(nButtonIndex==153) pulse[vdvSony_PCS_XG80[1],ACCEPT]
		}
    RELEASE:
		{	
			switch(nButtonIndex)
			{
				case 3: OFF[vdvSony_PCS_XG80[1],VOLUMEUP]
					break
				case 4: OFF[vdvSony_PCS_XG80[1],VOLUMEDN]
					break
				case 12: off[vdvSony_PCS_XG80[bFarSide+1],TILTUP]
					break
				case 13: off[vdvSony_PCS_XG80[bFarSide+1],TILTDN]
					break
				case 14: off[vdvSony_PCS_XG80[bFarSide+1],PANRIGHT]
					break
				case 15: off[vdvSony_PCS_XG80[bFarSide+1],PANLEFT]
					break
			    case 131: OFF[vdvSony_PCS_XG80[bFarSide+1],ZOOM_TELE]
						break
				case 132: OFF[vdvSony_PCS_XG80[bFarSide+1],ZOOM_WIDE]
						break
				case 147:
					send_command vdvSony_PCS_XG80[1],'DIAL-CANCEL'
					break
				case 149: 
					send_command vdvSony_PCS_XG80[1],'DISCONNECT-ALL'
					break
				case 123: 
				case 124: 
				case 125: 
				case 126: ON[vdvSony_PCS_XG80[1],STOP_CHANNEL]
			}
		}
}
BUTTON_EVENT[dvTP,nButtons[129]]
{
	HOLD[20]:
		{
			ON[vdvSony_PCS_XG80[1],MENU_LONG_CHANNEL]
		}
}
CHANNEL_EVENT[vdvSony_PCS_XG80[1],HOOK]
{
	ON: send_command dvTP,"'^SHO-',itoa(nButtons[147]),',1'" //show the disconnect button 
	OFF:
		{
			send_command dvTP,"'^SHO-',itoa(nButtons[147]),',0'" //hide the disconnect button 
        }
}
CHANNEL_EVENT[vdvSony_PCS_XG80[1],COMM]
{
	ON:
	{
		if(![vdvSony_PCS_XG80[1],INITIALIZED]) 
		{
			send_command dvTP,"'PPON-Message'"
			send_command dvTP,"'@TXT',nButtons[114],'Initializing...'"
		}
	}
}
CHANNEL_EVENT[vdvSony_PCS_XG80[1],INITIALIZED]
{
	ON :
		{
			send_command dvTP,"'@PPK-Message'"
			cancel_wait 'Refresh'
			wait 5 'Refresh'
				fnRefreshPhoneBook()
		}
	OFF:send_command vdvSony_PCS_XG80[1],"'PHONEBOOKCLOSESEARCH-',sSearchKey" // close search
}
LEVEL_EVENT[vdvSony_PCS_XG80[1],MAIN_VOLUME]
{
	nVolume =  level.value// 0...255
	SEND_LEVEL dvTP,MAIN_VOLUME,(nVolume*100/255)
}



DEFINE_PROGRAM

[dvTP,nButtons[1]] =[vdvSony_PCS_XG80[1],POWERFEEDBACK]
[dvTP,nButtons[2]] =[vdvSony_PCS_XG80[1],PRIVACYFEEDBACK]

[dvTP,nButtons[6]] =(nSource[1+bFarSide]==1) // cam 1
[dvTP,nButtons[7]] =(nSource[1+bFarSide]==2) // aux 1
[dvTP,nButtons[8]] =(nSource[1+bFarSide]==3) // s-video
[dvTP,nButtons[9]] =(nSource[1+bFarSide]==4) // RGB

//[dvTP,nButtons[10]] =(nSource[1+bFarSide]==5) // rgb

[dvTP,nButtons[16]]=bFarSide
[dvTP,nButtons[17]]=[vdvSony_PCS_XG80[1],PIP_FB]
[dvTP,nButtons[18]]=[vdvSony_PCS_XG80[1],COMM]
[dvTP,nButtons[19]]=[vdvSony_PCS_XG80[1],INITIALIZED]

[dvTP,nButtons[63]]=[vdvSony_PCS_XG80[1],AUTOANSWERFEEDBACK]
[dvTP,nButtons[93]]=(nLetterGroup==1)
[dvTP,nButtons[94]]=(nLetterGroup==2)
[dvTP,nButtons[95]]=(nLetterGroup==3)
[dvTP,nButtons[96]]=(nLetterGroup==4)

[dvTP,nButtons[70]]=(nVideoProtocol==0) // video auto
[dvTP,nButtons[71]]=(nVideoProtocol==1) // 
[dvTP,nButtons[72]]=(nVideoProtocol==2) // 
[dvTP,nButtons[73]]=(nVideoProtocol==3) // 
[dvTP,nButtons[74]]=(nVideoProtocol==4) //

[dvTP,nButtons[75]]=(nAudioProtocol==0) // audio auto
[dvTP,nButtons[76]]=(nAudioProtocol==1) //
[dvTP,nButtons[77]]=(nAudioProtocol==2) //
[dvTP,nButtons[78]]=(nAudioProtocol==3) //

//[dvTP,nButtons[79]]=(nAudioProtocol==3) //
//[dvTP,nButtons[80]]=(nAudioProtocol==4) //
//[dvTP,nButtons[81]]=(nAudioProtocol==5) //
//[dvTP,nButtons[82]]=(nAudioProtocol==6) //

[dvTP,nButtons[79]]=(nFrames==0) // auto-fps
[dvTP,nButtons[80]]=(nFrames==1) // 15fps
[dvTP,nButtons[81]]=(nFrames==2) // 30fps
[dvTP,nButtons[82]]=(nFrames==3) // 60fps

[dvTP,nButtons[83]]=(bFecc==true) // FECC on
[dvTP,nButtons[84]]=(bFecc==false) // FECC off

[dvTP,nButtons[99]]=(nPhoneBookEntryCursor==1) // entry 1
[dvTP,nButtons[100]]=(nPhoneBookEntryCursor==2) // entry 2
[dvTP,nButtons[101]]=(nPhoneBookEntryCursor==3) // entry 3
[dvTP,nButtons[102]]=(nPhoneBookEntryCursor==4) // entry 4
[dvTP,nButtons[103]]=(nPhoneBookEntryCursor==5) // entry 5
[dvTP,nButtons[104]]=(nPhoneBookEntryCursor==6) // entry 6
[dvTP,nButtons[105]]=(nPhoneBookEntryCursor==7) // entry 7
[dvTP,nButtons[106]]=(nPhoneBookEntryCursor==8) // entry 8
[dvTP,nButtons[107]]=(nPhoneBookEntryCursor==9) // entry 9