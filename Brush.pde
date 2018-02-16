class Brush {
  boolean dragging;
  float r;
  String c;
  JSONObject path;
  int index;
  JSONArray frame;
  Brush( float _r, String _c) {
    r = _r;
    c = _c;
    float[] l ={};
    JSONArray lines = new JSONArray();
    JSONArray points = new JSONArray();
    path = new JSONObject();
    path.setJSONArray("points", points);
    path.setJSONArray("lines", lines);
    path.setString("color", c);
    path.setFloat("radius", r);
    frame = drawing.getJSONArray("frame");
    index = frame.size();
    dragging = false;
  }

  void display(float _x, float _y) {
    if (displayOn) {
      stroke(0, 40);
      noFill();
      strokeWeight(1);
      ellipse(_x, _y, r, r);
      smooth();
    }
  }

  void drag(float _x, float _y) {
    float x = _x;
    float y = _y;
    JSONArray lines = new JSONArray();
    JSONArray points = new JSONArray();
    //path = new JSONObject();
    path.setJSONArray("points", points);
    path.setJSONArray("lines", lines);
    path.setString("color", c);
    path.setFloat("radius", r);

    if (isDrawing) {
      float weight = r+constrain(dist(mouseX, mouseY, pmouseX, pmouseY), 0, 25);
      float mx = x*responsiveRatio;
      float my = y*responsiveRatio;
      float pmx = pmouseX*responsiveRatio;
      float pmy = pmouseY*responsiveRatio;
      JSONObject lineCoords = new JSONObject();
      lineCoords.setFloat("mouseX", mx);
      lineCoords.setFloat("mouseY", my);
      lineCoords.setFloat("pmouseX", pmx);
      lineCoords.setFloat("pmouseY", pmy);
      JSONArray l = path.getJSONArray("lines");
      appendJSONArray(l, lineCoords);
      path.setJSONArray("lines", l);
      path.setFloat("radius", weight*responsiveRatio);
      path.setString("color", fillIcon.c);

      if (releasedMouse) {
        releasedMouse = false;
      }
    }
    frame.setJSONObject(index, path);
    index++;
  }

  JSONArray appendJSONArray(JSONArray jsa, JSONObject lc){
     return jsa.setJSONObject(jsa.size(), lc); 
  }

  void click(float _x, float _y) {
    float x = _x;
    float y = _y;

    if (isDrawing) {
      releasedMouse = false;
    }
  }

  void sizeUp(float amount) {
    r += amount;
  }

  void sizeDown(float amount) {
    r -= amount;
  }
}