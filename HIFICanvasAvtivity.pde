 public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private float force, angle, mag, Rv;

  public HIFICanvasAvtivity(){
    // super.setState(2);
    this.force = 0;
    this.angle = 0;
    this.mag = 0;
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
  }

  void draw(){
    fill(this.Rv);
    strokeWeight(4);

    this.paintBrush.setSize((int)map(this.mag, 1, 100, 1, 105));
    this.paintBrush.setColor(color((int)map(this.force, 10, 450, 0, 150), 0, 0));

    super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());

    this.paintBrush.drawSlider(this.paintSelector.getColor());

    this.paintSelector.drawPaintSelector();

    if (keyPressed && key != CODED){
      if (key == 'r' || key == 'R') {
        this.paintSelector.sendRed((int)this.force);
      }
      if (key == 'g' || key == 'G'){
        this.paintSelector.sendGreen((int)this.force);
      }
      if (key == 'b' || key == 'B'){
        this.paintSelector.sendBlue((int)this.force);
      }
      // Rv = map(this.force, 10, 450, 225, 0);
      // this.paintSelector.sendInputs((int)this.force, 0, 0);
      // amoutOfPaint = (int)this.mag;
    }

    // fill(this.Rv, 0, 0);
    // rect(150, 300, 100, 100);

    drawDirctionViz();

    fill(0,0,0);
    text("HIFI Mode", 100, 100);

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
  public void setAngle(float angle){
    this.angle = angle;
  }

  void resize(){}
}
