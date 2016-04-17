class HUD {
  PFont f;
  HUD() {
  }

  void display() {    
    hint(DISABLE_DEPTH_TEST);
    pushMatrix();
    resetMatrix();
    fill(230, 45, 45);
    translate( -50, 50, -100 );
    ellipse( 0, 0, 20, 20 );
    popMatrix();
    hint(ENABLE_DEPTH_TEST);
  }
}

