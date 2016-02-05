class Axis {

  PVector origin;
  PVector direction;

  PVector start;
  PVector end;
  
  color stroke_color;

  Axis(PVector origin_, PVector direction_, int len_, color color_) {
    start = origin_;

    direction_.normalize();
    direction_.mult(len_);

    end = direction_;
    
    stroke_color = color_;
  }



  void display() {
    strokeWeight(2);
    stroke(stroke_color);
    // Draw axis line
    line(start.x, start.y, start.z, end.x, end.y, end.z);
    // Draw end arrow

    pushMatrix();


    translate(end.x, end.y, end.z);

    if (end.y == 0.0 && end.z == 0.0) {
      line(0, 0, 0, -3, -3, 0);
      line(0, 0, 0, -3, +3, 0);
    } else if (end.x == 0.0 && end.z == 0.0) {
      line(0, 0, 0, -3, -3, 0);
      line(0, 0, 0, +3, -3, 0);
    } else {
      line(0, 0, 0, -3, 0, -3);
      line(0, 0, 0, +3, 0, -3);
    }

    popMatrix();

    noStroke();
  }
}

