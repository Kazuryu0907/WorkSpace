double Kp = 0.01;
double Ki = 0.0001;
double Kd = 0.01;//0.01
double mV = 1000;
double nV = 0;
double f =0;
double d = 0;
double hensa = 0;
int totalfitness = 0;
final int DI_HI = 3;
final int SA_HI = 1;
final int YOUSO = 20;
float[][] ele = new float[YOUSO][3];
float[] fit = new float[YOUSO];
float[] high = new float[3];
float[] two = new float[3];
float[] three = new float[3];
float[] four = new float[3];
float[] five = new float[3];
float[][] next = new float[YOUSO][3];
float fastest = 0;
int fastest_i = 0;
int count = 0;
final int HENI = 90;
void setup() {
  frameRate(1);
  firstpool(ele);
  Nagare();
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
  return(ret);
}

int select(float[] fit) {  
  int max = 0;
  int max_i = 0;
  for (int i = 0; i < YOUSO; i++) {
    int num = int(fit[i]);
    if (num > max) {
      max = num;
      max_i = i;
    }
  }
  fastest = max;
  fastest_i = max_i;
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
   print("z");
  //print(z);
  int goukei = 0;
  for (int i = 1; i < YOUSO; i++) {

    float hiritsu = fit[i]/int(z)*100;
    //println(hiritsu);
    goukei += hiritsu;
    hi[i] = goukei;
  }

  int ran = int(random(100));
  for (int i = 1; i < YOUSO; i++) {
    if (ran > hi[i-1] && ran < hi[i]) {
      ret = i-1;
      //break;
      print("rou");
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
      int ran = int(random(1, 6));
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
  print("2");
  int select_r3 = select_roulette(fit);
  //select_r3 = select_roulette(fit);
  //select random 2
  while (select_r2 == select_r3) {
    select_r3 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    three[i] = ele[select_r3][i];
  }
  print("3");
  int select_r4 = select_roulette(fit);
  while (select_r3 == select_r4 || select_r4 == select_r2) {
    select_r4 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    four[i] = ele[select_r4][i];
  }
  print("4");
  int select_r5 = select_roulette(fit);
  while (select_r5 == select_r4 || select_r5 == select_r3 || select_r5 == select_r2) {
    select_r5 = select_roulette(fit);
  }
  for (int i = 0; i < 3; i++) {
    five[i] = ele[select_r5][i];
  }
  print("5");
}

void Nagare() {
  for (int i = 0; i<YOUSO; i++) {
    float m = evalfit(ele[i]);
    //print(int(m));
    fit[i] = m;
  }
  print("b");


  ///////////////////////////////////////////////
  matching(fit);
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
}
