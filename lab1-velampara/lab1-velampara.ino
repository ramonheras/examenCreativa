#define micPin    A0
#define lightPin  2
#define temPin    3

#define FILTER_SIZE 20
#define MIC_THRES     100 //0-1023
#define TEM_THRES     50 //0-1023
#define IDLE_LEVEL    511 //0-1023
#define MIN_BLOW_TIME 500 //ms

//functions
void es_mechero(bool &light, int temp);
void es_palmada_o_soplido(bool &light, int mic);
int filter(int new_sample);

void setup() {
  // put your setup code here, to run once:

}

void loop() {
    bool light_status = false;

    es_palmada_o_soplido(light_status, analogRead(micPin));
    es_mechero(light_status, analogRead(temPin));

    digitalWrite(lightPin, light_status);
}

void es_palmada_o_soplido(bool &light, int mic){ //detectar palmada o soplido
    static char state = LOW;
    static unsigned long _time = 0;
    
    int micAux = filter(abs(mic - IDLE_LEVEL));
    int elapsed;

    
    if (state == LOW)
        if(micAux > MIC_THRES){
            state = HIGH;
            _time = millis();
        }
    else
        if(micAux <= MIC_THRES){
            state = LOW;
            elapsed = millis() - _time;
        }

    if(elapsed > MIN_BLOW_TIME)
        light = 0; //soplido
    else 
        light = !light; //palmada

}

void es_mechero(bool &light, int temp){ //detectar palmada o soplido
    //detectar mechero
    static char state = LOW;
    static int antTemp = 0;
    int deltaTemp = temp - antTemp;

    antTemp = temp;

    if (state == LOW)
        if(deltaTemp > TEM_THRES){
            light = 1; //mechero
            state = HIGH;
        }
    else
        if(deltaTemp < TEM_THRES)
            state = LOW;     
}

int filter(int new_sample){
    static bool first = true;
    static unsigned long sum=0;
    static int window[FILTER_SIZE], last=0;
    int res;

    //init
    if(first){
        first = false;
        for(int i=0; i<FILTER_SIZE; i++)
            window[i] = 0;     
    }

    //average filter
    res = sum / FILTER_SIZE;

    sum += new_sample - window[last];
    window[last] = new_sample;
    last = (last+1)%FILTER_SIZE; 

    return res;
 }


    //example 1


    
          #include <Panel.h>
        
          #define R Panel::color(255, 0, 0)
        
          Panel p(7, 7, SERPENTINE, LEFT, 0);
        
          void setup(){
              p.begin();
              p.setBrightness(20); // 0~255
            
              p.line(0, 0, 2, 2, R);
              p.line(6, 0, 3, 3, R);
               
              p.fill(R)
              p.line(3, 4, 3, 7);
              p.line(0, 6, 7, 6);

              p.show();
          }
          
          void loop(){}

          


    //example 2

    

        #include <Panel.h>
        
        #define G Panel::color(0, 255, 0)

        Panel p(7, 7, SERPENTINE, LEFT, 0);

        void setup(){
            p.begin();
            p.setBrightness(20); // 0~255
        }

        void loop(){
            p.setPixel(1, 3, G);
            p.show();
            delay(1000);
            
            p.setPixel(1, 3, 0); // clear();
            p.show();
            delay(1000); 
        }




    //example 3

    

        #include <Panel.h>
        
        #define B Panel::color(0, 0, 255)

        Panel p(7, 7, SERPENTINE, LEFT, 0);

        void setup(){
            p.begin();
            p.setBrightness(20); // 0~255

            p.rect(1, 1, 2, 2, B);
            p.rect(4, 1, 2, 2, B);

            p.fill(B);
            p.rect(2, 3, 3, 3);
        }

        void loop(){}



        

    bool setPixel(int x, int y, uint32_t color);
    bool setPixel(int x, int y);
    void setPixel(uint32_t color);
    uint32_t getPixel(int x, int y) const;



    void line(int x0, int y0, int x1, int y1);
    void line(int x0, int y0, int x1, int y1, uint32_t color);



    void fill(uint32_t color);
    void clear();


    void rect(int x0, int y0, unsigned width, unsigned height);
    void rect(int x0, int y0, unsigned width, unsigned height, uint32_t color);



    void pushMatrix();
    void popMatrix();
    void translate(int x, int y);
    void rotate(int deg);




        unsigned getWidth();
        unsigned getHeight();
        unsigned getMatrixRotation();
        Style_enum getLayoutStyle();
        IniSide_enum getIniSide();



    
