double Kp = 0.01;
double Ki = 0.0001;
double Kd = 0.01;//0.01
double mV = 1000;
double nV = 0;
double f =0;
double d = 0;
double hensa = 0;
int totalfitness = 0;
//////////////////////////////////////////
final int DI_HI = 1;
final int SA_HI = 2;
final int MAX_SA_HI = 20;
final int YOUSO = 50;
final int TARGET_V = 1000;
final int HENI = 50;
final int TARGET_M = 2500;
//////////////////////////////////////////
float[][] ele = new float[YOUSO][3];
float[] fit = new float[YOUSO];
float[] high = new float[3];
float[] two = new float[3];
float[] three = new float[3];
float[] four = new float[3];
float[] five = new float[3];
float[] six = new float[3];
float[] seven = new float[3];
float[] eight = new float[3];
float[][] next = new float[YOUSO][3];
float fastest = 0;
int fastest_i = 0;
int count = 0;
float max_max_sa = TARGET_V*200;
float max_di = TARGET_V*200;
float max_max_val = TARGET_V * 200;
//if I want to change low , you will change low in evalfit.
void setup() {
  frameRate(1);
  firstpool(ele);
  Nagare();
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
  return(ret);
}

int select(float[] fit) {  
  float max = 0;
  int max_i = 0;
  for (int i = 0; i < YOUSO; i++) {
    float num = fit[i];
    //println(fit[i]);
    if (num > max) {
      max = num;
      max_i = i;
    }
  }
  fastest = max;
  fastest_i = max_i;
  print("max_i:");
  println(max_i);
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
  //print("z");
  int goukei = 0;
  for (int i = 1; i < YOUSO; i++) {

    float hiritsu = abs(fit[i])/int(z)*100;
    //println(hiritsu);
    if (int(hiritsu) == 0) {
      hiritsu = 1;
    }
    goukei += hiritsu;
    hi[i] = goukei;
  }

  int ran = int(random(goukei));
  for (int i = 1; i < YOUSO; i++) {
    if (ran > hi[i-1] && ran < hi[i]) {
      ret = i-1;
      //break;
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
      int ran = int(random(1, 9));
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
  //print("2");
  int select_r3 = select_roulette(fit);
  //select_r3 = select_roulette(fit);
  //select random 2
  while (select_r2 == select_r3) {
    select_r3 = select_roulette(fit);
    //print("s3");
  }
  for (int i = 0; i < 3; i++) {
    three[i] = ele[select_r3][i];
  }
  //print("3");
  int select_r4 = select_roulette(fit);
  while (select_r3 == select_r4 || select_r4 == select_r2) {
    select_r4 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    four[i] = ele[select_r4][i];
  }
  //print("4");
  int select_r5 = select_roulette(fit);
  while (select_r5 == select_r4 || select_r5 == select_r3 || select_r5 == select_r2) {
    select_r5 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    five[i] = ele[select_r5][i];
  }
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
}

void Nagare() {
  for (int i = 0; i<YOUSO; i++) {
    float m = evalfit(ele[i]);
    fit[i] = m;
  }
  //print("b");


  ///////////////////////////////////////////////
  matching(fit);
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
}
