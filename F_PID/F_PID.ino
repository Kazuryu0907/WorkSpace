void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
}
double Ku = 0.1;
double Pu = 0.004;
double Kp = 0.60*Ku;
double Ki = 0.50*Pu;
double Kd = 0.125*Pu;//0.01
double mV = 1000;
double nV = 0;
double f =0;
double d = 0;
double hensa = 0;
void loop() {
  // put your main code here, to run repeatedly:
double sa = mV - nV;
nV += Kp*sa;
f += sa;
nV += f*Ki;
d = Kd*(sa-hensa);
nV += d;
hensa = sa;
Serial.println(nV);
//Serial.println(mV);
delay(10);
}
