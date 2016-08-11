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
  int matchingColorsRGB[] = {1,2,3};
  int matchingColorsDepth[] = {100,255,200};
  private int redMatch, blueMatch, greenMatch;

  public HIFIColorMatchActivity(){
    super();
    // this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    randRed = randInt(50,250);
    randBlue = randInt(50,250);
    randGreen = randInt(50,250);
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
      for(int i=0; i < times.length; i++){
        print("  "  + times[i]);
        TableRow newRow = table.addRow();
        newRow.setInt("id", table.getRowCount() - 1);
        newRow.setString("value-type", "colour");
        newRow.setString("value", Integer.toString(matchingColorsDepth[i]));
        newRow.setString("time", String.valueOf(times[i]));
      }
      delay(500);
      this.setState(0);
      currentActivity = new MenuActivity();
    } else {
      if (level == 0 ){
        rectMode(CENTER);
        switch (matchingColorsRGB[matchCount]) {
          case 1:
            fill(matchingColorsDepth[matchCount],0,0);
            rect(150, 140, 100, 100);
            fill(0);
            this.paintSelector.sendRed((int)this.force);
            fill(this.paintSelector.getRed(),0,0);
            rect(150, 340, 100, 100);
            if (matchingColorsDepth[matchCount] == this.paintSelector.getRed()){
              match();
            }
            break;
          case 2:
            fill(0,matchingColorsDepth[matchCount],0);
            rect(350, 140, 100, 100);
            this.paintSelector.sendGreen((int)this.force1);
            fill(0,this.paintSelector.getGreen(),0);
            rect(350, 340, 100, 100);
            if (matchingColorsDepth[matchCount] == this.paintSelector.getGreen()){
              match();
            }
            break;
          case 3:
            fill(0,0,matchingColorsDepth[matchCount]);
            rect(550, 140, 100, 100);
            this.paintSelector.sendBlue((int)this.force2);
            fill(0,0,this.paintSelector.getBlue());
            rect(550, 340, 100, 100);
            if (matchingColorsDepth[matchCount] == this.paintSelector.getBlue()){
              match();
            }
            break;
        }
        rectMode(CORNER);
      }
    }

    if (keyPressed) {
      if (key == 'r') {
        matchCount = 0;
      } else if (key == 'g') {
        matchCount = 1;
      } else if (key == 'b') {
        matchCount = 2;
      }
    }

    if (level == 2){
      this.paintBrush.setSize((int)map(this.mag, 1, 700, 1, 105));
    }
  }

  void match(){
    int elapsed = millis() - startTime;
    times[matchCount] = float(elapsed) / 1000;
    println(times[matchCount]);
    matchCount++;
    startTime = millis();
  }

  private void colorMatchCheck(){
    if (redMatch == 1){
      fill(randRed,0,0);
      text("Paint Matched", 600, 140);
      rect(500, 140, 100, 100);
    }
    if (greenMatch == 1){
      fill(0,randGreen,0);
      text("Paint Matched", 600, 340);
      rect(500, 340, 100, 100);
    }
    if (blueMatch == 1){
      fill(0,0,randBlue);
      text("Paint Matched", 600, 540);
      rect(500, 540, 100, 100);
    }
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
