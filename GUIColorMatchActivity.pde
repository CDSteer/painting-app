import java.util.Random;
public class GUIColorMatchActivity extends CanvasActivity {
  HIFIPaintBrush paintBrush;
  HIFIPaintSelector paintSelector;
  Canvas canvas;
  private int red, green, blue, nib;
  private int level, randRed, randBlue, randGreen;
  private int redMatch, blueMatch, greenMatch;
  private String inputValue;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;
  private String interfaceType = "gui";
  private int startTime;
  private float[] times;
  private int matchCount = 0;
  private int matchingMode[] = new int[6];
  private int matchingNib[] = new int[6];
  private int matchingNibSize[] = new int[6];
  private int matchingColorsRGB[] = new int[6];
  private int matchingColorsDepth[] = new int[6];
  private String[] userValues;
  private TableRow newRowSesh = tableSesh.addRow();
  private int topForce[] = new int[3];
  private int activeSensol;
  private boolean reseting = false;
  private int grabStartTime ;

  private String activecolour;

  private int[] rgb;
  private int[] rgbMatch;
  private boolean match;
  private Button nextButton;
  private boolean hoverbutton = false;

  public GUIColorMatchActivity(){
    super();
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    randRed = randInt(50,250);
    randBlue = randInt(50,250);
    randGreen = randInt(50,250);
    nextButton = new Button((width/2)-25, height-100, 100, 50, color(255), "Next");
    startTime = millis();
    for(int i=0; i < 6; i++){
      matchingNibSize[i] = randInt(10,100);
      matchingColorsDepth[i] = randInt(10,255);
    }
    switch (tabAtempt){
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
    userValues = new String[6];
    times = new float[6];
    startTime = millis();
  }

  void setup(){
    this.canvas = new Canvas(500, 140, 300, 300);
    this.drawCanvas();
  }
  void drawCanvas(){
    // this.canvas.draw();
  }
  public void draw(){
    background(200);
    nextButton.draw();
    if (reseting){
      parceInput();
      switch (activeSensol){
        case 0:
        if (red == 0) reseting = false;
        break;
        case 1:
        if (green == 0) reseting = false;
        break;
        case 2:
        if (green == 0) reseting = false;
        break;
      }
      if (activeSensol == maxIndex(red,green,blue)){
        reseting = true;
      }
    } else {
      reseting = false;
    }
    parceInput();
    if (matchCount == 6) {
      background(200);
      text("Tasks complete", width/2, height/2);
      for(int i=0; i < times.length; i++){
        //print("  "  + times[i]);
        TableRow newRow = tableResults.addRow();
        newRow.setInt("id", tableResults.getRowCount()-1);
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
      fileName = ("data/" + pNum + "-" + interfaceType + "-" + "results" + "-" + String.valueOf(tabAtempt) + ".csv");
      saveTable(tableResults, fileName);
      fileName = ("data/" + pNum + "-" + interfaceType + "-" + "sesh" + "-" + String.valueOf(tabAtempt) + ".csv");
      saveTable(tableSesh, fileName);
      this.setState(0);
      tabAtempt++;
      currentActivity = new MenuActivity();
    } else {
      topForce[0] = red;
      topForce[1] = green;
      topForce[2] = blue;
      rgb = ryb2rgb(red, green, blue);
      this.paintSelector.sendBlue(this.rgb[RED]);
      this.paintSelector.sendGreen(this.rgb[GREEN]);
      this.paintSelector.sendBlue(this.rgb[BLUE]);
      this.paintSelector.update();
      if (matchingMode[matchCount] == 0 ){
        rectMode(CENTER);
        switch (matchingColorsRGB[matchCount]) {
          case 1:
            rgbMatch = ryb2rgb(matchingColorsDepth[matchCount],0,0);
            fill(rgbMatch[RED],rgbMatch[GREEN],rgbMatch[BLUE]);
            rect((width/2)-100, 140, 100, 100);
            fill(0);
            if (!reseting) fill(this.rgb[RED],this.rgb[GREEN],this.rgb[BLUE]);
            rect((width/2)+100, 140, 100, 100);
            break;
          case 2:
            rgbMatch = ryb2rgb(0,matchingColorsDepth[matchCount],0);
            fill(rgbMatch[RED],rgbMatch[GREEN],rgbMatch[BLUE]);
            rect((width/2)-100, 340, 100, 100);
            fill(0);
            if (!reseting) fill(this.rgb[RED],this.rgb[GREEN],this.rgb[BLUE]);
            rect((width/2)+100, 340, 100, 100);
            break;
          case 3:
            rgbMatch = ryb2rgb(0,0,matchingColorsDepth[matchCount]);
            fill(rgbMatch[RED],rgbMatch[GREEN],rgbMatch[BLUE]);
            rect((width/2)-100, 440, 100, 100);
            fill(0);
            if (!reseting) fill(this.rgb[RED],this.rgb[GREEN],this.rgb[BLUE]);
            rect((width/2)+100, 440, 100, 100);
            break;
        }
        rectMode(CORNER);
        userValues[matchCount] = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
        println(matchCount);
        if (red > 0 || green > 0 || blue > 0){
          activecolour = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
          activeSensol = maxIndex(red,green,blue);
          newRowSesh = tableSesh.addRow();
          newRowSesh.setInt("id", tableSesh.getRowCount()-1);
          newRowSesh.setInt("sensol-num", activeSensol);
          newRowSesh.setString("value", activecolour);
          newRowSesh.setInt("match-num", matchCount);
          int elapsed = millis() - startTime;
          newRowSesh.setString("startTime", String.valueOf(float(elapsed)/1000));
        }
      } else if (matchingMode[matchCount] == 1){
        switch (matchingNib[matchCount]) {
          case 0:
            this.paintBrush.setSize((int)map(this.red, 1, 255, 100, 1));
            image(nibs[matchingNib[matchCount]], ((width/2)+100)-matchingNibSize[matchCount]/2, (140)-matchingNibSize[matchCount]/2, matchingNibSize[matchCount], matchingNibSize[matchCount]);
            if (!reseting) image(nibs[matchingNib[matchCount]], ((width/2)-100)-this.paintBrush.getSize()/2, (140)-this.paintBrush.getSize()/2, this.paintBrush.getSize(), this.paintBrush.getSize());
            if (reseting) image(nibs[matchingNib[matchCount]], ((width/2)-100)-100/2, (140)-100/2, 100, 100);
          break;
          case 1:
            this.paintBrush.setSize((int)map(this.green, 1, 255, 100, 1));
            image(nibs[matchingNib[matchCount]], ((width/2)+100)-matchingNibSize[matchCount]/2, (340)-matchingNibSize[matchCount]/2, matchingNibSize[matchCount], matchingNibSize[matchCount]);
            if (!reseting) image(nibs[matchingNib[matchCount]], ((width/2)-100)-this.paintBrush.getSize()/2, (340)-this.paintBrush.getSize()/2, this.paintBrush.getSize(), this.paintBrush.getSize());
            if (reseting) image(nibs[matchingNib[matchCount]], ((width/2)-100)-100/2, (340)-100/2, 100, 100);
          break;
          case 2:
            this.paintBrush.setSize((int)map(this.blue, 1, 255, 100, 1));
            image(nibs[matchingNib[matchCount]], ((width/2)+100)-this.matchingNibSize[matchCount]/2, (440)-matchingNibSize[matchCount]/2, matchingNibSize[matchCount], matchingNibSize[matchCount]);
            if (!reseting) image(nibs[matchingNib[matchCount]], ((width/2)-100)-this.paintBrush.getSize()/2, (440)-this.paintBrush.getSize()/2, this.paintBrush.getSize(), this.paintBrush.getSize());
            if (reseting) image(nibs[matchingNib[matchCount]], ((width/2)-100)-100/2, (440)-100/2, 100, 100);
          break;
        }
        userValues[matchCount] = Integer.toString(this.paintBrush.getSize());
        if (red > 0 || green > 0 || blue > 0){
          activecolour = Integer.toString(this.paintBrush.getSize());
          activeSensol = maxIndex(red,green,blue);
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
    //println(times[matchCount]);
    matchCount++;
    startTime = millis();
    match = false;
    this.red = 0;
    this.green = 0;
    this.blue = 0;
    reseting = true;
  }

  void setMatch(){
    match = true;
  }

  void paint(int size, color c) {
    if (this.isDragging() && amoutOfPaint > 0 && canvas.inCanvas(this.paintBrush.getSize())){
     stroke(c);
     strokeWeight(size);
     line(pmouseX, pmouseY, mouseX, mouseY);
     amoutOfPaint--;
     strokeWeight(1);
     stroke(0);
    }
  }

  public void setInputValue(String input){
    this.inputValue = input;
  }

  public int randInt(int min, int max) {
    Random rand = new Random();
    int randomNum = rand.nextInt((max - min) + 1) + min;
    return randomNum;
  }

  public void colorpick(){
    this.paintSelector.sendRed(this.red);
    fill(this.paintSelector.getRed(),0,0);
    rect(500, 140, 100, 100);
    if (randRed == this.paintSelector.getRed()){
      redMatch = 1;
    }
    this.paintSelector.sendGreen(this.green);
    fill(0,this.paintSelector.getGreen(),0);
    rect(500, 340, 100, 100);
    if (randGreen == this.paintSelector.getGreen()){
      greenMatch = 1;
    }
    this.paintSelector.sendBlue(this.blue);
    fill(0,0,this.paintSelector.getBlue());
    rect(500, 540, 100, 100);
    if (randBlue == this.paintSelector.getBlue()){
      blueMatch = 1;
    }
  }

  private void parceInput(){
    //println(inputValue);
    if (inputValue != null) {
      String[] qtmp = splitTokens(inputValue, ":");
      if (qtmp.length == 6){
         this.red = int(qtmp[1]);
         this.green = int(qtmp[3]);
         this.blue = int(qtmp[5]);
      }
    }
  }
}
