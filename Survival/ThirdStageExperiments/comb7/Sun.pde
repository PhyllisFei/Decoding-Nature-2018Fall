class Sun {
  PVector pos, vel, acc;
  float angle, rad, mass, x, y;
  float Rad;
  int c;

  Sun (PVector pos_, float angle_, float Rad_) {
    pos = pos_;
    vel = new PVector();
    acc = new PVector();
    angle = angle_;
    Rad = Rad_;
    mass = random(1, 5);
  }

  void applyForce(PVector force) {
    PVector f = new PVector();
    f = force.copy();
    f.div(mass);
    acc.add( f );
  }

  void applyRestitution(float rest) {
    float value = 1.0 + rest;
    vel.mult(value);
  }

  /*
  void checkCollision(Sun other) {
   PVector vector = PVector.sub(other.pos, pos);
   float distanceSq = vector.magSq();
   // ***** check the collision ***** //
   if (distanceSq < 15 ) { //(rad+other.rad) / (rad+other.rad)) {
     vector.mult(-0.005);
     vector.mult(-5);
     applyForce(vector);
     }
   }
   */

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    angle += 0.003;
    if (rad<2.5)
      rad += .008;

    c = (int) (clr1.length*100*noise(Rad) % clr1.length);
  }

  void display() {
    float alpha = map(pos.y, height/2, height/4*3, 180, 0);
    fill(255, alpha);
    //fill(clr2[c], alpha);

    x = pos.x + random(sin(angle) * Rad * rad - 7, sin(angle) * Rad * rad + 7);
    y = pos.y + random(cos(angle) * Rad * rad - 7, cos(angle) * Rad * rad + 7);
    ellipse( x, y, random(.5, 3), random(.5, 3));
  }
}