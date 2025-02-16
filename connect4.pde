int w = 7;
int h = 6;
int bs = 100;
int player = 1;
int[][] board = new int[h][w];

void setup() {
  ellipseMode(CORNER);
  size(600, 700);
}

int p(int y, int x) {
  return(y < 0 || x < 0 || y >= h || x >= w) ? 0 : board[y][x];
}

int getWinner() {
  // This checks if 4 in a row horizontally, then that player is the winner.
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      if (p(y, x) != 0 && p(y, x) == p(y + 1, x) && p(y, x) == p(y, x + 2) && p(y, x) == p(y, x + 3)) {
        return p(x, y);
      }
    }
  }
  
  // This checks if 4 in a row vertically, then that player is the winner.
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      if (p(y, x) != 0 && p(y, x) == p(y + 1, x) && p(y, x) == p(y + 2, x) && p(y, x) == p(y + 3, x)) {
        return p(x, y);
      }
    }
  }
  
  // Checks for 4 diagonaly with d = direction.
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      for (int d =- 1; d <= 1; d += 2) {
        if (p(y, x) != 0 && p(y, x) == p(y + 1 * d, x + 1) && p(y, x) == p(y + 2 * d, x + 2)) {
          return p(x, y);
        }
      }
    }
  }
  
  // For the possiblity to still go, if its still possible then return 0.
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      if (p(y, x) == 0) {
        return 0;
      }
    }
  }
  
  return -1;
}

int nextSpace(int x) {
  for (int y = h-1; y > 0; y--) {
    if(board[y][x] == 0) {
       return y;
    }
  }
  
  return -1;
}

float cosInter(float a, float b, float x) {
  float xProg = 0;
  if (x < 0) {
    xProg = 0;
  } else if (x >= 1) {
    xProg = 1;
  } else {
    xProg = 0.5-0.5*cos(x*PI);
  }
  return a+(b-a)*xProg;
}

void mousePressed() {
  int x = mouseX / bs, y = nextSpace(x);
  
  if (y >= 0) {
     board[y][x] = player;
     player = player==1 ? 2:1;
  }
}

void draw() {
  if (getWinner() == 0) {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        fill(255);
        rect(i * bs, j * bs, bs, bs);
        
        if (board[j][i] > 0) {
          fill(board[j][i] == 1 ? 255:0, board[j][i] == 2 ? 255:0, 0);
          ellipse(i * bs, j * bs, bs, bs);
        }
      }
    }
  } else {
    background(0);
    fill(255);
    text("The winner is: " + getWinner() + ". Space to restart the game!", width/2, height/2);
    if (keyPressed && key == ' ') {
      player = 1;
      for (int y = 0; y < h; y++) {
        for (int x = 0; x < w; x++) {
          board[y][x] = 0;
        }
      }
    }
  }
}
