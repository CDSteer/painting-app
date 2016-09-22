 public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private int level = 1;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;

  private float redIn, greenIn, blueIn;
  private float forceSet, force1Set, force2Set;

  private float[] squeezeValues;
  private int[] rgb;
  private int squeezeSensel;

  private int[] red;
  private int[] yellow;
  private int[] blue;
  private int mIndex;
  private TableRow newRowDrawing;

  private Button nibMode;
  private Button paintMode;
  private Button backButton;
  private boolean hoverNibMode = false;
  private boolean hoverPaintMode = false;
  private boolean hoverbackButton = false;

  private String activecolour;

  public HIFICanvasAvtivity(){
    this.angle = 0;
    this.mag = 0;
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
    fill(0);
    rect(width-200, 160, 150, 100);
    nibMode = new Button(width-175, 280, 100, 50, color(255), "Paint");
    paintMode = new Button(width-175, height-230, 100, 50, color(255), "Nib");
    backButton = new Button(width-175, height-120, 100, 50, color(180,0,0), "Back");
    squeezeValues = new float[3];
    this.paintBrush.setSize(72);
    fill(255,0,0);
    text("RED", width-190, 120);
    fill(255,255,0);
    text("YELLOW", width-155, 120);
    fill(0,0,255);
    text("BLUE", width-95, 120);
    fill(200);
    rect(width-195, 50, 40, 40);
    fill(200);
    rect(width-145, 50, 40, 40);
    fill(200);
    rect(width-95, 50, 40, 40);
    rgb = ryb2rgb(0, 0, 0);
  }

  void draw(){
    nibMode.draw();
    paintMode.draw();
    backButton.draw();
    if (level == 0) colourChange();
    if (level == 2) nibChange();
    this.paintBrush.drawSlider(color(rgb[RED],rgb[GREEN],rgb[BLUE]), squeezeSensel);
    fill(0);
    buttonListen();
  }

  void nibChange(){
    super.draw(this.paintBrush.getSize(), this.paintBrush.getColor(), squeezeSensel);
    // println("Force: "+squeezeValues[0]+", "+ squeezeValues[1] +", "+squeezeValues[2]);
    // println("nibSize: "+(int)map(this.squeezeValues[0], 15, 500, 72, 1)+", "+ (int)map(this.squeezeValues[1], 15, 500, 72, 1) +", "+(int)map(this.squeezeValues[2], 15, 500, 72, 1));
    squeezeSensel = maxIndex(squeezeValues[0], squeezeValues[1], squeezeValues[2]);
    mIndex = maxIndex(squeezeValues[0], squeezeValues[1], squeezeValues[2]);
    switch(mIndex){
      case 0:
        this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 650, 72, 1));
        break;
      case 1:
        this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 650, 72, 1));
        break;
      case 2:
        this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 650, 72, 1));
        break;
    }
    activecolour = (squeezeSensel+":"+this.paintBrush.getSize());
    if (squeezeValues[0] > 0 || squeezeValues[1] > 0 || squeezeValues[2] > 0){
      newRowDrawing = tableDrawing.addRow();
      newRowDrawing.setInt("id", tableDrawing.getRowCount()-1);
      newRowDrawing.setString("value-mode", "nib");
      newRowDrawing.setString("value", activecolour);
    }
    // if (max(squeezeValues[0], squeezeValues[1], squeezeValues[2]) > 1){
    //   this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 500, 72, 1));
    // }
  }
  void colourChange(){
    super.draw(this.paintBrush.getSize(), this.paintBrush.getColor(), squeezeSensel);
    if (this.force > 15) {
      redIn = map(this.force, 15, 650, 0, 255);
    } else {
      redIn = 0;
    }
    if (this.force1 > 15) {
      greenIn = map(this.force1, 15, 650, 0, 255);
    } else {
      greenIn = 0;
    }
    if (this.force2 > 15) {
      blueIn = map(this.force2, 15, 650, 0, 255);
    } else {
      blueIn = 0;
    }
    rgb = ryb2rgb(redIn, greenIn, blueIn);
    // println("Force: "+force+", "+ force1 +", "+force2);
    // println("colour: "+redIn+", "+ greenIn +", "+blueIn);

    red = ryb2rgb(redIn, 0, 0);
    fill(red[RED],red[GREEN],red[BLUE]);
    rect(width-200, 50, 50, 50);

    yellow = ryb2rgb(0, greenIn, 0);
    fill(yellow[RED],yellow[GREEN],yellow[BLUE]);
    rect(width-150, 50, 50, 50);

    blue = ryb2rgb(0, 0, blueIn);
    fill(blue[RED],blue[GREEN],blue[BLUE]);
    rect(width-100, 50, 50, 50);

    fill(rgb[RED],rgb[GREEN],rgb[BLUE]);
    rect(width-200, 160, 150, 100);
    this.paintBrush.setColor(color(rgb[RED],rgb[GREEN],rgb[BLUE]));
    if (redIn > 0 || greenIn > 0 || blueIn > 0){
      activecolour = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);
      newRowDrawing = tableDrawing.addRow();
      newRowDrawing.setInt("id", tableDrawing.getRowCount()-1);
      newRowDrawing.setString("value-mode", "paint");
      newRowDrawing.setString("value", activecolour);
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
    if (this.hoverbackButton == true) {
      back();
      background(200);
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

  public void back(){
    this.setLevel(1);
    myPort.write('m');
    this.setState(0);
    fileName = ("data/" + pNum + "-" + "deform" + "-" + "drawing" + ".csv");
    saveTable(tableDrawing, fileName);
    currentActivity = new MenuActivity();
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
  void buttonListen() {
    if (this.paintMode.inBounds(mouseX, mouseY)){
      this.hoverPaintMode = true;
      this.hoverNibMode = false;
      this.hoverbackButton = false;
      this.backButton.deHightlight();
      this.nibMode.deHightlight();
      this.paintMode.hightlight();
    } else if (this.nibMode.inBounds(mouseX, mouseY)){
      this.hoverNibMode = true;
      this.hoverPaintMode = false;
      this.hoverbackButton = false;
      this.backButton.deHightlight();
      this.paintMode.deHightlight();
      this.nibMode.hightlight();
    } else if (this.backButton.inBounds(mouseX, mouseY)){
      this.hoverPaintMode = false;
      this.hoverNibMode = false;
      this.hoverbackButton = true;
      this.backButton.hightlight();
      this.paintMode.deHightlight();
      this.nibMode.deHightlight();
    } else {
      this.hoverNibMode = false;
      this.hoverPaintMode = false;
      this.hoverbackButton = false;
      this.backButton.deHightlight();
      this.paintMode.deHightlight();
      this.nibMode.deHightlight();
    }
  }
}
