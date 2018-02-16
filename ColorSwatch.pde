//// Create colorswatch
class ColorSwatch {
  float x;
  float y;
  float r;
  String c;
  ColorSwatch(float _x, float _y, float _r, String _c) {
    x = _x;
    y = _y;
    r = _r;
    c = _c;
  }
  void display() {
    fill(int(unhex("FF"+(c))));
    ellipse(x, y, r, r);
  }

  void clicked(float _x, float _y) {
    float d = dist(_x, _y, this.x, this.y);
    //    //if mouse is inside swatch, update brush and fill icon
    if (d < r) {
      fillIcon.c = c;
      //  brush.updateColor(this.c);
    }
  }

  //  // Scale/translate if window is resizing
  void resize(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
  }
}