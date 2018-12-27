int val = 0;
float t;
unsigned long a ;
static int pin_a = ;
void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
val = analogRead(pin_a);
a = millis(); 
t = a*1000;
Serial.print(t);
Serial.print(",");
Serial.println(val);
delay(30);
}
