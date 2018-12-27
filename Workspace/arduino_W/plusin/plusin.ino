static int pin = A0;
static int O_pin = 22;
unsigned long T;
unsigned long Kyo;
void setup() {
  Serial.begin(9600);
  pinMode(O_pin, OUTPUT);
}
void loop() {
  digitalWrite(O_pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(O_pin, LOW);
  T = pulseIn(pin, HIGH);
  Kyo = T * 0.034 / 2 ;
  //Serial.print("Time: ");
  //Serial.println(T);
  if (T != 0) {
    Serial.print("Kyori: ");
    Serial.println(Kyo);
  }

}
