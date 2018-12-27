// Tetsuaki Baba
// Processing のサンプルコード
// str_format: データ名をカンマ区切りで書いておく
// port: 該当するシリアルポートへのパスを明記（Windowsの場合はCOMX（Xは数字））になります．

import processing.serial.*;
PrintWriter output;
Serial myPort;
boolean flg_start = false;
long time=0;
String str_format = "t,val";
int SER = 0;  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//String port = "/dev/cu.wchusbserial1440";
void setup() {
  size(320, 240);
  println(Serial.list());
   myPort = new Serial(this, Serial.list()[SER], 9600);
}

void draw() {
  while ( myPort.available() > 0 ) {    
    String inBuffer = myPort.readString();
    if ( inBuffer != null ) {
      if ( flg_start ) output.print(inBuffer);
    }
  }
}

void keyPressed() {
  if ( key == 's' ) {
    flg_start  = !flg_start;

    if ( flg_start == false ) {
      // end of recording
      output.flush(); 
      output.close();
    } else if ( flg_start == true ) {
      // begining of recording
      String filename = nf(year(), 4) + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) ;
      output = createWriter( filename + ".csv"); 
      output.println( str_format );
    }
  }
}
