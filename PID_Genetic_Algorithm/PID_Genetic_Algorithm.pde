double Kp = 0.01;
double Ki = 0.0001;
double Kd = 0.01;//0.01
double mV = 1000;
double nV = 0;
double f =0;
double d = 0;
double hensa = 0;
int totalfitness = 0;
<<<<<<< HEAD
//////////////////////////////////////////
final int DI_HI = 1;
final int SA_HI = 2;
final int MAX_SA_HI = 20;
final int YOUSO = 50;
final int TARGET_V = 1000;
final int HENI = 50;
final int TARGET_M = 2500;
//////////////////////////////////////////
=======
final int DI_HI = 3;
final int SA_HI = 1;
final int YOUSO = 20;
>>>>>>> work/master
float[][] ele = new float[YOUSO][3];
float[] fit = new float[YOUSO];
float[] high = new float[3];
float[] two = new float[3];
float[] three = new float[3];
float[] four = new float[3];
float[] five = new float[3];
<<<<<<< HEAD
float[] six = new float[3];
float[] seven = new float[3];
float[] eight = new float[3];
=======
>>>>>>> work/master
float[][] next = new float[YOUSO][3];
float fastest = 0;
int fastest_i = 0;
int count = 0;
<<<<<<< HEAD
float max_max_sa = TARGET_V*200;
float max_di = TARGET_V*200;
float max_max_val = TARGET_V * 200;
//if I want to change low , you will change low in evalfit.
=======
final int HENI = 90;
>>>>>>> work/master
void setup() {
  frameRate(1);
  firstpool(ele);
  Nagare();
<<<<<<< HEAD
  /*
  for (int i = 0; i <YOUSO; i++) {
   print(fit[i]);
   if (i != YOUSO-1) {
   print(",");
   } else {
   println();
   }
   }
   */
=======
>>>>>>> work/master
}

void draw() {
  Nagare();
  //delay(1000);
}

float PID(float nV, float mV, float Kp, float Ki, float Kd) {
  float sa = mV - nV;
  nV += Kp*sa;
  f += sa;
  nV += f*Ki;
  d = Kd*(sa-hensa);
  nV += d;
  hensa = sa;
  return(nV);
}

void firstpool(float[][] ele) {
  for (int i = 0; i < YOUSO; i++) {
    for (int k = 0; k < 3; k++) {
      ele[i][k] = random(0.1);
    }
  }
}

float evalfit(float[] g) {
  float nV=0;
  float back = 0;
  float sa = 0;
  boolean flag = false;
  int first_low = 0;
  float di = 0;
<<<<<<< HEAD
  float max_sa = 0;
  float ret = 0;
  float max_val = 0;
  for (int i =0; i < 10000; i++) {
    nV = PID(nV, TARGET_V, g[0], g[1], g[2]);
    sa = nV-back;
    if (nV > TARGET_V && !flag) {
      first_low = i;
      flag = true;
    }
    if (max_sa < nV - TARGET_V) {
      max_sa = nV - TARGET_V;
    }
    di += abs(TARGET_V-nV);
    back = nV;
  }
  if (max_di > di) {
    max_di = di;
  }
  if (max_max_sa > max_sa) {
    max_max_sa = max_sa;
  }
  /*
  max_val = SA_HI*abs((first_low)-TARGET_M);
  if (max_max_val > max_val) {
    max_max_val = max_val;
  }
  */
  ret = 200000 - abs(((di*DI_HI+first_low*SA_HI+max_sa*MAX_SA_HI))/100);
=======
  float ret;
  for (int i =0; i < 10000; i++) {
    nV = PID(nV, 1000, g[0], g[1], g[2]);
    sa = nV-back;
    if (sa < 0 && !flag) {
      first_low = i;
      flag = true;
    }
    di += abs(1000-nV);
    nV = back;
  }
  ret = 2000 - ((di*DI_HI+first_low*SA_HI)/100000000);
>>>>>>> work/master
  return(ret);
}

