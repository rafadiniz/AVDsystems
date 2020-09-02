class Ctrl {

  float transY = -150;

  FaderV f1, f2, f3;
  FaderH f4, f5;
  Button b1, b2;
  //Button b3;

  float cBorder;
  String bText = "show";

  Ctrl() {

    //vertical faders
    f1 = new FaderV(160, 15, 40, 110);
    f2 = new FaderV(width/2+160, 15, 40, 110);
    
    //f3 = new FaderV(190, 15, 30, 120);

    //horizontal faders
    f4 = new FaderH(260, 50, 160, 30);
    f5 = new FaderH(width/2+260, 50, 160, 30);

    //button toggle (interruptor)
    b1 = new Button(100, 30, 25, 25);
    b2 = new Button(width/2+100, 30, 25, 25);

    ////hold button
    //b3 = new Button(460, 100, 25, 25);
  }

  void show() {
    push();
    translate(0, transY);

    //background
    
    //lorenz
    noStroke();
    fill(10,30,10, 100);
    rect(0, 0, width/2, 150);
    fill(40);
    textSize(15);
    text("Lorenz \nSystem",10,30);
    
    //rossler
    noStroke();
    fill(10, 100);
    rect(width/2, 0, width, 150);
    fill(40);
    text("Rossler \nSystem",width/2+10,30);
    
    //border
    if (mouseY > 0 && mouseY < 20 && transY == -150) {
      cBorder = 100;
    } else {
      cBorder = 200;
      if (mouseY > 150 && mouseY < 170 && transY == 0) {
        cBorder = 240;
      } else {
        cBorder = 200;
      }
    }

    fill(cBorder, 200);
    rect(0, 150, width, 20);
    textSize(15);
    fill(40);
    text(bText,width/2-10,165);
    
    
    //vertical faders
    f1.display("BaseFreq and Stroke");
    f2.display("BaseFreq and Stroke");
    //f3.display("3");

    //horizontal faders
    f4.display("Freqs and Spacing");
    f5.display("Freqs and Spacing");

    //buttons toggles
    b1.display("on");
    b2.display("on");

    //b3.display();
    //b3.mouseP2(transY);

    pop();
  }

  void mouseP() {
    if (mouseY > 0 && mouseY < 30 && mousePressed) {
      transY = 0;
      bText = "hide";
    }
    if (mouseY < 170 && mouseY > 150 && mousePressed) {
      transY = -150;
      bText = "show";
    }

    if (mouseY > 0 && mouseY < 150 && mousePressed) {
      b1.mouseP1(transY);
      b2.mouseP1(transY);
    }
  }

  void mouseD() {
    f1.mouseD(transY);
    f2.mouseD(transY);
    //f3.mouseD(transY);

    f4.mouseD(transY);
    f5.mouseD(transY);
  }

  float mapFader1(float min, float max) {
    float in;
    push();
    translate(0, transY);
    in = f1.mapp(min, max);
    pop();
    return in;
  }

  float mapFader2(float min, float max) {
    float in;
    push();
    translate(0, transY);
    in = f2.mapp(min, max);
    pop();
    return in;
  }

  float mapFader3(float min, float max) {
    float in;
    push();
    translate(0, transY);
    in = f3.mapp(min, max);
    pop();
    return in;
  }

  float mapFader4(float min, float max) {
    float in;
    push();
    translate(0, transY);
    in = f4.mapp(min, max);
    pop();
    return in;
  }

  float mapFader5(float min, float max) {
    float in;
    push();
    translate(0, transY);
    in = f5.mapp(min, max);
    pop();
    return in;
  }

  int state() {
    int in = 0;
    push();
    translate(0, transY);
    if (b1.BB && b2.BB) {
      in = 1;
    } else if (b1.BB == true && b2.BB == false) {
      in = 2;
    } else if (b1.BB == false && b2.BB == true) {
      in = 3;
    }
    pop();
    return in;
  }

  //float randT() {
  //  float in;
  //  push();
  //  translate(0, transY);
  //  in =  b3.rand();
  //  pop();
  //  return in;
  //}
}
