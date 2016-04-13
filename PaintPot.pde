public class PaintPot {

  private int r, g, b;

  public PaintPot(){
    this.r = 0;
    this.g = 0;
    this.b = 0;
  }
  public int getR(){
    return this.r;
  }

  public int getG(){
    return this.g;
  }

  public int getB(){
    return this.b;
  }

  public void setR(int r){
    this.r = r;
  }

  public void setG(int g){
    this.g = g;
  }

  public void setB(int b){
    this.b = b;
  }

  public color getPaint(){
    return color(this.r, this.g, this.b);
  }

}
