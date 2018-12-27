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
int z_x, z_y;
static int textsize = 15;
int si_ta = 0;
boolean Con_F = false;
boolean Fi = false;
boolean cont = false;
int time = 0;
boolean F_X = false;
boolean F_Y = false;
boolean F_A = false;
int C_x, C_y, C_a;
int high, low;
int Con_cou = 0;
boolean F_gosa;
boolean to_right = false;
boolean M_flag = false;
int countcount = 0;
//static long PI=  3.1492653589793;

ControlP5 slider;
void setup() {
  size(900, 300);
  z_x= 0;
  z_y = 0;
  translate(width/2, height/2);
  //ser = new Serial(this, "COM7", 115200);
}



void serialEvent(Serial p) {
  //println("ser");
  delay(10);
  if (Con_F == false) {
    if (ser.available() > 0) {
      iti = ser.read();
    }
  } else {
    //println("else");
    if (ser.available()>0) {
      //ser.write('F');
      int i = ser.read();
      Serialcon(i);
      //println(i);
    } else {
      iti = ser.read();
    }
  }
}
void draw() {
  background(0);
  if (Con_F == false) {
    if (iti == 51) {
      Con_F = true;
      time = millis()+3000;
    }
  }

  if (Con_F == false) {
    //Nosignal();
    countcount = (countcount+1)%360;
    Cont(30, 30, countcount);
    print(F_gosa);
    println(to_right);
  } else {
    if (millis() < time) {
      Connected();
    } else {
      if (Fi == false) {
        println("F");
        ser.write('F');
        Fi = true;
      } else {
        //println("cont");
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
  if (cont == false) {
    slider();
    cont = true;
  }
  fill(255);
  ellipse(width/2, height/2, 255, 255);
  line(width/2 - 127.5, height/2, width/2 + 127.5, height/2);
  line(width/2, 22.5, width/2, 277.5);
  Drawscale();
  fill(255, 0, 0);
  ellipse(width/2+z_x, height/2+z_y, 5, 5);
  fill(0, 127, 0, 127);
  ellipse(width/2, height/2, gosa, gosa);
  fill(255, 0, 0);
  text("X:", width/2+width/4+30, height/2-50-20);
  text("Y:", width/2+width/4+30, height/2-20-20);
  text("A:", width/2+width/4+30, height/2+10-20);
  text(x, width/2+width/4+30+15, height/2-50-20);
  text(y, width/2+width/4+30+15, height/2-20-20);
  text(si_ta, width/2+width/4+30+15, height/2+10-20);
  Drawconer();
  for (int i=0; i <3; i++) {
    switch(i) {
    case 0:
      if (F_gosa == false && si_ta > 112.5 && si_ta < 157.5) {
        println(00);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+10+10+10+5, 35, 35, 30);
      break;
    case 1:
      if (F_gosa == false && si_ta > 67.5 && si_ta < 112.5) {
        println(01);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+10+10+10+5, 35, 35, 30);
      break;
    case 2:
      if (F_gosa == false && si_ta > 22.5 && si_ta < 67.5) {
        println(02);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+10+10+10+5, 35, 35, 30);
      break;
    }
  }
  for (int i=0; i <3; i++) {
    switch(i) {
    case 0:
      if (F_gosa == false && si_ta > 157.5 && si_ta < 202.5) {
        println(10);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+10+10+5, 35, 35, 30);
      break;
    case 1:
      if (x*x+y*y <= gosa*gosa) {
        println(11);
        fill(0, 255, 0);
        F_gosa= true;
      } else {
        fill(255, 0, 0);
        F_gosa = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+10+10+5, 35, 35, 30);
      break;
    case 2:
      if (to_right || F_gosa ) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+10+10+5, 35, 35, 30);
      break;
    }
  }
  for (int i=0; i <3; i++) {
    switch(i) {
    case 0:
      if (F_gosa == false && si_ta > 202.5 && si_ta < 247.5) {
        println(20);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+35+10+5+10+5, 35, 35, 30);
      break;
    case 1:
      if (F_gosa == false && si_ta > 247.5 && si_ta < 292.5) {
        println(21);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+35+10+5+10+5, 35, 35, 30);
      break;
    case 2:
      if (F_gosa == false && si_ta > 292.5 && si_ta < 337.5) {
        println(22);
        fill(0, 255, 0);
        to_right = true;
      } else {
        fill(255, 0, 0);
        to_right = false;
      }
      rect(width/2+width/4+35*i+10*i, height/2+10-20+40+10+35+10+5+10+5, 35, 35, 30);
      break;
    }
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

void Serialcon(int i) {
  if (F_X) {
    C_x = C_x+1;
    switch(C_x) {
    case 1:
      if (i == 'M') {
        M_flag = true;
        C_x = 0;
      } else {
        low = i;
      }
      break;
    case 2:
      high = i;
      z_x = high*256+low;
      if (M_flag) {
        z_x = -z_x;
      }
      //println(z_x);
      high = 0;
      low = 0;
      Con_cou += 1; 
      F_X = false;
      M_flag = false;
      break;
    }
  }
  if (F_Y) {
    C_y = C_y+1;
    switch(C_y) {
    case 1:
      if (i == 'M') {
        M_flag = true;
        C_y = 0;
      } else {
        low = i;
      }
      break;
    case 2:
      high = i;
      z_y = high*256+low;
      if (M_flag) {
        z_y = -z_y;
      }
      // println(z_y);
      high = 0;
      low = 0;
      Con_cou += 1; 
      F_X = false;
      M_flag = false;
      break;
    }
  }
  if (F_A) {
    C_a = C_a+1;
    switch(C_a) {
    case 1:
      if (i == 'M') {
        M_flag = true;
        C_x = 0;
      } else {
        low = i;
      }
      break;
    case 2:
      high = i;
      si_ta = high*256+low;
      //println(si_ta);
      high = 0;
      low = 0;
      Con_cou += 1;
      F_A = false;
      M_flag = false;
      break;
    }
  }

  if (i == 'X') {

    F_X = true;
    C_x = 0;
  }
  if (i == 'Y') {
    F_Y = true;
    C_y = 0;
  }
  if (i == 'A') {
    F_A = true;
    C_a = 0;
  }

  if (Con_cou == 3) {
    Con_cou = 0;
    delay(30);
    //println("F'");
    ser.write('F');
  }
}

void Drawconer() {
  fill(255, 0, 0, 90);
  arc(width/2, height/2, 255, 255, radians(22.5), radians(67.5));
  arc(width/2, height/2, 255, 255, radians(22.5+180), radians(67.5+180));
  fill(0, 0, 255, 90);
  arc(width/2, height/2, 255, 255, radians(22.5+90), radians(67.5+90));
  arc(width/2, height/2, 255, 255, radians(22.5+180+90), radians(67.5+180+90));
  fill(255, 127, 127, 90);
  arc(width/2, height/2, 255, 255, radians(22.5+45), radians(67.5+45));
  arc(width/2, height/2, 255, 255, radians(22.5+180+45), radians(67.5+180+45));
  fill(127, 127, 255, 90);
  arc(width/2, height/2, 255, 255, radians(22.5+135), radians(67.5+135));
  arc(width/2, height/2, 255, 255, radians(22.5+180+135), radians(67.5+180+135));
}
