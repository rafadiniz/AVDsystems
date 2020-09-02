class mySine implements Instrument {

  Oscil sine;
  ADSR  adsr;

  float pos;
  int i;

  mySine(float frequency, float amplitude, float p, int inter, int waveF) {
    i = inter;
    pos = p;
    
    if (waveF == 0) {
      sine = new Oscil( frequency, amplitude, Waves.SINE);
    } else if (waveF == 1) {
      sine = new Oscil( frequency, amplitude, Waves.TRIANGLE);
    }
    adsr = new ADSR(0.3, 0.1, 0.5, 0.5, 0.5);
    sine.patch(adsr);
  }

  void noteOn(float dur) {

    adsr.noteOn();
    adsr.patch(out[i]);
    out[i].setPan(pos);
  }

  void noteOff() {

    adsr.noteOff();
    adsr.unpatchAfterRelease(out[i]);
  }
}
