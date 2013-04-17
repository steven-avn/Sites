MODULE_NAME='AMX_MatrixAudio_MiSeries_UI' (DEV vdvMatrixAudio[], DEV dvTP, INTEGER nBUTTONS[])

(********************************************************************)
(* FILE CREATED ON: 03/02/05  AT: 15:38:46                          *)
(********************************************************************)
(********************************************************************)
(*  FILE_LAST_MODIFIED_ON: 01/10/2007  AT: 13:28:22        *)
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
#INCLUDE 'Snapi.axi'
#INCLUDE 'Properties.axi'
#INCLUDE 'RoomNames'
#INCLUDE 'AdvancedEvents'

DEFINE_TYPE 
structure  _sRm
{
	Sinteger nPageVolume
	Sinteger nVolume
	integer nInput 
}
structure _sTnr
{
	integer nPreset
	integer nBand     //0=FM 1=AM
	integer nTuneMode //1=Seek 0=Tune
	char    cFreq[10]
	char    cPresetFreq[10][10]
	char    cSiriusStatus[80]
	integer nSiriusSignalState // 1=NoSignal 2=Weak 3=Good 4=Excellent
	char    cSiriusChannelName[80]
	char    cSiriusSongTitle[80]
	char    cSiriusArtistName[80]
	char    cSiriusCategoryName[80]
}


DEFINE_CONSTANT


CHAR IP[15] = '192.168.100.27' // Device IP address. Update to match your device.

INTEGER MAX_INPUTS= 8  // maximum number of inputs supported by this sample UI
INTEGER MAX_PRESET=10  // maximum number of presets supported by the device 
INTEGER MAX_SOURCES=8  // maximum number of sources supported by the device 
INTEGER MAIN       =1  
INTEGER HIDE       =0
INTEGER SHOW       =1
INTEGER MAX_LEVEL  =255
INTEGER MIN_LEVEL  =0
CHAR    UNKNOWN[]  = '---'
// Source Type definitions
CHAR    PLACE_HOLDER[15]   = 'TUNER' // used as default
CHAR    OTHER[15]          = 'Other'
CHAR    INTERNAL_TUNER[15] = 'Internal Tuner'
CHAR    EXTERNAL_TUNER[15] = 'External Tuner'
CHAR    CD_PLAYER[15]      = 'CD'
CHAR    DVD_PLAYER[15]     = 'DVD'
CHAR    SATELLITE[15]      = 'Satellite'
CHAR    AUDIO_SERVER[15]   = 'Audio Server'
CHAR    DELPHI_XM[15]      = 'XM'
CHAR    SIRIUS[15]         = 'Sirius'

// Sirius Signal States 
CHAR    NOSIGNAL[]  	  	= 'No Signal' 
CHAR    WEAKSIGNAL[] 	  	= 'Weak Signal'
CHAR    GOODSIGNAL[]    	= 'Good Signal'
CHAR    EXCELLENTSIGNAL[] = 'Excellent Signal'
CHAR    SIGNAL[4][20]     = {'No Signal','Weak Signal','Good Signal','Excellent Signal'}
CHAR    BITMAP[4][20]     = {'none_s.png','weak_s.png','good_s.png','excellent_s.png'}
(********************************************************************)
DEFINE_VARIABLE


volatile integer nSelection = 0 // stores the button selected by user. (stores the index of that button)
volatile integer nRoomSelected = 1
volatile integer nRoomsInstalled = 0
volatile integer nInputsInstalled= 0
volatile char    sSourceTypes[MAX_INPUTS][15]
volatile integer nPower[MAX_INPUTS]  // stores the enable/disable state of a source
volatile integer nOnline 
volatile integer nInitialized
volatile integer bDebug  = false
volatile _sRm _sRoom[MAX_ROOMS]
volatile _sTnr _sTuner[MAX_INPUTS]
(********************************************************************)


(********************************************************************)

(********************************************************************)

