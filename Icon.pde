//// Icon parent class using stroke and fill icons as descendents 
class Icon {
  float x;
  float y;
  float r;
  String c;
  Icon(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
    c = defaultSwatch;
  }

  void display() {
    rect(x, y, r, r);
  }

  void resize(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
  }
}