PImage bg,gameover,title,restartHovered,restartNormal,startHovered,startNormal;
PImage cabbage,life,soil,soldier;
PImage groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;

float soldierX,soldierY;
int soldierSpeed;

float cabbageX,cabbageY;

float groundHogX,groundHogY;
boolean downPressed = false,leftPressed = false,rightPressed = false;

final int INITIAL_LIFE_X = 10;
final int LIFE_SPACE = 70;
int lifeAmount = 2;

int block;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 248+144;
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 360+60;

int gameState;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
  gameover = loadImage("img/gameover.jpg");
  title = loadImage("img/title.jpg");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  frameRate(60);
  
  //soldier 
  soldierX= -80;
  soldierY = (80*floor(random(4)))+160;
  soldierSpeed = 2;
  
  //cabbage
  cabbageX = 80*floor(random(8));
  cabbageY = (80*floor(random(4)))+160;
  
  //groundhog
  groundHogX = 320;
  groundHogY = 80;
  block = 80;  
}

void draw() {
  
  //Switch GameState
  switch(gameState){
    
    //Game Start
    case GAME_START:    
      background(title);     
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY<BUTTON_BOTTOM)
      {
        image(startHovered, BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed)
        {
          gameState = GAME_RUN;
        }        
      }else
      {
        image(startNormal,BUTTON_LEFT,BUTTON_TOP);
      }
    break;
      
    // Game Run
    case GAME_RUN:
      background(bg);

      //soil
      image(soil,0,160,640,320);
      
      //grass
      noStroke();
      fill(124, 204, 25);
      rect(0,145,640,15);
      
      //sun
      strokeWeight(5);
      stroke(255, 255, 0);
      fill(253, 184, 19);
      ellipse(590,50,120,120);
      
      // beginning life
      for(float i=0; i<lifeAmount; i++){
        image(life,INITIAL_LIFE_X+LIFE_SPACE*i,10);
      }
      
      //groundhog image
      image(groundhogIdle,groundHogX,groundHogY);
     
      //soldier
      image(soldier,soldierX,soldierY);  
        //move to right
        soldierX += soldierSpeed;
        if(soldierX >=640) soldierX=-80;
        //soldier killed groundhog
        if(soldierX < groundHogX+block && soldierX+block > groundHogX
        && soldierY < groundHogY+block && soldierY+block > groundHogY){
          groundHogX = 320; 
          groundHogY = 80;
          lifeAmount-=1;
          if(lifeAmount <= 0){
            gameState = GAME_LOSE;
          }
        }    
  
      //cabbage
      image(cabbage,cabbageX,cabbageY);
        //groundhod eat cabbage
        if(groundHogX == cabbageX && groundHogY == cabbageY){
          cabbageX = -80;
          lifeAmount+=1; 
        }
      break;
    
    //GAME Lose
    case GAME_LOSE:  
      background(gameover);     
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY<BUTTON_BOTTOM)
      {
        image(restartHovered, BUTTON_LEFT,BUTTON_TOP);
        if(mousePressed)
        {
          gameState = GAME_START;
          lifeAmount = 2;
        }        
      }else
      {
        image(restartNormal,BUTTON_LEFT,BUTTON_TOP);
      }
    break;
  }
}

void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case DOWN:
        downPressed = true;
        groundHogY += block;     
        if(groundHogY >= height-block) groundHogY=height-block;
        
        break;
      case LEFT:
        leftPressed = true;
        groundHogX -= block;
        if( groundHogX <= 0) groundHogX=0;
        break;
      case RIGHT:
        rightPressed = true;
        groundHogX += block;
        if( groundHogX >= width-block) groundHogX=width-block;
        break;
    }
  }
}

void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
