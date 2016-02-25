import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioSample skillSound, drawSound, endSound; //for triggered sound effects
AudioPlayer skillMusic, battleMusic, endMusic; //for looped background music

void setupSound(){
  minim = new Minim(this);
  //loading sound effects
  skillSound = minim.loadSample("219726__b-lamerichs__11.wav");
  drawSound = minim.loadSample("219729__b-lamerichs__16.wav");
  //battleSound = minim.loadSample("bach.mp3");
  endSound = minim.loadSample("219752__b-lamerichs__22.wav");
  //loading loops
  skillMusic = minim.loadFile("275737__nabz871__gated-fx-120bpm.wav");
  //battleMusic = minim.loadFile("255768__gattoangus__orchestal-music-game.wav");
  battleMusic = minim.loadFile("319232__mooncubedesign__beep-blip-loop.wav");
  endMusic = minim.loadFile("319232__mooncubedesign__beep-blip-loop.wav");
}