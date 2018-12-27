/*

  2016/04/06

  PS4コントローラ通信テンプレライブラリ

*/


//PS4のヘッダーファイル
#include<PS4BT.h>    //無線
USB Usb;
BTD Btd(&Usb);       //無線
PS4BT PS4(&Btd);     //無線

//AnalogButton
#define PUSH_L2        PS4.getButtonPress(L2)
#define PUSH_R2        PS4.getButtonPress(R2)
#define PUSH_L1        PS4.getButtonPress(L1)
#define PUSH_R1        PS4.getButtonPress(R1)
#define PUSH_CIRCLE    PS4.getButtonPress(CIRCLE)
#define PUSH_TRIANGLE  PS4.getButtonPress(TRIANGLE)
#define PUSH_SQUARE    PS4.getButtonPress(SQUARE)
#define PUSH_CROSS     PS4.getButtonPress(CROSS)
#define PUSH_UP        PS4.getButtonPress(UP)
#define PUSH_DOWN      PS4.getButtonPress(DOWN)
#define PUSH_LEFT      PS4.getButtonPress(LEFT)
#define PUSH_RIGHT     PS4.getButtonPress(RIGHT)
#define PUSH_
#define PUSH_
#define PUSH_
#define PUSH_

//ButtonClick
#define CLICK_SHARE     PS4.getButtonClick(SHARE)
#define CLICK_TOUCHPAD  PS4.getButtonClick(TOUCHPAD)
#define CLICK_OPTIONS   PS4.getButtonClick(OPTIONS)
#define CLICK_L1        PS4.getButtonClick(L1)
#define CLICK_R1        PS4.getButtonClick(R1)
#define CLICK_CIRCLE    PS4.getButtonClick(CIRCLE)
#define CLICK_CROSS     PS4.getButtonClick(CROSS)
#define CLICK_SQUARE    PS4.getButtonClick(SQUARE)
#define CLICK_TRIANGLE  PS4.getButtonClick(TRIANGLE)
#define CLICK_UP        PS4.getButtonClick(UP)
#define CLICK_DOWN      PS4.getButtonClick(DOWN)
#define CLICK_LEFT      PS4.getButtonClick(LEFT)
#define CLICK_RIGHT     PS4.getButtonClick(RIGHT)

//Stick
//変数
double LeftHatY_S  = 0;
double LeftHatX_S  = 0;
double RightHatY_S = 0;
double RightHatX_S = 0;
#define LH_Y_G    60
#define LH_Y_B   195
#define LH_Y_L    60
#define LH_Y_R   195
#define RH_Y_G    60
#define RH_Y_B   190
#define RH_Y_L    60
#define RH_Y_R   190
#define STICK_L_GO      LeftHatY_S   < LH_Y_G
#define STICK_L_BACK    LeftHatY_S   > LH_Y_B
#define STICK_L_L       LeftHatX_S   < LH_Y_L
#define STICK_L_R       LeftHatX_S   > LH_Y_R
#define STICK_R_GO      RightHatY_S  < LH_Y_G
#define STICK_R_BACK    RightHatY_S  > LH_Y_B
#define STICK_R_L       RightHatX_S  < LH_Y_L
#define STICK_R_R       RightHatX_S  > LH_Y_R


#define analog_L_X   PS4.getAnalogHat(LeftHatX)
#define analog_L_Y   PS4.getAnalogHat(LeftHatY)
#define analog_R_X   PS4.getAnalogHat(RightHatX)
#define analog_R_Y   PS4.getAnalogHat(RightHatY)


#define FRR 3
#define FLR 4
#define BRR 5
#define BLR 6
#define FRN 7
#define FLN 8
#define BRN 11
#define BLN 12
//デジタルピン,doは予約コードがあるためカット

#define PI 3.1492653589793
/*
  int da = 22 ;
  int db = 24 ;
  int dc = 26 ;
  int dd = 28 ;
  int de = 30 ;
  int df = 32 ;
  int dg = 34 ;
  int dh = 36 ;
  int di = 38 ;
  int dj = 40 ;
  int dk = 42 ;
  int dl = 44 ;
  int dm = 46 ;
  int dn = 48 ;
  int dp = 50 ;
  int dq = 52 ;
  //アナログピン
  int aa = 2 ;
  int ab = 3 ;
  int ac = 4 ;
  int ad = 5 ;
  int ae = 6 ;
  int af = 7 ;
*/
//スティック用
void stick();

