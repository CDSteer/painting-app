public class GUICanvasAvtivity extends CanvasActivity{
  GUIPaintBrush paintBrush;
  GUIPaintSelector paintSelector;

  public GUICanvasAvtivity(){
    super();
    paintBrush = new GUIPaintBrush();
    paintSelector = new GUIPaintSelector();
  }

  void draw(){
    fill(0);
    this.paintSelector.drawPaintSelector();
    this.paintBrush.drawSlider(this.paintSelector.getColor());
    super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());
    text("GUI Mode", 100, 100);
  }

  void resize(){}
}
