import java.util.Random;
public class HIFIColorMatchActivity extends CanvasActivity {
  HIFIPaintBrush paintBrush;
  HIFIPaintSelector paintSelector;
  Canvas canvas;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;
  private int level, randRed, randBlue, randGreen;
  private int startTime;
  private float[] times = new float[10];

  int matchCount = 0;
  private int matchingMode[] = {0, 1, 1, 0, 1, 1, 0, 1, 1, 0};

  private int matchingNib[] = {60, 30, 20, 12, 70, 10, 30, 45, 50, 20};

  private int matchingColorsRGB[] = {2, 1, 3, 2, 1, 1, 3, 1, 3, 2};
  private int matchingColorsDepth[] = {100, 255, 200, 100, 255, 200, 100, 255, 200, 50};
  private String[] userValues = new String[9];;

  private String interfaceType = "defomable";
  private boolean match = false;

  int[] rgb;
  int[] rgbMatch;

  public HIFIColorMatchActivity(){
    super();
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    randRed = randInt(50,250);
    randBlue = randInt(50,250);
    randGreen = randInt(50,250);
  }

  void setup(){
    this.canvas = new Canvas(500, 140, 300, 300);
    this.drawCanvas();
    this.setLevel(0);
    myPort.write('l');
  }

  void drawCanvas(){
    // this.canvas.draw();
  }

  public void draw(){
    background(200);
    rgb = ryb2rgb(map(this.force, 10, 600, 0, 255), map(this.force1, 10, 600, 0, 255), map(this.force2, 10, 600, 0, 255));
    this.paintSelector.sendBlue(this.rgb[RED]);
    this.paintSelector.sendGreen(this.rgb[GREEN]);
    this.paintSelector.sendBlue(this.rgb[BLUE]);
    this.paintSelector.update();
    if (matchCount == 9) {
      background(200);
      text("Tasks complete", width/2, height/2);
      for(int i=0; i < times.length; i++){
        print("  "  + times[i]);
        TableRow newRow = table.addRow();
        newRow.setInt("id", table.getRowCount() - 1);
        if (matchingMode[i] == 0){
          newRow.setString("value-type", "colour");
        } else if (matchingMode[i] == 1){
          newRow.setString("value-type", "nib");
        }
        newRow.setString("computer-value", Integer.toString(matchingColorsDepth[i]));
        newRow.setString("user-value", (userValues[i]));
        newRow.setString("time", String.valueOf(times[i]));
      }
      delay(500);
      this.setLevel(1);
      myPort.write('m');
      fileName = ("data/" + pNum + "-" + interfaceType + ".csv");
      saveTable(table, fileName);
      this.setState(0);
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
        userValues[matchCount] = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
      } else if (matchingMode[matchCount] == 1){
        this.paintBrush.setSize((int)map(this.mag1, 1, 700, 105, 1));
        super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());
        strokeWeight(105);
        stroke(0);
        strokeWeight(matchingNib[matchCount]);
        stroke(255);
        point(width-(width/2)-200, height-(height/2));
        strokeWeight(this.paintBrush.getSize());
        stroke(255);
        point(width-(width/2)+200, height-(height/2));
        strokeWeight(1);
        stroke(0);
        userValues[matchCount] = Integer.toString(this.paintBrush.getSize());
      }
    }
    if (match == true) {
      if (key == 'n' || key == 'N') {
        match();
      }
    }
  }

  void match(){
    int elapsed = millis() - startTime;
    times[matchCount] = float(elapsed) / 1000;
    println(times[matchCount]);
    matchCount++;
    startTime = millis();
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
}
