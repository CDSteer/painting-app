public interface AppActivity{

  //Window
  final int w = 1250; //width
  final int h = 750; //height

  public void setState(int state);
  public int getState();
  public void draw();
  public void update(int x, int y);
  public void mouseDragged();
  public void mousePressed();
}
