/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


#ifndef LEDSTRIP
#define LEDSTRIP


//_ledList[led/8] ^= 1 << led%8;
//_ledList[led/8] |= 1 << led%8;
//_ledList[led/8] &= ~(1 << led%8);
//_ledList[led/8] & (1 << led%8)

class LedStrip{
        
  
    private:
        unsigned _firstPin, _nLeds;
        char *_ledList;
  
    public:
        LedStrip(unsigned firstPin, unsigned nLeds) 
          : _firstPin(firstPin), _nLeds(nLeds){
                _ledList = (char*)malloc(sizeof(char)*(nLeds/8+1));
                memset(_ledList, 0, sizeof(char)*(nLeds/8+1));
           }

        void begin(){
            for(int i=0; i<_nLeds; i++)
                pinMode(i+_firstPin, OUTPUT);   
        }

        bool state(unsigned led){
            if(led < _nLeds)
                if(_ledList[led/8] & (1 << led%8))
                    return true;   
                else
                    return false; 
        }

        void turnON(unsigned led){
            if(led < _nLeds)
                _ledList[led/8] |= 1 << led%8;
                //_ledList[led] = true;
        }
        
        void turnOFF(unsigned led){
            if(led < _nLeds)
                _ledList[led/8] &= ~(1 << led%8);
                //_ledList[led] = false;  
        }

        void toggle(unsigned led){
            if(led < _nLeds)
                _ledList[led/8] ^= 1 << led%8;
                //_ledList[led] = !_ledList[led];  
        }
        
        void paint(){
            for(int i=0; i<_nLeds; i++)
                if(_ledList[i/8] & (1 << i%8))
                    digitalWrite(i+_firstPin, HIGH);   
                else
                    digitalWrite(i+_firstPin, LOW); 
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

        void sendState(){
          char data = 0;
          int maxx;
          
          if(_nLeds < 8) 
              maxx = _nLeds;
          else 
              maxx = 8;
             
          for(int i=0; i<maxx; ++i)
              if(_ledList[i/8] & (1 << i%8))
                  data |= 1 << i;

          //if(Serial.available() <= 0);
          Serial.write(data);
      }
  
};

#endif
