/*
    Author: Ramon Heras 
    Date: 8th Feb 2020
*/


#include "LedStrip.h"

#define LDR A7

LedStrip strip(2, 5);
char data;

void setup(){
    pinMode(LDR, INPUT);
  
    Serial.begin(9600);
    strip.begin();
}


void loop(){
    char data = map(analogRead(LDR), 0, 1024, 0, 100)
    
    ;
    Serial.write(data);
    delay(100);

    if (Serial.available() > 0) {
        data = Serial.read();
        strip.set(data); 
    }


    //delay(100); 
}
