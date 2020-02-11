/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


class LED{  
  private
  PImage _lightImg;
  
  public
  int posX, posY, size;
  color c;
  boolean state;
  
  LED(int pposX, int pposY, int ssize, color cc){
    posX = pposX;
    posY = pposY;
    c = cc;
    size = ssize;
    state = false;
    _lightImg = loadImage("light.png");
    _lightImg.resize(ssize*2, ssize*2);
  }
  
  void paint(){

    if(state){
      imageMode(CENTER);
      image(_lightImg, posX, posY);
      fill(c);
    }
    else
      fill(255, 255, 255);
    
    stroke(c);
    ellipse(posX, posY, size, size);
    
    fill(c);
    textAlign(CENTER, CENTER);
    textSize(size/4);
    text("OFF", posX, posY);
  }
  
  void turnON(){
    state = true;
  }
  
  void turnOFF(){
    state = false;
  }
  
  void toggle(){
    state = !state;
  }
  
  void toggle(int x, int y){
      if(dist(x, y, posX, posY) <= size/2)
        toggle();
  }

}
