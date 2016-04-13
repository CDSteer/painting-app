public class GUIPaintSelector extends AbstractPaintSelector{
  private HScrollbar hsR;
  private HScrollbar hsG;
  private HScrollbar hsB;

  private VScrollbar vsR;
  private VScrollbar vsG;
  private VScrollbar vsB;

  private int r,g,b;

  final int xposR = 340, ypos = height-10, h = 200, w = 16, l = 16;
  final int xposG = xposR*2+20;
  final int xposB = xposR*3+20;

  public GUIPaintSelector(){
    super();
    hsR = new HScrollbar(xposR, ypos, h, w, l);
    hsG = new HScrollbar(xposG, ypos, h, w, l);
    hsB = new HScrollbar(xposB, ypos, h, w, l);
    vsR = new VScrollbar(width-200, height-(height-40), w, h, l);
    vsG = new VScrollbar(width-150, height-(height-40), w, h, l);
    vsB = new VScrollbar(width-100, height-(height-40), w, h, l);
  }

  void draw(){
    this.update();
    this.drawSliders();
    vsR.update();
    vsR.display();

    vsG.update();
    vsG.display();

    vsB.update();
    vsB.display();
  }

  void update(){
    hsR.update();
    r = (int)map((int)hsR.getPos(), 370, 568, 0, 255);
    hsG.update();
    g = (int)map((int)hsG.getPos(), 761, 959, 0, 255);
    hsB.update();
    b = (int)map((int)hsB.getPos(), 1131, 1329, 0, 255);
    super.setColor(r, g, b);
  }

  public void drawSliders() {
    fill(super.pot.getPaint());
    rect(xposR, ypos-w, h, w);
    this.hsR.display();
    fill(super.pot.getPaint());
    rect(xposG, ypos-w, h, w);
    this.hsG.display();
    fill(super.pot.getPaint());
    rect(xposB, ypos-w, h, w);
    this.hsB.display();
  }


  public color getColor(){
    return super.pot.getPaint();
  }

}
