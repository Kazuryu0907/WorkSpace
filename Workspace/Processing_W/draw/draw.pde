import processing.opengl.*;
String[] eng = {"A","B","C","D","E","F"};
String[] mozi = new String[72];
int han = 200;

void setup(){
  size(400,400,OPENGL);
  PFont font;
  font = loadFont("Arial-BoldMT-48.vlw");
  translate(width/2,height/2,0);
  textFont(font,20);
  //ortho(0,width,0,height);

}

void draw(){
if(han > 0){
background(0);

if(han % 4 == 0){
for(int i = 0;i<36;i++){
  int A = int(random(10));
  int B = int(random(6));
  int saki = i*2;
  int ato = i*2+1;
  String E = eng[B];
  if(int(random(2)) == 0){
    mozi[saki] = str(A);
    mozi[ato] = E;
  }else{
   mozi[ato] = str(A);
   mozi[saki] = E;
  }
}
}
for(int i = 0;i < 72;i++){
  textAlign(CENTER);
  //pushMatrix();
  fill(#0066FF);
  text(mozi[i],(cos(radians((i+1+han)*5)))*han+float(width/2),(sin(radians((i+1+han)*5)))*han+float(width/2));
  colorMode(RGB,256);
  stroke(0,0,128);
  strokeWeight(1);
  noFill();
  ellipse(width/2,height/2,han+width/2,han+height/2);
  //rotateY(radians(i));
  //popMatrix();
}
delay(20);
han -= 1; 
}else{
background(0);
han = 200;
}

}
