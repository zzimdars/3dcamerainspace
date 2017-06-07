import toxi.audio.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.data.csv.*;
import toxi.data.feeds.*;
import toxi.data.feeds.util.*;
import toxi.doap.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;

Vec3D hori = new Vec3D(1,0,0);
Vec3D vert = new Vec3D(0,1,0);
Vec3D out = new Vec3D(0,0,1);
Vec3D m;
Vec3D axis;
float theta;

float xpos;
float ypos;
float zpos;
float cx, cy, cz;

Vec3D loc;
Vec3D forward;
Vec3D up;

boolean wDown,
        aDown,
        sDown,
        dDown;

boolean drag;

PImage img;
PImage hibbsey;
PImage bg;
ArrayList<Taurus> ts;
Shell s;
SpookyCylinder c;
Taurus t;

void setup() {
  size(960,701, P3D);
  hibbsey = loadImage("Hibbs_Matt.jpg");
  img = loadImage("pattern.jpg");
  bg = loadImage("space.jpg");
  s = new Shell(30,30,hibbsey);
  ts = new ArrayList<Taurus>();
  c = new SpookyCylinder(30,30,hibbsey);
  t = new Taurus(50, 16, img);
  
  for(int i = 0; i < 5; i++) {
    Taurus t = new Taurus(30,16, img);
    ts.add(t);
  }
    
  loc = new Vec3D(0,0,-1000);
  forward = new Vec3D(0,0,200);
  up = new Vec3D(0,1,0);
  
  
  wDown = false;
  aDown = false;
  sDown = false;
  dDown = false;
  
  
  translate(width/2, height/2, 0);
  pushMatrix();
}

void draw() {
  popMatrix();
  background(bg);
  
  noStroke();
  lights();
  fill(255);
  
  if(wDown) {
    loc = loc.add(forward);
  } else if(sDown) {
    loc = loc.sub(forward);
  } else if(aDown) {
    Vec3D cross = up.cross(forward);
    loc = loc.add(cross);
  } else if(dDown) {
    Vec3D cross = up.cross(forward);
    loc = loc.sub(cross);
  }
  
  camera(loc.x, loc.y, loc.z,loc.x+forward.x, loc.y + forward.y, loc.z + forward.z,up.x,up.y,up.z);
  
  pushMatrix();
  scale(40);
  s.display();
  popMatrix();
  translate(500,500,500);
  for(int i = 0; i < ts.size(); i++) {
    ts.get(i).display();
    rotateY(TWO_PI/ts.size());
  }
  translate(-500,-500,-500);
  translate(-250, -100, 50);
  pushMatrix();
  noFill();
  stroke(0,255,0);
  box(500,500,500);
  //rotateY(PI);
  //box(100,400,50);
  //rotateY(-PI);
  //rotateZ(90);
  t.display();
  popMatrix();
  translate(-250, -100, 50);
  
  
  pushMatrix();
}


void mouseDragged() {
  
  drag = true;
  
  if(mouseButton == RIGHT) {
    up.rotateAroundAxis(forward.normalize(), (mouseX-pmouseX)/((float)width/2));
  }
  
  Vec3D cross = forward.cross(up);
  
  forward.rotateAroundAxis(up.normalize(), (pmouseX - mouseX)/((float)width/2));
  forward.rotateAroundAxis(cross.normalize(), (mouseY-pmouseY)/((float)width/2));
  up.rotateAroundAxis(cross.normalize(), (mouseY-pmouseY)/((float)width/2));
}

void mouseReleased() {
  drag = false;
}

void roll() {
  up.rotateAroundAxis(forward.normalize(), 180);
}

void keyPressed() {
  if(key == 'w') {
    wDown = true;
  } else if(key == 'a') {
    aDown = true;
  } else if(key == 's') {
    sDown = true;
  } else if(key == 'd') {
    dDown = true;
  }
}

void keyReleased() {
  if(key == 'w') {
    wDown = false;
  } else if(key == 'a') {
    aDown = false;
  } else if(key == 's') {
    sDown = false;
  } else if(key == 'd') {
    dDown = false;
  }
}