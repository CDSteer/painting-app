import processing.serial.*;

Serial myPort;
PaintingAppActivity currentActivity;
String inString;
String[] readInFloats;

void setup() {
  currentActivity = new MenuActivity();
  size(1250, 750);
  background(200);

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 57600);
  myPort.bufferUntil('\n');
}

void draw() {
  smooth();
  currentActivity.mouseDragged();
  currentActivity.mouseReleased();
  if (currentActivity.getState() == 0){
    currentActivity.draw();
  } else if (currentActivity.getState() == 1) {
    currentActivity = new GUICanvasAvtivity();
    currentActivity.draw();
  } else if (currentActivity.getState() == 2) {
    currentActivity = new HIFICanvasAvtivity();
    currentActivity.draw();
  } else if (currentActivity.getState() == 4) {
    currentActivity = new GUIColorMatchActivity();
    currentActivity.draw();
  }

}

void serialEvent(Serial p) {
  inString = p.readStringUntil('\n');
  println(inString);
  if (inString != null && currentActivity.getState() == 2){
    readInFloats = readInFloats(inString);
    ((HIFICanvasAvtivity)currentActivity).setForce(readInFloat(readInFloats[0]));
    ((HIFICanvasAvtivity)currentActivity).setAngle(-readInFloat(readInFloats[1]));
    ((HIFICanvasAvtivity)currentActivity).setMag(readInFloat(readInFloats[2])*100);
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
