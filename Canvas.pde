public class Canvas extends AbstractGUIElement{
  public Canvas(int x, int y, int mHight, int mWidth){
    super(x,y,mHight,mWidth);
  }

  void draw(){
    stroke(0);
    fill(255);
    rect(this.getX(), this.getY(), this.getHeight(), this.getWidth());
  }

  boolean inCanvas(int size){
    return mouseX+size/2 > this.getX() && mouseX+size/2 < this.getX() + this.getWidth()
      && mouseY+size/2 > this.getY() && mouseY+size/2 < this.getY() + this.getHeight();
  }
}
