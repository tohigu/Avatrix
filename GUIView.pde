
class GUIView extends BasicView {

	PGraphics canvas;

	/******** GENERAL ********/
	final PFont BIG_FONT;
	final PFont SMALL_FONT;
	final int BIG_FONT_SIZE = 48;
	final int SMALL_FONT_SIZE = 24;

	final int EDGE_PADDING = 52;
	final int ICON_SIZE = 64;

	/******** PLAYERS ********/
	final color[] playerColors = {
		color(218, 100, 247),
		color(200, 255, 91)};

	/******** WEAPONS ********/
	final color LOADED_COLOR = color(0, 200, 0);
	final color LOADING_COLOR = color(255, 50, 0);
	final color UNAVAILABLE_COLOR = color(100,100,100);
	final int WEAPON_ICON_SIZE = 64;
	final int WEAPON_COUNT = 10;
	
	PShape[] weaponIcons;

	String[] console;


	public GUIView(){
		// init the canvas on which to draw
		canvas = createGraphics(width, height);
		BIG_FONT = loadFont("8-bitLimitRBRK-48.vlw");
		SMALL_FONT = loadFont("AlphaBetaBRK-48.vlw");

		// init the players
		initPlayers();
		// load svg icons of weapons
		//loadWeaponIcons();
		console = new String[3];
	}

	public void injectBattleSystem(BattleSystem _bs){
		battleSystem = _bs;
	}

	public void display(){
		canvas.beginDraw();
		canvas.clear();

		displayGUI();

		canvas.pushMatrix();
		canvas.translate(EDGE_PADDING*2, EDGE_PADDING * 4);
		displayPlayer(battleSystem.getPlayer(0));
		canvas.popMatrix();

		canvas.pushMatrix();
		canvas.translate(width-100, EDGE_PADDING * 4);
		displayPlayer(battleSystem.getPlayer(1));
		canvas.popMatrix();
		
		canvas.endDraw();
	}


	public void displayGUI(){
		title();
		console();

		if(battleSystem.getState() == SKILL_STATE) skillBar();
		if(battleSystem.getState() == BATTLE_STATE) timer();

	}

	private void skillBar(){
		int SKILL_BAR_WIDTH = 30;
		int SKILL_BAR_HEIGHT = 300;
		canvas.pushStyle();
		canvas.pushMatrix();
		canvas.translate(width/2,height/2);
		canvas.noFill();
		canvas.rectMode(CENTER);
		canvas.strokeWeight(3);
		canvas.stroke(100,0,0);
		canvas.rect(0,0, SKILL_BAR_WIDTH, SKILL_BAR_HEIGHT);
		canvas.noStroke();
		canvas.fill(0,0,200);
		canvas.rect(0,0, SKILL_BAR_WIDTH, SKILL_BAR_HEIGHT * battleSystem.getSkillFloat());
		canvas.popMatrix();
		canvas.popStyle();
	}


	private void title(){
		canvas.stroke(255);
		canvas.fill(255);
		canvas.textAlign(CENTER);
		canvas.textFont(BIG_FONT);
		canvas.textSize(BIG_FONT_SIZE);
		canvas.text("!-BattleSystem-!", width/2 , BIG_FONT_SIZE + EDGE_PADDING);
	}

	private void console(){
		canvas.stroke(255);
		canvas.fill(255);
		canvas.textAlign(CENTER);
		canvas.textFont(SMALL_FONT);
		canvas.textSize(SMALL_FONT_SIZE);
		canvas.text(battleSystem.getText(), width/2 , height - EDGE_PADDING);
	}

	private void timer(){
		canvas.stroke(255);
		canvas.fill(255);
		canvas.textAlign(CENTER);
		canvas.textFont(SMALL_FONT);
		canvas.textSize(SMALL_FONT_SIZE);
		canvas.text(battleSystem.timer, width/2 , height/2);
	}


	public void displayPlayer(BasicPlayer _player){
		canvas.pushMatrix();
		canvas.pushStyle();
		
		canvas.textFont(SMALL_FONT);
		canvas.textSize(SMALL_FONT_SIZE);
		canvas.fill(255);
		canvas.text(_player.getName(), 0,0);
		// canvas.fill(_player.getColor());
		canvas.translate(0,BIG_FONT_SIZE);
		canvas.text(str(_player.getHitPoints())+" HP", 0,0);
		canvas.translate(0,BIG_FONT_SIZE);

		ArrayList<BasicWeapon> _weapons = _player.getWeapons();
		for(BasicWeapon _w : _weapons){

			displayWeapon(_w, _player.getSelectedWeapon() == _w);
			canvas.translate(0, ICON_SIZE);
		}

		canvas.popStyle();
		canvas.popMatrix();
	}

