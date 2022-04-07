//Receiver code
//Rgb leds are connected to pwm pins 3,5,6
//Colour sensor is connected to pin 2,4,7,8,A4

#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"
#include "printf.h"
#include <Servo.h>
Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;
RF24 radio(9,10);
const uint64_t pipe = 0xE8E8F0F0E1LL;

void setup(void){
  servo1.attach(A0);
  servo2.attach(A1);
  servo3.attach(A2);
  servo4.attach(A3);
  pinMode(3,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
  digitalWrite(3,HIGH);
  digitalWrite(5,HIGH);
  digitalWrite(6,HIGH);
  Serial.begin(115200);
  radio.begin();
  radio.openReadingPipe(1,pipe);
  radio.startListening();
}


void loop(){
  uint8_t a[4]={0};
  if(radio.available()){
    radio.read(&a,sizeof(a));
    if(a[2]==1){
      analogWrite(3,255-a[3]);
    }
    else if(a[2]==2){
      analogWrite(5,255-a[3]);
    }
    else if(a[2]==3){
      analogWrite(6,255-a[3]);
    }
    if(a[0]==1){
      servo1.write(constrain(a[1],0,180));
    }
    else if(a[0]==2){
      servo2.write(constrain(a[1],0,180));
    }
    else if(a[0]==3){
      servo3.write(constrain(a[1],0,180));
    }
    else if(a[0]==4){
      servo4.write(constrain(a[1],0,180));
    }
  }
}
  
  
  
  











