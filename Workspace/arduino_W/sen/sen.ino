int re = 0;
int i = 0;
unsigned long START = 0;
unsigned long  STOP = 0;
int s = 0;
unsigned long  kyo;
unsigned long sec;
bool flag = false;
bool count = false;
int I_count = 0;
unsigned long backup = 0;
static int tame = 30;
void setup() {
  // put your setup code here, to run once:
  pinMode(22, OUTPUT);
  pinMode(A0, INPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:

  digitalWrite(22, HIGH);
  delayMicroseconds(10);
  digitalWrite(22, LOW);
  re = analogRead(A0);
  /*
    if (re > 0) {
    re = 1;
    }*/
  if (flag == false and re > 0) {
    flag = true;
    START = micros();
  }
  if (flag == true and re == 0) {
    flag = false;
    STOP = micros();
    //Serial.print(I_count);
    sec = (STOP - START);
    kyo = sec * 0.034 / 2;
    Serial.println(kyo);
    //Serial.println(sec);
    kyo = 0;
    //Serial.println(kyo);
    for (int i = 0; i < 2000; i++) {}
  }
  //Serial.println(re);
  //Serial.println(re);
  //digitalWrite(22, LOW);
  
}
