public class MenuActivity extends PaintingAppActivity{
  private Button[] buttons =  new Button[3];
  private int hoverbutton;
  
  public MenuActivity(){
    super();
    this.hoverbutton = 0;
    buttons[0] = new Button(100, 100, 100, color(255), "GUI");
    buttons[1] = new Button(100, 250, 100, color(255), "Hi-Fi");
    buttons[2] = new Button(100, 400, 100, color(255), "Low-Fi");
  }
  
  void draw(){
    super.draw();
    this.buttons[0].draw();
    this.buttons[1].draw();
    this.buttons[2].draw(); 
  }
  
  void update(int x, int y){
    for (int i = 0; i < 3; i++){
      if (this.buttons[i].inBounds(x,y)){
        this.hoverbutton = (i+1);
        this.buttons[i].hightlight();
      }else{
        this.buttons[i].deHightlight();
      }
    }
  }
  
  public Button[] getButtons(){
    return this.buttons;
  }
  
  void mousePressed() {
    if (mousePressed){
      switch (this.hoverbutton){
        case 1: 
          this.setState(1);
          break;
        case 2:
          this.setState(2);
          break;
        case 3:
          this.setState(3);
          break;
        default:
          this.setState(0);
      }
    }
  }
}