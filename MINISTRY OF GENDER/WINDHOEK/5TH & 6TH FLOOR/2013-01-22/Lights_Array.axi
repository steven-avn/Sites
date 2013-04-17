PROGRAM_NAME='Lights_Array'

(*** IMPORTANT NOTE: All Main House phantoms were assigned to RF link 1:8:2? ***)

DEFINE_CONSTANT
TL_LUTRON_FEEDBACK = 30 //note that every timeline must have a unique identifier

DEFINE_VARIABLE

LONG tlLutronFeedbackRate[]={500} //5/10 second

//Store info for RF link phantoms on 1:8:2?
VOLATILE INTEGER nHWI_BUTTONS[32][15]
VOLATILE CHAR sHWI_KP[32]	//32 keypads - Max 32 per link
VOLATILE CHAR sHWI_BUT[15]	//15 buttons - Max 24 per keypad

(***********************************************************)
(*          STARTUP CODE GOES BELOW             *)
(***********************************************************)
DEFINE_START
timeline_create(TL_LUTRON_FEEDBACK, tlLutronFeedbackRate, 1, TIMELINE_RELATIVE, TIMELINE_REPEAT)

DEFINE_EVENT
//String From the Lighting System?
DATA_EVENT[vdvHWI]
{
    STRING:
    {        
        IF(data.text == 'N:1')
        {
	    STACK_VAR INTEGER i
	    
	    //Keypads to monitor on Physical link 1:8:2:i	    
	    FOR (i = 5; i < 33; i++) //Note: Reduce number if not using all ??? 6/14/07
	    {
		SEND_COMMAND vdvHWI, "'N:K:[1:8:2:',ITOA(i),']', 13, 10"
	    }
	}
    }
}

(*
	    //Track these Keypads
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:5]'	//Front Entry
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:6]'	//Foyer
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:7]'	//Gallery
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:8]'	//Living Room
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:9]'	//Wet Bar 
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:10]'	//Wine Room
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:11]'	//Dining
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:12]'	//Kitchen
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:13]'	//Breakfast
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:14]'	//Family
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:15]'	//Luandry
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:16]'	//Gym
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:17]'	//Powder Bath 1 / Powder Bath 2
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:18]'	//Garage 1/Workshop/Bath
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:19]'	//Family Patio / Bar Patio / Living Patio
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:20]'	//Garage 2
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:21]'	//Kachina Room
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:22]'	//North Gallery / South Gallery /Master Toilet
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:23]'	//Office
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:24]'	//Master Bed
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:25]'	//Master BAth / Master Closet
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:26]'	//Stairs / Stairs Landing / Upstairs Hall
            SEND_COMMAND vdvHWI, 'N:K:[1:8:2:27]'	//Bed 2 / Bed 3 / Bed 4
	    
	    //Shades: Dining Slider, Dining Windows, Family East, Family South, 
	    //Gym 1, Gym 2 and Kitchen
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:28]'
	    
	    //Shades: Library Slider, Library Slider Sides, Living Sides, Living Door, 
	    //Master Bed Corner/Sliders, Master Bed Slider Sides, Master Bed South/East,
	    //and Master Bed West Corner
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:29]'
	    
	    //Shades: Breakfast Nook Sides, Breakfast Nook Door, South Gallery,
	    //West House Shades, All House Shades
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:30]'
	                                     
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:31]'	//Reserved Future	
	    SEND_COMMAND vdvHWI, 'N:K:[1:8:2:32]'	//Global All	    
*)

DATA_EVENT[vdvHWI]
{
    STRING:
    {
	//Process RF link 1:8:2:? LEDs
	IF (FIND_STRING(DATA.TEXT, "'K:L:[1:8:2:'", 1))
	{
	    REMOVE_STRING(DATA.TEXT, '[1:8:2:', 1)
	    sHWI_KP = REMOVE_STRING(DATA.TEXT, ']:',1)
	    SET_LENGTH_STRING(sHWI_KP, LENGTH_STRING(sHWI_KP)-2)
	    sHWI_BUT = REMOVE_STRING(DATA.TEXT, ':',1)
	    SET_LENGTH_STRING(sHWI_BUT, LENGTH_STRING(sHWI_BUT)-1)
	    nHWI_BUTTONS[ATOI(sHWI_KP)] [ATOI(sHWI_BUT)] = ATOI(DATA.TEXT)
	}
    }
}

