import java.util.Random;
public class HIFIColorMatchActivity extends CanvasActivity {
  HIFIPaintBrush paintBrush;
  HIFIPaintSelector paintSelector;
  Canvas canvas;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;
  private int level, randRed, randBlue, randGreen;
  private int startTime;
  private int grabStartTime;
  private float[] times = new float[6];
  private int activeSensol;
  private TableRow newRowSesh;
  private String activecolour;

  private int topForce[] = new int[3];
  private int sideForce[] = new int[3];
  private boolean grabStartTimeSet = false;

  int matchCount = 0;
  private int matchingMode[] = new int[6];
  private int matchingNib[] = new int[6];
  private int matchingNibSize[] = new int[6];
  private int matchingColorsRGB[] = new int[6];
  private int matchingColorsDepth[] = new int[6];
  private String[] userValues = new String[6];

  private String interfaceType = "defomable";
  private boolean match = false;
  private Button nextButton;
  private boolean hoverbutton = false;
  private boolean trigger = false;

  private int randNibS;
  private int randColor;

  int[] rgb;
  int[] rgbMatch;

  public HIFIColorMatchActivity(){
    super();
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    randRed = randInt(50,250);
    randBlue = randInt(50,250);
    randGreen = randInt(50,250);
    nextButton = new Button((width/2)-25, height-200, 100, 50, color(255), "Next");

    // matchingNibSize = new int[]{randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100), randInt(10,100)};
    // matchingColorsDepth = new int[]{randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255), randInt(10,255)};
    for(int i=0; i < 6; i++){
      randNibS = randInt(10,100);
      matchingNibSize[i] = randNibS;
      println(matchingNibSize[i]);
      randColor = randInt(10,255);
      matchingColorsDepth[i] = randColor;
      println(matchingColorsDepth[i]);
    }
    switch (defomAtempt){
      case 1:
        matchingMode = new int[]        {1,	1, 0, 1, 0, 0};
        matchingNib = new int[]         {0,	1, 0, 2, 0, 0};
        matchingColorsRGB = new int[]   {0,	0, 3,	0, 2, 1};
      break;
      case 2:
        matchingMode = new int[]        {1,	1, 1,	0, 0, 0};
        matchingNib = new int[]         {1, 2, 1, 0, 0, 0};
        matchingColorsRGB = new int[]   {0, 0, 0, 1, 3,	2};
      break;
      case 3:
        matchingMode = new int[]        {1,	0, 1, 0, 1, 0};
        matchingNib = new int[]         {2, 0, 1, 0, 0, 0};
        matchingColorsRGB = new int[]   {0, 1, 0, 2, 0, 3};
      break;
      case 4:
        matchingMode = new int[]        {0,	0, 1, 0, 1, 1};
        matchingNib = new int[]         {0,	0, 2,	0, 1, 0};
        matchingColorsRGB = new int[]   {1,	2, 0, 3, 0, 0};
      break;
      case 5:
        matchingMode = new int[]        {0, 0, 0, 1, 1, 1};
        matchingNib = new int[]         {0, 0, 0, 0, 2, 1};
        matchingColorsRGB = new int[]   {2, 3, 1, 0, 0, 0};
      break;
      case 6:
        matchingMode = new int[]        {0, 1, 0, 1, 0, 1};
        matchingNib = new int[]         {0, 1, 0, 0, 0, 2};
        matchingColorsRGB = new int[]   {3, 0, 2, 0, 1, 0};
      break;
    }
  }

  void setup(){
    this.canvas = new Canvas(500, 140, 300, 300);
    this.drawCanvas();
    this.setLevel(0);
  }

  void drawCanvas(){
    // this.canvas.draw();
  }

