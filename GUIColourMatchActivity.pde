public class GUIColorMatchActivity extends CanvasActivity {

  GUIPaintBrush paintBrush;
  GUIPaintSelector paintSelector;
  Canvas canvas;

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
    text("match this", 225, 100);
    text("paint here", 625, 100);
    text("nib size", width-130, height-(height-350));

    text("paint", width-170, height-(height-27));
    fill(255, 0, 0);
    text("Red", width-220, height-(height-270));
    fill(0, 200, 0);
    text("Green", width-165, height-(height-270));
    fill(0, 0, 255);
    text("Blue", width-112, height-(height-270));
    fill(0);
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
}
