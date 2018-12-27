import processing.serial.*;
import controlP5.*;

Serial ser;
static int haba = 30;
static int y = 80;
static int y2 = 200;
int iti;
int count = 0;
int count_tou = 0;
int i = 0;
int gosa;
float z_x, z_y;
static int textsize = 15;
float si_ta = 360;
boolean Con_F = false;
boolean Fi = false;
boolean cont = false;
int time = 0;
//static long PI=  3.1492653589793;

ControlP5 slider;
void setup() {
  size(600, 300);
  z_x= -30;
  z_y = 60;
  translate(width/2, height/2);
  //ser = new Serial(this,"COM6",115200);
}

void serialEvent(Serial p) {
  delay(10);
  if (ser.available()>2) {
    z_x = ser.read();
    z_y = ser.read();
    si_ta = ser.read();
    delay(10);
    ser.write(0);
  } else {
    iti = ser.read();
  }
}
void draw() {
  background(0);
  if (iti == 361) {
    Con_F = true;
    time = millis()+2000;
  }


  if (Con_F == false) {
    Nosignal();
    //Cont(30,30,10);
  } else {
    if (millis() < time) {
      Connected();
    } else {
      if (Fi == false) {
        ser.write(0);
        Fi = true;
      } else {
        Cont(z_x, z_y, si_ta);
      }
    }
  }
}

void dai(int z, int R, int G, int B) {
  fill(R, G, B);
  beginShape();
  vertex(z, y);
  vertex(z-20, y+20);
  vertex(z+20, y+20);
  vertex(z+40, y);
  endShape(CLOSE);
}
void dai2(int z, int R, int G, int B) {
  fill(R, G, B);
  beginShape();
  vertex(z, y2);
  vertex(z-20, y2+20);
  vertex(z+20, y2+20);
  vertex(z+40, y2);
  endShape(CLOSE);
}

void Nosignal() {
  background(128, 128, 0);
  fill(255, 255, 0);
  rect(0, 80, width, 140);
  fill(255, 0, 0, sin(count_tou/20*PI/2/2)*255);
  //textSize(3);
  textAlign(CENTER);
  PFont myFont = loadFont("NirmalaUI-Bold-48.vlw");
  textFont(myFont);
  text("NO SIGNAL!", 300, 150+15);

  for (int i = 0; i < 15; i++) {
    int a = i*2-2;
    a = a*40;
    a = a+count;
    dai(a, 255, 0, 0);
  }

  for (int i = 0; i < 15; i++) {
    int a = i*2-2;
    a = a*40;
    a= a-count;
    dai2(a, 255, 0, 0);
  }

  count = (count+2)%80;
  count_tou= (count_tou+1)%80;
}

void Connected() {
  background(0, 0, 64);
  fill(0, 0, 128);
  rect(0, 80, width, 140);
  fill(0, 255, 0, sin(count_tou/20*PI/2/2)*255);
  //textSize(3);
  textAlign(CENTER);
  PFont myFont = loadFont("NirmalaUI-Bold-48.vlw");
  textFont(myFont);
  text("Connected!", 300, 150+15);

  for (int i = 0; i < 15; i++) {
    int a = i*2-2;
    a = a*40;
    a = a-count;
    dai(a, 0, 255, 0);
  }

  for (int i = 0; i < 15; i++) {
    int a = i*2-2;
    a = a*40;
    a= a+count;
    dai2(a, 0, 255, 0);
  }

  count = (count+2)%80;
  count_tou= (count_tou+1)%80;
}

void Cont(float z_x, float z_y, float si_ta) {
  float x = z_x;
  float y = z_y;
  z_x = z_x/2;
  z_y = z_y/2;
  if(cont == false){
  slider();
  cont = true;
  }
  fill(255);
  ellipse(300, 150, 255, 255);
  line(172.5, height/2, 427.5, height/2);
  line(width/2, 22.5, width/2, 277.5);
  Drawscale();
  fill(255, 0, 0);
  ellipse(width/2+z_x, height/2+z_y, 5, 5);
  fill(0, 127, 0, 127);
  ellipse(width/2, height/2, gosa, gosa);
  fill(255, 0, 0);
  text("X:", width/2+width/4+30, height/2-50-20);
  text("Y:", width/2+width/4+30, height/2-20-20);
  text("θ:", width/2+width/4+30, height/2+10-20);
  text(x, width/2+width/4+30+15, height/2-50-20);
  text(y, width/2+width/4+30+15, height/2-20-20);
  text(si_ta, width/2+width/4+30+15, height/2+10-20);
  if(x*x+y*y <= gosa*gosa){
  fill(0,255,0);
  }else{
  fill(255,0,0);
  }
  rect(width/2-200+20, height/2-130, 35, 35, 30); 
  fill(127, 0, 255);
  textSize(20);
  text("S", width/2-200+20+15-3, height/2-130+24);
  fill(255, 0, 0);
  for (int i=0; i <3; i++) {
    rect(width/2+width/4+35*i+10*i, height/2+10-20+10+10+10+5, 35, 35, 30);
  }
  for (int i=0; i <3; i++) {
    rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+10+10+5, 35, 35, 30);
  }
  for (int i=0; i <3; i++) {
    rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+35+10+5+10+5, 35, 35, 30);
  }
}
void Drawscale() {
  textSize(textsize);
  text("255", width/2+127.5, height/2+textsize/2-2);
  text("-255", width/2-127.5-textsize*(4-1)+6, height/2+textsize/2-2);
  text("255", width/2-13, height/2+127.5+textsize);
  text("-255", width/2-22, height/2-127.5-textsize+10);
}

void slider() {
  slider = new ControlP5(this);
  slider.addSlider("gosa")
    //.setLabel("bbb")
    .setRange(0, 50)//0~100の間
    .setValue(5)//初期値
    .setPosition(50, 40)//位置
    .setSize(30, 200)//大きさ

    .setNumberOfTickMarks(50);//Rangeを(引数の数-1)で割った値が1メモリの値
}
