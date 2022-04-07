
import processing.serial.*;
Serial port;

void setup(){
  servo[0]=0;
  servo[1]=83;
  servo[2]=60;
  servo[3]=45;
  size(1200,650,P3D);
  background(255,0,0);
  port= new Serial(this,"COM5",9600);
  port.clear();
}

int data[] =new int[4]; 
int servo[] = new int[4];
int scrolVal=80;
int release = 1;
int r=0,g=0,b=0;


void draw(){
  background(86,92,95);
  noFill();
  noLights();
  fill(77,255,8);
  rect(295,0,610,105);
  fill(27,38,44);
  rect(300,0,600,100);
  fill(7,239,245);
  textSize(20);
  text("ROBOTIC ARM CONTROL",500,50);
  pushMatrix();
  scale(1.3);
  translate(-50,-120);
  drawRoboticArm();
  popMatrix();
  displayValues();
  colours();
  sendAndReceiveData();
}

void mouseWheel(MouseEvent counter) {
  float scroll = counter.getCount();
  if(scroll==1){
    scrolVal+=2;
  }
  else if(scroll==-1){
    scrolVal-=2;
  }
  scrolVal=constrain(scrolVal,45,90);
  data[1]=scrolVal;
  data[0]=4;
  servo[3]=scrolVal;
}

void drawRoboticArm(){
  fill(100);
  pushMatrix();
  lights();
  stroke(50);
  translate(width/2,500);
  fill(255);
  beginShape();
  vertex(-100,0,100);
  vertex(100,0,100);
  vertex(100,0,-100);
  vertex(-100,-0,-100);
  vertex(-100,0,100);
  endShape();
  beginShape();
  vertex(-100,30,100);
  vertex(100,30,100);
  vertex(100,0,100);
  vertex(-100,0,100);
  vertex(-100,30,100);
  endShape();
  beginShape();
  vertex(100,30,100);
  vertex(100,30,-100);
  vertex(100,0,-100);
  vertex(100,0,100);
  vertex(100,30,100);
  endShape();
  beginShape();
  vertex(100,0,-100);
  vertex(-100,0,-100);
  vertex(-100,30,-100);
  vertex(100,30,-100);
  vertex(100,0,-100);
  endShape();
  beginShape();
  vertex(-100,0,-100);
  vertex(-100,30,-100);
  vertex(-100,30,100);
  vertex(-100,0,100);
  vertex(-100,0,-100);
  endShape();
  beginShape();
  vertex(-100,30,100);
  vertex(100,30,100);
  vertex(100,30,-100);
  vertex(-100,30,-100);
  vertex(-100,30,100);
  endShape();
  popMatrix();
  
  pushMatrix();
  stroke(106,61,17);
  fill(245,240,146);
  translate(width/2,500);
  rotateY(map(servo[0],0,180,-PI,0));
  beginShape();
  vertex(-40,0,-40);
  vertex(40,0,-40);
  vertex(40,0,40);
  vertex(-40,0,40);
  vertex(-40,0,-40);
  endShape();
  beginShape();
  vertex(-40,-40,-40);
  vertex(40,-50,-40);
  vertex(40,0,-40);
  vertex(-40,0,-40);
  vertex(-40,-40,-40);
  endShape();
  beginShape();
  vertex(40,-40,-40);
  vertex(40,-40,40);
  vertex(40,0,40);
  vertex(40,0,-40);
  vertex(40,-40,-40);
  endShape();
  beginShape();
  vertex(-40,-40,40);
  vertex(40,-50,40);
  vertex(40,0,40);
  vertex(-40,0,40);
  vertex(-40,-40,40);
  endShape();
  beginShape();
  vertex(-40,-20,40);
  vertex(-40,-20,-40);
  vertex(-40,0,-40);
  vertex(-40,0,40);
  vertex(-40,-20,40);
  endShape();
  popMatrix();
  
  pushMatrix();
  translate(width/2,500);
  rotateY(map(servo[0],0,180,-PI/2,PI/2));
  rotateX(map(constrain(servo[1],75,160),0,180,-PI/2.1,PI/2.1));
  beginShape();
  vertex(18,-20,0);
  vertex(18,-110,0);
  vertex(18,-110,8);
  vertex(18,-20,8);
  vertex(18,-20,0);
  endShape();
  beginShape();
  vertex(15,-20,0);
  vertex(15,-110,0);
  vertex(15,-110,8);
  vertex(15,-20,8);
  vertex(15,-20,0);
  endShape();
  beginShape();
  vertex(15,-20,0);
  vertex(18,-20,0);
  vertex(18,-110,0);
  vertex(15,-110,0);
  vertex(15,-20,0);
  endShape();
  beginShape();
  vertex(-18,-20,0);
  vertex(-18,-110,0);
  vertex(-18,-110,8);
  vertex(-18,-20,8);
  vertex(-18,-20,0);
  endShape();
  beginShape();
  vertex(-15,-20,0);
  vertex(-15,-110,0);
  vertex(-15,-110,8);
  vertex(-15,-20,8);
  vertex(-15,-20,0);
  endShape();
  beginShape();
  vertex(-15,-20,0);
  vertex(-18,-20,0);
  vertex(-18,-110,0);
  vertex(-15,-110,0);
  vertex(-15,-20,0);
  endShape();
  beginShape();
  vertex(-15,-30,0);
  vertex(15,-30,0);
  vertex(15,-90,0);
  vertex(-15,-90,0);
  vertex(-15,-30,0);
  endShape();
  
  translate(0,-105,0);
  rotateX(map(servo[2],180,0,0.5,PI/1.85));
  beginShape();
  vertex(18,0,0);
  vertex(18,-110,0);
  vertex(18,-110,8);
  vertex(18,0,8);
  vertex(18,0,0);
  endShape();
  beginShape();
  vertex(-18,0,0);
  vertex(-18,-110,0);
  vertex(-18,-110,8);
  vertex(-18,0,8);
  vertex(-18,0,0);
  endShape();
  rotateY(PI/2);
  translate(0,0,19);
  ellipse(0,0,15,15);
  translate(0,0,-38);
  ellipse(0,0,15,15);
  rotateY(PI/2);
  rect(-36,-140,36,36);
  rotateY(PI/2);
  translate(0,-160,0);
  translate(0,0,0);
  rect(0,0,10,30);
  translate(0,0,10);
  translate(0,0,map(servo[3],45,90,-46,-20));
  rect(0,0,10,30);
  popMatrix();
}

