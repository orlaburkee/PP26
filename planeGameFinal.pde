Plane[] planes = new Plane[6];
Player player;
int score = 0;
int lives = 3;
boolean gameOver = false;

void setup() {
  size(600, 400);
  player = new Player();
  for (int i = 0; i < planes.length; i++) {
    planes[i] = new Plane();
  }
}

void draw() {
  // Sky background
  background(135, 206, 235);

  // Clouds
  fill(255);
  noStroke();
  ellipse(100, 80, 80, 40);
  ellipse(130, 70, 60, 35);
  ellipse(400, 120, 90, 40);
  ellipse(430, 110, 60, 35);

  // Ground
  fill(100, 180, 100);
  rect(0, 370, width, 30);

  if (!gameOver) {
    score++;

    player.move();
    player.draw();

    for (int i = 0; i < planes.length; i++) {
      planes[i].move();
      planes[i].draw();

      if (planes[i].hits(player)) {
        lives--;
        planes[i].reset();
        if (lives <= 0) gameOver = true;
      }
    }

    fill(0);
    textSize(18);
    text("Score: " + score/60, 10, 25);
    text("Lives: " + lives, 10, 48);

  } else {
    fill(0, 0, 0, 150);
    rect(0, 0, width, height);
    fill(255);
    textSize(36);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2 - 20);
    textSize(20);
    text("Score: " + score/60, width/2, height/2 + 20);
    text("Press R to restart", width/2, height/2 + 50);
    textAlign(LEFT);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    score = 0;
    lives = 3;
    gameOver = false;
    player = new Player();
    for (int i = 0; i < planes.length; i++) {
      planes[i] = new Plane();
    }
  }
}

// Player 
class Player {
  float x = 80;
  float y = height / 2;
  float speed = 4;
  float w = 40;
  float h = 20;

  void move() {
    if (keyPressed) {
      if (keyCode == UP    || key == 'w') y -= speed;
      if (keyCode == DOWN  || key == 's') y += speed;
      if (keyCode == LEFT  || key == 'a') x -= speed;
      if (keyCode == RIGHT || key == 'd') x += speed;
    }
    x = constrain(x, 0, width - w);
    y = constrain(y, 0, height - 30 - h);
  }

  void draw() {
    fill(30, 120, 255);
    noStroke();
    // Body
    triangle(x + w, y + h/2, x, y, x, y + h);
    // Wing
    rect(x + 5, y + h/2 - 4, w * 0.5, 8);
    // Tail
    triangle(x, y, x - 10, y - 8, x, y + 4);
  }
}

// ---- Enemy Plane ----
class Plane {
  float x, y, speed;
  float w = 40;
  float h = 20;

  Plane() {
    reset();
  }

  void reset() {
    x = width + w;
    y = random(20, height - 60);
    speed = random(2, 4 + score / 3000.0);
  }

  void move() {
    x -= speed;
    if (x < -w) reset();
  }

  void draw() {
    fill(220, 50, 50);
    noStroke();
    triangle(x, y + h/2, x + w, y, x + w, y + h);
    rect(x + w * 0.3, y + h/2 - 4, w * 0.4, 8);
    triangle(x + w, y, x + w + 10, y - 8, x + w, y + 4);
  }

  boolean hits(Player p) {
    return x < p.x + p.w && x + w > p.x &&
           y < p.y + p.h && y + h > p.y;
  }
}
