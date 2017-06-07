class SpookyCylinder {
  
  int nSegs;
  float r;
  PImage img;
  ArrayList<PVector> norms;
  
  
  SpookyCylinder(float rad, int number, PImage texture) {
    nSegs = number; r = rad; img = texture;
    norms = new ArrayList<PVector>();
  }
  
  void display() {
    noStroke();
    fill(200);
    beginShape(QUADS);
    textureMode(NORMAL);
    texture(img);
    
    
    
    float uStep = 2*PI/nSegs;
    float vStep = 2*PI/nSegs;
    
    for(float u = 0; u < 2*PI; u += uStep) {
      for(float v = 0; v < 2*PI; v += vStep) {
        createVertex(u,v);
        createVertex(u+uStep,v);
        createVertex(u+uStep,v+vStep);
        createVertex(u,v+vStep);
      }
    }
    
    endShape();  
  }
  
  void createVertex(float u, float v) {
    //float rad = 250;
    
    float x = r*sin(u);
    float y = r * cos(v);
    float z = v;
    
    
    
    PVector norm = new PVector(x,y,z);
    norm.normalize();
    norms.add(norm);
    normal(norm.x,norm.y,norm.z);
    vertex(x,y,z, map(u, -PI,PI, 0,1), map(v, 0, 2*PI, 1,0));
  }
  
}