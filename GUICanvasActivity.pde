public class GUICanvasAvtivity extends CanvasActivity{

  GUIPaintBrush paintBrush;
  GUIPaintSelector paintSelector;

  public GUICanvasAvtivity(){
    super();
    paintBrush = new GUIPaintBrush();
    paintSelector = new GUIPaintSelector();
  }

  void draw(){
    // background(200);
    fill(0);
    super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());
    text("GUI Mode", 100, 100);
    this.paintBrush.drawSlider();
    this.paintSelector.draw();
  }

  void resize(){

  }

  void update(int x, int y){

  }
}
