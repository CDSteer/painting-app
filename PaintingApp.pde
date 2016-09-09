import processing.serial.*;
final int RED = 0;
final int GREEN = 1;
final int BLUE = 2;
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
PImage[] nibs = new PImage[3];

void setup() {
  nibs[0] = loadImage("img/pen.png");
  nibs[1] = loadImage("img/pencil.png");
  nibs[2] = loadImage("img/brush.png");

  prepareExitHandler();
  table = new Table();
  table.addColumn("id");
  table.addColumn("value-mode");
  table.addColumn("value-type");
  table.addColumn("value-computer");
  table.addColumn("value-user");
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
    ((HIFIColorMatchActivity)currentActivity).setForce2(0);
    ((HIFIColorMatchActivity)currentActivity).setMag2(h2InByte2);
    // println(inByte + ", " + h1InByte1 + ", " + h2InByte2);
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

void mousePressed(){
  if (currentActivity instanceof HIFIColorMatchActivity){
    ((HIFIColorMatchActivity)currentActivity).clickNext();
  }
  if (currentActivity instanceof GUIColorMatchActivity){
    ((GUIColorMatchActivity)currentActivity).clickNext();
  }
  if (currentActivity instanceof HIFICanvasAvtivity){
    ((HIFICanvasAvtivity)currentActivity).click();
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
  if (key == 'n' || key == 'N') {
    if (currentActivity instanceof HIFIColorMatchActivity){
      ((HIFIColorMatchActivity)currentActivity).setMatch();
    }
    if (currentActivity instanceof GUIColorMatchActivity){
      ((GUIColorMatchActivity)currentActivity).setMatch();
    }
  }
}

int[] ryb2rgb(double iRed, double iYellow, double iBlue) {
  double iWhite = min(iRed, iYellow, iBlue);

  iRed -= iWhite;
  iYellow -= iWhite;
  iBlue -= iWhite;

  double iMaxYellow = max(iRed, iYellow, iBlue);
  double iGreen = Math.min(iYellow, iBlue);

  iYellow -= iGreen;
  iBlue   -= iGreen;

  if (iBlue > 0 && iGreen > 0){
    iBlue  *= 2.0;
    iGreen *= 2.0;
  }

  iRed   += iYellow;
  iGreen += iYellow;

  double iMaxGreen = max(iRed, iGreen, iBlue);

  if (iMaxGreen > 0){
    double iN = iMaxYellow / iMaxGreen;
    iRed   *= iN;
    iGreen *= iN;
    iBlue  *= iN;
  }

  iRed   += iWhite;
  iGreen += iWhite;
  iBlue  += iWhite;

  int rgb[] = {(int)Math.floor(iRed), (int)Math.floor(iGreen), (int)Math.floor(iBlue)};
  return rgb;
}

double max(double... n) {
    int i = 0;
    double max = n[i];
    while (++i < n.length)
        if (n[i] > max)
            max = n[i];
    return max;
}
int maxIndex(double... n) {
    int i = 0;
    double max = n[i];
    int maxIndex = 0;
    for (i = 0; i < n.length; i++){
      if (n[i] > max){
        max = n[i];
        maxIndex = i;
      }
    }
    return maxIndex;
}

double min(double... n) {
    int i = 0;
    double min = n[i];
    while (++i < n.length)
        if (n[i] < min)
            min = n[i];
    return min;
}


PImage changeImgColor(PImage img, float _r, float _g, float _b) {
  loadPixels();
  img.loadPixels();
  for (int c, i = img.pixels.length; i != 0;) {
    c = img.pixels[--i];   // gets pixel whole color
    float r, g, b;
    r = red(c);     // r = c >> 020 & 0xFF;
    g = green(c);   // g = c >> 010 & 0xFF;
    b = blue(c);    // b = c & 0xFF;

    // if (c != 0)  System.out.println(alpha(c));
    if (c != 0) {
      img.pixels[i] = color(_r, _g, _b, alpha(c)); // Set the display pixel to the image pixel
    }
  }
  img.updatePixels();
  return img;

  // image(pen, mouseX, mouseY, 30, 30);
}
