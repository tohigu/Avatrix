class OSCView extends BasicView {


	public OSCView() {
		LEDsetup();

	}

	public void display(BasicPlayer[] _players) {

		switch (battleSystem.gameState) {
		case SKILL_STATE :
			for (BasicPlayer player : _players) {
				for (BasicWeapon weapon : player.weapons) {
					patterns.get("fadeInOut").c1 = colors.get(player.mainColor);
					patterns.get("fadeInOut").doPattern(weapon.ledCount,player,weapon);
				}
			}
			break;
		case BATTLE_STATE:
			for (BasicPlayer player : _players) {
				for (BasicWeapon weapon : player.weapons) {
					switch (weapon.useCount) {
					case 2:
					patterns.get("fadeInOut").c1 = colors.get("red");
					patterns.get("fadeInOut").c2 = colors.get(player.mainColor);
					patterns.get("fadeInOut").doPattern(weapon.ledCount,player,weapon);	
					break;
					case 1:
					patterns.get("fadeInOut").c1 = colors.get("orange");
					patterns.get("fadeInOut").c2 = colors.get(player.mainColor);
					patterns.get("fadeInOut").doPattern(weapon.ledCount,player,weapon);	
					break;
					case 0:
					patterns.get("fadeInOut").c1 = colors.get("green");
					patterns.get("fadeInOut").c2 = colors.get(player.mainColor);
					patterns.get("fadeInOut").doPattern(weapon.ledCount,player,weapon);	
						break;
					}
					
				}
			}
			break;
		}
	}
}