import processing.serial.*;

Serial myPort;
PaintingAppActivity currentActivity;
String inString;
String[] readInFloats;
float inByte = 0;
float inByte1, inByte2, h1InByte1, h1InByte2, h2InByte1, h2InByte2;

String guiInput;
int forceValue;
SocketServer mSocketServer;
String[] qtmp;
String[] qtmp2;

String pNum = "p1";
String fileName;
Table table;

void setup() {
  prepareExitHandler();
  table = new Table();
  table.addColumn("id");
  table.addColumn("value-type");
  table.addColumn("value");
  table.addColumn("time");


  currentActivity = new MenuActivity();
  size(1250, 750);
  background(200);

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil('\n');
  myPort.write('l');
  delay(1000);
}

void draw() {
  smooth();
  currentActivity.mouseDragged();
  currentActivity.mouseReleased();
  if (currentActivity.getState() == 0){
    currentActivity.draw();
  } else if (currentActivity.getState() == 1) {
    currentActivity = new GUINibMatchActivity();
    currentActivity.draw();
    if (mSocketServer == null){
      mSocketServer = new SocketServer();
    }
  } else if (currentActivity.getState() == 2) {
    currentActivity = new HIFICanvasAvtivity();
    currentActivity.draw();
  } else if (currentActivity.getState() == 3) {
    currentActivity = new HIFINibMatchActivity();
    currentActivity.draw();
  } else if (currentActivity.getState() == 4) {
    currentActivity = new GUIColorMatchActivity();
    currentActivity.draw();
    if (mSocketServer == null){
      mSocketServer = new SocketServer();
    }
  } else if (currentActivity.getState() == 5) {
    currentActivity = new HIFIColorMatchActivity();
    currentActivity.draw();
  }

  if (currentActivity instanceof GUIColorMatchActivity){
    // println(mSocketServer.getValue());
    guiInput = mSocketServer.getValue();
    ((GUIColorMatchActivity)currentActivity).setInputValue(guiInput);
  }
  if (currentActivity instanceof GUINibMatchActivity){
    // println(mSocketServer.getValue());
    guiInput = mSocketServer.getValue();
    ((GUINibMatchActivity)currentActivity).setInputValue(guiInput);
  }
}



private void prepareExitHandler () {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
  public void run() {
    System.out.println("SHUTDOWN HOOK");
  }
  }));
}

void serialEvent(Serial p) {
  inString = p.readStringUntil('\n');
  readInFloats(inString);
  if (currentActivity instanceof HIFICanvasAvtivity){
    // ((HIFICanvasAvtivity)currentActivity).setForce(readInFloat(readInFloats[0]));
    ((HIFICanvasAvtivity)currentActivity).setForce(inByte1);
    ((HIFICanvasAvtivity)currentActivity).setMag(inByte2);
    ((HIFICanvasAvtivity)currentActivity).setForce1(h1InByte1);
    ((HIFICanvasAvtivity)currentActivity).setMag1(h1InByte2);
    ((HIFICanvasAvtivity)currentActivity).setForce2(h2InByte1);
    ((HIFICanvasAvtivity)currentActivity).setMag2(h2InByte2);
    // ((HIFICanvasAvtivity)currentActivity).setAngle(-readInFloat(readInFloats[1]));
    // ((HIFICanvasAvtivity)currentActivity).setMag(readInFloat(readInFloats[2])*100);
  } else if (currentActivity instanceof HIFIColorMatchActivity){
    ((HIFIColorMatchActivity)currentActivity).setForce(inByte1);
    ((HIFIColorMatchActivity)currentActivity).setMag(inByte2);
    ((HIFIColorMatchActivity)currentActivity).setForce1(h1InByte1);
    ((HIFIColorMatchActivity)currentActivity).setMag1(h1InByte2);
    ((HIFIColorMatchActivity)currentActivity).setForce2(h2InByte1);
    ((HIFIColorMatchActivity)currentActivity).setMag2(h2InByte2);
  } else if (currentActivity instanceof HIFINibMatchActivity){
    ((HIFINibMatchActivity)currentActivity).setForce(inByte1);
    ((HIFINibMatchActivity)currentActivity).setMag(inByte2);
    ((HIFINibMatchActivity)currentActivity).setForce1(h1InByte1);
    ((HIFINibMatchActivity)currentActivity).setMag1(h1InByte2);
    ((HIFINibMatchActivity)currentActivity).setForce2(h2InByte1);
    ((HIFINibMatchActivity)currentActivity).setMag2(h2InByte2);
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

void readInFloats(String inString){
  if (inString != null){
    inString = trim(inString);
    qtmp = splitTokens(inString, ":");
    if (qtmp.length == 2){
      if (qtmp[0].equalsIgnoreCase("head0")){
        qtmp2 = splitTokens(qtmp[1], ",");
        if (qtmp.length == 2){
          inByte1 = float(qtmp2[0]);
          inByte2 = float(qtmp2[1]);
        }
      }
      if (qtmp[0].equalsIgnoreCase("head1")){
        qtmp2 = splitTokens(qtmp[1], ",");
        if (qtmp.length == 2){
          h1InByte1 = float(qtmp2[0]);
          h1InByte2 = float(qtmp2[1]);
        }
      }
      if (qtmp[0].equalsIgnoreCase("head2")){
        qtmp2 = splitTokens(qtmp[1], ",");
        if (qtmp.length == 2){
          h2InByte1 = float(qtmp2[0]);
          h2InByte2 = float(qtmp2[1]);
        }
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (currentActivity instanceof HIFICanvasAvtivity || currentActivity instanceof HIFIColorMatchActivity){
      if (keyCode == UP) {
        if (currentActivity instanceof HIFICanvasAvtivity){
          ((HIFICanvasAvtivity)currentActivity).setLevel(2);
        } else {
          ((HIFIColorMatchActivity)currentActivity).setLevel(2);
        }
        myPort.write('h');
      } else if (keyCode == LEFT) {
        if (currentActivity instanceof HIFICanvasAvtivity){
          ((HIFICanvasAvtivity)currentActivity).setLevel(1);
        } else {
          ((HIFIColorMatchActivity)currentActivity).setLevel(1);
        }
        myPort.write('m');
      } else if (keyCode == DOWN) {
        if (currentActivity instanceof HIFICanvasAvtivity){
          ((HIFICanvasAvtivity)currentActivity).setLevel(0);
        } else {
          ((HIFIColorMatchActivity)currentActivity).setLevel(0);
        }
        myPort.write('l');
      }
    }
  }
  if ((key == 'a' || key == 'A')) {
    myPort.write('s');
  } else if (key == 's' || key == 's') {
    myPort.write('a');
  }

  if ((key == 'q' || key == 'Q')) {
    myPort.write('q');
  } else if (key == 'w' || key == 'W') {
    myPort.write('w');
  }

  if ((key == 'z' || key == 'Z')) {
    myPort.write('z');
  } else if (key == 'x' || key == 'X') {
    myPort.write('x');
  }
}
