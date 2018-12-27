import controlP5.*;
import processing.serial.*;
import java.util.Arrays;

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
int[] z_xs = {};
int[] z_ys = {};
int[] ecc = {};
int[] ecc_iti = {};
int[] reset = {};
int hai_x;
int hai_y;
boolean flag = false;
int back_x = 0;
int back_y = 0;
boolean first = true;
int iti_x, iti_y;
int max = 10;
void draw() {

  if (mousePressed) {
    flag = true;
    if (mouseX > width/2-200 && mouseX < width/2+200 && mouseY > height/2-200 && mouseY < height/2+200) {
      fill(0, 255, 0);
      ellipse(300, 300, 8, 8);
      /*
      fill(255, 0, 0);
       strokeWeight(0);
       ellipse(mouseX, mouseY, 8, 8);
       */
      sou_x = int(mouseX)-x;
      sou_y = (int(mouseY)-y);
      if (first) {
        iti_x = sou_x;
        iti_y = sou_y;
        first = false;
      }
      hai_x = int(mouseX);
      hai_y = int(mouseY);
      if (sq(iti_x-sou_x)+sq(iti_y-sou_y) > sq(max)) {
        fill(127, 127, 0);
        ellipse(hai_x, hai_y, 8, 8);
        iti_x = sou_x;
        iti_y = sou_y;
        z_xs = append(z_xs, hai_x);
        z_ys = append(z_ys, hai_y);
      }
      /*
      if (back_x-sou_x != 0 || back_y-sou_y != 0) {
       z_xs = append(z_xs, hai_x);
       z_ys = append(z_ys, hai_y);
       }
       */
      back_x = sou_x;
      back_y = sou_y;
    }
  } else if (flag) {

    for (int i =1; i< z_xs.length; i++) {
      if ((z_xs[i]-z_xs[i-1]) == 0) {
        ecc = append(ecc, ((z_ys[i]-z_ys[i-1])/1));
        
      } else if(z_ys[i]-z_ys[i-1] == 0){
        ecc = append(ecc, (1/(z_xs[i]-z_xs[i-1])));
      }else{
      ecc = append(ecc, ((z_ys[i]-z_ys[i-1])/(z_xs[i]-z_xs[i-1])));
      }
    }
    for (int i = 0; i < ecc.length; i++) {
      println(ecc[i]);
      if (ecc[i] != 0) {
        //line(z_xs[i], z_ys[i], z_xs[i+1], z_ys[i+1]);
        fill(0, 0, 255);
        ellipse(z_xs[i], z_ys[i], 8, 8);
      }
    }
    flag = false;
  }
}

void keyPressed() {
  if (key == BACKSPACE) {
    first = true;
    fill(0);
    rect(width/2-200, height/2-200, 400, 400);
    fill(0, 255, 0);
    ellipse(300, 300, 8, 8);
    z_xs = (int[])reset.clone();
    z_ys = (int[])reset.clone();
    ecc = (int[])reset.clone();
    println(z_xs.length);
  }
}
/*
void mousePressed() {
 
 if (mouseX > width/2-200 && mouseX < width/2+200 && mouseY > height/2-200 && mouseY < height/2+200) {
 fill(0, 255, 0);
 ellipse(300, 300, 8, 8);
 fill(255, 0, 0);
 ellipse(mouseX, mouseY, 8, 8);
 sou_x = int(mouseX)-x;
 sou_y = (int(mouseY)-y);
 hai_x = int(mouseX);
 hai_y = int(mouseY);
 z_xs = append(z_xs, hai_x);
 z_ys = append(z_ys, hai_y);
 //print(z_xs.length);
 if (z_xs.length == 2) {
 
 stroke(255, 0, 0);
 line(z_xs[0], z_ys[0], z_xs[1], z_ys[1]);
 } else if (z_xs.length > 2) {
 for (int i = 0; i < z_xs.length; i++) {
 int san = int(sqrt(sq(z_xs[i]-hai_x)+sq(z_ys[i]-hai_y)));
 ecc = append(ecc, san+int(sqrt(sq(hai_x)+sq(hai_y))));
 }
 ecc_iti = ecc;
 ecc = sort(ecc);
 
 for (int i = 0; i <ecc.length; i++) {
 println(ecc[i]);
 }
 
 for (int i = 0; i <ecc_iti.length; i++) {
 println(ecc_iti[i]);
 }
 println(Arrays.toString(ecc_iti));
 println(Arrays.binarySearch(ecc_iti, ecc[0]));
 println(ecc[0]);
 }
 }
 }
 
 void Sendint(char c, int a) {
 int high, low;
 high = a >> 8;
 low = a &255;
 }
 */
