public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  // GUIPaintBrush paintBrush;
  // GUIPaintSelector paintSelector;


  float[] linesAngle;
  float[] linesMag;
  float force, angle, mag;
  float Rv;
  String inString;

  public HIFICanvasAvtivity(){
    super();
    // paintBrush = new GUIPaintBrush();
    // paintSelector = new GUIPaintSelector();
  }

  void draw(){
    // fill(0);
    // this.paintSelector.drawPaintSelector();
    // this.paintBrush.drawSlider(this.paintSelector.getColor());
    // super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());

    background(200);
    fill(Rv);
    strokeWeight(4);
    if (keyPressed == true){
      Rv = map(force, 10, 450, 225, 0);
      amoutOfPaint = (int)mag;
    }
    fill(Rv,0,0);
    rect(150, 300, 100, 100);
    ellipseMode(CENTER);
    lineAngle(100, 100, angle, mag);
    text("HIFI Mode", 100, 100);
  }

  public void setInString(String inString){
    println(inString);
    this.inString = inString;
  }

  void lineAngle(int x, int y, float angle, float length) {
    line(x, y, x+cos(angle)*length, y-sin(angle)*length);
  }

  void printValues(){
    println("force: "+ force);
    println("red: " + Rv);
    println(readInFloat(readInFloats[2])*100);
    println("amount: " + amoutOfPaint);
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
  void update(int x, int y){}
}
