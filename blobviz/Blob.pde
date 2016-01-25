class Blob {
  PVector location;
  PVector velocity;
  PVector target_location;

  Date date;

  int size;
  String filename;

  Music sound;

  Blob(PVector location_, int size_, Date date_, String filename_) {
    // Blobs represent sound sources and have location, size and velocity
    location = location_;
    target_location = location_;
    size = size_;
    date = date_;
    velocity = new PVector(0, 0, 0);
    filename = filename_;

    // Create a new JSFML music object for each Blob
    sound = new Music();
    Path p = Paths.get(sketchPath(filename));

    try {
      sound.openFromFile(p);
    } 
    catch (Exception e) {
      println("Unable to open music file.");
      println(e);
    }

    // Make sure the Music object takes absolution positions
    sound.setRelativeToListener(false);

    // MinDistance is the maximum distance at which a sound is heard at its maximum volume
    sound.setMinDistance(250);
  }

  void play() {
    // Wraps the play function of the sound
    sound.play();
  }

  void update() {
    // Increment location by velocity on every update
    location.add(velocity);

    // If Blob is in motion to a new target and gets close enough, set
    // velocity to zero and snap to target_location

    if (PVector.sub(target_location, location).mag() < 2) {
      location = target_location;
      velocity = new PVector(0, 0, 0);
    }

    PVector l = location.get();
    l.add(new PVector(width/2, height/2, 0));
    sound.setPosition(l.x, l.y, l.z);
  }


  void move_to(PVector target) {
    target_location = target;

    velocity = PVector.sub(target_location, location);

    velocity.normalize();
    velocity.mult(3);
  }

  void display() {
    
    pushMatrix();
    
    // Position the Blob relative to the cube
    
    PVector l = location.get();
    translate(0 + l.x, -500 + l.y, -800 + l.z);


    sphere(size);

    popMatrix();
  }
}
