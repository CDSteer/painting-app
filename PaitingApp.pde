import processing.serial.*;

Serial myPort;        // The serial port
String inString;
String[] readInFloats;

PaintingAppActivity currentActivity;


float[] linesAngle;
float[] linesMag;

int rectX, rectY;      // Position of square button
int rectSize = 90;     // Diameter of rect
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;


//Delay to allow some mouse button debouncing
long now = 0;
long before = 0;
int interval = 150; //required delay in miliseconds

float Rv = 0.0;

int amoutOfPaint;

float force, angle, mag;
int state = 0;

int hoverbutton;

final int W = 960; //width
final int H = 600; //height

void setup() {
  currentActivity = new MenuActivity();
  size(1280, 800);
  background(200);

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 57600);
  myPort.bufferUntil('\n');
}

void draw() {
  currentActivity.mouseDragged();
  currentActivity.mouseReleased();
  if (currentActivity.getState() == 0){
    currentActivity.draw();
    currentActivity.update(mouseX, mouseY);
    currentActivity.mousePressed();
  }else if (currentActivity.getState() == 1){
    currentActivity = new GUICanvasAvtivity();
    currentActivity.draw();

  } else if (currentActivity.getState() >= 2) {
    background(200);
    fill(Rv);
    strokeWeight(4);

    if (inString != null);
    readInFloats = readInFloats(inString);

    force = readInFloat(readInFloats[0]);
    angle = -readInFloat(readInFloats[1]);
    mag = readInFloat(readInFloats[2])*100;

    if (keyPressed == true){
      Rv = map(force, 10, 450, 225, 0);
      amoutOfPaint = (int)mag;
    }

    fill(Rv,0,0);
    rect(150, 300, 100, 100);

    ellipseMode(CENTER);
    lineAngle(100, 100, angle, mag);
  }

}

String[] splitPoints(String buffer){
  String[] q = splitTokens(buffer, "\n");
  for (int i = 0; i < q.length; ++i){
    println(q[i]);
  }
  return q;
}

float readInFloat(String inString){
  float inByte = 0;
  if (inString != null) {
    inString = trim(inString);
    inByte = float(inString);
  }
  return inByte;
}

String[] readInFloats(String inString){
  String[] q =  {"0.0", "0.0", "0.0"};
  if (inString != null){
    String[] qtmp = splitTokens(inString, ",");
    if (q.length == 3){
      return qtmp;
    }
  }
  return q;
}

void lineAngle(int x, int y, float angle, float length) {
  line(x, y, x+cos(angle)*length, y-sin(angle)*length);
}

void serialEvent(Serial p) {
  inString = p.readStringUntil('\n');
}

void printValues(){
  println("force: "+ force);
  println("red: "+Rv);
  println(readInFloat(readInFloats[2])*100);
  println("amount: " + amoutOfPaint);
}
