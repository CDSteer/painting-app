public abstract class PaintingAppActivity implements AppActivity{

  private int state;
  private boolean dragging;

  public PaintingAppActivity(){
    this.state = 0;
    this.dragging = false;
  }

  public void draw(){
    fill(0);
    smooth();
  }

  public void update(int x, int y){

  }

  public void mousePressed(){

  }

  public void setState(int state){
    this.state = state;
  }
  public int getState(){
    return this.state;
  }

  void mouseDragged(){
    if(mousePressed){
      this.dragging=true;
    }
  }

  void mouseReleased(){
    if (!mousePressed){
      this.dragging=false;
    }
  }
}