////////セットアップ////////
void setup() {
  //通信速度
  Serial.begin(115200);

  //pinMode
  pinMode(FRR, OUTPUT);
  pinMode(FRN, OUTPUT);
  pinMode(FLR, OUTPUT);
  pinMode(FLN, OUTPUT);
  pinMode(BRR, OUTPUT);
  pinMode(BRN, OUTPUT);
  pinMode(BLR, OUTPUT);
  pinMode(BLN, OUTPUT);
  //PS4 BT関係
  while (!Serial);
  if (Usb.Init() == -1) {
    Serial.print(F("\nPS4 Do Not Connect \n"));
    //PS4が認識できないときLED全点灯
    while (1);
  }
  Serial.print(F("\nPS4 OK Program  Start\n"));
}
////////メイン////////
//時によって変化(ピン番号)
/*
  for (di = 30; di <= 44; di +=2){
  pinMode (di, OUTPUT);
  }
  for (an = 2; an <= 7; an++;){
  pinMode (an,OUTPUT);
  }
  }
*/
const int FOOT[][2] {
  {FRR, FRN},
  {FLR, FLN},
  {BRR, BRN},
  {BLR, BLN},
};
int Write[][4] {
  {255, 255, 255, 255}, //0前
  { -255, -255, -255, -255}, //1後ろ
  { -255, 255, 255, -255}, //2右
  {255, -255, -255, 255}, //3左
  {0, 255, 255, 0}, //4右前
  {255, 0, 0, 255}, //5左前
  { -255, 0, 0, -255}, //6右後ろ
  {0, -255, -255, 0}, //7左後ろ
  { -255, 255, -255, 255}, //8右旋回
  {255, -255, 255, -255}, //9左旋回
  {400, 400, 400, 400} //10ブレーキ
};

void Move(int way, int re = 255) {
  int i = 0;
  for (i = 0; i < 4; i++) {
    if (Write[way][i] == 400) {
      digitalWrite(FOOT[i][0], HIGH);
      digitalWrite(FOOT[i][1], HIGH);
    } else if (Write[way][i] > 0) {
      analogWrite(FOOT[i][0], re * 2);
      digitalWrite(FOOT[i][1], LOW);
    }
    else if (Write[way][i] < 0) {
      digitalWrite(FOOT[i][0], LOW);
      analogWrite(FOOT[i][1], re * 2);
    }
    else if (Write[way][i] == 0) {
      digitalWrite(FOOT[i][0], LOW);
      digitalWrite(FOOT[i][1], LOW);
    }
  }
}


