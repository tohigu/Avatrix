
class BasicPlayer implements BattleSystemConstants {
	// character name?
	String name;

	// hitpoints
	int hitPoints;
	
	// osc pairing
	String ip;

	// player's weapons
	ArrayList<BasicWeapon> weapons;

	// player can pick 
	BasicWeapon selectedWeapon;

	// the player's opponent
	BasicPlayer opponent;

	// Color
	String mainColor;
	String secondaryColor;
	// mental strength
	float psychi;

	// bonus can be set by doing well on skilltest
	boolean usingSp = false;
	int spCount = 1;

	// store how many skilltest they have won
	int skilltestWins;
	// skilltest float, bonus or nonus
	float skillTestValue;

	//Using Super Power

	/**
	 * Constructor, init weapons
	 */
	public BasicPlayer(){
		weapons = new ArrayList();
		init();
		opponent = null;
		ip = "0";
		psychi = 0.75;
		skillTestValue = 0;
	}


	/**
	 * Function to call at the begining of a match
	 */
	public void init(){
		println( name + "init");
		hitPoints = FULL_HEALTH;
		for(BasicWeapon weapon : weapons) weapon.init();
		selectedWeapon = null;
	}


	/////////////////////////////////////////////////////////////////////////////
	/////////////////////////////PLAYER ACTIONS//////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////


	// public void attackOpponent(int _w){
	// 	// pick weapon
	// 	BasicWeapon _wp = getWeapon(_w);
	// 	if(_wp == null) return;
	// 	_wp.attack(opponent);
	// }

	/**
	 * Here goes the player's special power. Like gain health.
	 * Revive a weapon.
	 * 
	 */
	public boolean specialPower(){
		// if(selectedWeapon == null) return;
		if(spCount > 0){
			usingSp = true;
			println(name+" used SpecialPower");
			spCount--;
			return true;
		}else{
			return false;
		}
	}

	public void receiveAttack(int _damage){
		hitPoints -= constrain(_damage, 0, FULL_HEALTH);
	}

	public void useWeapon(){
		if(getSelectedWeapon() == null) return;
		getSelectedWeapon().use();
	}

	// public void attack(BasicPlayer _p){
	// 	if(getSelectedWeapon() == null) return;
	// 	getSelectedWeapon().attack(_p);
	// }

	/////////////////////////////////////////////////////////////////////////////
	////////////////////////////////WEAPON///////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////


	public void loadWeapon(BasicWeapon _weapon){
		weapons.add(_weapon);
		println(_weapon.name + " loaded for " + name);
	}

	public void selectWeapon(int _i){
		if(_i <= 0 || !getWeapon(_i-1).isUseable()) selectedWeapon = null;
		else selectedWeapon = getWeapon(_i-1);
		if(selectedWeapon == null){
			println("No weapon selected for " + name);
			return;
		}
			println(name + " selects " + selectedWeapon.name);
	}

	public BasicWeapon getWeapon(int _i){
		if(_i >= weapons.size() || _i < 0) return null;
		else return weapons.get(_i);
	}

	public ArrayList<BasicWeapon> getWeapons(){
		return weapons;
	}

	public BasicWeapon getSelectedWeapon(){
		return selectedWeapon;
	}


	/////////////////////////////////////////////////////////////////////////////
	////////////////////////////////MODIFIERS////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////



	public void setOpponent(BasicPlayer _pl){
		opponent = _pl;
	}

	public void setSkill(float _f){
		skillTestValue = _f;
	}

	public void setIPaddr(String _ip){
		 ip = _ip;
		 println( name + " is paired to " + ip );
	}



	/////////////////////////////////////////////////////////////////////////////
	////////////////////////////////ACCESSORS////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////



	public int getDefenseStrength(){
		if(getSelectedWeapon() == null) return 0;
		return getSelectedWeapon().getDefenseStrength();
	}

	public int getAttackStrength(){
		if(getSelectedWeapon() == null) return 0;
		return getSelectedWeapon().getAttackStrength();
	}


	public boolean isAlive(){
		return (hitPoints > 0);
	}

	public boolean isPaired(){
		return ip != "0";
	}

	public int getHitPoints(){
		return hitPoints;
	}

	public float getSkill(){
		return skillTestValue;
	}

	public int getSkilltestWins(){
		return skilltestWins;
	}

	/**
	 * Returns if the weapon's loading process is complete.
	 * @return float a unit interval representing the progress of loading.
	 */
	public float getHealth(){
		return float(getHitPoints())/float(FULL_HEALTH);
	}

	public String getColor(){
		return mainColor;
	}

	public String getName(){
		return name;
	}

	public boolean hasWeapons(){
		boolean out = false;
		for (BasicWeapon weapon : weapons) {
				if (weapon.isUseable()) out = true;

		}
		return out;
	}
}



/////////////////////////////////////////////////////////////////////////////
/////////////////////////////  Characters  //////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

class DefensivePlayer extends BasicPlayer {
	public DefensivePlayer(){
		super();
		name = "Ludic";
		loadWeapon(new Corset());
		loadWeapon(new HeadPiece());
		loadWeapon(new Collar());
		loadWeapon(new Bracelet());
		mainColor = "blue";
		secondaryColor= "white";
	}

	// public void attackOpponent(int _wp){
	// 	super.attackOpponent(_wp);
	// 	// special powers go here
	// }
}


class MajesticPlayer extends BasicPlayer {
	public MajesticPlayer(){
		super();
		name = "Fierce";
		loadWeapon(new ShoulderPad());
		loadWeapon(new SpikeCollar());
		loadWeapon(new Helmet());
		loadWeapon(new Hammer());
		mainColor = "red";
		secondaryColor= "yellow";
	}

}

// a xml loadable player?
// 