public class GUIPaintBrush extends AbstractPaintBrush {
  HScrollbar hs1;

  public GUIPaintBrush(){
    super();
    hs1 = new HScrollbar(40, height-10, 200, 16, 16);
  }

  public void drawSlider() {
    hs1.update();
    int size = (int)map((int)hs1.getPos(), 0, 240, 0, 40);
    this.setSize(size);
    hs1.display();
  }
}
