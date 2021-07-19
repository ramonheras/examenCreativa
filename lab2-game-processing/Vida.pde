/*
    Author: Borja Castillos 
    Date: 2019
*/

class MarcadorVida
{
  int quedan;
  private int dimensions;
  private int xcoord, ycoord;
  private int SPACING;
  private PImage img_corazon;
  
  MarcadorVida(int _xcoord, int _ycoord, int _dimensions, int _spacing)
  {
    img_corazon = loadImage("heart.png");
    xcoord = _xcoord;
    ycoord = _ycoord;
    dimensions = _dimensions;
    SPACING = _spacing;
    quedan = 5;
  }
  void sumar_vida()
  {
    quedan++;
  }
  void restar_vida()
  {
    quedan = quedan - 1;
  }
  void reset_vida()
  {
    quedan = 5;
  }
  void dibujar_vida()
  {
    for(int i = 0; i < quedan; i++)
    {
      image(img_corazon,xcoord + i * SPACING,ycoord,dimensions,dimensions);
    }
  }
  int restantes_vida()
  {
    return quedan;
  }
}
