import processing.serial.*;

Serial port;
int sensor;      // HOLDS PULSE SENSOR DATA FROM ARDUINO
int IBI;         // HOLDS TIME BETWEN HEARTBEATS FROM ARDUINO
int BPM;         // HOLDS HEART RATE VALUE FROM ARDUINO
int heart = 0;   // This variable times the heart image 'pulse' on screen
boolean beat = false;    // set when a heart beat is detected, then cleared when the BPM graph is advanced
HeartBeatDashBoard board;
HeartBeatDashBoard board2;
PFont font;

void setup(){
  size(1920, 1000);
  frameRate(200);

  println(Serial.list());    // print a list of available serial ports
  // choose the number between the [] that is connected to the Arduino
  port = new Serial(this, Serial.list()[3], 115200);  // make sure Arduino is talking serial at this baud rate
  port.clear();            // flush buffer
  port.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
  board = new HeartBeatDashBoard("Richard", 0, 30, 1920, 500);
  board2 = new HeartBeatDashBoard("Kanayan", 0, 530, 1920, 500);
}

void draw() {
  background(#FAFAFA);
  board.draw(sensor, BPM, heart--, 0.2);
  board2.draw(sensor, BPM, heart--, 0.2);
}