DEFINE_FUNCTION displayAppropriateButtons()
{
	integer i
	if(_sRoom[nRoomSelected].nInput==0) return;
	if(sSourceTypes[_sRoom[nRoomSelected].nInput]!=SIRIUS)
	{
		for(i=1 ; i<=MAX_ROOMS ; i++)
		{
			send_command dvTP,"'@SHO',nButtons[i],HIDE"
		}
		for(i=1 ; i<=MAX_SOURCES ; i++)
		{
			send_command dvTP,"'@SHO',nButtons[i+16],HIDE"
		}
	}
	for(i=1 ; i<=nRoomsInstalled ; i++)
	{
		send_command dvTP,"'@SHO',nButtons[i],SHOW"
		send_command dvTP,"'@TXT',nButtons[i],ROOM_NAMES[i]"
	}
	for(i=1 ; i<=nInputsInstalled ; i++)
	{
		send_command dvTP,"'@SHO',nButtons[i+16],SHOW"
		send_command dvTP,"'@TXT',nButtons[i+16],'Input ',itoa(i),' ',sSourceTypes[i]"
	}
}

DEFINE_FUNCTION displaySourceButtons(integer src)
{
	if(src>0)
	{
		if(sSourceTypes[src]==SIRIUS) send_command dvTP,"'@PPN-Sirius'"
		else send_command dvTP,"'@PPN-Source'"
	}
	if(src==0) 
	{
		hideAllRoomButtons()
		send_command dvTP,"'@PPK-Sirius'"
		send_command dvTP,"'@PPK-Source'"
		send_command dvTP,"'@PPK-Save'"
	}
	else if(sSourceTypes[src]==OTHER || sSourceTypes[src]==DELPHI_XM) displayOtherButtons()
	else if(sSourceTypes[src]==INTERNAL_TUNER) displayInternalTunerButtons()
	else if(sSourceTypes[src]==EXTERNAL_TUNER) displayExternalTunerButtons()
	else if(sSourceTypes[src]==DVD_PLAYER) displayDVDButtons()
	else if(sSourceTypes[src]==CD_PLAYER) displayCDButtons()
	else if(sSourceTypes[src]==SATELLITE) displaySatelliteButtons()
	else if(sSourceTypes[src]==AUDIO_SERVER) displayAudioServerButtons()
	else if(sSourceTypes[src]==SIRIUS) displaySiriusTunerButtons()
}
DEFINE_FUNCTION hideAllRoomButtons()
{
	integer i
	for(i=27 ; i<=50 ; i++)
		if(i!=35)send_command dvTP,"'@SHO',nButtons[i],HIDE"
	send_command dvTP,"'@SHO',nButtons[53],HIDE" // power btn
}
DEFINE_FUNCTION displayOtherButtons()
{
	hideAllRoomButtons()
	send_command dvTP,"'@SHO',nButtons[33],SHOW" // page vol up 
	send_command dvTP,"'@SHO',nButtons[34],SHOW" // page vol down
	send_command dvTP,"'@SHO',nButtons[35],SHOW" // page vol text box
	send_command dvTP,"'@SHO',nButtons[36],SHOW" // page enable/disable
	send_command dvTP,"'@SHO',nButtons[47],SHOW" // preset up 
	send_command dvTP,"'@SHO',nButtons[48],SHOW" // preset down
	send_command dvTP,"'@SHO',nButtons[42],SHOW" // mute 
	send_command dvTP,"'@SHO',nButtons[43],SHOW" // volume up
	send_command dvTP,"'@SHO',nButtons[44],SHOW" // volume down
	send_command dvTP,"'@SHO',nButtons[45],SHOW" // volume text box
	send_command dvTP,"'@SHO',nButtons[53],SHOW" // power btn
}
DEFINE_FUNCTION displayInternalTunerButtons()
{	
	displayOtherButtons()
	send_command dvTP,"'@SHO',nButtons[37],SHOW" // freq up 
	send_command dvTP,"'@SHO',nButtons[38],SHOW" // freq down
	send_command dvTP,"'@SHO',nButtons[39],SHOW" // seek/tune mode
	send_command dvTP,"'@SHO',nButtons[40],SHOW" // band 
	send_command dvTP,"'^TXT-',itoa(nButtons[40]),',1,','FM'"
	send_command dvTP,"'^TXT-',itoa(nButtons[40]),',2,','AM'"
	send_command dvTP,"'@SHO',nButtons[41],SHOW" // freq text box
	send_command dvTP,"'@SHO',nButtons[46],SHOW" // save preset
	send_command dvTP,"'@SHO',nButtons[53],HIDE" // power btn
}
DEFINE_FUNCTION displayExternalTunerButtons()
{	
	displayOtherButtons()
	send_command dvTP,"'@SHO',nButtons[37],SHOW" // freq up 
	send_command dvTP,"'@SHO',nButtons[38],SHOW" // freq down
	send_command dvTP,"'@SHO',nButtons[40],SHOW" // band 
	send_command dvTP,"'@TXT',nButtons[40],'FM/AM'" // band
	send_command dvTP,"'@SHO',nButtons[46],SHOW" // save preset
}
DEFINE_FUNCTION displaySiriusTunerButtons()
{	
	closeAllPopups()
	send_command dvTP,"'@PPN-Sirius'"  
	displayInternalTunerButtons()
}
DEFINE_FUNCTION displayDVDButtons()
{	
	displayOtherButtons()
	send_command dvTP,"'@SHO',nButtons[27],SHOW" // cursor up 
	send_command dvTP,"'@SHO',nButtons[28],SHOW" // cursor down
	send_command dvTP,"'@SHO',nButtons[29],SHOW" // cursor left 
	send_command dvTP,"'@SHO',nButtons[30],SHOW" // cursor right
	send_command dvTP,"'@SHO',nButtons[31],SHOW" // select 
	send_command dvTP,"'@SHO',nButtons[50],SHOW" // menu
}
DEFINE_FUNCTION displayCDButtons()
{	
	displayOtherButtons()
	send_command dvTP,"'@SHO',nButtons[27],SHOW" // cursor up 
	send_command dvTP,"'@SHO',nButtons[28],SHOW" // cursor down
	send_command dvTP,"'@SHO',nButtons[29],SHOW" // cursor left 
	send_command dvTP,"'@SHO',nButtons[30],SHOW" // cursor right
	send_command dvTP,"'@SHO',nButtons[32],SHOW" // play
}
DEFINE_FUNCTION displaySatelliteButtons()
{	
	displayOtherButtons()
	send_command dvTP,"'@SHO',nButtons[27],SHOW" // cursor up 
	send_command dvTP,"'@SHO',nButtons[28],SHOW" // cursor down
	send_command dvTP,"'@SHO',nButtons[31],SHOW" // select 
	send_command dvTP,"'@SHO',nButtons[50],SHOW" // menu
}
DEFINE_FUNCTION displayAudioServerButtons()
{	
	displayCDButtons()
}
DEFINE_FUNCTION clearRoomText()
{
	send_command dvTP,"'@TXT',nButtons[26],''"
	send_command dvTP,"'@TXT',nButtons[35],''"
	send_command dvTP,"'@TXT',nButtons[41],''"
	send_command dvTP,"'@TXT',nButtons[45],''"
	send_command dvTP,"'@TXT',nButtons[49],''"
}