double ang(int re_y, int re_x) {
  re_y =  PS4.getAnalogHat(LeftHatY) - 127.5;
  re_x =  PS4.getAnalogHat(LeftHatX) - 127.5;
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
void loop() {
  Usb.Task();

  if (PS4.connected()) { //通信中に実行





    //プログラムを書くところ
    if (PS4.connected()) { //通信中に実行
      if(flag == false){
      Serial.write(361);
      flag = true;
      }
      // put your main code here, to run repeatedly:
      int re_y =  PS4.getAnalogHat(LeftHatY) - 127;
      int re_x =  PS4.getAnalogHat(LeftHatX) - 127;
      double rad = ang(re_y, re_x);
      Serial.print("X:");
      Serial.print(PS4.getAnalogHat(LeftHatX) - 127);
      Serial.print("Y:");
      Serial.print(PS4.getAnalogHat(LeftHatY) - 127);
      Serial.print("ang:");
      Serial.println(rad);
      if(Serial.available()>0){
        Serial.write(re_x*2);
        Serial.write(re_y*2);
        Serial.write(rad);
        Serial.read();
      }
      delay(10);
      /*
        Serial.print("x:");
        Serial.print(PS4.getAnalogHat(LeftHatX));
        Serial.print("y:");
        Serial.println((PS4.getAnalogHat(LeftHatY)));
      */
      /*
        if (PUSH_L2 && PUSH_R2) {
        Move(10);
        }
        else if (PS4.getAnalogHat(LeftHatY) < 80 && PS4.getAnalogHat(LeftHatX) > 180 ) {
        //↗
        Serial.print("↗:");

        int re_y = abs(127 - PS4.getAnalogHat(LeftHatY));
        int re_x = abs(127 - PS4.getAnalogHat(LeftHatX));
        int lo = int(re_x*re_x) + int(re_y*re_y);
        lo = abs(float(sqrt(lo)));
        lo = int(abs(float(lo*255)/137));
        lo = lo/2;
        Serial.println(lo*2);
        Move(4, lo);
        }
        else if (PS4.getAnalogHat(LeftHatY) < 80 && PS4.getAnalogHat(LeftHatX) < 80) {
        //↖
        Serial.print("↖:");
        int re_y = abs(127 - PS4.getAnalogHat(LeftHatY));
        int re_x = abs(127 - PS4.getAnalogHat(LeftHatX));
        double rad = 180 - atan2(re_y,re_x)*180/PI;
        int lo = int(re_x*re_x) + int(re_y*re_y);
        lo = abs(float(sqrt(lo)));
        lo = int(abs(float(lo*255)/137));
        lo = lo/2;
        Move(5, lo);
        Serial.print("θ:");
        Serial.print(rad);
        Serial.print("lo:");
        Serial.println(lo*2);
        }
        else if (PS4.getAnalogHat(LeftHatY) > 180 && PS4.getAnalogHat(LeftHatX) > 180) {
        //↘
        Serial.print("↘:");
        int re_y = abs(127 - PS4.getAnalogHat(LeftHatY));
        int re_x = abs(127 - PS4.getAnalogHat(LeftHatX));
        int lo = int(re_x*re_x) + int(re_y*re_y);
        lo = abs(float(sqrt(lo)));
        lo = int(abs(float(lo*255)/137));
        lo = lo/2;
        Move(6, lo);
        Serial.println(lo*2);
        }
        else if (PS4.getAnalogHat(LeftHatY) > 180 && PS4.getAnalogHat(LeftHatX) < 80) {
        //↙
        Serial.print("↙:");
        int re_y = abs(127 - PS4.getAnalogHat(LeftHatY));
        int re_x = abs(127 - PS4.getAnalogHat(LeftHatX));
        int lo = int(re_x*re_x) + int(re_y*re_y);
        lo = abs(float(sqrt(lo)));
        lo = int(abs(float(lo*255)/137));
        lo = lo/2;
        Move(7, lo);
        Serial.println(lo*2);
        }
        else if (PS4.getAnalogHat(LeftHatY) < 122) {
        Serial.print("↑:");
        re = abs(127 - PS4.getAnalogHat(LeftHatY));
        Move(0, re);
        Serial.println(re*2);
        }
        else if (PS4.getAnalogHat(LeftHatY) > 180) {
        Serial.print("↓:");
        re = abs(127 - PS4.getAnalogHat(LeftHatY));
        Move(1, re);
        Serial.println(re*2);
        }
        else if (PS4.getAnalogHat(LeftHatX) > 180) {
        Serial.print("→:");
        re = abs(127 - PS4.getAnalogHat(LeftHatX));
        Move(2, re);
        Serial.println(re*2);
        }
        else if (PS4.getAnalogHat(LeftHatX) < 80) {
        Serial.print("←:");
        re = abs(127 - PS4.getAnalogHat(LeftHatX));
        Move(3, re);
        Serial.println(re*2);
        }
        else if (PUSH_R1) {
        Serial.println("右回り");
        Move(8);
        }
        else if (PUSH_L1) {
        Serial.println("左回り");
        Move(9);
        }

        else {
        digitalWrite(FRR, HIGH);
        digitalWrite(FRN, HIGH);
        digitalWrite(FLR, HIGH);
        digitalWrite(FLN, HIGH);
        digitalWrite(BRR, HIGH);
        digitalWrite(BRN, HIGH);
        digitalWrite(BLR, HIGH);
        digitalWrite(BLN, HIGH);
        Serial.println("free");
        }*/
      //接続を切る
      if (PS4.getButtonClick(PS)) {
        PS4.disconnect();
      }
    }
  }
}
//スティック
