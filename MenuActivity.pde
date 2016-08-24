public class MenuActivity extends PaintingAppActivity{
  private final int BUTTONCOUNT = 5;
  private Button[] buttons =  new Button[BUTTONCOUNT];
  private int hoverbutton;

  public MenuActivity(){
    super();
    this.hoverbutton = 0;
    buttons[0] = new Button(100, 100, 250, 100, color(255), "GUI-Nib-Match");
    buttons[1] = new Button(100, 200, 250, 100, color(255), "Deformable-Drawing");
    buttons[2] = new Button(100, 400, 250, 100, color(255), "Deformable-Nib-Match");
    buttons[3] = new Button(400, 100, 250, 100, color(255), "GUI-Colour-Match");
    buttons[4] = new Button(400, 250, 250, 100, color(255), "Deformable-Colour-Match");
  }

  void draw(){
    super.draw();
    this.buttons[1].draw();
    this.buttons[3].draw();
    this.buttons[4].draw();
    this.update();
    this.mousePressed();
  }

  void update(){
    for (int i = 0; i < BUTTONCOUNT; i++){
      if (this.buttons[i].inBounds(mouseX, mouseY)){
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
        case 4:
          this.setState(4);
          break;
        case 5:
          this.setState(5);
          break;
        default:
          break;
      }
    }
  }
}
