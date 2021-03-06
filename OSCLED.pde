
HashMap<String, gameColor> colors = new HashMap<String, gameColor>();
HashMap<String, pattern> patterns = new HashMap<String, pattern>();

//////////////////////SET UP//////////////////////////////
void LEDsetup() {
  ///setting up names for hashmap and making objects :D
  colors.put("white", new gameColor(255, 255, 255));
  colors.put("yellow", new gameColor(255, 255, 0));
  colors.put("red", new gameColor(255, 0, 0));
  colors.put("orange", new gameColor(255, 140, 0));
  colors.put("blue", new gameColor(0, 0, 255));
  colors.put("cyan", new gameColor(0, 255, 255));
  colors.put("pink", new gameColor(255, 0, 255));
  colors.put("purple", new gameColor(138, 43, 255));
  colors.put("green", new gameColor(0, 255, 0));
  colors.put("aqua", new gameColor(102, 205, 170));

  patterns.put("solid", new solid());
  patterns.put("fire", new fire());
  patterns.put("flash", new flash());
  patterns.put("fadeIn", new fadeIn());
  patterns.put("fadeInOut", new fadeInOut());
  patterns.put("fadeInOutEven", new fadeInOutEven());
  patterns.put("fadeInOutString", new fadeInOutString());
  patterns.put("flameString", new flameString());
  patterns.put("knight", new knight());
}

//////////////////////////CLASSES/////////////////////////////////////

class gameColor {
  int R, G, B;
  gameColor (int r, int g, int b) {
    R = r;
    G = g;
    B = b;
  }
}

//This is the parent class called pattern
class pattern {
  gameColor c1;
  gameColor c2;

  byte[] outputBlob = new byte [100 * 3];
  int outputLitLEDNum = 0; //put the number of neopixels

  pattern() {
  }

  void outputWipe() { // wipes the LEDs, this function is inherited by all the kids
    for (int i = 0; i < outputBlob.length; i++) {
      outputBlob[i] = byte(0);
    }
  }
  void outputShow(BasicPlayer _pl, BasicWeapon _wp) {// send the blob out to xOSC, this function is inherited by all the kids
    OscMessage myMessage = new OscMessage("/outputs/rgb/" + _wp.address); //address pattern
    myMessage.add(outputBlob); //puts blob into message
    NetAddress myRemoteLocation = new NetAddress(_pl.ip, 9000);
    //println(' myMessage: '+myMessage); //FOR DEBUG
    oscP5.send(myMessage, myRemoteLocation);
  }
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {   //this one is emtpy cause the kids will fill it in

  }
}

///////////////////////////////////////////////////////////////

