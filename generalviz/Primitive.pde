class Primitive {
  PVector location;
  PVector velocity;
  PVector target_location;

  int size;
  color fill_color;

  String filename;
  Music sound;

  Primitive(PVector location_, int size_, color fill_color_) {
    // Primitives represent data binding and have location and size.
    location = location_;
    target_location = location_;
    size = size_;
    fill_color = fill_color_;
    velocity = new PVector(0, 0, 0);
  }

  Primitive() {
    target_location = new PVector(0, 0, 0);
    size = 0;
    location = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
  }

  void setSize(int size_) {
    this.size = size_;
  }

  void setLocation(PVector location_) {
    this.location = location_;
  }

  void setTargetLocation(PVector target_location_) {
    this.location = target_location_;
  }

  void setColor(color fill_color_) {
    this.fill_color = fill_color_;
  }

  void setSoundFilename(String filename_) {
    this.filename = filename_;
  }

  void initializeSound() {
    sound = new Music();
    Path p = Paths.get(sketchPath(this.filename));

    try {
      sound.openFromFile(p);
    } 
    catch (Exception e) {
      println("Unable to open music file.");
      println(e);
    }
    
    sound.setVolume(10);

    // Make sure the Music object takes absolute positions
    sound.setRelativeToListener(false);
    
    sound.setAttenuation(95);

    // MinDistance is the maximum distance at which a sound is heard at its maximum volume
    sound.setMinDistance(1);
  }
  
  void play() {
    sound.play();
  }

  void randomLocation() {
    PVector rand_loc = PVector.random3D();  
    rand_loc.mult(100);
    move_to(rand_loc);
  }

  void move_to(PVector target) {
    target_location = target;

    velocity = PVector.sub(target_location, location);

    velocity.normalize();
    velocity.mult(3);
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
    sound.setPosition(l.x, l.y, l.z);

  }

  void display() {
  }
}

class PrimitiveSphere extends Primitive {

  PrimitiveSphere(PVector location_, int size_, color fill_color_) {
    super(location_, size_, fill_color_);
  }

  PrimitiveSphere() {
  }

  void display() {

    fill(fill_color);

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    sphere(size);
  }
}

class PrimitiveCube extends Primitive {
  PrimitiveCube(PVector location_, int size_, color fill_color_) {
    super(location_, size_, fill_color_);
  }

  PrimitiveCube() {
  }

  void display() {

    fill(fill_color);


    PVector l = location.get();
    translate(l.x, l.y, l.z);

    box(size);
  }
}

class PrimitiveTeapot extends Primitive {
  PShape obj;

  PrimitiveTeapot(PVector location_, int size_, color fill_color_) {
    super(location_, size_, fill_color_);
  }

  PrimitiveTeapot() {
    obj = loadShape("data/teapot.obj");
    obj.scale(0.3);
    obj.rotateX(PI);
  }

  void display() {

    fill(fill_color);


    PVector l = location.get();
    translate(l.x, l.y, l.z);

    fill(fill_color);
    shape(obj);
  }
}

class PrimitiveFactory {

  Primitive p; 

  PrimitiveFactory(int primitive_type) {
    switch (primitive_type) {
    case 0: 
      p = new PrimitiveSphere();
      break;
    case 1: 
      p = new PrimitiveCube();
      break;
    case 2: 
      p = new PrimitiveTeapot();
      break;
    }
  }

  Primitive get() {
    return p;
  }
}

