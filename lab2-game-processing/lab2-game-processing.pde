/*
    Author: Ramon Heras 
    Date: 2019
*/

public class Marcador{
    float x, y;
    int textSize, score;
  
    Marcador (float _x, float _y, int _textSize){
        x = _x;
        y = _y;
        textSize = _textSize;
        score = 0;
    }
    
    void reset(){score = 0;}
    
    void addPoints(int points){
        score += points;
        drawMarcador();
    }
    
    void drawMarcador(){
        fill(0, 255, 0);
        textSize(textSize);
        text(score, x, y); 
        noFill();
    }
}
