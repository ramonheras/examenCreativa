/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


class Slider{
 
    boolean pressed;
  
  public
  
    int posX, posY, Width, Height, level;
    color c;
    
    Slider(int pposX, int pposY, int WWidth, int HHeight, color cc){
        posX = pposX;
        posY = pposY;
        Width = WWidth;
        Height= HHeight;
        c = cc;
        pressed = false;
        level = 0;
    }
    
    void paint(){
        stroke(0, 0, 0);
        strokeWeight(Height/10);
        fill(255, 255, 255);
        rect(posX, posY, Width, Height);
        
        noStroke();
        fill(c);
        
        if(pressed){
            if(mouseX >= posX){
                if(mouseX < (posX + Width))
                    level = mouseX-posX;
                else
                    level = Width;
            }
            else{ 
                level = 0;
            }
        }
  
        rect(posX, posY, level, Height);
        
    }
    
    void setLevel(float lvl){
        level = (int)(Width*lvl/100);
    }
    
    void press(){
        if(mouseX > posX && mouseX < (posX+Width) && mouseY > posY && mouseY < (posY+Height))
            pressed = true;
    }
    
    void release(){
        pressed = false;    
    }
  
}
