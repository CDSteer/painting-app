public class GUIColorMatchActivity extends CanvasActivity {

  GUIPaintBrush paintBrush;
  GUIPaintSelector paintSelector;
  Canvas canvas;

  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;
  private int level, randRed, randBlue, randGreen;

  int matchCount = 0;
  int matchingColorsRGB[] = {1,2,3};
  int matchingColorsDepth[] = {100,255,200};

  private int redMatch, blueMatch, greenMatch;

  public GUIColorMatchActivity(){
    super();
    this.paintBrush = new GUIPaintBrush();
    this.paintSelector = new GUIPaintSelector();
  }

  void setup(){
    this.canvas = new Canvas(500, 140, 300, 300);
    fill(255,0,0);
    rect(150, 140, 300, 300);
    this.drawCanvas();
  }

  void drawCanvas(){
    this.canvas.draw();
  }

  public void draw(){
    this.paintSelector.drawPaintSelector();
    this.paintBrush.drawSlider(this.paintSelector.getColor());
    super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());
    // text("match this", 225, 100);
    // text("paint here", 625, 100);
    // text("nib size", width-130, height-(height-350));
    //
    // text("paint", width-170, height-(height-27));
    // fill(255, 0, 0);
    // text("Red", width-220, height-(height-270));
    // fill(0, 200, 0);
    // text("Green", width-165, height-(height-270));
    // fill(0, 0, 255);
    // text("Blue", width-112, height-(height-270));
    // fill(0);


    background(200);
    if (level == 0 ){
      switch (matchingColorsRGB[matchCount]) {
        case 1:
          fill(matchingColorsDepth[matchCount],0,0);
          rect(150, 140, 100, 100);
          fill(0);
          this.paintSelector.sendRed((int)this.force);
          fill(this.paintSelector.getRed(),0,0);
          rect(150, 340, 100, 100);
          if (matchingColorsDepth[matchCount] == this.paintSelector.getRed()){
            matchCount++;
          }
          break;
        case 2:
          fill(0,matchingColorsDepth[matchCount],0);
          rect(350, 140, 100, 100);
          this.paintSelector.sendGreen((int)this.force1);
          fill(0,this.paintSelector.getGreen(),0);
          rect(350, 340, 100, 100);
          if (matchingColorsDepth[matchCount] == this.paintSelector.getGreen()){
            matchCount++;
          }
          break;
        case 3:
          fill(0,0,matchingColorsDepth[matchCount]);
          rect(550, 140, 100, 100);
          this.paintSelector.sendBlue((int)this.force2);
          fill(0,0,this.paintSelector.getBlue());
          rect(550, 340, 100, 100);
          if (matchingColorsDepth[matchCount] == this.paintSelector.getBlue()){
            matchCount++;
          }
          break;
        }
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
}
