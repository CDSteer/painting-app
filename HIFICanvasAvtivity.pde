 public class HIFICanvasAvtivity extends CanvasActivity implements DeformableContols{
  private HIFIPaintBrush paintBrush;
  private HIFIPaintSelector paintSelector;
  private int level = 1;

  private float force, angle, mag, Rv;
  private float force1, mag1, force2, mag2;

  public HIFICanvasAvtivity(){
    this.angle = 0;
    this.mag = 0;
    this.paintBrush = new HIFIPaintBrush();
    this.paintSelector = new HIFIPaintSelector();
  }

  void draw(){
    // fill(this.Rv);
    // strokeWeight(4);
    if (level == 2){
      strokeWeight(105);
      stroke(255);
      // point(width-400, ypos+100);

      strokeWeight((int)map(this.mag, 1, 450, 1, 105));
      stroke(0);
      point(width-(width/2)-200, height-(height/2));
      strokeWeight(1);

      if (keyPressed && key != CODED){
        if (key == 't' || key == 'T') {
          this.paintBrush.setSize((int)map(this.mag, 1, 450, 1, 105));
        }
      }
    }
    if (level == 0){
      this.paintBrush.setColor(color((int)map(this.force, 10, 450, 0, 150), 0, 0));
      fill((int)this.force, (int)this.force1,(int)this.force2);
      rect(150, 300, 100, 100);

      if (keyPressed && key != CODED){
        if (key == 'r' || key == 'R') {
          this.paintSelector.sendRed((int)this.force);
          this.paintSelector.sendGreen((int)this.force1);
          this.paintSelector.sendBlue((int)this.force2);
        }
        // if (key == 'g' || key == 'G'){
        //   this.paintSelector.sendGreen((int)this.force);
        // }
        // if (key == 'b' || key == 'B'){
        //   this.paintSelector.sendBlue((int)this.force);
        // }
      }
    }
    super.draw(this.paintBrush.getSize(), this.paintSelector.getColor());
    this.paintBrush.drawSlider(this.paintSelector.getColor());
    this.paintSelector.drawPaintSelector();

    // this.paintSelector.sendRed((int)this.force);
    // this.paintSelector.sendGreen((int)this.force1);
    // this.paintSelector.sendBlue((int)this.force2);



    // fill(0, 0, 0);
    // rect(150, 300, 100, 100);

    // drawDirctionViz();

    fill(0,0,0);
    text("HIFI Mode", 100, 100);

  }

  void drawDirctionViz(){
    ellipseMode(CENTER);
    fill(255);
    ellipse(400,200,200,200);
    lineAngle(400, 200, this.angle, this.mag);
  }

  void lineAngle(int x, int y, float angle, float length) {
    line(x, y, x+cos(angle)*length, y-sin(angle)*length);
  }

  void printValues(){
    println("force: "+ this.force);
    println("angle: "+ this.angle);
    println("mag: "+ this.mag);
    println("red: " + this.Rv);
    // println("amount: " + amoutOfPaint);
  }

  public void setForce(float force){
    this.force = force;
  }
  public void setMag(float mag){
    this.mag = mag;
  }

  public void setForce1(float force){
    this.force1 = force;
  }
  public void setMag1(float mag){
    this.mag1 = mag;
  }
  public void setForce2(float force){
    this.force2 = force;
  }
  public void setMag2(float mag){
    this.mag2 = mag;
  }

  public void setAngle(float angle){
    this.angle = angle;
  }
  public void setLevel(int l){
    this.level = l;
  }

  void resize(){}
}