// Highlights one of the room buttons from the Room Menu and updates the touch panel page for that room
DEFINE_FUNCTION selectRoom(integer value)
{
	integer i
	nRoomSelected = value
	updateRoomText(value)
	displaySourceButtons(_sRoom[value].nInput)
}
// Selects one of the input buttons from the Input Menu and updates the Room page with the correct buttons
DEFINE_FUNCTION selectInput(integer value)
{
	integer i 
	if(nRoomSelected>0)
	{
		if(_sRoom[nRoomSelected].nInput==value) value=!value
		send_command vdvMatrixAudio[nRoomSelected],"'INPUT-',PLACE_HOLDER,',',itoa(value)"
		displaySourceButtons(value)
	}
}
// Updates the room information on the touch panel 
DEFINE_FUNCTION updateRoomText(integer value)
{
	if(value==0) return;
	send_command dvTP,"'@TXT',nButtons[26],ROOM_NAMES[value]"
	if(_sRoom[value].nPageVolume>=0)send_command dvTP,"'@TXT',nButtons[35],itoa(_sRoom[value].nPageVolume)"
	else send_command dvTP,"'@TXT',nButtons[35],UNKNOWN"
	if(_sRoom[value].nVolume>=0)send_command dvTP,"'@TXT',nButtons[45],itoa(_sRoom[value].nVolume)"
	else send_command dvTP,"'@TXT',nButtons[45],UNKNOWN"
	if(_sRoom[value].nInput>0 && _sRoom[value].nInput<=MAX_INPUTS)
	{
		send_command dvTP,"'@TXT',nButtons[49],itoa(_sTuner[_sRoom[value].nInput].nPreset)"
		send_command dvTP,"'@TXT',nButtons[41],_sTuner[_sRoom[value].nInput].cFreq"
		send_command dvTP,"'@TXT',nButtons[64],_sTuner[_sRoom[value].nInput].cFreq"
		updateSiriusValues(value)
	}
}


