static int leds[] = {13, 12, 11, 10, 9, 8, 7, 6, 5, 4};
int han[10] = {0,0,0,0,0,0,0,0,0,0};
int pw[10] =  {0, -20,-40, -60, -80, -100, -120, -140, -160, -180};
int POWER = 0;
static int zure = 10;
void setup() {
  // put your setup code here, to run once:
  PIN();
  Serial.begin(9600);
  //Serial.println(han);
  //Serial.println(pw);
}

void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0; i <= 9; i++) {
    //Serial.println(i);
    POWER = PWM(i);
    Serial.print(i);
    Serial.print(": ");
    Serial.println(pw[i]);
    analogWrite(leds[i], POWER);
    delay(zure);
  }
}


void PIN() {
  for (int i = 0; i <= 9; i++) {
    pinMode(leds[i], OUTPUT);
  }
}

int PWM(int num) {
  int flag = han[num];
  int pwm = pw[num];
  if (flag == 0) {
    pwm = pwm + 10;
    if (pwm >= 255) {
      han[num] = 1;
    }
  } else {
    pwm = pwm - 10;
    if (pwm <= 0) {
      han[num] = 0;
    }
  }
  pw[num] = pwm;
  return pwm;
}
