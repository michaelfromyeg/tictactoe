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
boolean gameFinished = false;

//Setup
void setup() {
  size(900, 900);
  background(255,0,122);
  widthGrid = width/3;
  heightGrid = height/3;
  ellipseMode(CORNER); //makes it possible to draw circles inside squares with same code
  reset();
}

//Reset Function
public void reset() {
  gridFilled = 0;
  gameFinished = false;
  for (int rows = 0; rows < numRows; rows++) {
    for (int cols = 0; cols < numCols; cols++) {
      grid[rows][cols] = 0;
    }
  }
}

public void draw() {
  
  columnWin();
  rowWin();

  if (gridFilled == 9) {
    gamesPlayed++;
    reset();
  }
  

  for (int cols = 0; cols < numCols; cols++)
  {
    for (int rows = 0; rows < numRows; rows++)
    {
      stroke(0);
      noFill();
      rect((width/numRows)*rows, cols*height/numCols, width/numRows, height/numCols);
 
      if (grid[rows][cols] == -1) {
        ellipse(cols * widthGrid, rows * heightGrid, widthGrid, heightGrid);
      } 
      else if (grid[rows][cols] == 1) {
        line(cols * widthGrid, rows * heightGrid, (cols+1) * widthGrid, (rows+1) * heightGrid);
        line((cols+1) * widthGrid, rows * heightGrid, cols * widthGrid, (rows+1) * heightGrid);
      } 
      else {
        stroke(0);
        noFill();
        rect((width/numRows)*rows, cols*height/numCols, width/numRows, height/numCols);
      }

    }
  }
  
  textSize(30);
  fill(0);
  text("Your score is " + playerWins, 10, 30); 
  
}

void mouseClicked() {
  
  if (gameFinished) {
   
    reset();
    
  }


  if(columnWin() || rowWin()) {
   
    playerWins++;
    textSize(width/20);
    text("Win",width/2,height/2);
    println("W");
    gameFinished = true;
    
  }
  
  move();
}

void move() {
  int row = mouseY / heightGrid;
  int col = mouseX / widthGrid;

  if (grid[row][col] == 0) {
    grid[row][col] = player;
    gridFilled++;
    player = flipTurn();
  }
}

public int flipTurn() {
  return player = 0 - player;
}

public boolean columnWin() {
  int rows = 0;
  for (int cols = 0; cols < numCols; cols++) {
    if (Math.abs(grid[rows][cols] + grid[rows + 1][cols] + grid[rows + 2][cols]) == 3 ) {
      return true;
    }
  }
  return false;
}

public boolean rowWin() {
  int cols = 0;
  for (int rows = 0; rows < numRows; rows++) {
    if (Math.abs(grid[rows][cols] + grid[rows][cols + 1] + grid[rows][cols + 2]) == 3 ) {
      return true;
    }
  }
  return false;
}