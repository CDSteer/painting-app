public interface AppActivity{

  //Window
  final int w = 1280; //width
  final int h = 800; //height

  //Automatic window and column re-sizing
  float b=0.8*w/3; //default is at 0.8;
  float c=0.2*w/3;
  float a=c/2;
  float d=h-3*a-b;
  float e=w-c;

  public void setState(int state);
  public int getState();
  public void draw();
  public void update(int x, int y);
  public void mouseDragged();
  public void mousePressed();
}
