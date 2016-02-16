import processing.serial.*;

Serial port;
int sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int IBI;         // HOLDS TIME BETWEN HEARTBEATS FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
int heart = 0;   // This variable times the heart image 'pulse' on screen
boolean beat = false;    // set when a heart beat is detected, then cleared when the BPM graph is advanced
HeartBeatDashBoard board1;
HeartBeatDashBoard board2;
HBConfig conf1;
HBConfig conf2;
PFont font;
// add config


void setup(){
  size(1920, 1000);
  frameRate(200);

  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Arduino
  port = new Serial(this, Serial.list()[1], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return

  conf1 = new HBConfig("conf1.json");
  board1 = new HeartBeatDashBoard("Richard", 0, 30, 1920, 500);

  conf2 = new HBConfig("conf2.json");
  board2 = new HeartBeatDashBoard("Kanayan", 0, 530, 1920, 500);
}

void draw() {
  int bpmData, sensorData;
  background(#FAFAFA);
  conf1.read();
  conf2.read();

  if (conf1.getBPM() > 0) {
    bpmData = conf1.getBPM() * int(random(90, 100) / 100);
  } else {
    bpmData = BPM;
  }

  if (conf1.getSensor() > 0) {
    sensorData = conf1.getSensor() * int(random(80, 100) / 100);
  } else {
    sensorData = sensor;
  }

  board1.setTitle(conf1.getTitle());
  board2.setTitle(conf2.getTitle());

  board1.draw(sensorData, bpmData, heart--, 0.5);
  board2.draw(sensorData, bpmData, heart--, 0.5);
}