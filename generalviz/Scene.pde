class Scene {

  ArrayList<PrimitiveGroup> primitive_groups = new ArrayList<PrimitiveGroup>();
  ArrayList<Axis> axes = new ArrayList<Axis>();
  // HUD hud = new HUD();

  Scene(boolean draw_axes_) {
    if (draw_axes_) {
      add_axes();
    }
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

    // Display every Axis in the Scene
    for (Axis a : axes) {
      a.display();
    }

    // hud.display();
  }

  void clear_scene() {
    for (PrimitiveGroup p_g : primitive_groups) {
      p_g.depopulate();
    }
  }

  void add_axes() {
    Axis axis1 = new Axis(new PVector(0, 0, 0), new PVector(1, 0, 0), 40, color(255, 0, 0), 10);
    Axis axis2 = new Axis(new PVector(0, 0, 0), new PVector(0, 1, 0), 60, color(0, 255, 0), 20);
    Axis axis3 = new Axis(new PVector(0, 0, 0), new PVector(0, 0, 1), 60, color(0, 0, 255), 3);


    this.axes.add(axis1);
    this.axes.add(axis2);
    this.axes.add(axis3);
  }

  void remove_axes() {
    this.axes.clear();
  }
}

