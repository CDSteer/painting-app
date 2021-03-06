public class HIFIPaintSelector extends AbstractPaintSelector{
  private VScrollbar vsR, vsG, vsB;

  private int r,g,b,fR,fG,fB;
  private final int SLIDERLOW = 242;
  private final int SLIDERHIGH = 44;


  private final int xposR = width-200, ypos = height-(height-40), h = 200, w = 16, l = 16;
  private final int xposG = width-150;
  private final int xposB = width-100;

  public HIFIPaintSelector(){
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
    r = (int)map(this.fR, 10, 600, 0, 255);

    vsG.update();
    g = (int)map(this.fG, 0, 650, 0, 255);

    vsB.update();
    b = (int)map(this.fB, 0, 650, 0, 255);

    super.setColor(r, g, b);
  }

  public void drawSliders() {
    // fill(super.pot.getPaint());
    this.vsR.display(color(r,0,0));
    // fill(super.pot.getPaint());
    this.vsG.display(color(0,g,0));
    // fill(super.pot.getPaint());
    this.vsB.display(color(0,0,b));
  }
  public void sendInputs(int fR, int fRG, int fB){
    this.fR = fR;
    this.fG = fG;
    this.fB = fB;
  }
  public void sendRed(int fR){
    this.fR = fR;
  }
  public void sendGreen(int fG){
    this.fG = fG;
  }
  public void sendBlue(int fB){
    this.fB = fB;
  }
  public int getRed(){
    return this.r;
  }
  public int getGreen(){
    return this.g;
  }
  public int getBlue(){
    return this.b;
  }
  public color getColor(){
    return super.pot.getPaint();
  }
}
