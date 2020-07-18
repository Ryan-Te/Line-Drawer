int[] Test;
int Size = 20;
int X1 = 0;
int Y1 = 0;
int X2 = 10;
int Y2 = 5;

void setup(){
  size(640,640);
  Test = drawLine(X1,Y1,X2,Y2);
  for(int i = 0; i < Test.length && i + 1 < Test.length; i = i + 2){
    //println("X: " + Test[i] + " Y: " + Test[i + 1]);
  }
}

void draw(){
  if(mousePressed && mouseButton == LEFT){
    X1 = floor(mouseX / Size);
    Y1 = floor(mouseY / Size);
    Test = drawLine(X1,Y1,X2,Y2);
  }
  if(mousePressed && mouseButton == RIGHT){
    X2 = floor(mouseX / Size);
    Y2 = floor(mouseY / Size);
    Test = drawLine(X1,Y1,X2,Y2);
  }
  
  background(255);
  fill(255);
  for(int x = 0; x < 32; x++){
    for(int y = 0; y < 32; y++){
      rect(x * Size,y * Size, Size, Size);
    }
  }
  fill(0);
  for(int i = 0; i < Test.length && i + 1 < Test.length; i = i + 2){
    rect(Test[i] * Size, Test[i + 1] * Size, Size,Size);
  }
  fill(255,0,0);
  rect(X1 * Size, Y1 * Size, Size,Size);
  fill(0,0,255);
  rect(X2 * Size, Y2 * Size, Size,Size);
  
  if(X1 == X2 && Y1 == Y2){
    fill(255,0,255);
  rect(X2 * Size, Y2 * Size, Size,Size);
  }
}

int[] drawLine(int Xs, int Ys, int Xe, int Ye){
  int Xd = Xe - Xs;
  if(Xd == abs(Xd)){
    Xd++;
  }else{
    Xd--;
  }
  int Yd = Ye - Ys;
  if(Yd == abs(Yd)){
    Yd++;
  }else{
    Yd--;
  }
  String MajorDir = "E";
  String MinorDir = "E";
  boolean Stop = false;
  boolean Error = false;
  int[] Output = new int[0];
  int Xc = Xs;
  int Yc = Ys;
  int Xi = 0;
  int Yi = 0;
  int Counter = 0;
  if(abs(Yd) > abs(Xd)){
    MajorDir = "Y";
    MinorDir = "X";
  }else{
    MajorDir = "X";
    MinorDir = "Y";
  }
  if(MajorDir == "E" || MinorDir == "E"){
   return new int[1];
  }
  
  while(!Stop){
    Xc = Xc + Xi;
    Yc = Yc + Yi;
    Xi = 0;
    Yi = 0;
    //println(Xc + " | " + Yc + " C: " + Counter);
    
    if(MinorDir == "X"){
      Counter = Counter + abs(Xd);
      if (Counter >= abs(Yd)){
        Counter = Counter - abs(Yd);
        if(Xd == abs(Xd)){
          Xi = 1;
        }else{
          Xi = -1;
        }
      }
      if(Yd == abs(Yd)){
        Yi = 1;
      }else{
        Yi = -1;
      }
    }else{
      Counter = Counter + abs(Yd);
      if (Counter >= abs(Xd)){
        Counter = Counter - abs(Xd);
        if(Yd == abs(Yd)){
          Yi = 1;
        }else{
          Yi = -1;
        }
      }
      if(Xd == abs(Xd)){
        Xi = 1;
      }else{
        Xi = -1;
      }
    }
    Output = append(Output, Xc);
    Output = append(Output, Yc);
    if(Xc == Xe && Yc == Ye){
      Stop = true;
    }
    if(MajorDir == "X"){
      if(Xd == abs(Xd)){
        if(Xc > Xe){
          println("Xc > Xe");
          Error = true;
          Stop = true;
        }
      }else if(Xc < Xe){
        println("Xc < Xe");
          Error = true;
          Stop = true;
        }
    }
    if(MajorDir == "Y"){
      if(Yd == abs(Yd)){
        if(Yc > Ye){
          println("Yc > Ye");
          Error = true;
          Stop = true;
        }
      }else if(Yc < Ye){
        println("Yc < Ye");
          Error = true;
          Stop = true;
        }
    }
  }
  if(Error){
    return new int[1];
  }
  //println(Output.length);
  return Output;
}
