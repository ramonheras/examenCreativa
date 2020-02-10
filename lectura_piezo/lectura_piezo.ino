/*
    Author: Ramon Heras 
    Date: 2019
*/

#define THRES 200
#define FILTER_SIZE 20

int val;
int state;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  while(!Serial);
  state = LOW;
}

void loop() {
  // put your main code here, to run repeatedly:
  val = filter(analogRead(A0));
  if(state == LOW)
  {
    if(val > THRES)
      state = HIGH;  
  }
  else 
  {
    if(val < THRES)
    {
      state = LOW;
      Serial.println('1');  
    }
  }
  //Serial.println(val);
  delay(1);
}

int filter(int new_sample){
    static bool first = true;
    static unsigned long window[FILTER_SIZE], sum=0, last=0;
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
