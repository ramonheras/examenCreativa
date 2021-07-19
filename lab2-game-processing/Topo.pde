/*
    Author: Ramon Heras 
    Date: 2019
*/

public class Topo{

    private static final float canvas_width = 960;
    private static final float canvas_height = 720;  
    private static final float topo_height = 169;  
    private static final float topo_width = 222;
    
    float posMaxHeight = (canvas_height-topo_width)/2;
    float posMaxWidth  = (canvas_width-topo_width)/2;
    
    float x, y, vmin, vmax, dieFact;
    int from;
    boolean upwards, visible, die;
    
    PImage img;
     
     Topo(float _vmin, float _vmax){
         newOrigin(_vmin, _vmax);
     }
     
     void newOrigin(float _vmin, float _vmax){
         from = (int)random(0, 4);
         vmin = _vmin;
         vmax = _vmax;
         upwards = true;
         visible = true;
         die = false;
         
         img = loadImage("Monty_Mole.png");
         img.resize((int)topo_width, (int )topo_height);
         
         switch(from){
             case 0:
             case 1:
                 x = random(-posMaxWidth, posMaxWidth); //leaves a topo_width/2 margin
                 break;
             case 2:
             case 3:
                 x = random(-posMaxHeight, posMaxHeight);
                 break;
         }
         y = topo_height/2;
     }
     
    private void myTransform(){
         switch(from){
             case 0:
                 translate(canvas_width/2, canvas_height);
                 break;
             case 1:
                 translate(canvas_width/2, 0);
                 rotate(radians(180));
                 break;
             case 2:
                 translate(0, canvas_height/2);
                 rotate(radians(90));
                 break;
             case 3:
                 translate(canvas_width, canvas_height/2);
                 rotate(radians(270));
                 break;
         }
    }
    
    private void moveY(){
         switch(from){
             case 0:
             case 1:
                 if(y < -canvas_height/2)
                   upwards = false;
                 break;
             case 2:
             case 3:
                 if(y < -canvas_width/2)
                       upwards = false;
                 break;
         }
      
      
         if(upwards == true)
             y -= random(vmin, vmax);
         else
             y += random(vmin, vmax);
    }
     
    boolean drawTopo(){
        pushMatrix();
             myTransform();
             if(visible)
                 if(die){
                     tint(255, 0, 0);
                       image(img, x, y);
                       img.resize((int)(dieFact*topo_width), (int)(dieFact*topo_height));
                       //fill(255, 0, 0);
                       //ellipse(x, y, dieFact*topo_width, dieFact*topo_height);
                       //noFill();
                     noTint();
                     dieFact *= 0.8;
                     if (dieFact < 0.01)
                         visible = false;
                 }
                 else{
                     image(img, x, y);
                     //fill(0, 0, 0);
                     //ellipse(x, y, topo_width, topo_height);
                     noFill();
                     
                     moveY();
                     x += random(-vmax, vmax);
                     
                     if(y > topo_height/2)
                         visible = false;
                 }
       popMatrix();
         
           
       return visible;
     }
     
     boolean kill(){
         if(visible){
             dieFact = 1;
             die = true;
         }
         return visible;
     }
  
}
