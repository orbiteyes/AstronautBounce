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
