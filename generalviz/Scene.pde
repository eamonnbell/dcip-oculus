class Scene {

  ArrayList<PrimitiveGroup> primitive_groups = new ArrayList<PrimitiveGroup>();
  //  ArrayList<Axis> axes = new ArrayList<axes>();  

  Scene() {
  }

  void update() {
    // Update every PrimitiveGroup in the Scene
    for (PrimitiveGroup p_g : primitive_groups) {
      p_g.update();
    }
  }

  void display() {
    // Display every PrimitiveGroup in the Scene
    for (PrimitiveGroup p_g : primitive_groups) {
      p_g.display();
    }
  }

}
