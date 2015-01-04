import ddf.minim.*;
import java.awt.*;
import java.util.*;
import java.awt.geom.Ellipse2D;

AudioPlayer audio;
Minim minim;//audio context

String name = "";
String songprefix;
String TXTFILE = "doc/readme.txt";

int timer = 4;
int timermod = 30;
int framer = 0;
int textfill = #FFFFFF;
int backgroundfill = #000000;
int DiffLevel = -1;
int playtime = 0;

int MODE = 1;
int MINSPEED = 0;
int MINSIZE = 0;
int SIZEVARIATION = 0;
int TYPEVARIATION = 0;
int SPEEDVARIATION = 0;
int ASTEROIDCOUNT = 0;
int SCOREINTERVAL = 0;

PImage CornerOrnamentTL = null;
PImage CornerOrnamentTR = null;
PImage CornerOrnamentBL = null;
PImage CornerOrnamentBR = null;
PImage BackgroundG = null;
PImage StartOrnament = null;
PImage DividerOrnament = null;

Boolean ARNIE_MODE = false;

Object[] mutations;
Object[] specials;

ArrayList<Asteroid> Asteroids = new ArrayList<Asteroid>();

AssetManager namer = new AssetManager();
CollisionManager CManager;
Player player;

void setup()
{
  // we need minim to play METAL
  minim = new Minim(this);
  size(1550, 900);
  frameRate(30);

  ship = loadImage("img/gui/default/SHIPS.png");

  //use these to grab a part of the shipsheet
  int xin = (int) random(1, 20);
  int yin = (int) random(1, 20);
  int getx = xin * 25;
  int gety = yin * 25;

  player = new Player(ship.get(getx, gety, 25, 25));
  CManager = new CollisionManager(player);

  songprefix = "normal";
  Object[] ornaments = namer.getRandomOrnaments();      

  CornerOrnamentTR = loadImage(ornaments[0] + "tr.png");
  CornerOrnamentTL = loadImage(ornaments[0] + "tl.png");
  CornerOrnamentBL = loadImage(ornaments[0] + "bl.png");
  CornerOrnamentBR = loadImage(ornaments[0] + "br.png");

  DividerOrnament = (PImage)ornaments[1];
  BackgroundG = (PImage)ornaments[2];

  EASYIMAGE = loadImage("img/gui/default/EASY.png");
  MEDIUMIMAGE = loadImage("img/gui/default/MEDIUM.png");
  HARDIMAGE = loadImage("img/gui/default/HARD.png");
  BLACKMETALIMAGE = loadImage("img/gui/default/BLACKMETAL.png");
  ESCIMAGE = loadImage("img/gui/default/ESC.png");
  
  AsteroidImage1 = loadImage("img/asteroids/default/ASTEROID1.png");
  AsteroidImage2 = loadImage("img/asteroids/default/ASTEROID2.png");
  AsteroidImage3 = loadImage("img/asteroids/default/ASTEROID3.png");

  ArnieImage1 = loadImage("img/asteroids/arnie/ASTEROID1.png");
  ArnieImage2 = loadImage("img/asteroids/arnie/ASTEROID2.png");

  ArnieImage3 = loadImage("img/asteroids/arnie/ASTEROID3.png");
}

String ratingimg = "";
String ratingdesc = "";
int end = 45;

