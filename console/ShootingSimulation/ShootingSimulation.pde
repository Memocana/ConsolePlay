import processing.serial.*;
Serial myPort;
String val = "a";


int x, y=0, bulletX=240, h=50, i=0;
int score=0, reload=30, disp=6;
int[] ammo = new int[3];
int[] sp = new int[3];
int[] bulletY = new int[3]; 
PImage[] img = new PImage[3];
boolean shoot=false,collision=false,end=false,chosen=false;

void setup() {
  size(600, 600); 
  img[1] = loadImage("revolver.jpg");
  img[0] = loadImage("shotgun.jpg");
  img[2] = loadImage("machinegun.jpg");
  ammo[0]=8;
  ammo[1]=6;
  ammo[2]=12;
  bulletY[0] = 275;
  bulletY[1] = 268;
  bulletY[2] = 275;
  for(int a=0;a<3;a++)sp[a]=5*a+10;
  x=width-100;
  
 String portName = Serial.list()[2];
 myPort = new Serial(this,portName,9600); 
}

int chooseGun() {
 textSize(20);
 int gun=1;
 if(chosen==false){
 text("Choose Your Gun",230,200);
 fill(255,0,0);
 rect(70,220,150,50);
 rect(240,220,150,50);
 rect(410,220,150,50);
 fill(255);
 text("Shotgun",105,251); 
 text("Revolver",275,251);
 text("Machine Gun",425,251);
 if(mousePressed&&mouseX>70&&mouseX<220&&mouseY>220&&mouseY<270){
   gun=0;
   chosen=true; 
 }
 else if(mousePressed&&mouseX>240&&mouseX<390&&mouseY>220&&mouseY<270){
   gun=1;
   chosen=true;
 }
 else if(mousePressed&&mouseX>410&&mouseX<560&&mouseY>220&&mouseY<270){
   gun=2;   
   chosen=true;
 }
}
 return gun;

}


void draw() {
   if(myPort.available() > 0){
  val = myPort.readStringUntil('\n') + 'a'; 
 }
  
  
  
  if(!chosen){
  i=chooseGun();
  reload=ammo[i]*5;
  disp=ammo[i];
  }
  textSize(50);
  if(end) text("The End.",225,400);
  else if(chosen){
  background(255);
  fill(#464646);
  ellipse(bulletX, bulletY[i], 8, 8); //bullet
  image(img[i], 50, height/2-50, 200, 100); //gun
  if(val.charAt(0)=='S'&&disp>0)shoot=true;
  if(shoot) bulletX+=sp[i];
  if(bulletX>height||collision){
    shoot=false;
    bulletX=240;
  }
  //reload
  if(val.charAt(0)=='P'){
   // reload-=ammo;
    disp=ammo[i];
  }
  fill(0,0,255);
  if(y>height||collision) y=0;
  if(y==0) {
    h=(int)random(60,120);
    collision=false;
  }
  fill(0,0,255);
  rect(x,y,10,h);
  y+=5;
  
  //collision detection
  if(bulletX>=500&&bulletY[i]>y&&bulletY[i]<y+h-5){
   collision=true;
   score+=(130-h);    
  } 
  if(bulletX>240&&bulletX<=240+sp[i]){
    reload--;
    disp--;
  }
  textSize(30);
  fill(0,255,0);
  text("Score: "+score,50,50);
  fill(255,0,0);
  if(disp>=0)
  text("Ammo: "+disp,50,100);
  textSize(15);
  text("Enter to reload!",60,150);
  if(reload<=0)end=true;
}
}

