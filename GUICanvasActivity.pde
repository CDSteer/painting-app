public class GUICanvasAvtivity extends CanvasActivity{

  GUIPaintBrush paintBrush;

  public GUICanvasAvtivity(){
    super();
    paintBrush = new GUIPaintBrush();
  }

  void draw(){
    // background(200);
    fill(0);
    super.draw(this.paintBrush.getSize(), this.paintBrush.getColor());
    text("GUI Mode", 100, 100);
    this.paintBrush.drawSlider();
  }

  void resize(){

  }

  void update(int x, int y){

  }
}