void draw()
{  
  background(255);

  switch(MODE)  
  {

  case 1:  
    //intro
    background(255);
    fill(#FFFFFF);    

    //epic background image!!
    image(BackgroundG, 0, 0, width, height);

    textSize(24);
    text("Welcome to METAL ASTEROIDS", 100, (height / 2) - 100);
    textSize(14);
    text("Press M to continue \\m/", 100, height / 2);
    text("Press D for INFORMATION!", 100, height / 2 + 30);              
    text("Press ESC to exit", 100, height / 2 + 100);

    player.score = 0;
    player.health = 5;

    //keep flipping the coin...
    specials = namer.getRandomSpecialPower();
    player.special = (Integer)specials[1];
    mutations = namer.getRandomMutation();

    break;
  case 2: 

    fill(0);

    textSize(22);

    //draw corner ornaments    
    image(CornerOrnamentTR, width - 272 / 3, 0, 272 / 3, 280 / 3);
    image(CornerOrnamentTL, 0, 0, 272 / 3, 280 / 3);
    image(CornerOrnamentBR, width - 272 / 3, height - 280 / 3, 272 / 3, 280 / 3);
    image(CornerOrnamentBL, 0, height - 280 / 3, 272 / 3, 280 / 3);

    text("Choose difficulty level \\m/", 100, 100);
    textSize(13);

    text("Heavy Metal", 250, 235);
    image(EASYIMAGE, 100, 185, 100, 100);

    text("Trash Metal", 250, 375);
    image(MEDIUMIMAGE, 100, 325, 100, 100);

    text("Death Metal", 250, 525);
    image(HARDIMAGE, 100, 475, 100, 100); 

    text("Black Metal", 250, 675);
    image(BLACKMETALIMAGE, 100, 625, 100, 100);

    mouseOver();
    break;
  case 3:
    //special power!!!
    background(#FFFFFF);
    fill(0);

    //draw corner ornaments    
    image(CornerOrnamentTR, width - 272 / 2, 0, 272 / 2, 280 / 2);
    image(CornerOrnamentTL, 0, 0, 272 / 2, 280 / 2);
    image(CornerOrnamentBR, width - 272 / 2, height - 280 / 2, 272 / 2, 280 / 2);
    image(CornerOrnamentBL, 0, height - 280 / 2, 272 / 2, 280 / 2);

    //and divider ornament
    image(DividerOrnament, 490, (height / 2) - 95, 455, 30);

    textfill = #FFFFFF;
    backgroundfill = #000000;

    textSize(28);       
    text("Special POWER:", width / 2 - 190, (height / 2) - 190);
    text("Enemy MUTATION:", width / 2 - 190, (height / 2));

    textSize(22);
    text((String)specials[0], width / 2 - 190, height / 2 - 135);
    text((String)mutations[0], width / 2 - 190, height / 2 + 55);

    textSize(16);
    text("Mouse over for details", width / 2 - 190, height / 1.5);
    text("Press M to continue \\m/", width / 2 - 190, height / 1.4);    

    framer++;
    mouseOver();
    break;
  case 4: 
    //create an asteroid list!
    if (Asteroids.size() != ASTEROIDCOUNT) //ASTEROIDCOUNT
    { 
      for (int i = 0; i < ASTEROIDCOUNT; i++)
      {                  
        Asteroid A = new Asteroid((int)ceil(random(TYPEVARIATION)), (int)ceil(random(SIZEVARIATION)), (int)ceil(random(MINSIZE)), (int)ceil(random(SPEEDVARIATION)), (int)ceil(random(MINSPEED)), ARNIE_MODE, Asteroids, Asteroids.size());
        Asteroids.add(A);
      }
    }

    //count down!
    if (frameCount % 30 == 0)
    {
      timer--;
      name = namer.getRandomEvent(ARNIE_MODE);
      if (timer != -1)
      {        
        if (textfill == #FFFFFF)
        {
          textfill = #000000;
          backgroundfill = #FFFFFF;
        } else
        {
          textfill = #FFFFFF;
          backgroundfill = #000000;
        }
      } else
        MODE++;
    }

    background(backgroundfill);
    textSize(32);
    fill(textfill);

    if (timer > 0)     
    { 
      text(name, (width / 2) - 160, (height / 2) - 90);
      text(timer, width / 2, height / 2);
    } else
    {
      textSize(128);
      text("GO!", width / 2.4, height / 2);
      timermod = 5;
    }    

    framer++;

    break;
  case 5: 
    //draw the game!
    player.draw();
    if (framer % INITIALINV != 0)
    {
      //initial invincibility, to account for lackluster programming 
      ellipse(player.posx + 12.5, player.posy + 12.5, 25, 25);
      framer++;
    }    
    
    for (int i = 0; i < Asteroids.size (); i++)
    {
      //check the collision
      CManager.AsteroidWithAsteroid(Asteroids.get(i), (Integer)mutations[1]);      
      
      //draw asteroid      
      Asteroids.get(i).draw(player.special == 3 && player.specialActive == true);
           
      Asteroid A = Asteroids.get(i);
      
      //check collision with player
      if (framer % INITIALINV == 0 && CManager.AsteroidWithPlayer(A, i))
      {
        //if Death Rock is active, calc a change to do more damage...
        //but if Hood of the Skeletonwitch is active, dont do this anyway                
        if ((!player.specialActive && player.special == 0) || player.special != 0)
        {         
          if ((Integer)mutations[1] == 3)
          {
            //Death Rock is active, calc a change for double damage
            float change = random(0, 3);
            if (change > 2.0)
              player.health -= 2;
            else 
              player.health--;
          } else
            player.health--;          

          background(#000000);

          if (player.health == 0)
          {
            fadeMusic();
            MODE++;
          }
        }
      }
    }

    //now for the gui related things
    fill(0);

    //draw score
    textSize(16);
    text("Score: " + player.score, 50, 50);

    //now add to score
    if (playtime % SCOREINTERVAL == 0)
      player.score += 3;

    playtime++;

    //do this last, so the bounding collision gets another go, hopefully preventing 'sticky asteroids'
    for (int index = 0; index < Asteroids.size (); index++)
    {      
      if ((Integer)mutations[1] == 1) //Fanboys
      {
        float dist = dist(player.posx, player.posy, Asteroids.get(index).Position.dX, Asteroids.get(index).Position.dY);
        if (dist < 200)
        {     
          //Ease asteroids towards player, this is similar to the player ease
          float easing = 0.01;
          float targetX = mouseX;
          float dx = targetX - Asteroids.get(index).Position.dX;
          if (abs(dx) > 1) {
            Asteroids.get(index).Position.dX += dx * easing;
          }

          float targetY = mouseY;
          float dy = targetY - Asteroids.get(index).Position.dY;    
          if (abs(dy) > 1) {
            Asteroids.get(index).Position.dY += dy * easing;
          }
        }
      } 

      //Pentatonic Scale, speed up the 'stroids a little bit      
      if ((Integer)mutations[1] == 2)
      {
        float dist = dist(player.posx, player.posy, Asteroids.get(index).Position.dX, Asteroids.get(index).Position.dY);
        if (dist < 200)
        {
          Asteroids.get(index).speedup();
        }
      }
    }
    break;
  case 6: 
    //score rating page  
    background(255);

    getScoreImage();

    textSize(30);
    text(ratingdesc, 150, (height / 2) - 20);
    image(RATING, (width / 2) - 25, (height / 2) - 230, 500, 500);
    textSize(26);
    text("Game over!", 150, (height / 2) - 100);
    textSize(22);
    text("Score rating:", 150, (height / 2) - 70);

    //draw the ornaments...
    image(CornerOrnamentTR, width - 272 / 2, 0, 272 / 2, 280 / 2);
    image(CornerOrnamentTL, 0, 0, 272 / 2, 280 / 2);
    image(CornerOrnamentBR, width - 272 / 2, height - 280 / 2, 272 / 2, 280 / 2);
    image(CornerOrnamentBL, 0, height - 280 / 2, 272 / 2, 280 / 2);

    textSize(16);
    text("Press M to go to start or ESC to quit", 150, height / 1.5);

    break;  
  case -1: //case -1 because its a side screen
  
    //escape screen
    fill(0);
    
    fadeMusic();
    background(255);
    image(ESCIMAGE, (width / 2) - 25, (height / 2) - 230, 500 / 1.5, 658 / 1.5);
    textSize(18);
    text("Are you sure? Press M to return \\m/", 150, (height / 2) - 100);
    textSize(14);
    text("else press ESC again", 150, (height / 2) - 70);

    player.score = 0;

    break;
  case -2: //aaand -2, also side screen 
    //help and information & arnie mode        
    int mai = 150;
    String lines[] = loadStrings(TXTFILE);    
    for (int i = 0; i < lines.length; i++) {
      mai = mai + (35 * i);
      text(lines[i], 50, 50 + (30 * i));
    }

    //set the fill to zip if arnie mode is disabled
    if (ARNIE_MODE)
      fill(0);
    else
      fill(#FFFFFF);

    rect(50, height - 100, 50, 50);
    textSize(24);
    text("ARNIE MODE ENABLED", 130, height - 67);
    textSize(14);

    //reset fill because other stuff else will become invisible, which is bad obviously
    if (!ARNIE_MODE)
      fill(0);
    else
      fill(#FFFFFF);
    break;
  }
}

void keyPressed()
{
  if (MODE == 4)
    player.keyPressed();

  switch(keyCode)
  {
  case 77: //M key
    if (MODE == -1 || MODE == 6) //if at escape screen, put it at intro screen
      MODE = 1;          
    else if (MODE == -2) //if at info screen, move to difficulty selection
      MODE = 2;
    else if (MODE != 2) //if not at info screen just do the normal things
    {
      MODE++;

      Object[] ornaments = namer.getRandomOrnaments();      

      CornerOrnamentTR = loadImage(ornaments[0] + "tr.png");
      CornerOrnamentTL = loadImage(ornaments[0] + "tl.png");
      CornerOrnamentBL = loadImage(ornaments[0] + "bl.png");
      CornerOrnamentBR = loadImage(ornaments[0] + "br.png");

      
      DividerOrnament = (PImage)ornaments[1];
      BackgroundG = (PImage)ornaments[2];

      framer = 0;
    }
    break; 
  case 68: //D key
    if (MODE == 1)
    {
      MODE = -2;
    }
    break;
  case 66: //R key
    if (MODE == -2)
    {      
      if (TXTFILE == "doc/readme.txt")
        TXTFILE = BUGFILE;
      else  
        TXTFILE = READMEFILE;
    }
    break;
  case 27: //ESC key
    if (MODE != -1)
    {
      if (MODE == -2)
        MODE = 1;
      else if (MODE == 2)
        MODE--;
      else      
      {
        MODE = -1;
        player.score = 0;
      }

      key = 0;
    }

    break;
  }
}

void mousePressed()
{  
  if (MODE == 2) //if at difficulty selection
  {
    if ((mouseX > 75 && mouseX < 175) && (mouseY > 185 && mouseY < 275)) { 
      DiffLevel = 1; 
      player.DiffLevel = 1;
      MODE++;

      String musicfile = getMusicName();
      audio = minim.loadFile(musicfile);
      audio.play();

      player.easing = player.easing * DiffLevel;

      timer = 6;
           
      MINSIZE = 1;
      SIZEVARIATION = 3;
      MINSPEED = 2;
      SPEEDVARIATION = 4;
      TYPEVARIATION = 1;
      ASTEROIDCOUNT = 12;
      SCOREINTERVAL = 25;

      Asteroids = new ArrayList<Asteroid>();

      framer = 1;
    }  

    if ((mouseX > 75 && mouseX < 175) && (mouseY > 325 && mouseY < 425)) 
    { 
      DiffLevel = 2; 
      player.DiffLevel = 2;
      MODE++;

      String musicfile = getMusicName();
      audio = minim.loadFile(musicfile);
      audio.play();

      player.easing = player.easing * DiffLevel;

      timer = 6;

      MINSIZE = 2;
      SIZEVARIATION = 3;
      MINSPEED = 2;
      SPEEDVARIATION = 2;
      TYPEVARIATION = 2;
      ASTEROIDCOUNT = 14;
      SCOREINTERVAL = 15;

      Asteroids = new ArrayList<Asteroid>();

      framer = 1;
    }

    if ((mouseX > 75 && mouseX < 175) && (mouseY > 475 && mouseY < 575)) { 
      DiffLevel = 3; 
      player.DiffLevel = 3;

      MODE++;
      String musicfile = getMusicName();
      audio = minim.loadFile(musicfile);
      audio.play();

      player.easing = player.easing * DiffLevel;

      timer = 6;

      MINSIZE = 2;
      SIZEVARIATION = 4;
      MINSPEED = 2;
      SPEEDVARIATION = 4;
      TYPEVARIATION = 3;
      ASTEROIDCOUNT = 15;
      SCOREINTERVAL = 5;

      Asteroids = new ArrayList<Asteroid>();

      framer = 1;
    }
  } else if (MODE == -2) 
  {
    if ((mouseY < (height - 50) && mouseY > (height - 100)) && mouseX < 100 && mouseX > 50)
    {
      //switch boolean
      if (ARNIE_MODE)
      { 
        songprefix = "normal";
        ARNIE_MODE = false;
      } else
      {
        songprefix = "arnie";
        ARNIE_MODE = true;
      }
    }
  } else if (MODE == 5)
  {
    player.mousePressed();
  }
}

void mouseOver()
{
  if (MODE == 2)
  {
    if ((mouseX > 100 && mouseX < 200) && (mouseY > 185 && mouseY < 275)) {
      fill(#000000);
      rect(225, 210, 600, 60);
      fill(#FFFFFF);
      text(namer.getDiffDesc(0), 235, 224);
    }  

    if ((mouseX > 100 && mouseX < 200) && (mouseY > 325 && mouseY < 425)) { 
      fill(#000000);
      rect(225, 346, 600, 60);
      fill(#FFFFFF);
      String a = namer.DiffDesc[1];
      text(namer.getDiffDesc(1), 235, 360);
    }

    if ((mouseX > 100 && mouseX < 200) && (mouseY > 475 && mouseY < 575)) { 
      fill(#000000);
      rect(225, 492, 600, 60);
      fill(#FFFFFF);
      text(namer.getDiffDesc(2), 235, 506);
    }

    if ((mouseX > 100 && mouseX < 200) && (mouseY > 625 && mouseY < 725)) { 
      fill(#000000);
      rect(225, 638, 600, 60);
      fill(#FFFFFF);
      text(namer.getDiffDesc(3), 235, 652);
    }
  } else if (MODE == 3)
  {     
    if ((mouseX > 585 && mouseX < 795) && (mouseY > 285 && mouseY < 325)) {
      textSize(14);
      fill(#000000);
      rect(570, 295, 400, 30);
      fill(#FFFFFF);
      text(namer.getPowerDescription((Integer)specials[1]), 575, 315);
    }  

    if ((mouseX > 585 && mouseX < 775) && (mouseY > 485 && mouseY < 525)) {
      textSize(14); 
      fill(#000000);
      rect(570, 480, 400, 65);
      fill(#FFFFFF);
      text(namer.getMutationDesc((Integer)mutations[1]), 575, 497);
    }
  }
}

void fadeMusic()
{
  if (audio != null)
  {
    //set gain? werkt niet?
    if (audio.hasControl(Controller.VOLUME))    
      audio.setVolume(0.5);
    else  
      audio.setGain(0.5);
  }

  minim.stop();
}

String getMusicName() //random music! might be better off in RandomAsset
{  
  int index = (int)ceil(random(4));
  String musicfile = "music/"+ songprefix + "/" + index + ".mp3"; 
  
  return musicfile;
}

void getScoreImage()
{    
  if (player.score < 50)
  {
    ratingimg = "img/gui/ratings/RATING1.png";
    ratingdesc = "METAL PEDANT";
  } else if (player.score > 50 && player.score < 150)
  {
    ratingimg = "img/gui/ratings/RATING2.png";
    ratingdesc = "METAL FAN";
  } else if (player.score > 150 && player.score < 300)
  {
    ratingimg = "img/gui/ratings/RATING3.png";
    ratingdesc = "METAL WARRIOR";
  } else if (player.score > 300 && player.score < 400)
  {
    ratingimg = "img/gui/ratings/RATING4.png";
    ratingdesc = "BRUTAL";
  } else if (player.score > 400 && player.score < 500)
  {
    ratingimg = "img/gui/ratings/RATING5.png";
    ratingdesc = "ERIC ADAMS";
  } else if (player.score > 500)
  {
    ratingimg = "img/gui/ratings/RATING6.png";
    ratingdesc = "RONNIE JAMES DIO";
  }
  
  RATING = loadImage(ratingimg);
}



