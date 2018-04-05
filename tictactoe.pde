//Global Variables
int numCols = 3;
int numRows = 3;
int[][] grid = new int [numRows][numCols];
int player = 1;
int widthGrid, heightGrid;
int gridFilled = 0;
int gamesPlayed = 0;
int playerWins = 0;
int playerTies = 0;
int otherWins = 0;
boolean gameFinished = false;
boolean freshStart;

//Setup
void setup() {
  size(900, 900);
  background(255, 255, 255);
  widthGrid = width/3;
  heightGrid = height/3;
  ellipseMode(CORNER); //makes it possible to draw circles inside squares with same code
  reset();
  smooth();
}

//Reset Function
public void reset() {
  freshStart = true;
  player = 1;
  gridFilled = 0;
  gameFinished = false;
  for (int rows = 0; rows < numRows; rows++) {
    for (int cols = 0; cols < numCols; cols++) {
      grid[rows][cols] = 0;
    }
  }
}

public void draw() {

  //Check wins or ties
  columnWin();
  rowWin();
  diagWin();
  eitherTie();

  for (int cols = 0; cols < numCols; cols++)
  {
    for (int rows = 0; rows < numRows; rows++)
    {
      if (grid[rows][cols] == -1) {
        noFill();
        stroke(0, 0, 255);
        ellipse(cols * widthGrid + 10, rows * heightGrid + 10, widthGrid - 20, heightGrid - 20);
      } else if (grid[rows][cols] == 1) {
        noFill();
        stroke(255, 0, 0);
        line(cols * widthGrid + 10, rows * heightGrid + 10, (cols+1) * widthGrid - 10, (rows+1) * heightGrid - 10);
        line((cols+1) * widthGrid - 10, rows * heightGrid + 10, cols * widthGrid + 10, (rows+1) * heightGrid - 10);
      } else {
        stroke(0);
        fill(255, 255, 255);
        rect(cols * widthGrid, rows * heightGrid, widthGrid, heightGrid);
      }
    }
  }

  textAlign(LEFT);
  textSize(25);
  fill(0);
  text("Player 1's score is: " + playerWins, 20, 30); 

  textAlign(CENTER);
  textSize(25);
  fill(0);
  text("The ties are: " + playerTies, 450, 30); 

  textAlign(RIGHT);
  textSize(25);
  fill(0);
  text("Player 2's score is: " + otherWins, 870, 30); 

  if (columnWin() || rowWin() || diagWin()) {
    textAlign(CENTER);
    textSize(width/20);
    text(" We have a winner!", width/2, height/2);

    gameFinished = true;

    if (player == 1) {
      textSize(width/25);
      text("Congrats to Player 2!", width/2, height/2 + 50);
    } else {
      textSize(width/25);
      text("Congrats to Player 1!", width/2, height/2 + 50);
    }
  }

  if (eitherTie()) {
    textAlign(CENTER);
    textSize(width/20);
    text("Calm down everyone. It's just a tie.", width/2, height/2);

    gameFinished = true;
  }

  if (freshStart) {

    fill(0);
    stroke(255);
    rectMode(CENTER);
    rect(width/2, height/2, 350, 60);
    rectMode(CORNER);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Let's play tic tac toe!", width/2, height/2);
    noStroke();
  }
}


void mouseClicked() {

  if (freshStart) {

    freshStart = false;

    for (int cols = 0; cols < numCols; cols++)
    {
      for (int rows = 0; rows < numRows; rows++)
      {
        stroke(0);
        fill(255, 255, 255);
        rect(cols * widthGrid, rows * heightGrid, widthGrid, heightGrid);
      }
    }
  }

  if (!gameFinished) {

    move();
  }

  if (gameFinished) {

    if (columnWin() || rowWin() || diagWin()) { 
      println("W");
      if (player == 1) { 
        otherWins++;
      }
      if (player != 1) { 
        playerWins++;
      }
    } else {
      playerTies++;
      println("T");
    }

    reset();
  }
}


//Move function, which calcs position then changes whose turn it is

void move() {

  int row = mouseY / heightGrid;
  int col = mouseX / widthGrid;
  println(grid[row][col]);

  if (grid[row][col] == 0) {
    grid[row][col] = player;
    gridFilled++;
    player = flipTurn();
  }
}

public int flipTurn() {
  return player = 0 - player;
}

//Check win (column)

public boolean columnWin() {
  int rows = 0;
  for (int cols = 0; cols < numCols; cols++) {
    if (Math.abs(grid[rows][cols] + grid[rows + 1][cols] + grid[rows + 2][cols]) == 3 ) {
      return true;
    }
  }
  return false;
}

//Check win (row)

public boolean rowWin() {
  int cols = 0;
  for (int rows = 0; rows < numRows; rows++) {
    if (Math.abs(grid[rows][cols] + grid[rows][cols + 1] + grid[rows][cols + 2]) == 3 ) {
      return true;
    }
  }
  return false;
}

public boolean diagWin() {

  int diagLR = (grid[0][0] + grid[1][1] + grid [2][2]);
  int diagRL = (grid[2][0] + grid[1][1] + grid [0][2]);

  if (Math.abs(diagLR) == 3 || Math.abs(diagRL) == 3) return true;

  else return false;
}

//Check tie

public boolean eitherTie() {

  if (gridFilled == 9 && !(rowWin() || columnWin() || diagWin())) { 
    return true;
  } else return false;
}