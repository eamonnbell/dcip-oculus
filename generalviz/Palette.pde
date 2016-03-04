class Palette {
  int n;
  ArrayList<Integer> pal = new ArrayList<Integer>();
  
  Palette(int n_) {
    n = n_;
    
    colorMode(HSB, PI, 1.0, 1.0);
    
    for (int i = 0; i < n; i++){
      float theta = i * (PI / n);
      color c = color(theta, 0.8, 0.8);
      pal.add(c);
    }
    
    colorMode(RGB);
  }
}
  