TIMELINE_EVENT[TL_LUTRON_FEEDBACK]
{
    //LIGTHS FEEDBACK FOR ROOMS (Monitoring OFF State = 1)
    [vTP_LUTRON, 501] = (nHWI_BUTTONS[5][2] == 1)	//Front Entry
    [vTP_LUTRON, 502] = (nHWI_BUTTONS[6][2] == 1)	//Foyer
    [vTP_LUTRON, 503] = (nHWI_BUTTONS[7][2] == 1)	//Gallery
    [vTP_LUTRON, 504] = (nHWI_BUTTONS[8][2] == 1)	//Living Room
    [vTP_LUTRON, 505] = (nHWI_BUTTONS[9][2] == 1)	//Wet Bar 
    [vTP_LUTRON, 506] = (nHWI_BUTTONS[10][2] == 1)	//Wine Room
    [vTP_LUTRON, 507] = (nHWI_BUTTONS[11][2] == 1)	//Dining Room
    [vTP_LUTRON, 508] = (nHWI_BUTTONS[12][2] == 1)	//Kitchen
    [vTP_LUTRON, 509] = (nHWI_BUTTONS[13][2] == 1)	//Breakfast Nook
    [vTP_LUTRON, 510] = (nHWI_BUTTONS[14][2] == 1)	//Family Room
    [vTP_LUTRON, 511] = (nHWI_BUTTONS[15][2] == 1)	//Laundry
    [vTP_LUTRON, 512] = (nHWI_BUTTONS[16][2] == 1)	//Gym
    [vTP_LUTRON, 513] = (nHWI_BUTTONS[17][2] == 1)	//Powder Bath 1
    [vTP_LUTRON, 514] = (nHWI_BUTTONS[17][7] == 1)	//Powder Bath 2
    [vTP_LUTRON, 515] = (nHWI_BUTTONS[18][2] == 1)	//Garage 1
    [vTP_LUTRON, 516] = (nHWI_BUTTONS[18][5] == 1)	//Workshop
    [vTP_LUTRON, 517] = (nHWI_BUTTONS[20][2] == 1)	//Garage 2
    [vTP_LUTRON, 518] = (nHWI_BUTTONS[21][2] == 1)	//Kachina Room
    [vTP_LUTRON, 519] = (nHWI_BUTTONS[22][2] == 1)	//North Gallery
    [vTP_LUTRON, 520] = (nHWI_BUTTONS[22][7] == 1)	//South Gallery
    [vTP_LUTRON, 521] = (nHWI_BUTTONS[23][2] == 1)	//Office
    [vTP_LUTRON, 522] = (nHWI_BUTTONS[24][2] == 1)	//Master Bed
    [vTP_LUTRON, 523] = (nHWI_BUTTONS[25][2] == 1)	//Master Bath
    [vTP_LUTRON, 524] = (nHWI_BUTTONS[25][7] == 1)	//His Closet
    [vTP_LUTRON, 525] = (nHWI_BUTTONS[25][12] == 1)	//Her Closet
    [vTP_LUTRON, 526] = (nHWI_BUTTONS[26][2] == 1)	//Stairs
    [vTP_LUTRON, 527] = (nHWI_BUTTONS[26][7] == 1)	//Stairs Landing
    [vTP_LUTRON, 528] = (nHWI_BUTTONS[26][12] == 1)	//Upstairs Hall
    [vTP_LUTRON, 529] = (nHWI_BUTTONS[27][2] == 1)	//Bed2
    [vTP_LUTRON, 530] = (nHWI_BUTTONS[27][7] == 1)	//Bed3
    [vTP_LUTRON, 531] = (nHWI_BUTTONS[27][12] == 1)	//Bed4
    [vTP_LUTRON, 532] = (nHWI_BUTTONS[18][8] == 1)	//Garage Bath
    [vTP_LUTRON, 533] = (nHWI_BUTTONS[32][12] == 1)	//Landscape
    [vTP_LUTRON, 534] = (nHWI_BUTTONS[32][13] == 1)	//Waterfall
    [vTP_LUTRON, 535] = (nHWI_BUTTONS[19][2] == 1)	//Family Patio
    [vTP_LUTRON, 536] = (nHWI_BUTTONS[19][7] == 1)	//Bar Patio
    [vTP_LUTRON, 537] = (nHWI_BUTTONS[19][12] == 1)	//Living Patio
    [vTP_LUTRON, 538] = (nHWI_BUTTONS[22][12] == 1)	//Master Toilet
    [vTP_LUTRON, 539] = (nHWI_BUTTONS[5][7] == 1)	//Exterior Lights

    //SHADES FEEDBACK FOR ROOMS (Monitoring DOWN State = 1)
    [vTP_LUTRON, 641] = (nHWI_BUTTONS[28][2] == 1)	//Dining Slider
    [vTP_LUTRON, 642] = (nHWI_BUTTONS[28][4] == 1)	//Dining Windows
    [vTP_LUTRON, 643] = (nHWI_BUTTONS[28][6] == 1)	//Family East
    [vTP_LUTRON, 644] = (nHWI_BUTTONS[28][8] == 1)	//Family South
    [vTP_LUTRON, 645] = (nHWI_BUTTONS[28][10] == 1)	//Gym 1
    [vTP_LUTRON, 646] = (nHWI_BUTTONS[28][12] == 1)	//Gym 2
    [vTP_LUTRON, 647] = (nHWI_BUTTONS[28][14] == 1)	//Kitchen
    
    [vTP_LUTRON, 648] = (nHWI_BUTTONS[29][2] == 1)	//Library Slider
    [vTP_LUTRON, 649] = (nHWI_BUTTONS[29][4] == 1)	//Library Slider Sides
    [vTP_LUTRON, 650] = (nHWI_BUTTONS[29][6] == 1)	//Living Sides
    [vTP_LUTRON, 651] = (nHWI_BUTTONS[29][8] == 1)	//Living Door
    [vTP_LUTRON, 652] = (nHWI_BUTTONS[29][10] == 1)	//Mst Bed Corners/Sliders
    [vTP_LUTRON, 653] = (nHWI_BUTTONS[29][12] == 1)	//Mst Bed Slider Sides
    [vTP_LUTRON, 654] = (nHWI_BUTTONS[29][14] == 1)	//Mst Bed South/East
    
    [vTP_LUTRON, 655] = (nHWI_BUTTONS[30][2] == 1)	//Mst bed West Corner
    [vTP_LUTRON, 656] = (nHWI_BUTTONS[30][4] == 1)	//Breakfast Nook Sides
    [vTP_LUTRON, 657] = (nHWI_BUTTONS[30][6] == 1)	//Breakfast Nook Door
    [vTP_LUTRON, 658] = (nHWI_BUTTONS[30][8] == 1)	//South Gallery
    [vTP_LUTRON, 659] = (nHWI_BUTTONS[30][10] == 1)	//West House Shades
    [vTP_LUTRON, 660] = (nHWI_BUTTONS[30][12] == 1)	//All House Shades
    [vTP_LUTRON, 661] = (nHWI_BUTTONS[30][14] == 1)	//Master Bath Out Shades
}
 

             
            
            