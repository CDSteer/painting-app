public abstract class AbstractPaintBrush implements PaintBrush{
  private int size;
  private color c;

  public AbstractPaintBrush(){
    this.size = 10;
    this.c = color(0,0,0);
  }

  public int getSize(){
    return this.size;
  }
  public void setSize(int size){
    this.size = size;
  }
  public color getColor(){
    return this.c;
  }
  public void setColor(color c){
    this.c = c;
  }

}
