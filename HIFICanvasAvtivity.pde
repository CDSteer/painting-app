 public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private int level = 1;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;

  private float[] squeezeValues;
  private int[] rgb;
  private int squeezeSensel;

  private Button nibMode;
  private Button paintMode;
  private boolean hoverNibMode = false;
  private boolean hoverPaintMode = false;

  public HIFICanvasAvtivity(){
    this.angle = 0;
    this.mag = 0;
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    fill(this.paintSelector.getRed(), this.paintSelector.getGreen(), this.paintSelector.getBlue());
    rect(width-200, 100, 100, 100);
    nibMode = new Button(width-200, 250, 100, 50, color(255), "Paint");
    paintMode = new Button(width-200, height-220, 100, 50, color(255), "Nib");
    squeezeValues = new float[3];
  }

  void draw(){
    nibMode.draw();
    paintMode.draw();
    rgb = ryb2rgb(map(this.force, 10, 600, 0, 255), map(this.force1, 10, 600, 0, 255), map(this.force2, 10, 600, 0, 255));
    // this.paintSelector.sendBlue(this.rgb[RED]);
    // this.paintSelector.sendGreen(this.rgb[GREEN]);
    // this.paintSelector.sendBlue(this.rgb[BLUE]);
    // this.paintSelector.update();
    if (level == 0){
      println(force+", "+ force1 +", "+force2);
      fill(rgb[RED],rgb[GREEN],rgb[BLUE]);
      rect(width-200, 100, 100, 100);
      this.paintBrush.setColor(color(rgb[RED],rgb[GREEN],rgb[BLUE]));
    }

    if (level == 2){
      println(squeezeValues[0]+", "+ squeezeValues[1] +", "+squeezeValues[2]);
      squeezeSensel = maxIndex(squeezeValues[0], squeezeValues[1], squeezeValues[2]);
      if (max(squeezeValues[0], squeezeValues[1], squeezeValues[2]) > 20){
        this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 20, 500, 72, 1));
      }
    }
    this.paintBrush.drawSlider(this.paintSelector.getColor(), squeezeSensel);
    super.draw(this.paintBrush.getSize(), this.paintBrush.getColor(), squeezeSensel);


    // this.paintSelector.drawPaintSelector();
    fill(0,0,0);

    if (this.paintMode.inBounds(mouseX, mouseY)){
      this.hoverPaintMode = true;
      this.hoverNibMode = false;
      this.nibMode.deHightlight();
      this.paintMode.hightlight();
    } else if (this.nibMode.inBounds(mouseX, mouseY)){
      this.hoverNibMode = true;
      this.hoverPaintMode = false;
      this.paintMode.deHightlight();
      this.nibMode.hightlight();
    } else {
      this.hoverNibMode = false;
      this.hoverPaintMode = false;
      this.paintMode.deHightlight();
      this.nibMode.deHightlight();
    }
  }

  void click(){
    if (this.hoverPaintMode == true){
      level = 2;
      myPort.write('h');
    }
    if (this.hoverNibMode == true) {
      level = 0;
      myPort.write('l');
    }
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
    this.squeezeValues[0] = mag;
  }

  public void setForce1(float force){
    this.force1 = force;
  }
  public void setMag1(float mag){
    this.squeezeValues[1] = mag;
  }
  public void setForce2(float force){
    this.force2 = force;
  }
  public void setMag2(float mag){
    this.squeezeValues[2] = mag;
  }

  public void setAngle(float angle){
    this.angle = angle;
  }
  public void setLevel(int l){
    this.level = l;
  }
  void resize(){}
}
