import processing.serial.*;
int a=150,b=360,x=(int)random(20,480),y=10,dx=2,dy=3, score=0;
boolean check=true,start=false;

Serial myPort;
String val = "a";

void setup() {
  size(500,400);
 String portName = Serial.list()[2];
 myPort = new Serial(this,portName,9600); 
}

void draw() {
 if(myPort.available() > 0){
  val = myPort.readStringUntil('\n') + 'a'; 
 }

 
 //The Actual Game
  background(#4FE55F);    
  fill(255,0,0);
  ellipse(x,y,15,15);
  if(x>width-10|x<10)dx*=-1;
  if(y>height-10|y<10)dy*=-1;
  if(start==false)delay(1000);
 
    
     fill(#4188F7);
     rectMode(CENTER);
     rect(a,b,75,10);
 
    if (check==true){
    if (val.charAt(0) == 'R' && a+5<width-75/2){
        a+=3;
    }
    else if (val.charAt(0) == 'L'  && a-5>75/2){
        a-=3;
    } 
    if(x>height-30||x>30){}


    if(a-28<x&&a+28>x&&y>345){dy=-3; score++;}  

  x+=dx;
  y+=dy;
      
      if(y>390){
        check=false;
        text("YOU LOSE!",200,200);
      } 

    }
 // text(val,10,10);
  if (start == false) text ("Press enter to begin!", 180, 190);
  if (val.charAt(0) == 'P'||key==ENTER) start=!start;
  if(check==false)  text("Score: "+score, 220,180);
  
}
