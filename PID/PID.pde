import controlP5.*;
ControlP5 slider;

float P, I, D;
/*
float Kp = 0.01;
 float Ki = 0.0001;
 float Kd = 0.01;//0.01
 */
float Kp = 0.09744175;
float Ki = 0.009331203;
float Kd = 0.09252518;//0.01

float mV = 1000;
float nV = 0;
float f =0;
float d = 0;
float hensa = 0;
float a, b, c;
int k;
float w = 2.0;
graphMonitor testGraph;

void setup() {
  size(1000, 600, P3D);
  frameRate(100);
  smooth();
  testGraph = new graphMonitor("PID", 100, 50, 1000, 400);
  slider("P", 30, 460);
  slider("I", 80, 460);
  slider("D", 130, 460);
}


void draw() {
  // put your main code here, to run repeatedly:
  background(250);
  testGraph.graphDraw(nV, 1000, 0);
  float sa = mV - nV;
  nV += Kp*sa;
  f += sa;
  nV += f*Ki;
  d = Kd*(sa-hensa);
  nV += d;
  hensa = sa;
  print(P/1000);
  print(",");
  print(I/1000);
  print(",");
  println(D/1000);
  //Serial.println(mV);
  text("P:", 530, 495);
  text(P/1000, 610, 495);
  text("I:", 530, 520);
  text(I/1000, 610, 520);
  text("D:", 530, 545);
  text(D/1000, 610, 545);
  text("V:", 730, 520);
  text(nV, 850, 520);
  delay(10);
}
class graphMonitor {
  String TITLE;
  int X_POSITION, Y_POSITION;
  int X_LENGTH, Y_LENGTH;
  float [] y1, y2, y3;
  float maxRange;
  graphMonitor(String _TITLE, int _X_POSITION, int _Y_POSITION, int _X_LENGTH, int _Y_LENGTH) {
    TITLE = _TITLE;
    X_POSITION = _X_POSITION;
    Y_POSITION = _Y_POSITION;
    X_LENGTH   = _X_LENGTH;
    Y_LENGTH   = _Y_LENGTH;
    y1 = new float[X_LENGTH];
    y2 = new float[X_LENGTH];
    y3 = new float[X_LENGTH];
    for (int i = 0; i < X_LENGTH; i++) {
      y1[i] = 0;
      y2[i] = 0;
      y3[i] = 0;
    }
  }

  void graphDraw(float _y1, float _y2, float _y3) {
    y1[X_LENGTH - 1] = _y1;
    y2[X_LENGTH - 1] = _y2;
    y3[X_LENGTH - 1] = _y3;
    for (int i = 0; i < X_LENGTH - 1; i++) {
      y1[i] = y1[i + 1];
      y2[i] = y2[i + 1];
      y3[i] = y3[i + 1];
    }
    maxRange = 1;
    for (int i = 0; i < X_LENGTH - 1; i++) {
      maxRange = (abs(y1[i]) > maxRange ? abs(y1[i]) : maxRange);
      maxRange = (abs(y2[i]) > maxRange ? abs(y2[i]) : maxRange);
      maxRange = (abs(y3[i]) > maxRange ? abs(y3[i]) : maxRange);
    }

    pushMatrix();

    translate(X_POSITION, Y_POSITION);
    fill(240);
    stroke(130);
    strokeWeight(1);
    rect(0, 0, X_LENGTH, Y_LENGTH);
    line(0, Y_LENGTH / 2, X_LENGTH, Y_LENGTH / 2);

    textSize(25);
    fill(60);
    textAlign(LEFT, BOTTOM);
    text(TITLE, 20, -5);
    textSize(22);
    textAlign(RIGHT);
    text(0, -5, Y_LENGTH / 2 + 7);
    text(nf(maxRange, 0, 1), -5, 18);
    text(nf(-1 * maxRange, 0, 1), -5, Y_LENGTH);

    translate(0, Y_LENGTH / 2);
    scale(1, -1);
    strokeWeight(1);
    for (int i = 0; i < X_LENGTH - 1; i++) {
      stroke(255, 0, 0);
      line(i, y1[i] * (Y_LENGTH / 2) / maxRange, i + 1, y1[i + 1] * (Y_LENGTH / 2) / maxRange);
      stroke(255, 0, 255);
      line(i, y2[i] * (Y_LENGTH / 2) / maxRange, i + 1, y2[i + 1] * (Y_LENGTH / 2) / maxRange);
      stroke(0, 0, 0);
      line(i, y3[i] * (Y_LENGTH / 2) / maxRange, i + 1, y3[i + 1] * (Y_LENGTH / 2) / maxRange);
    }
    popMatrix();
  }
}

void keyPressed() {
  if (keyCode == UP) {
    w = w + 0.1;
  }
  if (keyCode == DOWN) {
    w = w - 0.1;
  }
  if (key == 'R' || key == 'r') {
    nV = 0;
    Kp = P/1000;
    Ki = I/1000;
    Kd = D/1000;
  }
}

void slider(String s, int x, int y) {
  slider = new ControlP5(this);
  slider.addSlider(s)
    //.setLabel("bbb")
    .setRange(0, 100)//0~100の間
    .setValue(1)//初期値
    .setPosition(x, y)//位置
    .setSize(30, 100)//大きさ

    .setNumberOfTickMarks(50);//Rangeを(引数の数-1)で割った値が1メモリの値
}
