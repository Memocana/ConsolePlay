int page;
import processing.serial.*;
Serial myPort;
String val = "a";
PImage[] menu = new PImage[3];

int a=150,b=360,x=(int)random(20,480),y=10,dx=2,dy=3, pongScore=0; //for pong
boolean check=true,start=false; //for pong

//for space invaders 
int sx=325, bully=445, bullx=sx+25, speed=0;
tank t = new tank(325);
int gx = (int)random(25,675), gy=50, tempx, tempy=50, lands=0;
int score=0;
float fallSp=1,moveSp=3;
boolean hit = false, play=true;


void setup () {
  page = 0;
  size(500,500);
  String portName = Serial.list()[2];
  myPort = new Serial(this,portName,9600); 
  menu[0] = loadImage("invade.jpg");
  menu[1] = loadImage("flap.png");
  menu[2] = loadImage("gun.jpg");
}

void setupPong() {
  a=150;  b=360;  x=(int)random(20,480);  y=10;  dx=2;  dy=3;  pongScore=0;
   check=true;  start=false;
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
  

void draw () {
  if(myPort.available() > 0){
    val = myPort.readStringUntil('\n') + 'a';
  }
  if (page == 0) {
    rectMode(CORNER);
    background(0);
    textSize(40);
    noStroke();
    fill(0,255,0);
    text("AR", 155,60);
    textSize(60);
    fill(255,0,0);
    text("KA", 212,65);
    textSize(40);
    fill(0,0,255);
    text("DE", 295,60);
    
    stroke(0);
    ellipse(100,175,50,25);
    
    if(val.charAt(0) != 'L') {
      noStroke();
      rect(76,150, 49, 25);
      stroke(0);
      ellipse(100,150,50,25);
    } else {
      page = 1;
    }
    
    stroke(100,100,100);
    line(65,220, 45,200);
    line(55,220, 45,210);
    line(65,210, 55,200);
    stroke(0);
    fill(0,0,255);
    ellipse(65,220, 20,20);
    fill(255,0,255);
    rect(65,250, 70, 15);
    
    fill(0,255,0);
    ellipse(200,175,50,25);
    if(val.charAt(0) != 'P') {
    noStroke();
    rect(176,150, 49, 25);
    stroke(0);
    ellipse(200,150,50,25);
    } else {
      page = 2;
    }
    
    image(menu[0], 150, 200,100,100);
    
    
    fill(255,0,0);
    ellipse(300,175,50,25);
    if(val.charAt(0) != 'S') {
    noStroke();
    rect(276,150, 49, 25);
    stroke(0);
    ellipse(300,150,50,25);
    }
    
    image(menu[2],245,215,130,65);

    fill(255,255,255);
    ellipse(400,175,50,25);
    if(val.charAt(0) != 'R') {
    noStroke();
    rect(376,150, 49, 25);
    stroke(0);
    ellipse(400,150,50,25);
    }
    
    image(menu[1],375,213,75,75);
    
  } else if (page == 1) { //game pong
    textSize(20);
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


    if(a-28<x&&a+28>x&&y>345){dy=-3; pongScore++;}  

  x+=dx;
  y+=dy;
      
      if(y>390){
        check=false;
        text("YOU LOSE!",200,200);
      } 

    }
 // text(val,10,10);
  if (start == false) text ("Press enter to begin!", 180, 190);
 if ((val.charAt(0) == 'P'||key==ENTER) && !start)
 { println("here");
   start = !start; 
   val = "null";
 }
  if ((val.charAt(0) == 'P'||key==ENTER) && start) { 
    val = "null";
    page = 0;
  }
 
  if(check==false) {  text("Score: "+pongScore, 220,180); 
delay(100);
setupPong();
} 
  } else if (page == 2) { //space invaders
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
}
