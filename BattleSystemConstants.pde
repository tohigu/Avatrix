
/******************************************/
/*										  */
/* A place to store all of our constants! */
/*										  */
/******************************************/

public interface BattleSystemConstants {
	// public final float VERSION = 0.1;

	// public final HashMap<String, Interger> WEAPON_HASHMAP;

	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    GENERAL DATA
	///////
	////////////////////////////////////////////////////////////////////////////////////
	
	// game states
	final int INTRO_STATE = 0;
	final int SETUP_STATE = 1;
	final int SKILL_STATE = 2;
	final int BATTLE_STATE = 3;
	final int GAME_OVER = 4;

	final int UNUSED_POWER = 0;
	final int ACTIVE_POWER = 1;
	final int USED_POWER = 2;

	// XOSC
	final String XOSC_P1_IP = "172.30.130.16";
	final String XOSC_P2_IP = "172.30.130.15";


	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    PLAYER DATA
	///////
	////////////////////////////////////////////////////////////////////////////////////

	// final color[] PLAYER_COLORS = {
	// 	color(233, 45, 12),
	// 	color(22, 233, 12)};
	
	// full health value
	final int FULL_HEALTH = 25;

	//Weapon Colors
	final int WEAPON_FULL_R = 0;
	final int WEAPON_FULL_G = 255;
	final int WEAPON_FULL_B = 127;
	final int WEAPON_USED_R = 255;
	final int WEAPON_USED_G = 0;
	final int WEAPON_USED_B = 255;
	final int WEAPON_EMPTY_R = 255;
	final int WEAPON_EMPTY_G = 0;
	final int WEAPON_EMPTY_B = 0;



	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    WEAPON DATA
	///////
	////////////////////////////////////////////////////////////////////////////////////
	// final String SHOULDERPAD_ICON = "data/graphics/shoulderpad_icon.svg";
	final String SHOULDERPAD_ICON = "data/graphics/placeholder.svg";
	final int SHOULDERPAD_LOADING_TIME = 2000;
	final int SHOULDERPAD_DEFENSE_STRENGTH = 3;
	final int SHOULDERPAD_ATTACK_STRENGTH = 8;
	final int SHOULDERPAD_MAXUSE = 2;

	// final String FOXMASK_ICON = "data/graphics/foxmask_icon.svg";
	final String FOXMASK_ICON = "data/graphics/placeholder.svg";
	final int FOXMASK_LOADING_TIME = 2000;
	final int FOXMASK_DEFENSE_STRENGTH = 10;
	final int FOXMASK_ATTACK_STRENGTH = 7;
	final int FOXMASK_MAXUSE = 2;

	// final String PENDANT_ICON = "data/graphics/pendant_icon.svg";
	final String PENDANT_ICON = "data/graphics/placeholder.svg";
	final int PENDANT_LOADING_TIME = 2000;
	final int PENDANT_DEFENSE_STRENGTH = 7;
	final int PENDANT_ATTACK_STRENGTH = 2;
	final int PENDANT_MAXUSE = 2;

	// final String CLAWS_ICON = "data/graphics/claws_icon.svg";
	final String CLAWS_ICON = "data/graphics/placeholder.svg";
	final int CLAWS_LOADING_TIME = 2000;
	final int CLAWS_DEFENSE_STRENGTH = 4;
	final int CLAWS_ATTACK_STRENGTH = 4;
	final int CLAWS_MAXUSE = 2;
//---------
	// final String RAMHORNS_ICON = "data/graphics/ramhorns_icon.svg";
	final String RAMHORNS_ICON = "data/graphics/placeholder.svg";
	final int RAMHORNS_LOADING_TIME = 2000;
	final int RAMHORNS_DEFENSE_STRENGTH = 4;
	final int RAMHORNS_ATTACK_STRENGTH = 13;
	final int RAMHORNS_MAXUSE = 2;

	// final String TAIL_ICON = "data/graphics/tail_icon.svg";
	final String TAIL_ICON = "data/graphics/placeholder.svg";
	final int TAIL_LOADING_TIME = 2000;
	final int TAIL_DEFENSE_STRENGTH = 2;
	final int TAIL_ATTACK_STRENGTH = 12;
	final int TAIL_MAXUSE = 2;

	// final String COLLAR_ICON = "data/graphics/collar_icon.svg";
	final String COLLAR_ICON = "data/graphics/placeholder.svg";
	final int COLLAR_LOADING_TIME = 2000;
	final int COLLAR_DEFENSE_STRENGTH = 4;
	final int COLLAR_ATTACK_STRENGTH = 11;
	final int COLLAR_MAXUSE = 2;

	// final String CAP_ICON = "data/graphics/cap_icon.svg";
	final String CAP_ICON = "data/graphics/placeholder.svg";
	final int CAP_LOADING_TIME = 2000;
	final int CAP_DEFENSE_STRENGTH = 3;
	final int CAP_ATTACK_STRENGTH = 8;
	final int CAP_MAXUSE = 2;
//-----------------
	// final String WINGS_ICON = "data/graphics/wings_icon.svg";
	final String WINGS_ICON = "data/graphics/placeholder.svg";
	final int WINGS_LOADING_TIME = 2000;
	final int WINGS_DEFENSE_STRENGTH = 4;
	final int WINGS_ATTACK_STRENGTH = 3;
	final int WINGS_MAXUSE = 2;
	
	// final String ANTLERS_ICON = "data/graphics/antlers_icon.svg";
	final String ANTLERS_ICON = "data/graphics/placeholder.svg";
	final int ANTLERS_LOADING_TIME = 2000;
	final int ANTLERS_DEFENSE_STRENGTH = 3;
	final int ANTLERS_ATTACK_STRENGTH = 7;
	final int ANTLERS_MAXUSE = 2;
}
