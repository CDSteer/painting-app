public class GUICanvasAvtivity extends CanvasActivity {
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private int level = 1;
  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;
  private String inputValue;
  private float redIn, greenIn, blueIn;
  private int redSet, greenSet, blueSet;
  private float forceSet, force1Set, force2Set;

  private int[] squeezeValues;
  private int[] pushValues;
  private int[] rgb;
  private int squeezeSensel;
  private TableRow newRowDrawing;

  private int[] red;
  private int[] yellow;
  private int[] blue;
  int mIndex;
  private String activecolour;

  private Button nibMode;
  private Button paintMode;
  private Button backButton;
  private boolean hoverNibMode = false;
  private boolean hoverPaintMode = false;
  private boolean hoverbackButton = false;

 public GUICanvasAvtivity(){
   this.angle = 0;
   this.mag = 0;
   this.paintBrush = new HIFIPaintBrush();
   this.paintSelector = new HIFIPaintSelector();
   fill(0);
   rect(width-200, 160, 150, 100);
   nibMode = new Button(width-175, 280, 100, 50, color(255), "Paint");
   paintMode = new Button(width-175, height-230, 100, 50, color(255), "Nib");
   backButton = new Button(width-175, height-120, 100, 50, color(180,0,0), "Back");
   squeezeValues = new int[3];
   pushValues = new int[3];
   this.paintBrush.setSize(72);
   fill(255,0,0);
   text("RED", width-190, 120);
   fill(255,255,0);
   text("YELLOW", width-155, 120);
   fill(0,0,255);
   text("BLUE", width-95, 120);

   fill(200);
   rect(width-195, 50, 40, 40);
   fill(200);
   rect(width-145, 50, 40, 40);
   fill(200);
   rect(width-95, 50, 40, 40);
   rgb = ryb2rgb(0, 0, 0);
 }

 void draw(){
   nibMode.draw();
   paintMode.draw();
   backButton.draw();
   parceInput();
   if (level == 0) colourChange();
   if (level == 2) nibChange();
   this.paintBrush.drawSlider(color(rgb[RED],rgb[GREEN],rgb[BLUE]), squeezeSensel);
   fill(0);
   buttonListen();
 }

 void nibChange(){
   super.draw(this.paintBrush.getSize(), this.paintBrush.getColor(), squeezeSensel);
   this.squeezeValues[0] = (int)redIn;
   this.squeezeValues[1] = (int)greenIn;
   this.squeezeValues[2] = (int)blueIn;
   if (squeezeValues[0] > 0 || squeezeValues[1] > 0 || squeezeValues[2] > 0){
     squeezeSensel = maxIndex(squeezeValues[0], squeezeValues[1], squeezeValues[2]);
     mIndex = maxIndex(squeezeValues[0], squeezeValues[1], squeezeValues[2]);
   }

   if (squeezeValues[mIndex] != 0) {
     switch(mIndex){
       case 0:
         this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 255, 72, 1));
         break;
       case 1:
         this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 255, 72, 1));
         break;
       case 2:
         this.paintBrush.setSize((int)map(this.squeezeValues[squeezeSensel], 1, 255, 72, 1));
         break;
     }
   }
   activecolour = (squeezeSensel+":"+this.paintBrush.getSize());
   newRowDrawing = tableDrawing.addRow();
   newRowDrawing.setInt("id", tableDrawing.getRowCount()-1);
   newRowDrawing.setString("value-mode", "nib");
   newRowDrawing.setString("value", activecolour);
 }
 void colourChange(){
    super.draw(this.paintBrush.getSize(), this.paintBrush.getColor(), squeezeSensel);
    redSet = (int)redIn;
    greenSet = (int)greenIn;
    blueSet = (int)blueIn;

    rgb = ryb2rgb(redSet, greenSet, blueSet);
    println("colour: " + redSet + ", " + greenSet + ", " + blueSet);

    red = ryb2rgb(redSet, 0, 0);
    fill(red[RED],red[GREEN],red[BLUE]);
    rect(width-200, 50, 50, 50);

    yellow = ryb2rgb(0, greenSet, 0);
    fill(yellow[RED],yellow[GREEN],yellow[BLUE]);
    rect(width-150, 50, 50, 50);

    blue = ryb2rgb(0, 0, blueSet);
    fill(blue[RED],blue[GREEN],blue[BLUE]);
    rect(width-100, 50, 50, 50);

    fill(rgb[RED],rgb[GREEN],rgb[BLUE]);
    rect(width-200, 160, 150, 100);
    this.paintBrush.setColor(color(rgb[RED],rgb[GREEN],rgb[BLUE]));
    activecolour = (this.rgb[RED]+":"+this.rgb[GREEN]+":"+this.rgb[BLUE]);

    newRowDrawing = tableDrawing.addRow();
    newRowDrawing.setInt("id", tableDrawing.getRowCount()-1);
    newRowDrawing.setString("value-mode", "paint");
    newRowDrawing.setString("value", activecolour);
 }

 void click(){
   if (this.hoverPaintMode == true){
     level = 2;
     myPort.write('h');
   }
   if (this.hoverNibMode == true) {
     level = 0;
     myPort.write('l');
   }
   if (this.hoverbackButton == true) {
     back();
     background(200);
   }
 }

 public void back(){
   this.setState(0);
   fileName = ("data/" + pNum + "-" + "tab" + "-" + "drawing" + ".csv");
   saveTable(tableDrawing, fileName);
   delay(500);
   currentActivity = new MenuActivity();
 }

 private void parceInput(){
   println(inputValue);
   if (inputValue != null) {
     String[] qtmp = splitTokens(inputValue, ":");
     if (qtmp.length == 6){
        // println(qtmp[0]);
        // println(qtmp[1]);
        // println(qtmp[2]);
        // println(qtmp[3]);
        // println(qtmp[4]);
        // println(qtmp[5]);

        this.redIn = int(qtmp[1]);
        this.greenIn = int(qtmp[3]);
        this.blueIn = int(qtmp[5]);
     }
   }
 }


 void resize(){}
 void buttonListen() {
   if (this.paintMode.inBounds(mouseX, mouseY)){
     this.hoverPaintMode = true;
     this.hoverNibMode = false;
     this.hoverbackButton = false;
     this.backButton.deHightlight();
     this.nibMode.deHightlight();
     this.paintMode.hightlight();
   } else if (this.nibMode.inBounds(mouseX, mouseY)){
     this.hoverNibMode = true;
     this.hoverPaintMode = false;
     this.hoverbackButton = false;
     this.backButton.deHightlight();
     this.paintMode.deHightlight();
     this.nibMode.hightlight();
   } else if (this.backButton.inBounds(mouseX, mouseY)){
     this.hoverPaintMode = false;
     this.hoverNibMode = false;
     this.hoverbackButton = true;
     this.backButton.hightlight();
     this.paintMode.deHightlight();
     this.nibMode.deHightlight();
   } else {
     this.hoverNibMode = false;
     this.hoverPaintMode = false;
     this.hoverbackButton = false;
     this.backButton.deHightlight();
     this.paintMode.deHightlight();
     this.nibMode.deHightlight();
   }
 }

 public void setInputValue(String input){
   this.inputValue = input;
 }
}
