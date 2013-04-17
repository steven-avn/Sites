PROGRAM_NAME='Main'
(*
	A FEW COMMENTS:
	1.	This is just my way of doing things which has worked 
	very well for me. I never instantiate a module in my Main
	file, I instantiate it in an include file as illustrated
	here, and then any custom code associated with the module
	that is being instantiated can be placed in that include
	file. That makes the file structures logical and it makes
	it easier to find code. 
	2.	So, in this example, I am including the file called
	'Green Box Systems Wired Initialisation.AXI' and then
	the 'GBSCommsMod' module is instantiated in that file.
	All variables, devices and virtual devices pertaining to 
	the module are declared in the include file. 
	3. This project shows some example code in the include 
	file, for example how to switch lights on and off or dim
	them, and how to use the feedback from the GBS 
	variables. 
	4. For further documentation on this module, please see
	the wording in the include file. 
*)
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

dTP											= 10007:1:0

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

VOLATILE INTEGER RFID_ALARM;
VOLATILE INTEGER LED_LIGHTS_ON;

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

#INCLUDE 'Green Box Systems Wired Initialisation.AXI'

(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,1,dTP,1)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,2,dTP,2)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,3,dTP,3)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_1,4,dTP,4)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,1,dTP,1)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,2,dTP,2)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,3,dTP,3)
DEFINE_CONNECT_LEVEL (vdvGBS_4_DIMMER_2,4,dTP,4)

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)