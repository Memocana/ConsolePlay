import processing.serial.*;
Serial myPort;
String val = "a";

//for game
PImage bg;
int x=150, y=150, score=0;
int[]  margin = new int[3];
float acc=0, speed=2;
boolean click = false, play=true, end=false;
int[] a = new int[3];
int[] b = new int[3];
int[] h = new int[3];
boolean[] changeH = new boolean[3];

 
void setup() {
 String portName = Serial.list()[2];
 myPort = new Serial(this,portName,9600);  
  
 size(600,600); 
 bg = loadImage("BlueGreen.jpg");
 a[0]=height-200;
 for(int i=0; i<2; i++) {
     a[i+1] = a[i] + 200;
  // b[i] = 0;
     h[i]=(int)random(40,300);
     changeH[i] = false;
 } 
 margin[0]=margin[1]=margin[2]=125;
}

void heights(int i) {
   h[i]=(int)random(100,200);
   margin[i]=(int)random(80,160);
}

void draw() {
  if(myPort.available() > 0){
    val = myPort.readStringUntil('\n') + 'a';
  }
  
  //check if paused / unpaused
  if(val.charAt(0) == 'P'){
    play=!play;
    fill(255,0,0);
    textSize(30);
    text("PAUSED", 190, 225);
  }
  if(!end&&play)
  {
  background(bg);
  fill(255);
  stroke(#0017FF);
  ellipse(x,y,20,20);
  fill(0); 
  if (val.charAt(0) == 'S'){
    y-=5;
    click=true;
  }
  if(click==true){
    click=false; 
  }
   
  
for(int i=0;i<3;i++){
  //draw rectangles
  if(a[i]<-30)heights(i);
  strokeWeight(2);
  stroke(#762D2D);
  fill(#934D4D);
  rect(a[i],height,30,-h[i],10);
  rect(a[i],0,30,height-h[i]-margin[i],10);
  //collision detection
  if((x>a[i]-13 && x<a[i]+13 && (y+h[i]>height||y<height-h[i]-margin[i]))||y<-25||y>height+25){
   score/=10;
   textSize(30);
   fill(0);
   text("The End. Score: " + score + ".",a[i]-100,height-h[i]-20); 
   end=true;
  } 
   a[i]-=1;
  if(changeH[i]) {
    h[i]=(int)random(100,400);
    //margin = (int) random(100,160);
    changeH[i] = false;
    }
  if(a[i]<-20) {
    changeH[i] = true;
    a[i]=height;
  }
  //increase score
  if(x>a[i]-13 && x<a[i]+13 && y<height-h[i]) score++;
 }
 y+=speed;
 if(click==false){
   acc=0.5;
   speed=2;
 }
 speed+=acc;
  }
}
  