int select(float[] fit) {  
<<<<<<< HEAD
  float max = 0;
  int max_i = 0;
  for (int i = 0; i < YOUSO; i++) {
    float num = fit[i];
    //println(fit[i]);
=======
  int max = 0;
  int max_i = 0;
  for (int i = 0; i < YOUSO; i++) {
    int num = int(fit[i]);
>>>>>>> work/master
    if (num > max) {
      max = num;
      max_i = i;
    }
  }
  fastest = max;
  fastest_i = max_i;
<<<<<<< HEAD
  print("max_i:");
  println(max_i);
=======
>>>>>>> work/master
  return(max_i);
}
//This
int select_roulette(float[] fit) {
  float z = 0;
  float[] hi = new float[YOUSO];
  int ret = 0;
  for (int i = 1; i< YOUSO; i++) {
    //println(fit[i]);
    z += (abs(fit[i]));

    //println(z);
  }
<<<<<<< HEAD
  //print("z");
  int goukei = 0;
  for (int i = 1; i < YOUSO; i++) {

    float hiritsu = abs(fit[i])/int(z)*100;
    //println(hiritsu);
    if (int(hiritsu) == 0) {
      hiritsu = 1;
    }
=======
   print("z");
  //print(z);
  int goukei = 0;
  for (int i = 1; i < YOUSO; i++) {

    float hiritsu = fit[i]/int(z)*100;
    //println(hiritsu);
>>>>>>> work/master
    goukei += hiritsu;
    hi[i] = goukei;
  }

<<<<<<< HEAD
  int ran = int(random(goukei));
=======
  int ran = int(random(100));
>>>>>>> work/master
  for (int i = 1; i < YOUSO; i++) {
    if (ran > hi[i-1] && ran < hi[i]) {
      ret = i-1;
      //break;
<<<<<<< HEAD
=======
      print("rou");
>>>>>>> work/master
    }
  }
  return(ret);
}


void Crossing(float[] high, float[] two, float[] three, float[] four, float[] five) {
  float num =0;
  for (int i = 0; i < 3; i++) {
    next[0][i] = high[i];
  }
  for (int i = 1; i < YOUSO; i++) {
    for (int k = 0; k < 3; k++) {
<<<<<<< HEAD
      int ran = int(random(1, 9));
=======
      int ran = int(random(1, 6));
>>>>>>> work/master
      switch(ran) {
      case 1:
        num = high[k];
        next[i][k] = Mutation(num);
        break;
      case 2:
        num = two[k];
        next[i][k] = Mutation(num);
        break;
      case 3:
        num = three[k];
        next[i][k] = Mutation(num);
        break;
      case 4:
        num = four[k];
        next[i][k] = Mutation(num);
        break;
      case 5:
        num = five[k];
        next[i][k] = Mutation(num);
        break;
<<<<<<< HEAD
      case 6:
        num = six[k];
        next[i][k] = Mutation(num);
        break;
      case 7:
        num = seven[k];
        next[i][k] = Mutation(num);
        break;
      case 8:
        num = eight[k];
        next[i][k] = Mutation(num);
        break;
=======
>>>>>>> work/master
      }
    }
  }
}

float Mutation(float f) {
  int ran = int(random(HENI));
  if (ran == 1) {
    f = random(0.1);
    return(f);
  } else {
    return(f);
  }
}

void matching(float[] fit) {
  int select_high = select(fit);
  for (int i = 0; i < 3; i++) {
    high[i] = ele[select_high][i];
  }
  int select_r2 = select_roulette(fit);
  for (int i = 0; i < 3; i++) {
    two[i] = ele[select_r2][i];
  }
<<<<<<< HEAD
  //print("2");
=======
  print("2");
>>>>>>> work/master
  int select_r3 = select_roulette(fit);
  //select_r3 = select_roulette(fit);
  //select random 2
  while (select_r2 == select_r3) {
    select_r3 = select_roulette(fit);
<<<<<<< HEAD
    //print("s3");
=======
>>>>>>> work/master
  }
  for (int i = 0; i < 3; i++) {
    three[i] = ele[select_r3][i];
  }
<<<<<<< HEAD
  //print("3");
=======
  print("3");
>>>>>>> work/master
  int select_r4 = select_roulette(fit);
  while (select_r3 == select_r4 || select_r4 == select_r2) {
    select_r4 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    four[i] = ele[select_r4][i];
  }
<<<<<<< HEAD
  //print("4");
=======
  print("4");
>>>>>>> work/master
  int select_r5 = select_roulette(fit);
  while (select_r5 == select_r4 || select_r5 == select_r3 || select_r5 == select_r2) {
    select_r5 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    five[i] = ele[select_r5][i];
  }
<<<<<<< HEAD
  // print("5");
  int select_r6 = select_roulette(fit);
  while (select_r6 == select_r5 || select_r6 == select_r4 || select_r6 == select_r3 || select_r6 == select_r2) {
    select_r6 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    six[i] = ele[select_r6][i];
  }
  int select_r7 = select_roulette(fit);
  while (select_r7 == select_r6 || select_r7 == select_r5 || select_r7 == select_r4 || select_r7 == select_r3 || select_r7 == select_r2) {
    select_r7 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    seven[i] = ele[select_r7][i];
  }
  int select_r8 = select_roulette(fit);
  while (select_r8 == select_r7 || select_r8 == select_r6 || select_r8 == select_r5 || select_r8 == select_r4 || select_r8 == select_r3 || select_r7 == select_r2) {
    select_r8 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    eight[i] = ele[select_r8][i];
  }
=======
  print("5");
>>>>>>> work/master
}

void Nagare() {
  for (int i = 0; i<YOUSO; i++) {
    float m = evalfit(ele[i]);
<<<<<<< HEAD
    fit[i] = m;
  }
  //print("b");
=======
    //print(int(m));
    fit[i] = m;
  }
  print("b");
>>>>>>> work/master


  ///////////////////////////////////////////////
  matching(fit);
<<<<<<< HEAD
  //println("c");
  ///////////////////////////////////////////////
  //write();
  Crossing(high, two, three, four, five);
  //print("d");
  arrayCopy(next, ele);
  /*
  for (int i = 0; i < YOUSO; i ++) {
   for (int k = 0; k < 3; k++) {
   if (k != 2) {
   print(ele[i][k]);
   print(",");
   } else {
   println(ele[i][k]);
   }
   }
   }
   */
=======
  print("c");
  ///////////////////////////////////////////////
  Crossing(high, two, three, four, five);
  print("d");
  arrayCopy(next, ele);
  for (int i = 0; i < YOUSO; i ++) {
    for (int k = 0; k < 3; k++) {
      if(k != 2){
      print(ele[i][k]);
      print(",");
      }else{
      println(ele[i][k]);
      }
    }
  }
>>>>>>> work/master
  print("Generation:");
  println(count);
  print("Fastest:");
  println(fastest);
  for (int  i =0; i < 3; i++) {
    if (i != 2) {
      print(ele[fastest_i][i]);
    } else {
      println(ele[fastest_i][i]);
    }
  }
  count++;
<<<<<<< HEAD
  print("max_max_sa:");
  println(max_max_sa);
  print("max_di:");
  println(max_di);
  print("max_max_val:");
  println(max_max_val);
  max_di = TARGET_V * 20;
  max_max_sa = TARGET_V * 20;
  max_max_val = TARGET_V * 20;
}



void write() {
  for (int i = 0; i < 3; i ++) {
    print(high[i]);
    if (i != 2) {
      print(",");
    } else {
      println();
    }
  }
  for (int i = 0; i < 3; i ++) {
    print(two[i]);
    if (i != 2) {
      print(",");
    } else {
      println();
    }
  }
  for (int i = 0; i < 3; i ++) {
    print(three[i]);
    if (i != 2) {
      print(",");
    } else {
      println();
    }
  }
  for (int i = 0; i < 3; i ++) {
    print(four[i]);
    if (i != 2) {
      print(",");
    } else {
      println();
    }
  }
  for (int i = 0; i < 3; i ++) {
    print(five[i]);
    if (i != 2) {
      print(",");
    } else {
      println();
    }
  }
=======
>>>>>>> work/master
}
