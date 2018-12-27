int pins[] = {};
//static int max_ = 1024;
int leds = 0;
int mod = 0;
static int an_pin = 0;
static int max_sen = 0;
int va;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
attachInterrupt(an_pin,WARI,CHANGE);
}
/*
  val = analogWrite(an_pin);
  i = val/max_sen*100;
*/
void WARI() {
  int re = analogRead(an_pin);
  Serial.println(re);
  int i = re / max_sen * 100;
  leds = i / 10;
  leds = constrain(leds-1,0,9);
  mod = i % 10;
  for (int a = 0; a <= leds; a++) {
    analogWrite(pins[a], 255);
  }
  if (leds != 9) {
    analogWrite(pins[leds + 1], mod * 255 / 10);
  }

}