class solid extends pattern {
  solid() {
  }

  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    outputWipe();
    for (int i = 0; i < levels * 3; i = i + 3) {
      outputBlob[i] = byte(c1.R);
      outputBlob[i + 1] = byte(c1.G);
      outputBlob[i + 2] = byte(c1.B);
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

class flash extends pattern {
  //
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {

    outputWipe();
    for (int i = 0; i < int(levels / 2); i++) {
      int ranLevel = int(random(levels));
      outputBlob[(ranLevel * 3)] = byte(c1.R);
      outputBlob[(ranLevel * 3) + 1] = byte(c1.G);
      outputBlob[(ranLevel * 3) + 2] = byte(c1.B);
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

class fadeIn extends pattern {
  double intensity = 0.0;
  //
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    // intensity = intensity >= 1.0 ? 0.0 : intensity + 0.01;
    intensity += 0.01;
    if (intensity >= 1.0) intensity = 0.0;
    outputWipe();
    for (int i = 0; i < levels * 3; i = i + 3) {
      outputBlob[i] = byte((int)(c1.R * intensity));
      outputBlob[i + 1] = byte((int)(c1.G * intensity));
      outputBlob[i + 2] = byte((int)(c1.B * intensity));
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

public class fire extends pattern {
  pattern flame =  new solid();
  pattern flicker = new flash();
  int counter = 0;
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    counter += 1;
    if ((counter / 2) % 2 == 0) {
      flame.c1 = c1;
      flame.doPattern(levels, _player, _weapon); //runs super class which is solidPattern
    } else {
      flicker.c1 = c2;
      flicker.doPattern(levels, _player, _weapon);
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

public class fadeInOut extends pattern {
  double intensity = 0.0;
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    intensity = (sin(frameCount * .2) + 1 ) / 2.0;
    outputWipe();
    for (int i = 0; i < levels * 3; i = i + 3) {
      outputBlob[i] = byte((int)(c1.R * intensity));
      outputBlob[i + 1] = byte((int)(c1.G * intensity));
      outputBlob[i + 2] = byte((int)(c1.B * intensity));
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

public class fadeInOutEven extends pattern {
  double intensity = 0.0;
  //
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    intensity = (sin(frameCount * .2) + 1 ) / 2.0;
    outputWipe();
    for (int i = 0; i < levels * 3; i = i + 3) {
      if (i % 2 == 0) {
        outputBlob[i] = byte((int)(c1.R * intensity));
        outputBlob[i + 1] = byte((int)(c1.G * intensity));
        outputBlob[i + 2] = byte((int)(c1.B * intensity));
      } else {
        outputBlob[i] = byte((int)(c1.R * (1 - intensity)));
        outputBlob[i + 1] = byte((int)(c1.G * (1 - intensity)));
        outputBlob[i + 2] = byte((int)(c1.B * (1 - intensity)));
      }

    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

public class fadeInOutString extends pattern { //In a pulse
  double intensity = 0.0;
  //
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    outputWipe();
    for (int i = 0; i < levels * 3; i = i + 3) {
      // intensity = (sin((frameCount*i)*.2) + 1 )/2.0;
      // intensity = (sin((frameCount*(i/3))*.2) + 1 )/2.0;
      // intensity = ((sin((frameCount+(i/3)))*.2) + 1 )/2.0;
      // intensity = ((sin(frameCount)/100*i) + 1 )/2.0;
      intensity = ((sin((frameCount + i) * .05)) + 1 ) / 2.0;
      outputBlob[i] = byte((int)(c1.R * intensity));
      outputBlob[i + 1] = byte((int)(c1.G * intensity));
      outputBlob[i + 2] = byte((int)(c1.B * intensity));
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

public class flameString extends pattern { //In a pulse
  double intensity = 0.0;
  float noiseScale = 0.0001;
  //
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    outputWipe();
    for (int i = 0; i < levels * 3; i = i + 3) {
      // intensity = (sin((frameCount*i)*.2) + 1 )/2.0;
      // intensity = (sin((frameCount*(i/3))*.5) + 1 )/2.0;
      // intensity = ((sin((frameCount+(i/3)))*.2) + 1 )/2.0;
      // intensity = ((sin(frameCount)/100*i) + 1 )/2.0;
      // intensity = ((sin((frameCount+i)*.05)) + 1 )/2.0;
      // intensity = random(100)/100;
      // outputBlob[i+1] = byte((int)((c1.G * 1-intensity)+(c2.G * (1-intensity))));
      float noiseVal = noise( ( ( (i * 30) + 1 ) * frameCount * noiseScale) );
      outputBlob[i]     = byte((int)(255));
      outputBlob[i + 1] = byte((int)(c2.G * noiseVal));
      outputBlob[i + 2] = byte(0);
    }
    outputShow(_player, _weapon);
  }
}

///////////////////////////////////////////////////////////////

public class knight extends pattern { //Knight rider
  int counter = 0;
  boolean increasing = true;
  int speed = 3;
  //
  void doPattern(int levels, BasicPlayer _player, BasicWeapon _weapon) {
    outputWipe();
    if (increasing) {
      if (!(counter + 1 < levels * 3)) {
        increasing = false;
      }
      counter += speed;
    } else {
      if ((counter - 1 < 0)) {
        increasing = true;
      }
      counter -= speed;
    }
    for (int i = 0; i < levels * 3; i = i + 3) {
      if (i == counter) {
        outputBlob[i]     = byte((int)(c1.R));
        outputBlob[i + 1] = byte((int)(c1.G));
        outputBlob[i + 2] = byte((int)(c1.B));
        int tail = 3;
        int tcount = tail;
        float freq = 0.3;
        while (tail > 1) {
          tail--;
          // intensity = sqrt((int)tail)*0.01;
          // intensity = 1.0 - ((double)sin(tail)*0.1);
          if (increasing) {
            int offset = -tail;
            int j = i - (int)(tail * 3);
            if (j >= 0) {
              float intensity = (sin(freq * (frameCount + offset)) * .5) + 0.5;
              float tailFade = 1.0 / (tail);
              // println(tailFade);
              outputBlob[j]     = byte((int)(c1.R * intensity * tailFade) + (int)(c2.R * (1 - intensity) * tailFade));
              outputBlob[j + 1] = byte((int)(c1.G * intensity * tailFade) + (int)(c2.G * (1 - intensity) * tailFade));
              outputBlob[j + 2] = byte((int)(c1.B * intensity * tailFade) + (int)(c2.B * (1 - intensity) * tailFade));
            }
          } else {
            int offset = tail;
            int j = i + (int)(tail * 3);
            if (j < levels * 3) {
              float intensity = (sin(freq * (frameCount - offset)) * .5) + 0.5;
              float tailFade = 1.0 / (tail);
              // println(tailFade);
              outputBlob[j]     = byte((int)(c1.R * intensity * tailFade) + (int)(c2.R * (1 - intensity) * tailFade));
              outputBlob[j + 1] = byte((int)(c1.G * intensity * tailFade) + (int)(c2.G * (1 - intensity) * tailFade));
              outputBlob[j + 2] = byte((int)(c1.B * intensity * tailFade) + (int)(c2.B * (1 - intensity) * tailFade));
            }
          }
        }
      }
    }
    outputShow(_player, _weapon);
  }
}