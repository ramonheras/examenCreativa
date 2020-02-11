/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


import processing.serial.*;
Serial port; 

PImage bgrnd;


int lvl=0;

LedStrip strip;
Slider slider;

void setup(){
  size(800,450);
  
  bgrnd = loadImage("fondo.jpeg");
  bgrnd.resize(800, 450);
    
  printArray(Serial.list()); 
  port = new Serial(this, Serial.list()[0], 9600); 
  
  strip = new LedStrip(100, 300, 150, 5, 100, color(100, 0, 0), port);
  slider = new Slider(50, 100, 700, 30, color(30, 100, 150));

  frameRate(50);
  
}


int c=0 ;

void draw(){
 
  background(255,255, 255);
  imageMode(CORNER);
  image(bgrnd, 0, 0);
  strip.paint();
  slider.paint();
  //strip.set(c);
  
  if (port.available() > 0)  
      strip.set(port.read());
  
 
/*  // Test // .setLevel(int)

  if(random(-1, 1) >= 0)
    lvl += 1;
  else 
    lvl -= 1;
   
  if(lvl < 0) lvl = 0;
  else if(lvl >= 5) lvl = 4;
  
  print(lvl);
  strip.setLevel(lvl);
*/

/*  // Test // .setLevel(float)

   strip.setLevel(random(0, 100));
   println(random(90, 100)/100 * 5);
  
*/
  
 
}
/*
void mousePressed(){
    strip.toggle(mouseX, mouseY);
    slider.press();
}

void mouseReleased(){
    slider.release();
}

void serialEvent(Serial port)
{
    str = port.readStringUntil('\n');
}*/