DEFINE_FUNCTION updatePresetFreqValues(integer source, integer preset)
{
	if(_sRoom[nRoomSelected].nInput==source)
	{
		send_command dvTP,"'@TXT',nButtons[53+preset],_sTuner[source].cPresetFreq[preset]"
	}
}
DEFINE_FUNCTION getProperties()
{
	send_command vdvMatrixAudio[MAIN],"'?PROPERTY-',ROOMS_INSTALLED"
	send_command vdvMatrixAudio[MAIN],"'?PROPERTY-',INPUTS_INSTALLED"
}

DEFINE_FUNCTION getSourceTypes()
{
	integer i
	for(i=1 ; i<=nInputsInstalled ; i++)
	{
		send_command vdvMatrixAudio[MAIN],"'?PROPERTY-',SOURCE_TYPE,itoa(i)"
	}
}

DEFINE_FUNCTION closeAllPopups()
{
	send_command dvTP,"'@PPF-Wait'"
	send_command dvTP,"'@PPF-RoomMenu'"
	send_command dvTP,"'@PPF-Save'"
	send_command dvTP,"'@PPF-Source'"
	send_command dvTP,"'@PPF-Sirius'"
}

DEFINE_FUNCTION updateSiriusValues(integer port)
{
	if(_sRoom[nRoomSelected].nInput==port)
	{
		if(_sTuner[port].nSiriusSignalState>0)
			send_command dvTP,"'^ANI-',itoa(nButtons[65]),',',itoa(_sTuner[port].nSiriusSignalState),',',itoa(_sTuner[port].nSiriusSignalState),',0'"
		send_command dvTP,"'@TXT',nButtons[66],_sTuner[port].cSiriusStatus"
		send_command dvTP,"'@TXT',nButtons[67],_sTuner[port].cSiriusChannelName"
		send_command dvTP,"'@TXT',nButtons[68],_sTuner[port].cSiriusSongTitle"
		send_command dvTP,"'@TXT',nButtons[69],_sTuner[port].cSiriusArtistName"
		send_command dvTP,"'@TXT',nButtons[72],_sTuner[port].cSiriusCategoryName"
	}
}
(********************************************************************)
DEFINE_START



(********************************************************************)
DEFINE_EVENT

CHANNEL_EVENT[vdvMatrixAudio[MAIN],DEVICE_COMMUNICATING]
{
	ON: 
	{
		nOnline = true 
	  send_command dvTP,"'@PPN-Wait'"
	}
	OFF:
	{
		nOnline = false
	  clearRoomText()
		closeAllPopups();
		nRoomsInstalled = 0
		nInputsInstalled= 0
		displayAppropriateButtons()
	}
}
CHANNEL_EVENT[vdvMatrixAudio[MAIN],DATA_INITIALIZED]
{
	ON: 
	{
		nInitialized = true 
		closeAllPopups();
		getProperties()
		if(nRoomSelected>0)
		{
			updateRoomText(nRoomSelected)
	    wait 30
			{
				displayAppropriateButtons()
				displaySourceButtons(_sRoom[nRoomSelected].nInput)
			}
		}
	}
	OFF:
	{
		nInitialized = false
		closeAllPopups();
	}
}

