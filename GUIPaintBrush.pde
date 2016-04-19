public class GUIPaintBrush extends AbstractPaintBrush {
  private VScrollbar vs1;
  private final int SLIDERLOW = 568;
  private final int SLIDERHIGH = 370;
  private final int xpos = width-200, ypos = height-(height-340), h = 200, w = 16, l = 16;

  public GUIPaintBrush(){
    super();
    vs1 = new VScrollbar(xpos, ypos, w, h, l);
  }

  public void drawSlider(color c) {
    vs1.update();
    this.setSize((int)map((int)vs1.getPos(), SLIDERHIGH, SLIDERLOW, 0, 105));
    vs1.display(c);
    this.drawNib(c);
  }

  private void drawNib(color c) {
    strokeWeight(105);
    stroke(0);
    point(width-100, ypos+100);

    strokeWeight(this.getSize()+2);
    stroke(255);
    point(width-100, ypos+100);

    strokeWeight(this.getSize());
    stroke(c);
    point(width-100, ypos+100);
    strokeWeight(1);
    stroke(0);

    
  }
}
