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
  
  void setColor(color fill_color_) {
    this.fill_color = fill_color_;
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
    l.add(new PVector(width/2, height/2, 0));
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

    pushMatrix();

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    sphere(size);

    popMatrix();
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

    pushMatrix();

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    box(size);

    popMatrix();
  }
}

class PrimitiveSpike extends Primitive {
  PrimitiveSpike(PVector location_, int size_, color fill_color_) {
    super(location_, size_, fill_color_);
  }
  
  PrimitiveSpike() {
  }

  void display() {

    fill(fill_color);

    pushMatrix();

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    fill(fill_color);
    box(size);

    pushMatrix();

    rotateX(PI/4);
    rotateY(PI/6);
    rotateZ(PI/8);

    fill(fill_color);
    box(size);

    popMatrix();

    fill(fill_color);
    sphere(size * .75);


    popMatrix();
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
      p = new PrimitiveSpike();
      break;
    }
  }

  Primitive get() {
    return p;
  }
}

