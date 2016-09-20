public abstract class CanvasActivity extends PaintingAppActivity{
  int xMin = 40; // the position of the canvas from left
  int xMax = 560; // the position of the canvas from right
  int yMin = 40; // the position of the canvas from top
  int yMax = 560; // the position of the canvas from bottom
  int amoutOfPaint;

  public CanvasActivity(){
    background(200);
    this.amoutOfPaint = 9999999;
    this.setup();
  }

  void drawCanvas(){
    fill(255);
    rect(xMin, yMin, w - 2*xMin-200, h-2*yMin);
  }

  void setup(){
    this.drawCanvas();
  }

  void draw(int size, color c, int nib){
    this.paint(size, c, nib);
  }

  void paint(int size, color c, int nib) {
    if (super.dragging && amoutOfPaint > 0 && this.inCanvas()){
     image(changeImgColor(nibs[nib], red(c), green(c), blue(c)), mouseX-(size/2), mouseY-(size/2), size, size);
     image(changeImgColor(nibs[nib], red(c), green(c), blue(c)), mouseX+2-(size/2), mouseY-(size/2), size, size);
     image(changeImgColor(nibs[nib], red(c), green(c), blue(c)), mouseX-2-(size/2), mouseY-(size/2), size, size);
     image(changeImgColor(nibs[nib], red(c), green(c), blue(c)), mouseX-(size/2), mouseY+2-(size/2), size, size);
     image(changeImgColor(nibs[nib], red(c), green(c), blue(c)), mouseX-(size/2), mouseY-2-(size/2), size, size);
    }
  }

  boolean inCanvas(){
    if((mouseX > xMin) && (mouseX <  w - 2*xMin-200)){
      if((mouseY > yMin) && (mouseY < h - 2*yMin)){
        return true;
      }
    }
    return false;
  }

  int fillBrush(int force){
    int amoutOfPaint = 0;
    while (force>0){
      System.out.println(force);
      if (force > amoutOfPaint){
        amoutOfPaint = force;
      }
    }
    return amoutOfPaint;
  }

  public boolean isDragging(){
    return super.dragging;
  }
}
