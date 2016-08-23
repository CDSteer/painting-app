
import java.util.Random;
public class GUINibMatchActivity extends CanvasActivity {

  HIFIPaintBrush paintBrush;
  HIFIPaintSelector paintSelector;
  Canvas canvas;
  private int red, green, blue, nib;
  private int level;
  private int redMatch, blueMatch, greenMatch;
  private String inputValue;

  private int startTime;
  private float[] times = new float[10];

  private String interfaceType = "gui";
  private String mode = "nibMatch";

  private final int SLIDERLOW = 568;
  private final int SLIDERHIGH = 370;
  private final int xpos = width-200, ypos = height-(height-340), h = 200, w = 16, l = 16;

  private int matchCount = 0;
  private int matchingNib[] = {60, 30, 20, 100, 70, 10, 30, 150, 50, 20};

  public GUINibMatchActivity(){
    super();
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
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
    parceInput();
    this.paintBrush.setSize(this.green);
    // this.paintSelector.drawPaintSelector();
    // this.paintBrush.drawSlider(this.paintSelector.getColor());
    super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());

    strokeWeight(105);
    stroke(0);
    // point(width-400, ypos+100);

    strokeWeight(matchingNib[matchCount]);
    stroke(255);
    point(width-(width/2)-200, height-(height/2));

    strokeWeight(this.paintBrush.getSize());
    stroke(255);
    point(width-(width/2)+200, height-(height/2));
    strokeWeight(1);
    stroke(0);

    if (matchCount == 9) {
      background(200);
      text("Tasks complete", width/2, height/2);
      for(int i=0; i < times.length; i++){
        print("  "  + times[i]);
        TableRow newRow = table.addRow();
        newRow.setInt("id", table.getRowCount() - 1);
        newRow.setString("value-type", "nib");
        newRow.setString("value", Integer.toString(matchingNib[i]));
        newRow.setString("time", String.valueOf(times[i]));
      }
      delay(500);
      fileName = ("data/" + pNum + "-" + interfaceType + "-" + mode + ".csv");
      saveTable(table, fileName);
      this.setState(0);
      currentActivity = new MenuActivity();
    } else if (this.paintBrush.getSize() == matchingNib[matchCount]){
      match();
    }
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
          println(this.nib);
        }
      }
    }
  }
}
