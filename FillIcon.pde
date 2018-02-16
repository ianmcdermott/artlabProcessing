//// Fill icon descendant of icon class
class FillIcon extends Icon {
  FillIcon(float x, float y, float r) {
    super(x, y, r);
  }
  void display() {
    fill(int(unhex("FF"+c)));  
    noStroke();
    rect(x, y, r, r);
  }
}