LEVEL_EVENT[vdvMatrixAudio,VOL_LVL]
{
	_sRoom[LEVEL.SOURCEDEV.PORT].nVolume = LEVEL.VALUE
	if(_sRoom[nRoomSelected].nVolume>=0 && nRoomSelected==LEVEL.SOURCEDEV.PORT)send_command dvTP,"'@TXT',nButtons[45],itoa(_sRoom[nRoomSelected].nVolume)"
	else if(nRoomSelected==LEVEL.SOURCEDEV.PORT)send_command dvTP,"'@TXT',nButtons[45],UNKNOWN"
}
LEVEL_EVENT[vdvMatrixAudio,PAGE_VOLUME_LVL]
{
	_sRoom[LEVEL.SOURCEDEV.PORT].nPageVolume = LEVEL.VALUE
	if(_sRoom[nRoomSelected].nPageVolume>=0 && nRoomSelected==LEVEL.SOURCEDEV.PORT)send_command dvTP,"'@TXT',nButtons[35],itoa(_sRoom[nRoomSelected].nPageVolume)"
  else if(nRoomSelected==LEVEL.SOURCEDEV.PORT)send_command dvTP,"'@TXT',nButtons[35],UNKNOWN"
}
DATA_EVENT[dvTP]
{
	ONLINE:
	{
		closeAllPopups();
		nRoomsInstalled = 0
		nInputsInstalled= 0
		displayAppropriateButtons()
		getProperties()
		if(nRoomSelected>0)
		{
			updateRoomText(nRoomSelected)
		  displaySourceButtons(_sRoom[nRoomSelected].nInput)
			if(_sRoom[nRoomSelected].nInput>=1 && _sRoom[nRoomSelected].nInput<=2)
				updateSiriusValues(_sRoom[nRoomSelected].nInput)
		}
	}
	STRING:
	{
		if(find_string(DATA.TEXT,'ABORT',1)){}
		else if(left_string(DATA.TEXT,5)=='KEYP-')
		{
			remove_string(DATA.TEXT,'-',1)
			send_command dvTP,"'^TXT-',itoa(nButtons[64]),',0,',DATA.TEXT"
			if(atoi(data.text)>0)send_command vdvMatrixAudio[_sRoom[nRoomSelected].nInput],"'XCH-',DATA.TEXT"
			_sTuner[_sRoom[nRoomSelected].nInput].cFreq = DATA.TEXT
		}
	}
}

DATA_EVENT[vdvMatrixAudio[1]]
{
	ONLINE:
		{
			send_command vdvMatrixAudio[1],"'PROPERTY-',IP_ADDRESS,',',IP"
			send_command vdvMatrixAudio[1],'REINIT'
		}
}

