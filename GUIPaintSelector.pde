public class GUIPaintSelector extends AbstractPaintSelector{
  private VScrollbar vsR, vsG, vsB;

  private int r,g,b;
  private final int SLIDERLOW = 242;
  private final int SLIDERHIGH = 44;
  private final int xposR = width-200, ypos = height-(height-40), h = 200, w = 16, l = 16;
  private final int xposG = width-150;
  private final int xposB = width-100;

  public GUIPaintSelector(){
    super();
    // hsR = new HScrollbar(xposR, ypos, h, w, l);
    // hsG = new HScrollbar(xposG, ypos, h, w, l);
    // hsB = new HScrollbar(xposB, ypos, h, w, l);
    vsR = new VScrollbar(xposR, ypos, w, h, l);
    vsG = new VScrollbar(xposG, ypos, w, h, l);
    vsB = new VScrollbar(xposB, ypos, w, h, l);
  }

  void drawPaintSelector(){
    this.update();
    this.drawSliders();
  }

  void update(){
    vsR.update();
    r = (int)map((int)vsR.getPos(), SLIDERHIGH, SLIDERLOW, 0, 255);
    vsG.update();
    g = (int)map((int)vsG.getPos(), SLIDERHIGH, SLIDERLOW, 0, 255);
    vsB.update();
    b = (int)map((int)vsB.getPos(), SLIDERHIGH, SLIDERLOW, 0, 255);
    super.setColor(r, g, b);
  }

  public void drawSliders() {
    fill(super.pot.getPaint());
    this.vsR.display(color(r,g,b));
    fill(super.pot.getPaint());
    this.vsG.display(color(r,g,b));
    fill(super.pot.getPaint());
    this.vsB.display(color(r,g,b));
  }


  public color getColor(){
    return super.pot.getPaint();
  }

}
