public class HIFIPaintBrush extends AbstractPaintBrush {
  private VScrollbar vs1;
  private final int SLIDERLOW = 568;
  private final int SLIDERHIGH = 370;
  private final int xpos = width-200, ypos = height-(height-340), h = 200, w = 16, l = 16;
  private final float nibXPos = (float)width-175;
  private final float  nibYPos = (float)ypos+150;

  public HIFIPaintBrush(){
    super();
    vs1 = new VScrollbar(xpos, ypos, w, h, l);
  }

  public void drawSlider(color c, int nib) {
    this.drawNib(c, nib );
  }

  private void drawNib(color c, int nib) {
    // strokeWeight(105);
    // stroke(0);
    // point(width-150, ypos+100);
    stroke(0);
    fill(200);
    rect((width-150)-25, (ypos+100)-50, 100, 100);
    image(changeImgColor(nibs[nib], red(c), green(c), blue(c)), (width-125)-this.getSize()/2, (ypos+100)-this.getSize()/2, (float)this.getSize(), (float)this.getSize());
    stroke(255,255,255);
    // point(width-150, ypos+100);
    // strokeWeight(1);
    // stroke(0);
  }
}
