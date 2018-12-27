import controlP5.*;
import processing.serial.*;

Serial ser;
int sou_x, sou_y;
void setup() {
  size(600, 600);
  fill(0);
  rect(width/2-200, height/2-200, 400, 400);
  fill(0, 255, 0);
  ellipse(x, y, 8, 8);
  //ser = new Serial(this, "XXXX", 115200);
}
//int x = 100;
//int y = 500;
int x = 300;
int y = 300;

void draw() {
}

void mousePressed() {

  if (mouseX > width/2-200 && mouseX < width/2+200 && mouseY > height/2-200 && mouseY < height/2+200) {
    fill(0);
    rect(width/2-200, height/2-200, 400, 400);
    fill(0, 255, 0);
    ellipse(300, 300, 8, 8);
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 8, 8);
    sou_x = int(mouseX)-x;
    sou_y = -(int(mouseY)-y);
    print("X:");
    print(sou_x);
    Sendint('X', sou_x);
    print("Y:");
    println(sou_y);
    Sendint('Y', sou_y);
  }
}

void Sendint(char c, int a) {
  int high, low;
  high = a >> 8;
  low = a &255;
  ser.write(c);
  ser.write(high);
  ser.write(low);
}
