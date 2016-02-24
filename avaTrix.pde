
/**
 * Multiplayer battle system
 */

import oscP5.*;
import netP5.*;
OscP5 oscP5;


BattleSystem battleSystem;
GUIView gui;
OSCView oscController;

// set if the sketch is fullscreen by default
//boolean fullscreen = true;
boolean fullscreen = false;

// default window size if not fullscreen
int xres = 1024;
int yres = 768;

// a few options
final boolean USE_KEYBOARD = true;

void setup() {
  // if(!fullscreen) size(xres, yres);
  // else size(displayWidth, displayHeight);
  // noCursor();
  frameRate(30);

  size(1024, 768);

  battleSystem = new BattleSystem();
  gui          = new GUIView();
  gui.injectBattleSystem(battleSystem);
  oscController = new OSCView();
  oscController.injectBattleSystem(battleSystem);


  // init all the network stuff
  initOSC();
}

// lets processing know if we want it fullscreen
// boolean sketchFullScreen() {
//   return fullscreen;
// }

void draw() {
  background(0);
  battleSystem.update();
  gui.display();
  oscController.display(battleSystem.players);
  image(gui.getCanvas(), 0, 0);
}

/////////////////////////////////////////////////////////////
//////  Input Section
/////////////////////////////////////////////////////////////

void keyPressed() {
  if (USE_KEYBOARD) keyboardEvent();
}

void keyboardEvent() {
  if      (key == 'q') battleSystem.playerInput(0, 1);
  else if (key == 'w') battleSystem.playerInput(0, 2);
  else if (key == 'e') battleSystem.playerInput(0, 3);
  else if (key == 'r') battleSystem.playerInput(0, 4);
  else if (key == 't') battleSystem.playerInput(0, 5);

  else if (key == 'z') battleSystem.playerInput(1, 1);
  else if (key == 'x') battleSystem.playerInput(1, 2);
  else if (key == 'c') battleSystem.playerInput(1, 3);
  else if (key == 'v') battleSystem.playerInput(1, 4);
  else if (key == 'b') battleSystem.playerInput(1, 5);
}

/////////////////////////////////////////////////////////////
//////  x-OSC Section
/////////////////////////////////////////////////////////////


void initOSC() {
    oscP5 = new OscP5(this, 8000);
}

void oscEvent(OscMessage _message) {
  battleSystem.oscInput(_message);
}