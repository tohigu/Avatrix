
class BattleSystem implements BattleSystemConstants {

	// array of players (2)
	BasicPlayer[] players;
	final int PLAYER_COUNT = 2;
	// references of players
	BasicPlayer selectedPlayer;
	BasicPlayer attackingPlayer;
	BasicPlayer defendingPlayer;

	// what state the game is in
	int gameState;

	// the text that will appear on screen, use it to communicate things
	String textConsole = " ";

	// x-osc stuffs
	boolean oscPaired = false;
	final boolean USE_XOSC = true;

	float skillFloat;

	int timer = 0;



	public BattleSystem() {
		initPlayers();
		gameState = SETUP_STATE;//INTRO_STATE;// BATTLE_STATE;
	}

	private void initPlayers() {
		players    = new BasicPlayer[PLAYER_COUNT];
		players[0] = new DefensivePlayer();
		players[1] = new MajesticPlayer();
		players[0].setOpponent(players[1]);
		players[1].setOpponent(players[0]);
	}

	public void update() {
		switch (gameState) {
		case INTRO_STATE:
			intro();
			break;
		case SETUP_STATE:
			setup();
			break;
		case SKILL_STATE:
			skillTest();
			break;
		case BATTLE_STATE:
			battle();
			break;		
		case GAME_OVER:
			gameOver();
			break;
		}

	}


	/////////////////////////////////////////////////////////////
	//////  Game states
	/////////////////////////////////////////////////////////////

	private void intro() {
		textConsole = "Press ENTER to start skilltest";
		if (key == ENTER) startSkillTest();
	}

	private void setup() {
		if (!pairXOSC() && USE_XOSC) {
			pairXOSC();
		} else {
			gameState = INTRO_STATE;
		};
	}


	private boolean pairXOSC() {
		players[0].setIPaddr(XOSC_P1_IP);
		players[1].setIPaddr(XOSC_P2_IP);


		if (!players[0].isPaired()) {
			selectedPlayer = players[0];
			textConsole = "Pair XOSC for player 0";
			return false;
		} else if (!players[1].isPaired()) {
			selectedPlayer = players[1];
			textConsole = "Pair XOSC for player 1";
			return false;
		} else {
			textConsole = "Players paired!";
			oscPaired = true;
			return true;
		}
	}


	private void startSkillTest() {
		skillFloat = 1.0;
		gameState = SKILL_STATE;
		players[0].setSkill(0.0);
		players[1].setSkill(0.0);
	}

	private void skillTest() {
		// set attackingPlayer
		skillFloat -= 0.01;

		if (skillFloat <= 0.0) startBattle();
	}

	private void startBattle() {
		delay(1000);

		if (players[0].getSkill() < players[1].getSkill()) {
			attackingPlayer = players[1];
			defendingPlayer = players[0];
		} else {
			attackingPlayer = players[0];
			defendingPlayer = players[1];
		}
		players[0].selectWeapon(-1);
		players[1].selectWeapon(-1);
		gameState = BATTLE_STATE;
		timer = 30*8;
		textConsole = attackingPlayer.getName() + "  is attacking  " + defendingPlayer.getName() + "\nPick your Weapons!";
	}


	private void battle() {
		if (timer > 0) {
			timer--;
			return;
		}

		// if (players[0].getSelectedWeapon() == null || players[1].getSelectedWeapon() == null) {
		// 	return;
		// }

		/////
		//
		// Damage calculation based on attack power defense power and special powers active
		//
		/////

		int p1WpCount = players[0].weapons.size();
		int p2WpCount = players[1].weapons.size();
		ArrayList<Integer> checkedwp1 = new ArrayList<Integer>();
		ArrayList<Integer> checkedwp2 = new ArrayList<Integer>();
		boolean roundEndsGame = false;

		if(players[0].getSelectedWeapon() == null || players[1].getSelectedWeapon() == null){
			if (players[0].getSelectedWeapon() == null) {
				while(players[0].getSelectedWeapon() == null){
					int rndWpId = int(random(p1WpCount));
					if(! checkedwp1.contains(rndWpId) && players[0].weapons.get(rndWpId).isUseable()){
						players[0].selectWeapon(rndWpId+1);
					}else{
						checkedwp1.add(rndWpId);
					}
				}
			} else if (players[1].getSelectedWeapon() == null){
				while(players[1].getSelectedWeapon() == null){
					int rndWpId = int(random(p2WpCount));
					if(! checkedwp2.contains(rndWpId) && players[1].weapons.get(rndWpId).isUseable()){
						players[1].selectWeapon(rndWpId+1);
					}else{
						checkedwp2.add(rndWpId);
					}
				}
			}
		}

		//Calculate damage based on super powers
		//Basic Damage Calculation
		int dammage = attackingPlayer.getAttackStrength();
		int defense = defendingPlayer.getDefenseStrength();
		players[0].useWeapon();
		players[1].useWeapon();
		boolean switchPlayers = false;

		if(attackingPlayer.usingSp){
			//Apply sP on priority
			switch (attackingPlayer.name) {
				case "Fierce" :
					 dammage += 4;
					 println("-->Fierce Attack Power!");
				break;
				case "Ludic" :
					 switchPlayers = true;
					 println("-->Mirror Attack Power!");
				break;		
				default:
				break;
			}
			attackingPlayer.usingSp = false;
		}else if (defendingPlayer.usingSp){
			//Apply sP on priority
			switch (defendingPlayer.name) {
				case "Fierce" :
					 println("-->Fierce Attack Missed!");
				break;
				case "Ludic" :
					 switchPlayers = true;
					 println("-->Mirror Attack Power!");
				break;		
				default:
				break;
			}
			defendingPlayer.usingSp = false;
		}
		if(switchPlayers) attackingPlayer.receiveAttack(dammage - defense);
		else defendingPlayer.receiveAttack(dammage - defense);
		println("Dammage = " + dammage + "    Defense = " + defense);
		// unselect weapons
		players[0].selectWeapon(-1);
		players[1].selectWeapon(-1);

		//Check if there are still more weapons to use
		for (BasicPlayer player : players) {
			if(!player.hasWeapons()) roundEndsGame = true;
		}

		if(!attackingPlayer.isAlive() || !defendingPlayer.isAlive() || roundEndsGame){
			// Game Over
			gameState = GAME_OVER;
		}else{
			// Go to next state
			gameState = INTRO_STATE;
		}
	}

