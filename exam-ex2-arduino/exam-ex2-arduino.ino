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
    char data = map(analogRead(LDR), 0, 1024, 0, 6);
    strip.setLevel(data); 
    strip.paint();
    strip.sendState();
    delay(50);

   


    //delay(100); 
}
