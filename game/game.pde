/*
    Author: Borja Castillos y Ramon Heras 
    Date: 2019
*/

//Global
import processing.serial.*;
Serial myport;

Topo topo;
Marcador marcador;
MarcadorVida marcadorVida;
int moves=0, randDelay=0;
boolean stopped=false;

int canvas_width = 960;
int canvas_height = 720; 

static int state;
static int init = 0;
static int in_game = 1;
static int game_over = 2;

PImage backgroundImg;

void setup(){
  size(960, 720);
  imageMode(CENTER);
  frameRate(200);  
  backgroundImg = loadImage("fondo.png");
  
  topo = new Topo(2, 5);
  marcador = new Marcador(50, 60, 40);
  marcadorVida = new MarcadorVida(700, 50, 40, 50);
  printArray(Serial.list());
  //myport = new Serial(this, Serial.list()[0],9600);
  //myport.bufferUntil(10);
  state = init;
}

void draw(){
  
  image(backgroundImg, 480, 360);
  if (state == init)
  {
    PImage img_topo = loadImage("Monty_Mole.png");
    img_topo.resize(150,150);
    image(img_topo,width/2,height-60);
    textSize(80);
    fill(0, 102, 153);
    text(" TAP THE TOPO!", 145, height/3);
    textSize(26);
    fill(255);
    text("Press any key to start the game", 275, height/2);
    if(keyPressed)
      state++;
  }
  else if(state == in_game)
  {
    
    if(marcadorVida.quedan == 0){//marcadorVida.quedan == 0
          marcador.drawMarcador();
          fill(0, 102, 153);
          noFill(); 
          state++;
    }
    else{
        if(!stopped){
            if(!topo.visible)
              topo.newOrigin(0.1*moves, moves);
              
            boolean status = topo.drawTopo();
           
            if (!status){
                if (!topo.die)
                    marcadorVida.restar_vida();
                    
                moves++;
                
                stopped = true;
                randDelay = (int)random(50, 500);
            }
        }
        marcador.drawMarcador();
        marcadorVida.dibujar_vida();
        
        if(randDelay > 0)
            randDelay--;
        else
            stopped = false;
    
    }
  }
  else if(state == game_over)
  {
    textSize(80);
    fill(0, 102, 153);
    text("Game Over", 262, height/3);  
    textSize(42);
    fill(255);
    text("Restart? Y / N", 337, height/2);
    if(keyPressed)
    {
      if(key == 'y')
      {
        topo.newOrigin(0.1, 1);
        marcador.reset();
        marcadorVida.reset_vida();
        state = in_game;
      }
      else if(key == 'n')
      {
        System.exit(0);
      }
    }
  }             
}

void keyPressed(){
    moves = 0;
    marcador.reset();
    marcadorVida.reset_vida();
}

void mousePressed()
{
 
   if (topo.kill())
    marcador.addPoints(20);
   else
    marcadorVida.restar_vida();
  
}