	public void displayWeapon(BasicWeapon _weapon, boolean _sel){
		// drawLoading
		canvas.noStroke();
		if(!_weapon.isUseable()) canvas.fill(UNAVAILABLE_COLOR);
		else if(!_weapon.isLoaded()) canvas.fill(LOADING_COLOR);
		else canvas.fill(LOADED_COLOR);
		canvas.rect(-ICON_SIZE/2, -ICON_SIZE/2, ICON_SIZE, (float)ICON_SIZE * _weapon.getLoadingProgress());
		canvas.noFill();
		canvas.strokeWeight(4);
		canvas.stroke(_sel ? color(100,10, 50) : color(100,0, 50));
		canvas.rect(-ICON_SIZE/2, -ICON_SIZE/2, ICON_SIZE, ICON_SIZE);
		canvas.shape(_weapon.getIcon(), -ICON_SIZE/2, -ICON_SIZE/2);
		canvas.textFont(SMALL_FONT);
		canvas.textSize(SMALL_FONT_SIZE);
		canvas.fill(255);
		canvas.text("A "+_weapon.getAttackStrength(), 60, 0);
		canvas.text("D "+_weapon.getDefenseStrength(), 60, 20);
	}

	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    GUI Utils
	///////
	////////////////////////////////////////////////////////////////////////////////////

	private void progressBar(int _width, int _height, float _value){
		pushStyle();
		//rect(0,0);
	}

	public PGraphics getCanvas(){
		return canvas;
	}

	////////////////////////////////////////////////////////////////////////////////////
	///////
	///////    Initialisations
	///////
	////////////////////////////////////////////////////////////////////////////////////

	private void initPlayers(){

	}

	// private void loadWeaponIcons(){
	// 	weaponIcons = new PShape[WEAPON_COUNT];
	// 	weaponIcons[0] = loadShape("data/graphics/shoulderpad_icon.svg");
	// 	weaponIcons[1] = loadShape("data/graphics/foxmask_icon.svg");
	// 	weaponIcons[2] = loadShape("data/graphics/pendant_icon.svg");
	// 	weaponIcons[3] = loadShape("data/graphics/claws_icon.svg");
	// 	weaponIcons[4] = loadShape("data/graphics/ramhorns_icon.svg");
	// 	weaponIcons[5] = loadShape("data/graphics/tail_icon.svg");
	// 	weaponIcons[6] = loadShape("data/graphics/collar_icon.svg");
	// 	weaponIcons[7] = loadShape("data/graphics/cap_icon.svg");
	// 	weaponIcons[8] = loadShape("data/graphics/wings_icon.svg");
	// 	weaponIcons[9] = loadShape("data/graphics/antlers_icon.svg");

	// 	for(int i = 0; i < WEAPON_COUNT; i++){
	// 		weaponIcons[i].disableStyle();
	// 	}
	// }

}





class WeaponView {
	public WeaponView(){}

	public void displayWeapon(BasicWeapon _bw){

	}
}


// This class displays a weapon icon on screen with various information
class GUIWeaponView extends WeaponView{
	final color LOADED_COLOR = color(0, 255, 0);
	final color LOADING_COLOR = color(255, 255, 0);
	final color UNAVAILABLE_COLOR = color(100,100,100);
	final int ICON_SIZE = 64;

	
	final int WEAPON_COUNT = 10;
	PShape[] weaponIcons;

	public GUIWeaponView(){
		super();
		loadIcons();
	}

	// takes a PGraphics
	public void display(PGraphics _pg, PVector _loc, BasicWeapon _wp){

	}

	private void loadIcons(){
		weaponIcons = new PShape[WEAPON_COUNT];
		weaponIcons[0] = loadShape("/data/graphics/shoulderpad_icon.svg");
		weaponIcons[1] = loadShape("/data/graphics/foxmask_icon.svg");
		weaponIcons[2] = loadShape("/data/graphics/pendant_icon.svg");
		weaponIcons[3] = loadShape("/data/graphics/claws_icon.svg");
		weaponIcons[4] = loadShape("/data/graphics/ramhorns_icon.svg");
		weaponIcons[5] = loadShape("/data/graphics/tail_icon.svg");
		weaponIcons[6] = loadShape("/data/graphics/collar_icon.svg");
		weaponIcons[7] = loadShape("/data/graphics/cap_icon.svg");
		weaponIcons[8] = loadShape("/data/graphics/wings_icon.svg");
		weaponIcons[9] = loadShape("/data/graphics/antlers_icon.svg");

		for(int i = 0; i < WEAPON_COUNT; i++){
			weaponIcons[i].disableStyle();
		}
	}
}

