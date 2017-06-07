



class Shell {
  
  int nSegs;
  float r;
  PImage img;
  ArrayList<PVector> norms;
  
  
  Shell(float rad, int number, PImage texture) {
    nSegs = number; r = rad; img = texture;
    norms = new ArrayList<PVector>();
  }
  
  void display() {
    noStroke();
    fill(200);
    beginShape(QUADS);
    textureMode(NORMAL);
    texture(img);
    
    
    
    float tStep = PI/nSegs;
    float sStep = 2*PI/nSegs;
    
    for(float t = 0; t < PI; t += tStep) {
      for(float s = 0; s < 2*PI; s += sStep) {
        createVertex(t,s);
        createVertex(t+tStep,s);
        createVertex(t+tStep,s+sStep);
        createVertex(t,s+sStep);
      }
    }
    
    endShape();  
  }
  
  void createVertex(float t, float s) {
    float x = pow((4/3f),s) * pow(sin(t),2) * cos(s);
    float y = pow((4/3f),s) * pow(sin(t),2) * sin(s);
    float z = pow((4/3f),s) * sin(t) * cos(t);
    
    
    //PVector norm = new PVector(x,y,z);
    //norm.normalize();
    //norms.add(norm);
    //normal(norm.x,norm.y,norm.z);
    vertex(x,y,z, map(t, 0,PI, 0,1), map(s, 0, 2*PI, 1,0));
  }
  
}