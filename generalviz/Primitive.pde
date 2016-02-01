class Primitive {
  PVector location;
  PVector velocity;
  PVector target_location;

  Date date;

  int size;
  String filename;

  Music sound;

  Primitive(PVector location_, int size_) {
    // Primitives represent data binding and have location and size.
    location = location_;
    target_location = location_;
    size = size_;
    velocity = new PVector(0, 0, 0);
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
  
  PrimitiveSphere(PVector location_, int size_) {
    super(location_, size_);
  }
  
  void display() {

    fill(250, 10, 10);

    pushMatrix();
    

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    sphere(size);

    popMatrix();
  }
}

class PrimitiveCube extends Primitive {
    PrimitiveCube(PVector location_, int size_) {
    super(location_, size_);
  }
  
  void display() {
    
    fill(10, 10, 250);

    pushMatrix();

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    box(size);

    popMatrix();
  }
}

class PrimitiveSpike extends Primitive {
    PrimitiveSpike(PVector location_, int size_) {
    super(location_, size_);
  }
  
  void display() {
    
    fill(10, 10, 250);

    pushMatrix();

    PVector l = location.get();
    translate(l.x, l.y, l.z);

    fill(200, 10, 50);
    box(size);
    
    pushMatrix();
    
      rotateX(PI/4);
      rotateY(PI/6);
      rotateZ(PI/8);
      
      fill(200, 10, 50);
      box(size);
    
    popMatrix();
    
    fill(200, 200, 250);
    sphere(size * .75);
    
  
    

    popMatrix();
  }
}