void sendAndReceiveData(){
  if(keyPressed){
    if(keyCode==RIGHT  || key=='d'){
    data[0]=1;
    servo[0]--;
    data[1]=servo[0];
    delay(3);
    }
    else if(keyCode==LEFT  || key=='a'){
    data[0]=1;
    servo[0]++;
    data[1]=servo[0];
    delay(3);
    }
    else if(keyCode==UP){
    data[0]=2;
    servo[1]+=1;
    data[1]=servo[1];
    delay(1);
    }
    else if(keyCode==DOWN){
    data[0]=2;
    servo[1]-=1;
    data[1]=servo[1];
    delay(1);
    }
    else if(key=='w' || key=='1'){
    data[0]=3;
    servo[2]++;
    data[1]=servo[2];
    delay(3);
    }
    else if(key=='s' || key=='0'){
    data[0]=3;
    servo[2]--;
    data[1]=servo[2];
    delay(3);
    }
    data[1]=constrain(data[1],1,180);
    servo[0]=constrain(servo[0],0,180);
    servo[1]=constrain(servo[1],55,180);
    servo[2]=constrain(servo[2],0,180);
    if(port.available()>0){
    if(port.read()=='A'){
      port.clear();
      port.write(data[0]);
      port.write(data[1]);
      port.write(data[2]);
      port.write(data[3]);
    }
  }
  }
}

