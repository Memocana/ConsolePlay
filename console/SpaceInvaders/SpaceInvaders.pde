//SPACE INVADERS
import processing.serial.*;
Serial myPort;
String val = "a";

//for game use
int sx=325, bully=445, bullx=sx+25, speed=0;
tank t = new tank(325);
int gx = (int)random(25,675), gy=50, tempx, tempy=50, lands=0;
int score=0;
float fallSp=1,moveSp=3;
boolean hit = false, play=true;



void setup(){
 size(700,500);
 smooth();
 String portName = Serial.list()[2];
 myPort = new Serial(this,portName,9600); 
}


class tank {
  
  
   tank(int tempx){
    sx=tempx; 
   }

void make() {
 fill(0,0,0); 
 rect(sx,480,50,30);
 rect(sx+15,460,20,20);
 rect(sx+23,440,4,30);
  } 
  
  
}
void draw() {
  if(myPort.available() > 0)
  val = myPort.readStringUntil('\n') + 'a'; 
  
  if(play)
   background(#81C7FF);
   int a=425,b=60; 
   boolean shoot=false;
   if (play == true) {
   
   t.make();
   if(val.charAt(0) == 'R'&&sx<width-50){sx+=moveSp;}
   else if(val.charAt(0) == 'L'&&sx>0){sx-=moveSp;}
  //bullet
  if(bully==445)bullx=sx+25;
   noFill();
   ellipse(bullx,bully,4,4);

   if (val.charAt(0) == 'S'){
     speed=10;
   } 
   if (hit==true){
   bully=445;
   speed=0; 
   hit=false;  
   }
   bully-=speed;  
   
   if(bully<10){
     bully=445;
     speed=0;
   }
   
   
  if(gy>500){
    gy=50;
    gx=(int)random(25,675);
    tempx=gx;
    lands++;
  }

   
  if (gy>50&&gy<500){
  fill(0,0,0);
  ellipse(gx,gy,12,20);
  ellipse(gx,gy-14,7,7);
  rect(gx+2,gy+8,5,13,5); 
  rect(gx-7,gy+8,5,13,5);
  ellipse(gx+10,gy-3,7,4);  
  ellipse(gx-10,gy-3,7,4);  
  line(gx+5,gy-4,gx+15,gy-50);
  line(gx-5,gy-4,gx-15,gy-50);
  stroke(0);
  curve(gx-5,gy-4,gx-2,gy-6,gx+2,gy-6,gx+5,gy-4);
  }
  gy+=fallSp;
  
  
  if(gy+10>bully&&gy-10<bully&&gx-25<bullx&&gx+25>bullx){
  gx=tempx;
  gy=tempy;
  gx=(int)random(25,675);
  score++;
  hit=true;
  }
 } 
  if(lands>4) {
   play=false;
   text("You lose. Score: " + score, 230, 250); 
  }
 if (score>10){
 fallSp=score/10;
 }
 if (score>20)
 moveSp=fallSp*3;

if(val.charAt(0) == 'P')play=!play;

}