	public void gameOver(){
		textConsole = "Game Over\n";
		if(players[0].hitPoints > players[1].hitPoints){
			textConsole += players[0].name + " defeats " + players[1].name + "!\n";
		}else if(players[0].hitPoints == players[1].hitPoints){
			textConsole += "It's a Draw!\n";
		}else{
			textConsole += players[1].name + " defeats " + players[0].name + "!\n";
		}
		textConsole += "Press ENTER to restart.\n";
		if (key == ENTER) {
			for (BasicPlayer player : players) {
				player.init();
			}
			startSkillTest();
		}

	}

	/////////////////////////////////////////////////////////////
	//////  Player input
	/////////////////////////////////////////////////////////////

	/**
	 * Simple input system
	 * @param player number
	 * @param button number
	 */
	public void playerInput(int _p, int _i) {
		BasicPlayer _player = getPlayer(_p);
		if (_player == null) {
			println("Error: Player not found!");
			return;
		}
		else if (gameState == BATTLE_STATE) {
			if (_i == 5) {
				_player.specialPower();
			}
			else {
				_player.selectWeapon(_i);
			}
		} else if (gameState == SKILL_STATE) {
			_player.setSkill(_player.getSkill()+0.01);
		}else if(gameState == INTRO_STATE){
			startSkillTest();
		}
		println("Got input " + _i + " from Player " + _player.name);
	}

	public void oscInput(OscMessage _mess) {
		//println("OSC message " + _mess.addrPattern() + " From " + _mess.netAddress().address());
		// if in paring mode
		//println(_mess.addrPattern() == "/ping");
		if (!oscPaired && _mess.checkAddrPattern("/ping")) {
			selectedPlayer.setIPaddr(_mess.netAddress().address());
		}else if(int(_mess.get(0).floatValue())==1){
			if(_mess.checkAddrPattern("/Player1/1")){
				battleSystem.playerInput(0,1);
			}else if(_mess.checkAddrPattern("/Player1/2")){
				battleSystem.playerInput(0,2);
			}else if(_mess.checkAddrPattern("/Player1/3")){
				battleSystem.playerInput(0,3);
			}else if(_mess.checkAddrPattern("/Player1/4")){
				battleSystem.playerInput(0,4);
			}else if(_mess.checkAddrPattern("/Player1/5")){
				battleSystem.playerInput(0,5);
			}else if(_mess.checkAddrPattern("/Player2/1")){
				battleSystem.playerInput(1,1);
			}else if(_mess.checkAddrPattern("/Player2/2")){
				battleSystem.playerInput(1,2);
			}else if(_mess.checkAddrPattern("/Player2/3")){
				battleSystem.playerInput(1,3);
			}else if(_mess.checkAddrPattern("/Player2/4")){
				battleSystem.playerInput(1,4);
			}else if(_mess.checkAddrPattern("/Player2/5")){
				battleSystem.playerInput(1,5);
			}
		}
		
	}

	/////////////////////////////////////////////////////////////
	//////  Accessors
	/////////////////////////////////////////////////////////////

	public float getSkillFloat() {
		return skillFloat;
	}

	public BasicPlayer getPlayer(int _p) {
		if (_p >= PLAYER_COUNT && _p < 0) return null;
		else return players[_p];
	}

	public String getText() {
		return textConsole;
	}

	public int getState() {
		return gameState;
	}
}