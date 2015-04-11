// This is an empty Processing sketch with support for Fadecandy.

OPC opc;

int size=5;
float hueOffset = 0.0;
int previousFrameStartTime = 0;
float stretch = 2.0;

void setup()
{
  size(300, 300);
  colorMode(HSB, width, height, height);
  opc = new OPC(this, "raspberrypi.local", 7890);
  noStroke();

  // Set up your LED mapping here
  opc.ledGrid8x8(0, width/2, height/2, height / 10.0, 0, false);
}

void draw()
{
  int thisFrameStartTime = millis();
  hueOffset += ((mouseX * 1.0)/width) * (thisFrameStartTime-previousFrameStartTime)/4.0;
  previousFrameStartTime = thisFrameStartTime;
  background(0);
  for(int i=0; i<width; i+=size)
  {
    for(int j=0; j<height; j+=size)
    {
      fill(((i/stretch) + hueOffset) % width, mouseY, j);
      rect(i, j, size, size);
    }
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  stretch = constrain(stretch * (1.0 + e/20.0), 0.5, 8.0);
}

