
float x = 0;
String creamsicle = "ffb241";
String sage = "39b876";
String magenta = "e32c7e";
String eraser = "a7edff";
String white = "ffffff";
String[] colorArray = {sage, creamsicle, magenta, eraser};
String defaultSwatch = colorArray[0];

int radius = 50;
String fillColor = sage;
String strokeColor = white;
boolean strokeOn = false;
boolean fillOn = true;
int numColor = 4;
ColorSwatch[] swatches = new ColorSwatch[colorArray.length];
Brush brush;

float frameThickness;
float canvasWidth;
float initialRadius;
float colorSwatchRadius;
float maxWidth = 1110;

float responsiveRatio;

color strokeI;
//Image img;

boolean isDrawing = false;
boolean releasedMouse = false;

float fc = 0;
boolean displayOn = true; 
JSONObject drawing;
FillIcon fillIcon;

float[] userDrawing;


void setup() {
  size(800, 800);
  noStroke();
  drawing = loadJSONObject("art.json");
  // Instantiate brush
  frameThickness = width/10;
  canvasWidth = width;
  initialRadius = canvasWidth/20;
  colorSwatchRadius = canvasWidth/10;
  brush = new Brush(initialRadius, defaultSwatch);

  createPallet();
  smooth();
}

void draw() {
  background(int(unhex("FF"+eraser)));
  initialRadius = canvasWidth/20;

  ////set frame
  displayDrawing();
  frame();  
  renderPallet();

  brush.display(mouseX, mouseY);
  fc++;
}

// Display the drawing
void displayDrawing() {
  JSONArray frames = drawing.getJSONArray("frame");
  if (drawing != null) {
    for (int i = 0; i < frames.size(); i++) {
      JSONObject frame = frames.getJSONObject(i);
      JSONArray lines = frame.getJSONArray("lines");
      JSONArray points = frame.getJSONArray("points");

      float weight = frame.getFloat("radius");//responsiveRatio;

      if (lines != null) {

        for (int j = 0; j < lines.size(); j++) {
          //unhex the hex value, into a usable int, take away the hex # using substring
          int c = int(unhex("FF"+frame.getString("color")));
          strokeWeight(weight);
          stroke(c);
          line(lines.getJSONObject(j).getFloat("mouseX")/2, lines.getJSONObject(j).getFloat("mouseY")/2, lines.getJSONObject(j).getFloat("pmouseX")/2, lines.getJSONObject(j).getFloat("pmouseY")/2);
        }
      }
      if (points != null) {
        for (int j = 0; j < points.size(); j++) {
          int c = int(unhex("FF"+frame.getString("color")));
          noStroke();
          fill(c);
          ellipse(points.getJSONObject(j).getFloat("x")/2, points.getJSONObject(j).getFloat("y")/2, 50, 50);
        }
      }
    }
  }
}

///////////

//Creates the pallet for drawing, adds fill icon
void createPallet() {
  for (int i = 0; i < numColor; i++) {
    swatches[i] = new ColorSwatch(((i*colorSwatchRadius)+colorSwatchRadius/2), colorSwatchRadius/2, colorSwatchRadius/2, colorArray[i]);
  }
  fillIcon = new FillIcon(canvasWidth-frameThickness*.75, canvasWidth/40, canvasWidth/20);
}

// Render color selections of pallet
void renderPallet() {
  for (int i = 0; i < numColor; i++) {
    swatches[i].display();
  }
  fillIcon.display();
}

//// Create frame around canvas - pallet goes on top 
void frame() {
  //  //FRAME DEBUG


  //  //Frame Appearance
  noStroke();
  fill(0);

  //  //Frame Render
  rect(0, 0, canvasWidth, frameThickness);
  rect(0, canvasWidth-frameThickness, canvasWidth, frameThickness);
  rect(0, 0, frameThickness, canvasWidth);
  rect(canvasWidth-frameThickness, 0, frameThickness, canvasWidth);
}

//// Activate the brush if mouse dragged
void mouseDragged() {
  if (mouseX > frameThickness && mouseX < canvasWidth-frameThickness && mouseY > frameThickness && mouseY <  canvasWidth-frameThickness) {
    //    //"Turn on" drawing
    isDrawing = true;
    releasedMouse = false;
    brush.drag(mouseX, mouseY);
    //hide mouse if dragging
    displayOn = false;
    //return false;
  }
}

////When mouse released, show brush and "turn off" drawing 
void mouseReleased() {
  releasedMouse = true;
  displayOn = true;
  isDrawing = false;
}

//// If mouse clicked, create an ellipse the size of brush
void mouseClicked() {
  isDrawing = true;
  for (int i = 0; i < numColor; i++) {
    swatches[i].clicked(mouseX, mouseY);
  }
  if (mouseX >= frameThickness && mouseX <= canvasWidth-frameThickness && mouseY >= frameThickness && mouseY <= canvasWidth-frameThickness) {
    brush.click(mouseX, mouseY);
  }
}

//// Resize brush functions
void keyPressed() {
  if (key == ']') {
    brush.sizeUp(1);
  }
  if (key == SHIFT && key == ']') {
    brush.sizeUp(10);
  }
  if (key == '[') {
    if (key == SHIFT) {
      brush.sizeDown(10);
    } else {
      brush.sizeDown(1);
    }
  }

  if (key == 'e' || key == 'E') {
  }

  if (key == 'b' || key == 'B') {
  }
}