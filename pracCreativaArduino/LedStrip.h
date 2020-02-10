/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


#ifndef LEDSTRIP
#define LEDSTRIP

class LedStrip{
  
    public:
        LedStrip(int firstPin, int nLeds) 
          : _firstPin(firstPin), _nLeds(nLeds){}

        void begin(){
            for(int i=0; i<_nLeds; i++)
                pinMode(i+_firstPin, OUTPUT);   
        }

        void turnON(int led){
            if(led < _nLeds)
                digitalWrite(led+_firstPin, HIGH);  
        }
        
        void turnOFF(int led){
            if(led < _nLeds)
                digitalWrite(led+_firstPin, LOW);  
        }

        void setLevel(int lvl){
            if(lvl < 0)
                lvl = 0;
            else if(lvl > _nLeds)
                lvl = _nLeds;
            
            for(int i=0; i < lvl; ++i)
                turnON(i);
            for(int i=lvl; i<_nLeds; ++i)
                turnOFF(i);
        }
      
        void set(int val){
            int mmax;
          
            if(_nLeds < 8) 
                mmax = _nLeds;
            else 
                mmax = 8;
            
            for(int i=0; i<mmax; ++i)
                if((val & (1 << i)) != 0)
                    turnON(i);
                else 
                    turnOFF(i);
      }
  
    private:
        int _firstPin, _nLeds;
  
};

#endif
