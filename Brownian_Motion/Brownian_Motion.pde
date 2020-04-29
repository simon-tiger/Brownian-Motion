/**
 * Circle Collision with Swapping Velocities
 * by Ira Greenberg. 
 * 
 * Based on Keith Peter's Solution in
 * Foundation Actionscript Animation: Making Things Move!
 */
 
Ball[] balls;
Ball ball;

void setup() {
  size(1280, 720);
  ball = new Ball(360, 360, 90, false);
  ball.velocity = new PVector(0.06, 0);
  ball.col = color(220, 220, 0);
  balls = new Ball[100];
  int count = 0;
  while (count < balls.length) {
    float x = random(12, width-12);
    float y = random(12, height-12);
    
    boolean ok = true;
    
    float ballD = dist(ball.position.x, ball.position.y, x, y);
    if (ballD < 102) {
      ok = false;
    }
    
    for (int i = 0; i < count; i++) {
      float d = dist(balls[i].position.x, balls[i].position.y, x, y);
      if (d < 24) {
        ok = false;
      }
    }
    
    if (ok) {
      balls[count] = new Ball(x, y, 12, false);
      count++;
    }
  }
}

void keyPressed() {
  ball.history.clear();
}

void draw() {
  background(255);
  
  ball.display();

  for (Ball b : balls) {
    b.display();
  }
  
  for (int n = 0; n < 100; n++) {
    ball.update();
    ball.checkBoundaryCollision();
    
    for (Ball b : balls) {
      b.update();
      b.checkBoundaryCollision();
      b.checkCollision(ball);
    }
    
    for (int j = 0; j < balls.length; j++) {
      for (int i = 0; i < j; i++) {
        balls[i].checkCollision(balls[j]);
      }
    }
  }
}
