import org.jsfml.audio.*;
import org.jsfml.window.event.*;
import org.jsfml.window.*;
import org.jsfml.system.*;
import org.jsfml.internal.*;
import org.jsfml.graphics.*;

class VRListener {
  PVector location;
  PVector direction;

  VRListener(PVector location_, PVector direction_) {

    // VRListener is just a thin wrap around the Listener object
    // which allows us to render a representation of it.

    location = location_;
    direction = direction_;

    // Listener represents the location and direction of the listener in 3D space
    // It doesn't require instantiation and has only static methods.

    Listener.setPosition(location.x, location.y, location.z);
    Listener.setDirection(direction.x, direction.y, direction.z);
  }

  void display() {
    pushMatrix();

    // Draw a red box representing the location of the listener
    // PVector l = location.get();
    translate(location.x, location.y, location.z);   
    fill(200, 15, 15);
    box(20);
    fill(255);

    // Draw a green line representing the orientation of the listener
    strokeWeight(3);
    stroke(0, 255, 0);
    PVector d = direction.get();
    d.mult(35);    
    line(0, 0, 0, d.x, d.y, d.z);
    noStroke();

    popMatrix();
  }

  void update() {

    if (oculus.isUsingHeadTracking) {
      // Get view matrix from Oculus rift
      PMatrix3D view_matrix = oculus.getMatrix();

      // Fix the rotation
      view_matrix.preApply(
      -1, 0, 0, 0, 
      0, -1, 0, 0, 
      0, 0, 1, 0, 
      0, 0, 0, 0);

      PMatrix3D n = new PMatrix3D();

      // reconstruct a 3x3 for a multiplication on a 3vector
      n.m00 = view_matrix.m00;
      n.m01 = view_matrix.m01;
      n.m02 = view_matrix.m02;
      n.m10 = view_matrix.m10;
      n.m11 = view_matrix.m11;
      n.m12 = view_matrix.m12;
      n.m20 = view_matrix.m20;
      n.m21 = view_matrix.m21;
      n.m22 = view_matrix.m22;

      PVector original = new PVector(0, 0, -1);
      PVector result = new PVector();

      n.mult(original, result);

      direction = result;
    } 

    // Set the position and location of the listener to that of the camera
    Listener.setPosition(location.x, location.y, location.z);
    Listener.setDirection(direction.x, direction.y, direction.z);
  }
}
