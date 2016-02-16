class HeartBeatDashBoard{
  int x, y, h, w;
  int absW, absH;
  String title;
  int[] rawY;
  int[] scaledY;
  int pulseWindowWidth;
  int pulseWindowHeight;
  boolean beat;
  int bpm;
  int offset;
  int sensor;
  float zoom;
  int heart;

  HeartBeatDashBoard(String title, int x, int y, int width, int height, int pulseWindowWidth, int pulseWindowHeight){
    this.title = title;
    this.x = x;
    this.y = y;
    this.h = height;
    this.w = width;
    this.absH = this.y + this.h;
    this.absW = this.x + this.w;
    this.pulseWindowHeight = pulseWindowHeight;
    this.pulseWindowWidth = pulseWindowWidth;
    this.beat = false;
    this.rawY = new int[pulseWindowWidth];
    this.scaledY = new int[pulseWindowWidth];

    for (int i=0; i < rawY.length; i++){
      rawY[i] = this.y + this.pulseWindowHeight / 2;
    }
  }

  HeartBeatDashBoard(String title, int x, int y, int width, int height){
    this(title, x, y, width, height, int(width * 10 / 12), 450);
  }

  void draw(int sensor, int bpm, int heart, float zoom){
    this.zoom = zoom;
    this.sensor = sensor;
    this.bpm = bpm;
    this.heart = heart;
    drawTitle();
    drawBPM();
    drawHeart();
    drawHeartBeatWave();
  }

  void drawHeartBeatWave(){
    // what 1023?
    this.rawY[this.rawY.length - 1] = (1023 - this.sensor) - 212;
    float offset = map(this.zoom, 0.5, 1, this.absH / 3, 0);
    for (int i = 0; i < rawY.length - 1; i++){
      rawY[i] = rawY[i+1];
      float dummy = rawY[i] * zoom + offset;
      scaledY[i] = constrain(int(dummy), this.y + 10, this.y + this.pulseWindowHeight);
    }

    stroke(238,18,137);                               // red is a good color for the pulse waveform
    strokeWeight(2);
    noFill();
    beginShape();                                  // using beginShape() renders fast
    for (int x = 1; x < this.scaledY.length-1; x++) {
      vertex(x+30, this.scaledY[x]);                    //draw a line connecting the data points
    }
    endShape();
  }

  void drawTitle(){
    fill(#F06292);
    textSize(26);
    text(this.title, this.x + 70, this.y + 10);
  }

  void drawHeart(){
    fill(250,0,0);
    stroke(250,0,0);
    // doutbt heart becomes local varialbe
    this.heart--;
    this.heart = max(this.heart, 0);
    if (heart > 0){
      strokeWeight(8);
    }
    smooth();
    bezier(this.absW - 150, this.y + 50,
      this.absW - 70, this.y - 20,
      this.absW - 50, this.y + 140,
      this.absW - 150, this.y + 150);
    bezier(this.absW - 150, this.y + 50,
      this.absW - 240, this.y - 20,
      this.absW - 250, this.y + 140,
      this.absW - 150, this.y + 150);
    // reset strokeWeight
    strokeWeight(1);
  }

  void drawBPM(){

    fill(#F06292);
    textSize(50);
    textAlign(CENTER);
    int bpmX = this.absW - 150;
    int bpmY = this.absH - 150;
    font = loadFont("Helvetica-Bold-64.vlw");
    textFont(font);
    text(this.bpm, bpmX, bpmY - 50);
    font = loadFont("Helvetica-Bold-48.vlw");
    textFont(font);
    text("BPM", bpmX, bpmY);
  }
}
