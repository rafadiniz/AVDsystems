
class DSystem {

  //Lorenz globals
  float x = 0.01;
  float y = 0;
  float z = 0;

  float a = 10;
  float b = 28;
  float c = 8.0/3.0;

  float rotXL, rotYL, rotZL;
  float transL = 0;
  float transR = 100;
  float rot;

  float strokeWL = 0;
  float strokeWr = 0;

  boolean name = false;
  int lC = 0;
  float tL = 0;
  float distAmp = 0;

  ArrayList<PVector> pointsLorenz = new ArrayList<PVector>();

  //Rossler globals
  float xRossler = 0;
  float yRossler = 0;
  float zRossler = 0;

  float aRossler = 0.3;
  float bRossler = 0.2;  
  float cRossler = 4.27;

  float tR = 0;
  float rotXR, rotYR, rotZR;

  ArrayList<PVector> pointsRossler = new ArrayList<PVector>();


  PFont f;

  DSystem() {
    f = createFont("Barlow", 80);
    textFont(f);
  }

  void updateLorenz() {
    float dt = 0.01;

    float dx = (a * (y - x))*dt;
    float dy = (x * (b - z) - y)*dt;
    float dz = (x * y - c * z)*dt;

    x += dx;
    y += dy;
    z += dz;

    pointsLorenz.add(new PVector(x, y, z));
  }

  void updateRossler() {
    float dtRossler = 0.08;

    //aRossler = 0.3;
    //bRossler = 0.2;  
    //cRossler = 4.27;

    float dxRossler = (-yRossler - zRossler) * dtRossler;
    float dyRossler = (xRossler + aRossler * yRossler) * dtRossler;
    float dzRossler = (bRossler + (zRossler * xRossler - zRossler * cRossler)) * dtRossler;

    xRossler += dxRossler;
    yRossler += dyRossler;
    zRossler += dzRossler;  

    pointsRossler.add(new PVector(xRossler, yRossler, zRossler));

    //if (pointsRossler.size() > 600) {
    //  pointsRossler.remove(10);
    //}
  }


  void displayLorenz() {

    push();
    tL += 0.08;
    translate(transL, 0, 0);
    noFill();
    if (name) {
      textFont(f);
      textSize(6);
      noStroke();
      fill(0);
      rect(-2, 45, 42, 5);
      fill(220);
      text("Lorenz System", 0, 45, 0);
    }
    //rotateX(radians(tL));
    rotateY(radians(tL+rot));
    //rotateZ(radians(tL+rot));
    beginShape(LINE_STRIP);
    for (PVector v : pointsLorenz) {
      strokeWeight(strokeWL);
      stroke(127+127*sin(v.x*0.813+tL), 200);
      vertex(v.x, v.y, v.z);
      //PVector offset = PVector.random3D();
      //offset.mult(0.1);
      //v.add(offset);
      //println("lorenz:", v.x);
    }
    endShape();
    pop();
  }

  float rLorenz() {
    float out = 0;
    out = c;
    return out;
  }

  float rRossler() {
    float out = 0;
    out = bRossler;
    return out;
  }

  void displayRossler() {
    push();
    tR += 0.06;
    translate(transR, 0, 0);
    if (name) {
      textFont(f);
      textSize(6);
      fill(0);
      rect(-2, 45, 45, 5);
      fill(220);
      text("Rossler System", 0, 45, 0);
    }
    scale(2);

    //rotateX(radians(rotXR));
    rotateY(radians(tR + rot));
    //rotateZ(radians(tR + rot));

    beginShape(LINE_STRIP);
    for (PVector v2 : pointsRossler) {
      strokeWeight(strokeWr);
      stroke(127+127*cos(v2.x*0.810+tR), 200);
      vertex(v2.x, v2.y, v2.z);
      //PVector offset = PVector.random3D();
      //offset.mult(0.1);
      //v.add(offset);
    }
    endShape();

    pop();
  }
}