  public void draw(){
    background(200);
    nextButton.draw();
    topForce[0] = (int)map(this.force, 10, 600, 255, 0);
    topForce[1] = (int)map(this.force, 10, 600, 255, 0);
    topForce[2] = (int)map(this.force, 10, 600, 255, 0);

    sideForce[0] = (int)map(this.mag, 10, 600, 255, 0);
    sideForce[1] = (int)map(this.mag1, 10, 600, 255, 0);
    sideForce[2] = (int)map(this.mag2, 10, 600, 255, 0);

    rgb = ryb2rgb(topForce[0], topForce[1], topForce[2]);
    this.paintSelector.sendBlue(this.rgb[RED]);
    this.paintSelector.sendGreen(this.rgb[GREEN]);
    this.paintSelector.sendBlue(this.rgb[BLUE]);
    this.paintSelector.update();
    if (matchCount == 6) {
      background(200);
      text("Tasks complete", width/2, height/2);
      for(int i=0; i < times.length-1; i++){
        print("  "  + times[i]);
        TableRow newRow = tableResults.addRow();
        newRow.setInt("id", tableResults.getRowCount() - 1);
        if (matchingMode[i] == 0){
          newRow.setString("value-mode", "paint");
          newRow.setString("value-type", Integer.toString(matchingColorsRGB[i]));
          newRow.setString("value-computer", Integer.toString(matchingColorsDepth[i]));
        } else if (matchingMode[i] == 1){
          newRow.setString("value-mode", "nib");
          newRow.setString("value-type", Integer.toString(matchingNib[i]));
          newRow.setString("value-computer", Integer.toString(matchingNibSize[i]));
        }
        newRow.setString("value-user", (userValues[i]));
        newRow.setString("time", String.valueOf(times[i]));
      }
      delay(500);
      this.setLevel(1);
      myPort.write('m');
      fileName = ("data/" + pNum + "-" + interfaceType + "-" + "results" + "-" + String.valueOf(defomAtempt) + ".csv");
      saveTable(tableResults, fileName);
      fileName = ("data/" + pNum + "-" + interfaceType + "-" + "sesh" + "-" + String.valueOf(defomAtempt) + ".csv");
      saveTable(tableSesh, fileName);
      this.setState(0);
      defomAtempt++;
      currentActivity = new MenuActivity();
    } else {
      if (matchingMode[matchCount] == 0 ){
        rectMode(CENTER);
        switch (matchingColorsRGB[matchCount]) {
          case 1:
            rgbMatch = ryb2rgb(matchingColorsDepth[matchCount],0,0);
            fill(rgbMatch[RED],rgbMatch[GREEN],rgbMatch[BLUE]);
            rect(150, 140, 100, 100);
            fill(0);
            fill(this.rgb[RED],this.rgb[GREEN],this.rgb[BLUE]);
            rect(150, 340, 100, 100);
            break;
          case 2:
            rgbMatch = ryb2rgb(0,matchingColorsDepth[matchCount],0);
            fill(rgbMatch[RED],rgbMatch[GREEN],rgbMatch[BLUE]);
            rect(350, 140, 100, 100);
            fill(this.rgb[RED],this.rgb[GREEN],this.rgb[BLUE]);
            rect(350, 340, 100, 100);
            break;
          case 3:
            rgbMatch = ryb2rgb(0,0,matchingColorsDepth[matchCount]);
            fill(rgbMatch[RED],rgbMatch[GREEN],rgbMatch[BLUE]);
            rect(550, 140, 100, 100);
            fill(this.rgb[RED],this.rgb[GREEN],this.rgb[BLUE]);
            rect(550, 340, 100, 100);
            break;
        }

        rectMode(CORNER);
        if (!trigger) {
          myPort.write('l');
          trigger = true;
        }
        userValues[matchCount] = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
        if (topForce[0] > 0 || topForce[1] > 0 || topForce[2] > 0){
          activecolour = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
          activeSensol = maxIndex(topForce[0],topForce[1],topForce[2]);
          newRowSesh = tableSesh.addRow();
          newRowSesh.setInt("id", tableSesh.getRowCount()-1);
          newRowSesh.setInt("sensol-num", activeSensol);
          newRowSesh.setString("value", activecolour);
          newRowSesh.setInt("match-num", matchCount);
          int elapsed = millis() - startTime;
          newRowSesh.setString("startTime", String.valueOf(float(elapsed)/1000));
        }
      }  else if (matchingMode[matchCount] == 1){
        // println(mag+", "+ mag1 +", "+mag2);
        switch (matchingNib[matchCount]) {
          case 0:
            this.paintBrush.setSize((int)map(this.mag, 1, 700, 100, 1));
            image(nibs[matchingNib[matchCount]], (150)-this.paintBrush.getSize()/2, (140)-this.paintBrush.getSize()/2, matchingNibSize[matchCount], matchingNibSize[matchCount]);
            image(nibs[matchingNib[matchCount]], (150)-this.paintBrush.getSize()/2, (340)-this.paintBrush.getSize()/2, this.paintBrush.getSize(), this.paintBrush.getSize());
          break;
          case 1:
            this.paintBrush.setSize((int)map(this.mag1, 20, 75, 100, 1));
            image(nibs[matchingNib[matchCount]], (150)-this.paintBrush.getSize()/2, (140)-this.paintBrush.getSize()/2, matchingNibSize[matchCount], matchingNibSize[matchCount]);
            image(nibs[matchingNib[matchCount]], (150)-this.paintBrush.getSize()/2, (340)-this.paintBrush.getSize()/2, this.paintBrush.getSize(), this.paintBrush.getSize());
          break;
          case 2:
            this.paintBrush.setSize((int)map(this.mag2, 1, 500, 100, 1));
            image(nibs[matchingNib[matchCount]], (150)-this.paintBrush.getSize()/2, (140)-this.paintBrush.getSize()/2, matchingNibSize[matchCount], matchingNibSize[matchCount]);
            image(nibs[matchingNib[matchCount]], (150)-this.paintBrush.getSize()/2, (340)-this.paintBrush.getSize()/2, this.paintBrush.getSize(), this.paintBrush.getSize());
          break;
        }
        if (!trigger) {
          myPort.write('h');
          trigger = true;
        }
        userValues[matchCount] = Integer.toString(this.paintBrush.getSize());
        if (sideForce[0] > 0 || sideForce[1] > 0 || sideForce[2] > 0){
          activecolour = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
          activeSensol = maxIndex(sideForce[0],sideForce[1],sideForce[2]);
          newRowSesh = tableSesh.addRow();
          newRowSesh.setInt("id", tableSesh.getRowCount()-1);
          newRowSesh.setInt("sensol-num", activeSensol);
          newRowSesh.setString("value", activecolour);
          newRowSesh.setInt("match-num", matchCount);
          int elapsed = millis() - startTime;
          newRowSesh.setString("startTime", String.valueOf(float(elapsed)/1000));
        }
      }
    }
    if (match == true) {
      if (key == 'n' || key == 'N') {
        match();
      }
    }
    if (this.nextButton.inBounds(mouseX, mouseY)){
      this.hoverbutton = true;
      this.nextButton.hightlight();
    } else {
      this.hoverbutton = false;
      this.nextButton.deHightlight();
    }
  }

