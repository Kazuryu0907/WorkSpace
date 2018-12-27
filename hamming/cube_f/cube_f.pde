import controlP5.*;
import processing.serial.*;

Serial ser;
int sou_x, sou_y;
void setup() {
  size(600, 600);
  fill(0);
  rect(width/2-200, height/2-200, 400, 400);
  //ser = new Serial(this,"XXXX",115200);
}
int x = 100;
int y = 500;
void draw() {
  fill(0, 255, 0);
  ellipse(x, y, 8, 8);
}

int high, low;
int high_l, high_h, low_l, low_h;
int P1, P2, P3;
void mousePressed() {
  fill(0);
  rect(width/2-200, height/2-200, 400, 400);
  if (mouseX > width/2-200 && mouseX < width/2+200 && mouseY > height/2-200 && mouseY < height/2+200) {
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 8, 8);
    sou_x = int(mouseX)-x;
    sou_y = -(int(mouseY)-y);
    print("X:");
    print(sou_x);
    print("Y:");
    println(sou_y);


    ser.write('X');

    high = sou_x >> 8;
    high_l = high & 15;
    low = sou_x & 255;
    low_h = low >> 4;
    low_l = low & 15;

    ser.write(bit(high_l));
    ser.write(bit(low_h));
    ser.write(bit_l(low_l,sou_x));



    ser.write('Y');
    
    high = sou_y >> 8;
    high_l = high & 15;
    low = sou_y & 255;
    low_h = low >> 4;
    low_l = low & 15;
    
    ser.write(bit(high_l));
    ser.write(bit(low_h));
    ser.write(bit_l(low_l,sou_y));

  }
}

int bit(int i) {
  println(binary(i));
  int X4 = int(i&1);
  int X3 = int(i&2) >> 1;
  int X2 = int(i&4) >> 2;
  int X1 = int(i&8) >>3;
  println(X1);
  println(X2);
  println(X3);
  println(X4);
  int P1 = X1 ^ X3 ^ X4;
  int P2 = X1 ^ X2 ^ X4;
  int P3 = X1 ^ X2 ^ X3;
  print(P1);
  print(P2);
  println(P3);
  int fum = P1 * 4+P2*2+P3;
  println(binary(fum));
  int fin = int(i) << 3| fum;
  print(X1);
  print(X2);
  print(X3);
  print(X4);
  print(P1);
  print(P2);
  println(P3);
  println(binary(fin));
  return(fin);
}
int bit_l(int i,int z_x) {
  int L1;
  if (z_x < 0) {
    L1 = 0;
  } else {
    L1 = 1;
  }
  println(binary(i));
  int X4 = int(i&1);
  int X3 = int(i&2) >> 1;
  int X2 = int(i&4) >> 2;
  int X1 = int(i&8) >>3;
  println(X1);
  println(X2);
  println(X3);
  println(X4);
  int P1 = X1 ^ X3 ^ X4;
  int P2 = X1 ^ X2 ^ X4;
  int P3 = X1 ^ X2 ^ X3;
  print(P1);
  print(P2);
  println(P3);
  int fum = P1 * 4+P2*2+P3;
  println(binary(fum));
  int fin = int(i) << 4| fum << 1 | L1;
  print(X1);
  print(X2);
  print(X3);
  print(X4);
  print(P1);
  print(P2);
  println(P3);
  println(binary(fin));
  return(fin);
}
