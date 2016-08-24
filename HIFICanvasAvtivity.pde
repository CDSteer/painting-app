 public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private int level = 1;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;

  private int[] rgb;

  public HIFICanvasAvtivity(){
    this.angle = 0;
    this.mag = 0;
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    fill(this.paintSelector.getRed(), this.paintSelector.getGreen(), this.paintSelector.getBlue());
    rect(width-200, 260, 100, 100);
  }

  void draw(){
    rgb = ryb2rgb(map(this.force, 10, 600, 0, 255), map(this.force1, 10, 600, 0, 255), map(this.force2, 10, 600, 0, 255));
    // this.paintSelector.sendBlue(this.rgb[RED]);
    // this.paintSelector.sendGreen(this.rgb[GREEN]);
    // this.paintSelector.sendBlue(this.rgb[BLUE]);
    // this.paintSelector.update();
    if (level == 0){
      // if (keyPressed && key != CODED){
        // if (key == 'r' || key == 'R') {
          fill(rgb[RED],rgb[GREEN],rgb[BLUE]);
          rect(width-200, 270, 100, 100);
          this.paintBrush.setColor(color(rgb[RED],rgb[GREEN],rgb[BLUE]));
        // }
      // }
    }
    if (level == 2){
      if (keyPressed && key != CODED){
        if (key == 't' || key == 'T') {
          this.paintBrush.setSize((int)map(this.mag, 1, 700, 72, 1));
        }
      }
    }
    super.draw(this.paintBrush.getSize(), this.paintBrush.getColor());
    this.paintBrush.drawSlider(this.paintSelector.getColor());
    this.paintSelector.drawPaintSelector();
    fill(0,0,0);
  }

  void drawDirctionViz(){
    ellipseMode(CENTER);
    fill(255);
    ellipse(400,200,200,200);
    lineAngle(400, 200, this.angle, this.mag);
  }

  void lineAngle(int x, int y, float angle, float length) {
    line(x, y, x+cos(angle)*length, y-sin(angle)*length);
  }

  void printValues(){
    println("force: "+ this.force);
    println("angle: "+ this.angle);
    println("mag: "+ this.mag);
    println("red: " + this.Rv);
    // println("amount: " + amoutOfPaint);
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
  void resize(){}
}
