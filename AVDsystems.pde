import ddf.minim.*;
import ddf.minim.ugens.*;

//general class minim (audio)
Minim minim;
AudioOutput[] out = new AudioOutput[5];

//globals positions
float posZ = 500;
float posX = 650;

//globals dragged movement in X and Z position
boolean locked = false; 
boolean play = true;
float xoff = 0;

//global var used in amplitude of each cell system
float distAmp = 0;

//declaring controller
Ctrl c1;

//declaring systems
DSystem[] systems = new DSystem[5];

void setup() {
  size(1280, 720, P3D);

  //initializing controller
  c1 = new Ctrl();

  //initializing systems
  for (int i = 0; i < 5; i++) {
    systems[i] = new DSystem();
  }

  //initializing Minim objects outputs
  minim = new Minim(this);
  for (int i = 0; i < 5; i ++) {  
    out[i] = minim.getLineOut();
  }

  //String[] fontList = PFont.list();
  //printArray(fontList);
}

void draw() {
  background(230, 230, 255);

  //manual background
  noStroke();
  fill(0);
  rect(0, 150, width, 450);

  //a constrain for X axis
  posX =  constrain(posX, 350, width-300);

  //show the controller
  push();
  c1.show();
  pop();

  ///--------------------lorenz and rossler together
  if (c1.state() == 1) {

    push();

    translate(width/2, height/2, posZ);

    systems[2].updateLorenz();
    systems[2].updateRossler();
    systems[2].name = true;

    systems[2].displayLorenz();
    systems[2].transL = -60;
    systems[2].strokeWL = c1.f1.mapp(10, 1);

    systems[2].displayRossler();
    systems[2].transR = 50;
    systems[2].strokeWr = c1.f2.mapp(10, 1);

    float baseFreqL = c1.f1.mapp(100, 5000);
    out[0].playNote(0.15, 0.05, new mySine(systems[0].rLorenz()*baseFreqL, 0.8, -1, 0));

    float baseFreqR = c1.f2.mapp(100, 5000);
    out[1].playNote(0.15, 0.05, new mySine(systems[1].rRossler()*baseFreqR*1.1, 0.8, 1, 1));

    pop();
  }


  push();

  translate(posX, height/2, posZ);

  ///------------------------lorenz sequence
  if (c1.state() == 2) {
    for (int i = 0; i < 5; i ++) {
      systems[2].name = false;
      systems[i].updateLorenz();
      systems[i].displayLorenz();
      float distance = c1.f1.mapp(250, 1);
      systems[i].transL = map(i, 0, 4, -distance, distance);
      systems[i].c = map(i, 0, 5, 1, 9);
      systems[i].rot = map(i, 0, 5, 0, 360);

      float mapX = map(posX, 350, width-300, -300, 300);

      if (dist(mapX, 0, systems[i].transL, 0) < 50) {
        distAmp = 1;
      } else {
        distAmp = 0.1;
      }

      float baseFreq = c1.f1.mapp(10, 100);

      out[i].playNote(
        i * 0.05, 0.05, 
        new mySine(systems[i].rLorenz()*map(i, 0, 5, 10, 15)*baseFreq, 
        distAmp, 
        map(i, 0, 5, -1, 1), 
        i)
        );

      for ( int j = 0; j < out[i].bufferSize() - 1; j++ ) {
        systems[i].strokeWL = c1.f1.mapp(10, 1) * (0+1)+out[i].mix.get(j) * 3;
      }
    };
  }

  ///------------------------rossler sequence
  if (c1.state() == 3) {
    systems[2].name = false;
    for (int i = 0; i < 5; i ++) {
      systems[i].updateRossler();
      systems[i].displayRossler();
      float distance = c1.f2.mapp(250, 1);
      systems[i].transR = map(i, 0, 4, -distance, distance);
      systems[i].bRossler = map(i, 0, 5, 0.2, 5.0);
      systems[i].rot = map(i, 0, 5, 0, 360);

      float mapX = map(posX, 350, width-300, -300, 300);

      if (dist(mapX, 0, systems[i].transR, 0) < 50) {
        distAmp = 1;
      } else {
        distAmp = 0.1;
      }

      float baseFreq = c1.f2.mapp(20, 200);

      out[i].playNote(
        i * 0.15, 0.05, 
        new mySine(systems[i].rRossler()*map(i, 0, 5, 4, 8)*baseFreq, 
        distAmp, map(i, 0, 5, -1, 1), 
        i)
        );

      for ( int j = 0; j < out[i].bufferSize() - 1; j++ ) {
        systems[i].strokeWr = c1.f2.mapp(10, 1) * (0+1)+out[i].mix.get(j) * 3;
      }
    };
  }

  pop();

  textSize(15);
  text("2020", 10, height-10);
  text("frame rate: " + nf(frameRate, 0, 1), 60, height-10);

  if (c1.state() == 2) {
    noStroke();
    textSize(30);
    fill(0);
    rect(width/2-100, height-140, 240, 30);
    fill(220);
    text("Lorenz System", width/2-80, height-140, 0);
  }
  if (c1.state() == 3) { 

    noStroke();
    textSize(30);
    fill(0);
    rect(width/2-100, height-140, 240, 30);
    fill(220);
    text("Rossler System", width/2-80, height-140, 0);
  }
}


void mousePressed() {
  c1.mouseP();

  if (mouseY > 150) {
    if (play) { 
      locked = true;
    } else {
      locked = false;
    }
    xoff = mouseX-posX;
  }
  //yoff = mouseY-posZ;
}

void mouseDragged() {
  c1.mouseD();

  if (locked) {
    posX = mouseX-xoff; 
    //posZ = mouseY-yoff;
  }
}

void mouseWheel(MouseEvent me) {
  final int inc = keyPressed & keyCode == CONTROL ? -10 : 10;
  posZ = constrain(posZ + me.getCount()*inc, 300, 500);
}

void mouseReleased() {
  locked = false;
}
