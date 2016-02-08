class Axis {

  PVector origin;
  PVector direction;

  PVector start;
  PVector end;

  color stroke_color;

  Axis(PVector origin_, PVector direction_, int len_, color color_) {
    start = origin_;

    direction = direction_;

    direction.normalize();
    direction.mult(len_);

    end = PVector.add(start, direction_);

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
    
    // Draw ticks
    pushMatrix();
    float axis_length = PVector.sub(this.start, this.end).mag();

    float tick_count = 10.0;

    float tick_spacing = axis_length / tick_count;
    
    println("tick_spacing");
    println(tick_spacing);

    for (float i = 0.0; i < axis_length; i += tick_spacing) {
      PVector extent = PVector.sub(end, start);

      extent.normalize();        
      extent.mult(tick_spacing);

      PVector tick_location = extent;

      translate(tick_location.x, tick_location.y, tick_location.z);

      stroke(255, 255, 255);      
      line(0, -1, -1, 0, 1, 1);
    }
    popMatrix();

    noStroke();
  }
}