void displayValues(){
  fill(255,0,0);
  arc(1080,100,100,100,PI,2*PI);
  fill(77,255,8);
  arc(1080,100,100,100,PI,map(servo[0],180,0,PI,2*PI));
  textSize(15);
  fill(196,255,8);
  text("Servo1",1055,30);
  text(servo[0],1150,80);
  
  fill(255,0,0);
  arc(1080,210,100,100,PI,2*PI);
  fill(77,255,8);
  arc(1080,210,100,100,PI,map(servo[1],180,0,PI,2*PI));
  textSize(15);
  fill(196,255,8);
  text("Servo2",1055,140);
  text(servo[1],1150,190);
  
  fill(255,0,0);
  arc(1080,320,100,100,PI,2*PI);
  fill(77,255,8);
  arc(1080,320,100,100,PI,map(servo[2],180,0,PI,2*PI));
  textSize(15);
  fill(196,255,8);
  text("Servo3",1055,250);
  text(servo[2],1150,300);
  
  fill(255,0,0);
  arc(1080,430,100,100,PI,2*PI);
  fill(77,255,8);
  arc(1080,430,100,100,PI,map(servo[3],180,0,PI,2*PI));
  textSize(15);
  fill(196,255,8);
  text("Servo4",1055,360);
  text(servo[3],1150,410);
}
void colours(){
  fill(77,255,8);
  rect(0,145,295,505);
  fill(27,38,44);
  rect(0,150,290,495);
  fill(150);
  rect(20,180,60,425);
  fill(150);
  rect(100,180,60,425);
  fill(150);
  rect(180,180,60,425);
  fill(r,g,b);
  rect(0,0,295,145);
  fill(255-r,255-g,255-b);
  text("COLOR",120,70);
  strokeWeight(10);
  stroke(77,255,8);
  line(20,map(r,0,255,600,185),80,map(r,0,255,600,185));
  line(100,map(g,0,255,600,185),160,map(g,0,255,600,185));
  line(180,map(b,0,255,600,185),240,map(b,0,255,600,185));
  strokeWeight(1);
  fill(255,50,50);
  rect(20,map(r,0,255,600,185),60,600-map(r,0,255,600,185));
  fill(50,200,50);
  rect(100,map(g,0,255,600,185),60,600-map(g,0,255,600,185));
  fill(50,50,255);
  rect(180,map(b,0,255,600,185),60,600-map(b,0,255,600,185));
  if(mousePressed && mouseX>20 && mouseX<80 && mouseY>175 && mouseY<605){
    r=int(map(mouseY,180,605,255,0));
    r=constrain(r,0,255);
    data[2]=1;
    data[3]=int(r);
  }
  else if(mousePressed && mouseX>100 && mouseX<160 && mouseY>175 && mouseY<605){
    g=int(map(mouseY,180,605,255,0));
    g=constrain(g,0,255);
    data[2]=2;
    data[3]=int(g);
  }
  else if(mousePressed && mouseX>180 && mouseX<240 && mouseY>175 && mouseY<605){
    b=int(map(mouseY,180,605,255,0));
    b=constrain(b,0,255);
    data[2]=3;
    data[3]=int(b);
  }
  if(keyPressed && key=='r'){
    r++;
    r=constrain(r,0,255);
    data[2]=1;
    data[3]=int(r);
  }
  else if(keyPressed && key=='e'){
    r--;
    r=constrain(r,0,255);
    data[2]=1;
    data[3]=int(r);
  }
  else if(keyPressed && key=='g'){
    g++;
    g=constrain(g,0,255);
    data[2]=2;
    data[3]=int(g);
  }
  else if(keyPressed && key=='f'){
    g--;
    g=constrain(g,0,255);
    data[2]=2;
    data[3]=int(g);
  }
  else if(keyPressed && key=='b'){
    b++;
    b=constrain(b,0,255);
    data[2]=3;
    data[3]=int(b);
  }
  else if(keyPressed && key=='v'){
    b--;
    b=constrain(b,0,255);
    data[2]=3;
    data[3]=int(b);
  }
  r=constrain(r,0,255);
  g=constrain(g,0,255);
  b=constrain(b,0,255);
  if(port.available()>0){
    if(port.read()=='A'){
      port.clear();
      port.write(data[0]);
      port.write(data[1]);
      port.write(data[2]);
      port.write(data[3]);
    }
  }
  fill(255);
  text(r,45,630);
  text(g,125,630);
  text(b,205,630);
}