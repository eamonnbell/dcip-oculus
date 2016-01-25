boolean isFullScreen = false;

OculusRift oculus;
PVector position;

BlobComplex blob_complex;
//VRListener vr_listener;

// OculusRift needs this, apparently
boolean sketchFullScreen() {
  return isFullScreen;
};

// Draw a gridded thing
void drawPlate(float w, float h, float grid_interval) {
  for (float x=-w/2; x<w/2; x+=grid_interval) {
    line( x, -h/2, 0, x, h/2, 0 );
  }
  for (float y=-h/2; y<h/2; y+=grid_interval) {
    line( -w/2, y, 0, w/2, y, 0 );
  }
  box( w, h, 0.5 );
}

void setup() {
  size( 1920, 1080, P3D );
  oculus = new OculusRift(this);
  oculus.enableHeadTracking();
  
  // Create blob complex
  blob_complex = new BlobComplex();
//
//  // Create VR listener with (position, direction)
//  vr_listener = new VRListener(new PVector(0, 0, 0), new PVector(1, 0, 1));
  
  position = new PVector( 0, 1200, 0 );  // 1200 mm from floor.
}

void draw() {
  oculus.draw();
}

void onDrawScene(int eye) {

  background(50);
  fill(255);
  translate( position.x, position.y, position.z  );

  // light
  lights();

  // floor
  pushMatrix();
  rotateX(radians(90));
  drawPlate( 4000, 4000, 500 );
  popMatrix();

  // wall
  pushMatrix();
  translate( 0, -1500, -2000 );
  drawPlate( 4000, 3000, 500 );
  popMatrix();

  // cube
  pushMatrix();
  translate( 0, -500, -800 );
  fill(50, 200, 50);
  rotateX(millis()/1000.0);
  rotateY(millis()/900.0);
  box(200);
  popMatrix();
  
  // blobcomplex
  blob_complex.update();
  blob_complex.display();

//  vr_listener.display();
//  vr_listener.update();
//  blob_complex.update();
//  blob_complex.display();
}

void keyPressed() {

  // Move a random blob to a random location on the sphere of size 250
  // and trigger associated sound.

//  PVector rand_loc = PVector.random3D();  
//  rand_loc.mult(int(random(250)));
//  int index = int(random(blob_complex.blobcount));
//
//  blob_complex.blobs[index].move_to(rand_loc);
//  blob_complex.blobs[index].play();
  
  if (key==' ') {
    oculus.resetHeadState();
  }
  
  // Move
  if (keyCode==LEFT) {
    position.x += 20;
  }
  if (keyCode==RIGHT) {
    position.x -= 20;
  }
  if (keyCode==UP) {
    position.z += 20;
  }
  if (keyCode==DOWN) {
    position.z -= 20;
  }
}
