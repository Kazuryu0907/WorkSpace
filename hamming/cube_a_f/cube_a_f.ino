void setup() {

  Serial.begin(9600);
}

int  C_x, C_y;
bool F_X = false;
bool F_Y = false;
bool M_flag = false;
int high_h,high_l,low_h,low_l;
int z_x, z_y;
void loop() {

  if (Serial.available() > 0) {
    int i = Serial.read();
    if (F_X) {
      C_x = C_x + 1;
      switch (C_x) {
        case 1:
          high_l = Dec(i);
          break;
        case 2:
          low_h = Dec(i);
          break;
        case 3:
          low_l = Dec_l(i);
          z_y = int(high_l << 8 | low_h << 4 | low_l);
          if (M_flag) {
            z_x = -z_x;
          }
          F_X = false;
          M_flag = false;
          break;
      }
    }
    if (F_Y) {
      C_y = C_y + 1;
      switch (C_y) {
        case 1:
          high_l = Dec(i);
          break;
        case 2:
          low_h = Dec(i);
          break;
        case 3:
          low_l = Dec_l(i);
          z_y = int(high_l << 8 | low_h << 4 | low_l);
          if (M_flag) {
            z_y = -z_y;
          }
          M_flag = false;
          F_Y = false;
          break;
      }
    }
  }
  
}


int Dec(int i) {
  int P3 = int(i & 1);
  int P2 = int(i & 2) >> 1;
  int P1 = int(i & 4) >> 2;
  int X4 = int(i & 8) >> 3;
  int X3 = int(i & 16) >> 4;
  int X2 = int(i & 32) >> 5;
  int X1 = int(i & 64) >> 6;
  int D1 = X1 ^ X3 ^ X4 ^ P1;
  int D2 = X1 ^ X2 ^ X4 ^ P2;
  int D3 = X1 ^ X2 ^ X3 ^ P3;
  if (D1 == 1 and D2 == 1 and D3 == 1) {
    X1 = (X1 + 1) % 2;
  } else if (D1 == 0 and D2 == 1 and D3 == 1) {
    X2 = (X2 + 1) % 2;
  } else if (D1 == 1 and D2 == 0 and D3 == 1) {
    X3 = (X3 + 1) % 2;
  } else if (D1 == 1 and D2 == 1 and D3 == 0) {
    X4 = (X4 + 1) % 2;
  }
  int num = X1 << 3 | X2 << 2 | X3 << 1 | X4;
  return (num);
}

int Dec_l(int i) {
  int La = int(i & 1);
  int P3 = int(i & 2) >> 1;
  int P2 = int(i & 4) >> 2;
  int P1 = int(i & 8) >> 3;
  int X4 = int(i & 16) >> 4;
  int X3 = int(i & 32) >> 5;
  int X2 = int(i & 64) >> 6;
  int X1 = int(i & 128) >> 7;
  int D1 = X1 ^ X3 ^ X4 ^ P1;
  int D2 = X1 ^ X2 ^ X4 ^ P2;
  int D3 = X1 ^ X2 ^ X3 ^ P3;
  if (D1 == 1 and D2 == 1 and D3 == 1) {
    X1 = (X1 + 1) % 2;
  } else if (D1 == 0 and D2 == 1 and D3 == 1) {
    X2 = (X2 + 1) % 2;
  } else if (D1 == 1 and D2 == 0 and D3 == 1) {
    X3 = (X3 + 1) % 2;
  } else if (D1 == 1 and D2 == 1 and D3 == 0) {
    X4 = (X4 + 1) % 2;
  }
  int num = X1 << 3 | X2 << 2 | X3 << 1 | X4;
  if (La == 0) {
    M_flag = true;
  }
  return (num);
}
