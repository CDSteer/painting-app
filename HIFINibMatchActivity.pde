
import java.util.Random;
public class HIFINibMatchActivity extends CanvasActivity {

  HIFIPaintBrush paintBrush;
  HIFIPaintSelector paintSelector;
  Canvas canvas;
  private int red, green, blue, nib;
  private int level, randRed, randBlue, randGreen;
  private int redMatch, blueMatch, greenMatch;
  private String inputValue;

  private int startTime;
  private float[] times = new float[10];

  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;

  private final int SLIDERLOW = 568;
  private final int SLIDERHIGH = 370;
  private final int xpos = width-200, ypos = height-(height-340), h = 200, w = 16, l = 16;

  int matchCount = 0;
  int matchingNib[] = {60, 30, 20, 100, 70, 10, 30, 90, 50, 20};

  public HIFINibMatchActivity(){
    super();
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
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
    // this.paintSelector.drawPaintSelector();
    // this.paintBrush.drawSlider(this.paintSelector.getColor());

    this.paintBrush.setSize((int)map(this.mag, 1, 700, 1, 105));

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

}