  void clickNext() {
    if (this.hoverbutton = true){
      match();
    }
  }

  void match(){
    int elapsed = millis() - startTime;
    times[matchCount] = float(elapsed) / 1000;
    println(times[matchCount]);
    matchCount++;
    startTime = millis();
    trigger = false;
    match = false;
  }

  void setMatch(){
    match = true;
  }

  void paint(int size, color c) {
    // if (this.isDragging() && amoutOfPaint > 0 && canvas.inCanvas(this.paintBrush.getSize())){
    //  stroke(c);
    //  strokeWeight(size);
    //  line(pmouseX, pmouseY, mouseX, mouseY);
    //  amoutOfPaint--;
    //  strokeWeight(1);
    //  stroke(0);
    // }
  }

  public void setForce(float force){
    this.force = force;
  }
  public void setMag(float mag){
    this.mag = mag;
  }

  public void setForce1(float force){
    this.force1 = force;
  }
  public void setMag1(float mag){
    this.mag1 = mag;
  }
  public void setForce2(float force){
    this.force2 = force;
  }
  public void setMag2(float mag){
    this.mag2 = mag;
  }


  public void setAngle(float angle){
    this.angle = angle;
  }
  public void setLevel(int l){
    this.level = l;
  }

  public int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
  }

  void interactionDeform(){
    if (map(this.force, 10, 600, 255, 0) > 0 && map(this.force1, 10, 600, 0, 255) > 0 && map(this.force2, 10, 600, 255, 0) > 0){

    }
  }
}
