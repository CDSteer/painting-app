
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
  private String mode = "colourMatch";

  private int startTime;
  private float[] times = new float[10];

  private int matchCount = 0;
  private int matchingColorsRGB[] = {1, 3, 2, 2, 1, 1, 3, 1, 3, 2};
  private int matchingColorsDepth[] = {100, 255, 200, 100, 255, 200, 100, 255, 200, 50};

  public GUIColorMatchActivity(){
    super();
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    randRed = randInt(50,250);
    randBlue = randInt(50,250);
    randGreen = randInt(50,250);
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
    if (matchCount == 9) {
      background(200);
      text("Tasks complete", width/2, height/2);
      for(int i=0; i < times.length-1; i++){
        print("  "  + times[i]);
        TableRow newRow = table.addRow();
        newRow.setInt("id", table.getRowCount() - 1);
        newRow.setString("value-type", "colour");
        newRow.setString("value", Integer.toString(matchingColorsDepth[i]));
        newRow.setString("time", String.valueOf(times[i]));
      }
      delay(500);
      fileName = ("data/" + pNum + "-" + interfaceType + "-" + mode + ".csv");
      saveTable(table, fileName);
      this.setState(0);
      currentActivity = new MenuActivity();
    } else {
      rectMode(CENTER);
      switch (matchingColorsRGB[matchCount]) {
        case 1:
          fill(matchingColorsDepth[matchCount],0,0);
          rect(width-(width/2)-200, height-(height/2), 100, 100);
          fill(0);
          fill(this.red,0,0);
          rect(width-(width/2)+200, height-(height/2), 100, 100);
          if (matchingColorsDepth[matchCount] == this.red+1){
            match();
          }
          break;
        case 2:
          fill(0,matchingColorsDepth[matchCount],0);
          rect(width-(width/2)-200, height-(height/2), 100, 100);
          fill(0,this.green,0);
          rect(width-(width/2)+200, height-(height/2), 100, 100);
          if (matchingColorsDepth[matchCount] == this.green){
            match();
          }
          break;
        case 3:
          fill(0,0,matchingColorsDepth[matchCount]);
          rect(width-(width/2)-200, height-(height/2), 100, 100);
          fill(0,0,this.blue);
          rect(width-(width/2)+200, height-(height/2), 100, 100);
          if (matchingColorsDepth[matchCount] == this.blue){
            match();
          }
          break;
        }
        rectMode(CORNER);
      }
    parceInput();
  }
  void match(){
    int elapsed = millis() - startTime;
    times[matchCount] = float(elapsed) / 1000;
    println(times[matchCount]);
    matchCount++;
    startTime = millis();
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
    if (inputValue != null) {
      String[] qtmp = splitTokens(inputValue, ":");
      if (qtmp.length == 2){
        String type = trim(qtmp[0]);
        String value = trim(qtmp[1]);
        if (type.equalsIgnoreCase("RED")){
          this.red = int(value);
        } else if (type.equalsIgnoreCase("GREEN")){
          this.green = int(value);
        } else if (type.equalsIgnoreCase("BLUE")){
          this.blue = int(value);
        } else if (type.equalsIgnoreCase("nib")){
          this.nib = int(value);
        }
      }
    }
  }
}