DATA_EVENT[vdvMatrixAudio]
{

	COMMAND:
		{
			if(bDebug)
				SEND_STRING 0,"'UI RECEIVED FROM COMM on Port ',itoa(DATA.DEVICE.PORT),': ',DATA.TEXT"
			switch(REMOVE_STRING(DATA.TEXT,'-',1))
			{
				case 'BAND-':
				{
					if(FIND_STRING(DATA.TEXT,'AM',1) && DATA.DEVICE.PORT<=MAX_INPUTS) 
						_sTuner[DATA.DEVICE.PORT].nBand = 1 //AM
					else if(DATA.DEVICE.PORT<=MAX_INPUTS)
						_sTuner[DATA.DEVICE.PORT].nBand = 0 // FM
				}
				case 'DEBUG-':
				{
					if(atoi(data.text)>=3) bDebug = true 
					else bDebug = false
				}
				case 'TUNE_MODE-':
				{
					if(DATA.DEVICE.PORT<=MAX_INPUTS) 
					{
						
						_sTuner[DATA.DEVICE.PORT].nTuneMode = atoi(data.text)
					}
				}
				case 'TUNERPROP-':
				{
					if(DATA.DEVICE.PORT<=MAX_INPUTS) 
					{
						stack_var char propname[80]
						propname = remove_string(data.text,',',1)
						set_length_string(propname,length_string(propname)-1)
						switch(propname)
						{
							case SIRIUS_TUNE_STATUS:
							{
								_sTuner[DATA.DEVICE.PORT].cSiriusStatus=data.text 
								break
							}
							case SIRIUS_ARTIST:
							{
								_sTuner[DATA.DEVICE.PORT].cSiriusArtistName=data.text 
								break
							}
							case SIRIUS_TITLE:
							{
								_sTuner[DATA.DEVICE.PORT].cSiriusSongTitle=data.text 
								break
							}
							case SIRIUS_CHANNEL:
							{
								_sTuner[DATA.DEVICE.PORT].cSiriusChannelName=data.text 
								break
							}
							case SIRIUS_CATEGORY:
							{
								_sTuner[DATA.DEVICE.PORT].cSiriusCategoryName=data.text 
								break
							}
							case SIRIUS_SATELLITE_STRENGTH:
							{
								if(data.text==nosignal)
									_sTuner[DATA.DEVICE.PORT].nSiriusSignalState = 1; 
								else if(data.text==weaksignal)
									_sTuner[DATA.DEVICE.PORT].nSiriusSignalState = 2; 
								else if(data.text==goodsignal)
									_sTuner[DATA.DEVICE.PORT].nSiriusSignalState = 3;
								else if(data.text==excellentsignal)
									_sTuner[DATA.DEVICE.PORT].nSiriusSignalState = 4; 
								break
							}
						}
						updateSiriusValues(DATA.DEVICE.PORT)
					}
				}
				case 'TUNERPRESETSAVE-':
				{
					integer preset
					preset = atoi(data.text)
					remove_string(data.text,',',1)
					_sTuner[DATA.DEVICE.PORT].cPresetFreq[preset]=data.text
					updatePresetFreqValues(DATA.DEVICE.PORT,preset)
				}
				case 'INPUT-':
				{
					_sRoom[DATA.DEVICE.PORT].nInput = atoi(DATA.TEXT)
					if(DATA.DEVICE.PORT==nRoomSelected) 
					{
						if(find_string(data.text,SIRIUS,1))
						{
							send_command vdvMatrixAudio[_sRoom[DATA.DEVICE.PORT].nInput],"'?TUNERPROPS'"
						}
						updateRoomText(nRoomSelected)
						displaySourceButtons(_sRoom[DATA.DEVICE.PORT].nInput)
					}
				}
				break;
				case 'PROPERTY-':
				{
					char prop[80]
					prop = REMOVE_STRING(DATA.TEXT,',',1)
					prop = left_string(prop,length_string(prop)-1)
					switch(prop)
					{
						case ROOMS_INSTALLED: nRoomsInstalled=atoi(DATA.TEXT)
						case INPUTS_INSTALLED:
						{
							nInputsInstalled=atoi(DATA.TEXT)
							getSourceTypes()
							break;
					  }
						case SOURCE1_TYPE: sSourceTypes[1] = DATA.TEXT
						case SOURCE2_TYPE: sSourceTypes[2] = DATA.TEXT
						case SOURCE3_TYPE: sSourceTypes[3] = DATA.TEXT
						case SOURCE4_TYPE: // If we have an S4
						{
							sSourceTypes[4] = DATA.TEXT
						  if(nInputsInstalled==4)displayAppropriateButtons()
						}
						case SOURCE5_TYPE: sSourceTypes[5] = DATA.TEXT
						case SOURCE6_TYPE: // If we have an S6
						{
							sSourceTypes[6] = DATA.TEXT
						  if(nInputsInstalled==6)displayAppropriateButtons()
						}
						case SOURCE7_TYPE: sSourceTypes[7] = DATA.TEXT
						case SOURCE8_TYPE: // If we have an S8
						{
							sSourceTypes[8] = DATA.TEXT
					    if(nInputsInstalled==8)displayAppropriateButtons()
						}
					}
				}
				break;
				case 'XCH-':
				{
					if(DATA.DEVICE.PORT<=MAX_INPUTS) 
					{
						_sTuner[DATA.DEVICE.PORT].cFreq = DATA.TEXT
						if(DATA.DEVICE.PORT==_sRoom[nRoomSelected].nInput)
						{
							send_command dvTP,"'@TXT',nButtons[41],_sTuner[_sRoom[nRoomSelected].nInput].cFreq"
							send_command dvTP,"'@TXT',nButtons[64],_sTuner[_sRoom[nRoomSelected].nInput].cFreq"
						}
					}
				}
				break;
			}
		}

}

