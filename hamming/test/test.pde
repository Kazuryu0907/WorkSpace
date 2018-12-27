void setup() {
  int high, sou_x, high_h, high_l, low, low_l, low_h;
  int P1, P2, P3;
  sou_x = 19708;

  high = sou_x >> 8;
  high_l = high & 15;
  low = sou_x & 255;
  low_h = low >> 4;
  low_l = low & 15;
  /*
  println(binary(2 >> 1));
  println(binary(low_h));
  println(binary(low_l));
  */
  bit(high_l);
  //println(binary(bit(high_l)));
}


int bit(int i) {
  int L1;
  if (i < 0) {
    L1 = 0;
  } else {
    L1 = 1;
  }
  println(binary(i));
  int X4 = int(i&1);
  int X3 = int(i&2) >> 1;
  int X2 = int(i&4) >> 2;
  int X1 = int(i&8) >>3;
  println(X1);
  println(X2);
  println(X3);
  println(X4);
  int P1 = X1 ^ X3 ^ X4;
  int P2 = X1 ^ X2 ^ X4;
  int P3 = X1 ^ X2 ^ X3;
  print(P1);
  print(P2);
  println(P3);
  int fum = P1 * 4+P2*2+P3;
  println(binary(fum));
  int fin = int(i) << 4| fum << 1 | L1;
  print(X1);
  print(X2);
  print(X3);
  print(X4);
  print(P1);
  print(P2);
  println(P3);
  println(binary(fin));
  return(fin);
}
