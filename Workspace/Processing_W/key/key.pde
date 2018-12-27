import processing.serial.*;
Serial ser;
boolean n_a,f_a;
void setup(){
  ser = new Serial(this,"COM6",9600);
}


void draw(){
}

void keyPressed(){
  switch(key){
    case 'a':
    a();
    break;
    case 's':
    s();
    break;
    case 'd':
    d();
    break;
    case 'w':
    w();
    break;
    default:
    
}
}

void keyReleased(){
switch(key){
 case 'a':
 println(-1);
 ser.write(11);
 break;
 case 'd':
 ser.write(22);
 println(-2);
 break;
 case 'w':
 ser.write(33);
 println(-3);
 break;
 case 's':
 ser.write(44);
 println(-4);
 break;
}
}

void a(){
  println(1);
  ser.write(1);
}

void s(){
  println(4);
  ser.write(4);
}

void d(){
  println(2);
  ser.write(2);
}

void w(){
  println(3);
  ser.write(3);
}
