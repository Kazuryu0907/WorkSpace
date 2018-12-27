void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
pinMode(22,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available()>0){
    int input = Serial.read();
    //Serial.println(input);
    switch(input){
      case 1:
      digitalWrite(22,HIGH);
      break;
      case 11:
      digitalWrite(22,LOW);
      break;
      case 2:
      digitalWrite(12,HIGH);
      break;
      case 22:
      digitalWrite(12,LOW);
      break;
      case 3:
      digitalWrite(11,HIGH);
      break;
      case 33:
      digitalWrite(11,LOW);
      break;
      case 4:
      digitalWrite(10,HIGH);
      break;
      case 44:
      digitalWrite(10,LOW);
      break;
      }
    }
}
