AMXTools v2.1.33
Copyright 2008 AMX Corporation

Installation Release Notes
--------------------------------------------------------------------------------
- Updates
- Known Issues
- Notes
- Using AMXTools


Updates:
--------------------------------------------------------------------------------
2.1.33 (January 26, 2008)
------------------------------
- Fixed memory leak in SocketConnection.java class.

2.1.32 (January 9, 2008)
------------------------------
- fixed hextoi method in HexUtil.java

2.1.31 (September 6, 2007)
------------------------------
- Added the following new packages:
	com.amx.duet.tools.json: JSON (JavaScript Object Notation) is a lightweight data-interchange format.
	com.amx.duet.tools.net.http: Provides HTTP communication classes and interfaces.
	com.amx.duet.tools.reqexp: Jakarta Regexp is a 100% Pure Java Regular Expression package.
- Fixed some javadoc issues and added package descriptions.

2.0.30 (August 29, 2007)
------------------------------
- Fixed handleDataEvent in DeviceUtil.java to make it call pass back event.

2.0.29 (August 27, 2007)
------------------------------
- Improved connection performance by yielding to other CPU processes in SocketConnection.java

2.0.28 (August 24, 2007)
------------------------------
- deprecated getIPAddress in DeviceUtil.java
- Removed extra error message from SocketConnection.java

2.0.27 (August 20, 2007)
------------------------------
- Added ability to start and stop heartbeat, queue, and poll timelines in DeviceUtil.java.
- Removed error message from SocketConnection.java.

2.0.26 (July 31, 2007)
------------------------------
- Corrected null pointer exception thrown within VirtualPreAmpComponent.java. 
- Corrected invalid state message from handleOnlineEvent method within DeviceUtil.java
  
--------------------------------------------------------------------------------
2.0.25 (July 25, 2007)
------------------------------
- Added support for surround modes 
- Added VirtualPreAmpComponent.java - Surround Mode template
          Also corrects problem with SNAPI not calling setSurroundMode properly.
- Added ISurroundModes.java - - methods that must be implemented by components that utilize surround modes.
- Added SurroundModesAdvancedEvent.java - A TSE listing the advanced events used for surround modes
	
--------------------------------------------------------------------------------
2.0.24 (July 17, 2007)
------------------------------
- Made the following changes to VirtualSourceSelectComponent.java
	made the class abstract
	made setInputSource(InputSourceSelectInfo sourceSelectInfo) abstract
	overrode refresh()
	overrode reinitialize()
	Added getSourceSelectComponent() with no index parameter
	Added getSelectedInput() - Returns the currently selected input.
	Added getInputs() - Returns the entire list of inputs.
	Added isValidInput() - Checks to see if the InputSourceSelect matches up with the input number.

2.0.23 (July 13, 2007)
------------------------------
- Added intitializeConnection() to DeviceUtil.java
- Added handleDataEvent() to DeviceUtil.java.
- Added parseResponse(ByteBuffer response) to IDeviceListener.java

2.0.22 (July 12, 2007)
------------------------------
- Added Range.java class to com.amx.duet.toosl.math package.
- Added setDefaultIPAddress with address and port parameters to DeviceUtil.java
- Added priority param to enQueue declaration in IDeviceListener.java

2.0.21 (July 10, 2007)
------------------------------
- Made the following changes to DeviceUtil.java
	Fixed reconnect timeline event
	Added protected enableIPControl method
	deprecated and replaced fn' feedback methods
	Added sendString(String) method
- Fixed scale range methods and deprecated fn' methods in RangeUtil.java
- Added new packSendLevel(int) and packSendLevel(float) methods to EventPacker.java

2.0.20 (July 6, 2007)
------------------------------
- Made the following changes to DeviceUtil.java
	Added new queue timeline methods
	Removed IDeviceListener dependency

2.0.19 (July 5, 2007)
------------------------------
- Added consildating logging througout DeviceUtil.java.

2.0.18 (June 15, 2007)
------------------------------
- Added isBitSet method to Bits.java
- Fixed indexing for various methods in VirtualSourceSelectComponent.java
- Added new IDeviceListener.java class to define the standard structure of
	modules.
- Added various methods the DeviceUtil.java class to help standardize device
	communications for processes such as Device Discovery.
- Added the following new properties to DeviceUtil.java
	"Timeout_Count";
	"Reconnect_Time";
	"System_Diagnostic";

2.0.17 (May 31, 2007)
------------------------------
- Added two new packages:
	com.amx.duet.tools.comm - for Commonly used comm module classes.
		DeviceUtil.java - used in almost every module to date.
		ICommonComponent.java - methods that must be implemented by every component.
		InputProperty.java - Source select input property container
	com.amx.duet.tools.comm.component - for Component implementation templates.
		VirtualSourceSelectComponent.java - Source Select template

2.0.16 (May 29, 2007)
------------------------------
- Added StringBuffer like methods to ByteBuffer class

2.0.15 (April 24, 2007)
------------------------------
- Fixed StringUtil.RightString() method

2.0.14 (April 11, 2007)
------------------------------
- Removed various warnings from a few files
- Replaced setDebug() with setDebugState() in the following files to match the 
  DeviceSDK:
	SNMPConnection.java
	SNMPTrapConnection.java
	SocketConnection.java
	Reg.java
	XMLNode.java
	XMLParser.java
- Deprecated setDebug()

2.0.13 (December 06, 2006)
------------------------------
- Reorganized the entire project and removed package interdependancies

1.0.12 (April 03, 2006)
------------------------------
- Revamped the XML parser to parse the entire XML data and create and XML tree 
  to use for traversal, due to streams with missing white space skipping nodes.
- Added new isNumeric() methods to Misc.java

1.0.11 (March 24, 2006)
------------------------------
- Updated DuetCommon.java

1.0.10 (March 08, 2006)
------------------------------
- Fixed xml parser getNext methods in XMLParser.java and XMLNode.java

1.0.9 (March 01, 2006)
------------------------------
- Added hextoi and itohex method in NetLinx.java

1.0.8 (February 15, 2006)
------------------------------
- Initial ITG Release


Known Issues:
--------------------------------------------------------------------------------
- The javadoc comments are not complete for every class.
- Base64 decoding is not supported as of yet.

Notes:
--------------------------------------------------------------------------------
- AMXTools does not include the devicesdk.jar file as a dependency. Therefore, 
API specific calls or objects are not and should not be included in this 
project.

- com.amx.duet.tools.xml files are not necessary for parsing XML files. You may 
want to use KDOM provided by KXML to create and parse XML documents.

- Most methods from the ITG file Common.java have been spread around to various
*Util.java files according to their functionality. Only the devicesdk specific 
methods were left out.


Using AMXTools:
--------------------------------------------------------------------------------
Refer to "AMXTools Tutorial.doc" for a complete description

- Deliverables
------------------------------
AMXTOOLS.zip must be imported into your project.
AMXTOOLSDOCS.zip is available for help reference use.

- Location
------------------------------
You should copy the amxtools.zip file to the same location as your Cafe Duet 
devicesdksrc.jar directory.  

This can usually be found here:
	C:\Program Files\Common Files\AMXShare\Duet\src


