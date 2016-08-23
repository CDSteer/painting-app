 public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private int level = 1;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;

  public HIFICanvasAvtivity(){
    this.angle = 0;
    this.mag = 0;
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    fill(this.paintSelector.getRed(), this.paintSelector.getGreen(), this.paintSelector.getBlue());
    rect(width-200, 260, 100, 100);
  }

  void draw(){
    if (level == 0){
      // if (keyPressed && key != CODED){
        // if (key == 'r' || key == 'R') {
          this.paintSelector.sendRed((int)this.force);
          this.paintSelector.sendGreen((int)this.force1);
          this.paintSelector.sendBlue((int)this.force2);
          fill(this.paintSelector.getRed(), this.paintSelector.getGreen(), this.paintSelector.getBlue());
          rect(width-200, 270, 100, 100);
          this.paintBrush.setColor(color(this.paintSelector.getRed(), this.paintSelector.getGreen(), this.paintSelector.getBlue()));
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
