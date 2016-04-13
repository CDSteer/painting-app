public abstract class AbstractPaintSelector{
  private PaintPot pot;

  public AbstractPaintSelector(){
    this.pot =  new PaintPot();
  }

  abstract void draw();
  abstract void update();

  public void setColor(int r, int g, int b){
    this.pot.setR(r);
    this.pot.setG(g);
    this.pot.setB(b);
  }

}
