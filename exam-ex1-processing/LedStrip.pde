/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


import processing.serial.*;

class LedStrip{
     private
          ArrayList<LED> _ledList;
          boolean _remoteEnabled;
          Serial _port;

          void _createLeds(int pposX, int pposY, int spacing, int nLeds, int ssize, color cc){
            
              _ledList = new ArrayList<LED>();
              
              for(int i=0; i<nLeds; i++){
                  _ledList.add(new LED(pposX+i*spacing, pposY, ssize, cc));
              }
          }
      public
       
      LedStrip(int pposX, int pposY, int spacing, int nLeds, int ssize, color cc){
          _remoteEnabled = false;
          _createLeds(pposX, pposY, spacing, nLeds, ssize, cc);
      }
      
      LedStrip(int pposX, int pposY, int spacing, int nLeds, int ssize, color cc, Serial port){
            _remoteEnabled = true;
            _port = port;
            _createLeds(pposX, pposY, spacing, nLeds, ssize, cc);
      }
      
      void paint(){
          for(int i=0; i<_ledList.size(); i++)
              _ledList.get(i).paint();    
      }
      
      void ON(){
          for(int i=0; i<_ledList.size(); i++){
              _ledList.get(i).turnON();
          }
      }
      
      void OFF(){
          for(int i=0; i<_ledList.size(); i++){
              _ledList.get(i).turnOFF();
          }
      }
      
      void turnON(int led){
          if(led < _ledList.size())
              _ledList.get(led).turnON();
      }
      
      void turnOFF(int led){
          if(led < _ledList.size())
              _ledList.get(led).turnOFF();
      }
      
      void toggle(int led){
          if(led < _ledList.size())
              _ledList.get(led).toggle();
      }
      
      void setLevel(int lvl){
          if(lvl < 0)
              lvl = 0;
          else if(lvl > _ledList.size())
              lvl = _ledList.size();
          
          for(int i=0; i < lvl; i++)
              turnON(i);
          for(int i=lvl; i<_ledList.size(); ++i)
              turnOFF(i);
          
      }
      
      void setLevel(float lvl){
          setLevel((int)(lvl/100*(_ledList.size()+1)));
      }
      
      void toggle(int x, int y){
          for(int i=0; i<_ledList.size(); i++)
              _ledList.get(i).toggle(x, y);
              
          sendState();
      }
      
      void set(int val){
          int max;
          
          if(_ledList.size() < 64) 
              max = _ledList.size();
          else 
              max = 64;
          
          for(int i=0; i<max; ++i)
              if((val & (1 << i)) != 0)
                  turnON(i);
              else 
                  turnOFF(i);
      }
      
      void sendState(){
          char data = 0;
          int max;
          
          if(_ledList.size() < 8) 
              max = _ledList.size();
          else 
              max = 8;
              
          if(_remoteEnabled)
              for(int i=0; i<max; ++i)
                  if(_ledList.get(i).state)
                      data |= 1 << i;

          while(_port.available() != 0);
          _port.write(data);
      }
 }