BUTTON_EVENT[dvTP,nBUTTONS]
{

	PUSH:
		{
			nSelection=get_last(nButtons)
			if(nSelection>=1 && nSelection<=MAX_ROOMS)
			{
				selectRoom(nSelection)
			}
			else if(nSelection>=17 && nSelection<=24)
			{
				selectInput(nSelection-16)
			}
			else if(nSelection==25)
			{
				if([vdvMatrixAudio[nRoomSelected],KEYPAD_LOCK_CH])
					OFF[vdvMatrixAudio[nRoomSelected],KEYPAD_LOCK_CH]
				else ON[vdvMatrixAudio[nRoomSelected],KEYPAD_LOCK_CH]
			}
			else if(nSelection>=27 && nSelection<=30)
			{ // cursor up/down/left/right
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],nSelection+18]
			}
			else if(nSelection==31)
			{
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],MENU_SELECT]
			}
			else if(nSelection==32)
			{
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],PLAY]
			}
			else if(nSelection==33)
			{ // page volume up
				Sinteger value
				value = _sRoom[nRoomSelected].nPageVolume+8
				if(value>MAX_LEVEL) value=MAX_LEVEL
				SEND_LEVEL vdvMatrixAudio[nRoomSelected],PAGE_VOLUME_LVL,value
			}
			else if(nSelection==34)
			{ // page volume down
				Sinteger value
				value = _sRoom[nRoomSelected].nPageVolume-4
				if(value<0) value=MIN_LEVEL
				SEND_LEVEL vdvMatrixAudio[nRoomSelected],PAGE_VOLUME_LVL,value
			}
			else if(nSelection==36)
			{ // page enable/disable
				if([vdvMatrixAudio[nRoomSelected],PAGE_ENABLE_CH])
					OFF[vdvMatrixAudio[nRoomSelected],PAGE_ENABLE_CH]
				else ON[vdvMatrixAudio[nRoomSelected],PAGE_ENABLE_CH]
			}
			else if(nSelection==37)
			{ // tuner freq up
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],TUNER_STATION_UP]
				send_command dvTP,"'@TXT',nButtons[64],''"
			}
			else if(nSelection==38)
			{ // tuner freq down
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],TUNER_STATION_DN]
				send_command dvTP,"'@TXT',nButtons[64],''"
			}
			else if(nSelection==39)
			{ // toggle seek/tune modes
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],TUNE_MODE_CH]
			}
			else if(nSelection==40)
			{ // toggle AM/FM modes
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],TUNER_BAND]
				if(sSourceTypes[_sRoom[nRoomSelected].nInput]==EXTERNAL_TUNER)
				{
					PULSE[dvTP,nButtons[40]]
			    send_command dvTP,"'@TXT',nButtons[64],''"
				}
			}
			else if(nSelection==64)
			{ // direct freq 
				send_command dvTP,"'@EKP- '"
			}
			else if(nSelection==42)
			{
				PULSE[vdvMatrixAudio[nRoomSelected],VOL_MUTE]
			}
			else if(nSelection>=43 && nSelection<=44)
			{ // volume ramp start
				ON[vdvMatrixAudio[nRoomSelected],nSelection-19]
			}
			else if(nSelection==46)
			{ // Save preset button 
				integer i 
				for(i=1 ; i<=MAX_PRESET ; i++)
				{
					send_command dvTP,"'@TXT',nButtons[53+i],''"   // clear text
					updatePresetFreqValues(_sRoom[nRoomSelected].nInput,i)//update text
			  }
			}
			else if(nSelection==47)
			{ // preset up
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],CHAN_UP]
			}
			else if(nSelection==48)
			{ // preset down
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],CHAN_DN]
			}
			else if(nSelection==50)
			{ // menu
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],MENU_FUNC]
			}
			else if(nSelection==53)
			{
				if(_sRoom[nRoomSelected].nInput<=2) // Internal Source do not use this command
				{/*do nothing*/}
				else if([vdvMatrixAudio[_sRoom[nRoomSelected].nInput],POWER_ON])
					OFF[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],POWER_ON]
				else ON[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],POWER_ON]
			}
			else if(nSelection>=54 && nSelection<=63)
			{// Save a tuner preset
				send_command vdvMatrixAudio[_sRoom[nRoomSelected].nInput],"'TUNERPRESETSAVE-',itoa(nSelection-53),',',_sTuner[_sRoom[nRoomSelected].nInput].cFreq"
			}
			else if(nSelection==70)
			{ // category up
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],SIRIUS_CATEGORY_UP_CH]
			}
			else if(nSelection==71)
			{ // category down
				PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],SIRIUS_CATEGORY_DN_CH]
			}
		}
    HOLD[5,REPEAT]:
		{
			if(nSelection==34)
			{ // page volume down
				Sinteger value
				value = _sRoom[nRoomSelected].nPageVolume-4
				if(value<0) value=MIN_LEVEL
				SEND_LEVEL vdvMatrixAudio[nRoomSelected],PAGE_VOLUME_LVL,value
			}
			else if(nSelection==33)
			{ // page volume up
				Sinteger value
				value = _sRoom[nRoomSelected].nPageVolume+8
				if(value>MAX_LEVEL) value=MAX_LEVEL
				SEND_LEVEL vdvMatrixAudio[nRoomSelected],PAGE_VOLUME_LVL,value
			}
			else if(nSelection==37 && _sRoom[nRoomSelected].nInput>0)
			{ 
			  if(_sTuner[_sRoom[nRoomSelected].nInput].nTuneMode==0)
				{
					// tuner freq up if Tuner is in Tune Mode and not Seek
					PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],TUNER_STATION_UP]
			  }
			}
			else if(nSelection==38 && _sRoom[nRoomSelected].nInput>0)
			{ 
			  if(_sTuner[_sRoom[nRoomSelected].nInput].nTuneMode==0)
				{
					// tuner freq down if Tuner is in Tune Mode and not Seek
					PULSE[vdvMatrixAudio[_sRoom[nRoomSelected].nInput],TUNER_STATION_DN]
			  }
			}
			
		}
		RELEASE:
		{
			if(nSelection>=43 && nSelection<=44) // volume ramp stop
				OFF[vdvMatrixAudio[nRoomSelected],nSelection-19]
		}
}

