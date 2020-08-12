class FaderV {

  //rectangle structure
  float posX, posY;
  float szW, szH;

  //button fader
  float iposX; 
  float iposY;
  float isizeW;
  float isizeH = 20;

  float in = 0;

  PFont f;

  FaderV(float x, float y, float w, float h) {

    posX = x;
    posY = y;
    szW = w;
    szH = h;

    iposX = x;
    iposY = y + w/2;
    isizeW = w;

    f = createFont("Barlow", 80);
    textFont(f);
  }
  float mapp(float min, float max) {

    in = map(iposY, posY+isizeH/2, (posY+szH)-isizeH/2, min, max);

    fill(240);
    textSize(15);
    //text(nf(in, 0, 1), posX+isizeW+5, posY+szH);

    return in;
  }


  void display(String par) {

    //text
    fill(240);
    textSize(12);
    text(par, posX-16, posY+szH+13);
    text(nf(in, 0, 1), posX+isizeW+5, posY+8);

    //structure box
    rectMode(CORNER);
    stroke(240);
    noFill();
    rect(posX, posY, szW, szH);

    //button fader
    rectMode(CENTER);
    stroke(0);
    fill(200);
    rect(iposX+isizeW/2, iposY, isizeW, isizeH);
  }


  void mouseD(float XX) {

    if (mouseX > XX + posX && mouseX < XX + posX + szW && mouseY > posY && mouseY < posY + szH && mousePressed) {
      iposY = mouseY;
      iposY = constrain(iposY, posY+isizeH/2, (posY+szH)-isizeH/2);
    }
  }
}



///////////////

class FaderH {

  float posX, posY;
  float szW, szH;

  float iposX; 
  float iposY;
  float isizeW = 20;
  float isizeH;

  PFont f;

  FaderH(float x, float y, float w, float h) {

    posX = x;
    posY = y;
    szW = w;
    szH = h;

    iposX = x + h/2;
    iposY = y;
    isizeH = h;

    f = createFont("Barlow", 30);
    textFont(f);
  }


  void display(String par) {

    //text
    fill(240);
    textSize(15);
    text(par, posX, posY-10);

    //structure box
    rectMode(CORNER);
    stroke(240);
    noFill();
    rect(posX, posY, szW, szH);

    //button
    rectMode(CENTER);
    stroke(0);
    fill(200);
    rect(iposX, iposY+isizeH/2, isizeW, isizeH);
  }


  void mouseD(float XX) {

    if (mouseX > XX + posX && mouseX < XX + posX + szW && mouseY > posY && mouseY < posY + szH && mousePressed) {
      iposX = mouseX;
      iposX = constrain(iposX, posX+isizeW/2, (posX+szW)-isizeW/2);
    }
  }

  float mapp(float min, float max) {

    float in;
    in = map(iposX, posX+isizeW/2, (posX+szW)-isizeW/2, min, max);

    fill(240);
    textSize(15);

    return in;
  }
}


class Button {

  //rectangle
  float posX, posY;
  float szW, szH;
  float result = 0;

  float v[] = new float[4];

  boolean BB = false;

  Button(float x, float y, float w, float h) {
    posX = x;
    posY = y;
    szW = w;
    szH = h;
  }

  void display(String t) {

    fill(240);
    text(t, posX-8, posY+szH);
    rectMode(CENTER);
    stroke(40);
    fill(200);
    rect(posX, posY, szW, szH);

    if (BB) {
      noStroke();
      fill(40);
      ellipse(posX, posY, szW-4, szH-4);
    }
  }

  void mouseP1(float XX) {
    if (mouseX > XX + posX - szW/2 && mouseX < XX + posX + szW/2 && mouseY > posY - szH/2 && mouseY < posY + szH/2 && mousePressed) {
      BB =! BB;
    }
  }

  void mouseP2(float XX) {
    if (mouseX > XX + posX - szW/2 && mouseX < XX + posX + szW/2 && mouseY > posY - szH/2 && mouseY < posY + szH/2 && mousePressed) {
      BB = true;
    } else {
      BB = false;
    }
  }


  float rand() {
    float in = 0;
    float values[] = {0, 0.1, 0.2, 0.3, 0.35, 0.38};

    if (BB) {
      in = values[int(random(0, values.length-1))];
      println(in);
    }

    fill(240);
    textSize(15);
    text(nf(in, 0, 1), posX+15, posY);

    return in;
  }
}
