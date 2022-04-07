//Transmitter program for led control 
//connect button to pin 3 
#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"
#include "printf.h"
RF24 radio(9,10);
const uint64_t pipe = 0xE8E8F0F0E1LL;

void setup(void){
  pinMode(3,INPUT);
  Serial.begin(9600);
  radio.begin();
  radio.openWritingPipe(pipe);
}

uint8_t a[4]={0};
int counter=0;

void loop(){
  Serial.print('A');
  while(Serial.available()>0){
    a[counter]=Serial.read();
    counter++;
    if(counter>3){
      counter=0;
      radio.write(&a,sizeof(a));
    }
  }
}