DEFINE_PROGRAM

[dvTP,nButtons[1]]  = (nRoomSelected==1)
[dvTP,nButtons[2]]  = (nRoomSelected==2)
[dvTP,nButtons[3]]  = (nRoomSelected==3)
[dvTP,nButtons[4]]  = (nRoomSelected==4)
[dvTP,nButtons[5]]  = (nRoomSelected==5)
[dvTP,nButtons[6]]  = (nRoomSelected==6)
[dvTP,nButtons[7]]  = (nRoomSelected==7)
[dvTP,nButtons[8]]  = (nRoomSelected==8)
[dvTP,nButtons[9]]  = (nRoomSelected==9)
[dvTP,nButtons[10]] = (nRoomSelected==10)
[dvTP,nButtons[11]] = (nRoomSelected==11)
[dvTP,nButtons[12]] = (nRoomSelected==12)
[dvTP,nButtons[13]] = (nRoomSelected==13)
[dvTP,nButtons[14]] = (nRoomSelected==14)
[dvTP,nButtons[15]] = (nRoomSelected==15)
[dvTP,nButtons[16]] = (nRoomSelected==16)

[dvTP,nButtons[17]] = (_sRoom[nRoomSelected].nInput=1)
[dvTP,nButtons[18]] = (_sRoom[nRoomSelected].nInput=2)
[dvTP,nButtons[19]] = (_sRoom[nRoomSelected].nInput=3)
[dvTP,nButtons[20]] = (_sRoom[nRoomSelected].nInput=4)
[dvTP,nButtons[21]] = (_sRoom[nRoomSelected].nInput=5)
[dvTP,nButtons[22]] = (_sRoom[nRoomSelected].nInput=6)
[dvTP,nButtons[23]] = (_sRoom[nRoomSelected].nInput=7)
[dvTP,nButtons[24]] = (_sRoom[nRoomSelected].nInput=8)
[dvTP,nButtons[25]] = ([vdvMatrixAudio[nRoomSelected],KEYPAD_LOCK_CH])
[dvTP,nButtons[36]] = ([vdvMatrixAudio[nRoomSelected],PAGE_ENABLE_CH])
if(_sRoom[nRoomSelected].nInput>0 && _sRoom[nRoomSelected].nInput<=MAX_INPUTS)
{
	[dvTP,nButtons[39]] = (_sTuner[_sRoom[nRoomSelected].nInput].nTuneMode)
	[dvTP,nButtons[40]] = (_sTuner[_sRoom[nRoomSelected].nInput].nBand)
}
[dvTP,nButtons[42]] = ([vdvMatrixAudio[nRoomSelected],VOL_MUTE_ON])

[dvTP,nButtons[51]] = (nOnline)
[dvTP,nButtons[52]] = (nInitialized)

if(_sRoom[nRoomSelected].nInput>0)
{
	[dvTP,nButtons[53]] = ([vdvMatrixAudio[_sRoom[nRoomSelected].nInput],POWER_ON])
}
else [dvTP,nButtons[53]] = 0

