public class Button extends AbstractGUIElement{

  private color c;
  private String text;
  private color highlight = color(51);
  private color cc;

  public Button(int x, int y, int sizeX, int sizeY, int c, String text){
    super(x,y,sizeX,sizeY);
    this.c = c;
    this.text = text;
  }

  void draw(){
    fill(this.cc);
    stroke(141);
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());

    textSize(14);
    fill(0);
    text(this.text, this.getX() + (this.getWidth()/4), this.getY() + (getHeight()/2));
  }

  void hightlight(){
    this.cc = highlight;
  }
  void deHightlight(){
    this.cc = c;
  }
}
