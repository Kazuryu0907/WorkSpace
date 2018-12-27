#include <SoftwareSerial.h>

#include "config.h"



#define moveeyRX 51

#define moveeyTX 22

SoftwareSerial moveey(51, 22); //moveeyとの通信用



void setup() {

  Serial.begin(9600);

  pinMode(22, OUTPUT);

  pinMode(51, INPUT);

  moveey.begin(9600);

  moveey.listen();

  //sendSlCommand();

}


int i;
bool F_X = false;
bool F_Y = false;
int C_x, C_y;
bool M_flag = false;
int z_x, z_y;
int high, low;
int Con_cou;
bool start  = false;


void loop() {

  if(start){
    //sendSlCommand(z_x,z_y);
    start = false;
    }
    
  if ((i = moveey.read()) != -1) {
    Input(i);
  }
}


void Input(int i) {
  if (i == 'X') {
    F_X = true;
    C_x = 0;
  }
  if (i == 'Y') {
    F_Y = true;
    C_y = 0;
  }
  if (F_X) {
    C_x = C_x + 1;
    switch (C_x) {
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
        z_x = high * 256 + low;
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
    C_y = C_y + 1;
    switch (C_y) {
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
        z_y = high * 256 + low;
        if (M_flag) {
          z_y = -z_y;
        }
        high = 0;
        low = 0;
        Con_cou += 1;
        F_X = false;
        M_flag = false;
        break;
    }

  }
  if (Con_cou == 2) {
    Con_cou = 0;
    start = true;
  }

}
