<<<<<<< HEAD
/*below is the Live2Processing stuff */
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
float amp;
int OSCnote;
int OSCvelocity;
int DrumBass = 20; //match this to the bassdrum cc#
int DrumSnare = 21; //match this to the snare cc#

/*this is the midi control stuff*/
import themidibus.*;
float cc[] = new float [256];
MidiBus myBus;

PImage astronaut;
PImage astronautFlipped;

float imgX; //
float imgY;
float imgXspeed = 3;
float imgYspeed = 1;

//DISPLAY RATIO
int screenWidth = 1024;
int screenHeight = 768;

void setup() {
  astronaut = loadImage("OrbitEyes_Astronaut_Icon.png"); // load the image
  astronautFlipped = loadImage("OrbitEyes_Astronaut_Icon_Flipped.png"); 
  size(screenWidth, screenHeight); // size of the projector
  colorMode(HSB, 360, 100, 100); // change RGB mode to HSB colormode

  oscP5 = new OscP5(this, 8080);

  MidiBus.list();// will show the available controllers
  myBus = new MidiBus(this, 3, 4); //( ?, input #, output #) when you run the midi list will show you the numbers that correspond to the right midi controller
}
///// END OF SETUP
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/drumMidiNote1") == true) {
    OSCnote = theOscMessage.get(0).intValue();
    println("ccNote:" + OSCnote);
  }
  if (theOscMessage.checkAddrPattern("/drumMidiVelocity1") == true) {
    OSCvelocity = theOscMessage.get(0).intValue();
    println("ccVelocity:" + OSCvelocity);
  }
  if (theOscMessage.checkAddrPattern("/drumAmpL1") == true) {
    amp = theOscMessage.get(0).floatValue();
    println("Amplitude:" + amp);
  }
}
///// END OF OSC_EVENT
void controllerChange(int channel, int number, int value) {
  cc[number] = map(value, 0, 127, 0, 1);

  //println(channel);
  //println(number);
  //  println(value);
}
///// END OF MIDI_BUS


void draw() {
  rectMode(LEFT);
  noStroke();
  fill(0,0,0,mouseY); // change alpha to a midi knob
  rect(0,0,width,height);
  reactive();

  astronautMove();
}

void astronautMove() {
  astronaut.resize(0, 200); // changes the size of the original image
  astronautFlipped.resize(0, 200);
  if (imgXspeed > 0) {
    image(astronaut, imgX, imgY); // places the image in scene (every frame)
    imgX = imgX + imgXspeed; // x velocity
    imgY = imgY + imgYspeed; // y velocity
    if (imgX > width) {
      imgXspeed = -imgXspeed;
    }
    if ( imgY < 0-astronaut.height || imgY > height) {
      imgYspeed = -imgYspeed;
    }
  } else {

    image(astronautFlipped, imgX, imgY); // places the image in scene (every frame)
    imgX = imgX + imgXspeed; // x velocity
    imgY = imgY + imgYspeed; // y velocity
    if ( imgX < 0-astronautFlipped.width) {
      imgXspeed = -imgXspeed;
    }
    if ( imgY < 0-astronautFlipped.height || imgY > height) {
      imgYspeed = -imgYspeed;
    }
  }


  ///// end of astronaut move
}

void reactive() {
  for (int i = 20; i < width; i += 200) {
    for (int j = 100; j < height; j += 200) {
      smooth(8);

      if(OSCnote == DrumBass){
      strokeWeight(8);
      stroke(j*.25, j, amp*.75);
      noFill();
      ellipse(i, j, amp, amp);
      strokeWeight(4);
      ellipse(i, j, amp*.75, amp*.75);
      }
      else if(OSCnote == DrumSnare){
      strokeWeight(2);
      stroke(j*.6, j, amp*.75);
      noFill();
      rectMode(CENTER);
      rect(i, j, amp, amp);
      }else {
      }
    }
  }
}

///// END OF REACTIVE

void keyPressed() {
  if (key =='s') {
    saveFrame("myframe_####.tif");
  }
}

=======
PImage img;

float x;
float y;
float xspeed = 3;
float yspeed = 4;

void setup(){
  img = loadImage("OrbitEyes_Astronaut_Icon.png");
  size(1280, 720);
}

void draw(){
  background(0);
  img.resize(0,200);
  image(img,x,y);
  x = x + xspeed;
  y = y + yspeed;
   if( x < 0|| x > width-img.width){
    xspeed = -xspeed;
  }
  if( y < 0 || y > height-img.height){
    yspeed = -yspeed;
  }
}
>>>>>>> 8c8c6abfa5b6696b0fc0a18d2c757db6b37955c5
