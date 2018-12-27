#define UP 1
#define DOWN 2
#define RIGHT 3
#define LEFT 4
#define SPINR 5
#define SPINL 6
#define UR 7
#define DR 8
#define DL 9
#define UL 10
#define STOP 11
#define FREE 12

int TIRES[4][2] = {
  {1, 2}, //UR
  {3, 4},
  {5, 6},
  {7, 8}  //UL
};

int H_L[12][4] = {
  { -1, -1, 1, 1},
  {1, 1, -1, -1},
  {1, -1, -1, 1},
  { -1, 1, 1, -1},
  {1, 1, 1, 1},
  { -1, -1, -1, -1},
  {0, -1, 0, 1},
  {1, 0, -1, 0},
  {0, 1, 0, -1},
  { -1, 0, 1, 0},
  {2,2,2,2},
  {0,0,0,0}
};

void Move(int num,int pwm = 255) {
  for (int i = 0; i < 4; i++) {
    int v = H_L[num][i];
    if (v == 0) {
      digitalWrite(TIRES[i][0], 0);
      digitalWrite(TIRES[i][1], 0);
    } else if (v == 1) {
      analogWrite(TIRES[i][0], pwm);
      digitalWrite(TIRES[i][1], 0);
    } else if (v == -1) {
      digitalWrite(TIRES[i][0], 0);
      analogWrite(TIRES[i][1], pwm);
    }else if(v == 2){
      analogWrite(TIRES[i][0],pwm);
      analogWrite(TIRES[i][1],pwm);
      }
  }
};

#include<PS4BT.h>
USB Usb;
BTD Btd(&Usb);
PS4BT PS4(&Btd);

double ang(float re_y, float re_x) {
  if (abs(re_y) > gosa && abs(re_x) > gosa) {
    double rad = atan2(re_y, re_x) * 180 / PI;
    rad = -rad;
    if (rad < 0) {
      rad = rad + 360;
    }
  } else {
    rad = 0;
  }
  return (rad);
}
//やったぜ
static double gosa = 5;
bool flag = false;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  while (!Serial);
  if (Usb.Init() == -1) {
    Serial.print(F("\nPS4 Do Not Connect \n"));
    while (1);
  }
  Serial.print(F("\nPS4 OK Program  Start\n"));

}
float re_y, re_x;
bool to_right = false;
bool F_gosa = false;
void loop() {
  // put your main code here, to run repeatedly:
  Usb.Task();
  if (PS4.connected()) {
    re_y =  PS4.getAnalogHat(LeftHatY) - 127.5;
    re_x =  PS4.getAnalogHat(LeftHatX) - 127.5;
    double angle = ang(re_y, re_x) * 2;
    if(PS4.getButtonClick(TRIANGLE)){
      
    }else if(angle == 0){
      F_gosa == true;
    }else if (!F_gosa && angle >= 22.5 && angle < 67.5) {
      to_right == true;
      Move(UR);
    } else if (!F_gosa && angle >= 67.5 && angle < 112.5) {
      to_right == true;
      Move(UP);
    } else if (!F_gosa && angle >= 112.5 && angle < 157.5) {
      to_right == true;
      Move(UL);
    } else if (!F_gosa && angle >= 157.5 && angle < 202.5) {
      to_right == true;
      Move(LEFT);
    } else if (!F_gosa && angle >= 202.5 && angle < 247.5) {
      to_right == true;
      Move(DL);
    } else if (!F_gosa && angle >= 247.5 && angle < 292.5) {
      to_right == true;
      Move(DOWN);
    } else if (!F_gosa && angle >= 292.5 && angle < 337.5) {
      to_right == true;
      Move(DR);
    } else if (!F_gosa && !to_right) {
      Move(RIGHT);
    }

    F_gosa = false;
    to_right = false;



    if (PS4.getButtonClick(PS)) {
      PS4.disconnect();
    }
  }
}
