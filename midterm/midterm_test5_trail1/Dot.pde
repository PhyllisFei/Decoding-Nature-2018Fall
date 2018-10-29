class Dot {
  PVector pos, vel, acc;
  float mass;
  float rad;

  //float alpha, r, g, b;
  color c = cols[(int)random(cols.length)];

  Dot(float x, float y, float _mass) {
    pos = new PVector (x, y);
    vel = new PVector (0, 0);
    acc = new PVector (0, 0);

    mass = _mass;
    rad = mass*1;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    //float dist = dist(pos.x, pos.y, width/7*5, height/2);
    //if (dist < 300) {
    //  alpha = map(dist, 0, 255, 180, 80);

    //  r = map(dist, 0, 280, 0, 100);
    //  g = map(dist, 280, 0, 200, 110);
    //  b = map(dist, 0, 390, 250, 0);
    //}
  }

  void repel( PVector target) {
    PVector vector = PVector.sub(target, pos);
    float distance = vector.mag();
    if (distance < 100) {
      vector.mult(-0.1); // stage 1
      //vector.mult(0.1 * sin(mass/50)); // stage 2
      applyForce(vector);
    }
    else {
      vector.mult(-.00001 * sin(mass/100));
      applyForce(vector);
    }
  }

  void applyRestitution(float amount) {
    float value = 1.0 + amount;
    vel.mult(value);
  }

  void connectLine1(Dot other) {
    float dist = dist(pos.x, pos.y, other.pos.x, other.pos.y);
    if (dist < 50 && dist > 10) {
      float alpha = map(dist, 0, 600, 100, 0);
      stroke(0, alpha);
      line(pos.x, pos.y, other.pos.x, other.pos.y);
    }
  }

  void connectLine2() {
    float dist = dist(pos.x, pos.y, random(width), random(height));

    if (dist > 150) {
      float alpha = map(dist, 150, 500, 10, 0);
      //float alpha = map(dist, 150, 500, 1, 0);
      stroke(0, alpha);
      strokeWeight(0.01);

      //***** img1.2&1.3_vertical: straight pattern
      //line(x, y+random(-10, 10), x, height/2);

      //***** img1.4_vertical: symmetrical pattern with randomness
      //line(x+random(-80, 80), y+random(-10, 10), x, random(height));

      //***** img1.5_semi-transparent lines as bgc
      line(pos.x+random(-80, 80), pos.y+random(-10, 10), random(pos.x), random(pos.y));
    }
  }

  void display() {
    pushMatrix();
    noStroke();
    //fill(r, g, b, alpha);
    //fill(0, 100);
    fill(c, 150);
    ellipse(pos.x, pos.y, mass*2, mass*3);
    popMatrix();
  }
}
