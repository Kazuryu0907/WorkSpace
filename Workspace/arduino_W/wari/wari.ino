static int lpin = 22;
static int p = 40;
unsigned long START;
unsigned long STOP;
bool flag_loop = true;
bool flag_on = false;
unsigned long  kyo;
unsigned long sec;
int count = 0;
void setup() {
  // put your setup code here, to run once:
  pinMode(lpin, OUTPUT);
  pinMode(p, OUTPUT);
  Serial.begin(9600);
}
void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(22, HIGH);
  delayMicroseconds(10);
  digitalWrite(22, LOW);
  while (flag_loop) {
    attachInterrupt(2, wari, CHANGE);
  }
  flag_loop = true;
 for(int i;i<=200;i++){
  
 }
}
void wari() {
  //Serial.println(flag);
  count = (count + 1) % 2;
  flag_on = !flag_on;
  if (flag_on) {
    START = micros();
  }
  if (!flag_on) {
    STOP = micros();
    sec = (STOP - START);
    kyo = sec * 34000/1000000/2;
    if(kyo != 0){
    Serial.println(kyo);
    }
  }
  if (count == 0) {
    flag_loop = false;
  }
}
