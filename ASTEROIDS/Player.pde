class Player
{  
  float posx = width / 2;
  float posy = height / 2;
  float easing = 0.05;
  float angle;

  int VectorIndex = 0;
  int DiffLevel;  
  int timer = 0;
  int score;
  int health = 5;
  
  int special;
  int specialTimer;
  int specialCooldown;

  boolean specialActive = false;

  PImage sprite;  

  Vector2D[] LastPositions = new Vector2D[5];

  public Player(PImage sprite1)
  {
    sprite = sprite1;
    specialCooldown = 0;
  }

  public void draw()
  {   
    //save only once in a number of frames
    if (timer % 2 == 0)
    {
      if (VectorIndex == 5)
        VectorIndex = 0;

      LastPositions[VectorIndex] = new Vector2D(posx, posy);   
      VectorIndex++;
    }

    //draw exhaust trail, i know spaceships run on blablabla *gurgle*. dont worry about it k?
    for (int i = 0; i < 5; i++)
    {
      if (LastPositions[i] != null)
      {
        Vector2D v = LastPositions[i];     
        pushMatrix(); 
        
        translate(v.dX + 12.5, v.dY + 12.5);
        rotate(angle);                
        rect(-(i * 2) / 2, -(i * 2) / 2, i * 2, i* 2);         
        //if power is compass, draw the ship again
        if(special == 2 && specialActive == true)
        {                
            image(sprite, -12.5, -12.5, 25, 25);
            easing = 0.15; 
        }
        else
          easing = 0.05 * DiffLevel;
          
        translate(0, 0);

        popMatrix();
      }
    }
    
    timer++;

    float targetX = mouseX;
    float dx = targetX - posx;
    if (abs(dx) > 1) {
      posx += dx * easing;
    }

    float targetY = mouseY;
    float dy = targetY - posy;    
    if (abs(dy) > 1) {
      posy += dy * easing;
    }

    angle = (PI / 2) + atan2(mouseY - posy, mouseX - posx);

    pushMatrix(); 

    translate(posx + 12.5, posy + 12.5);

    rotate(angle);
    
     if(specialCooldown != 0)
      specialCooldown--;
    
    //draw cooldown on screen
    text(specialCooldown, 25, 0);
    
    //and health    
    text(health, -35, 0);

    //see if special is active and reset if needed
    if(specialActive)
    {
      if(specialTimer % 90 == 0)
      {      
        specialActive = false;        
        specialCooldown = 240;
      }
      else
      {
        specialPowerEffects();
        specialTimer++;
      }      
    }
        
    //dont draw if Hood of the Skeletonwitch is active
    if((!specialActive && special == 0) || special == 1 || special == 2 || special == 3) //dit moet uitgezocht worden, lelijkste code ooit
      image(sprite, -12.5, -12.5, 25, 25);
      
      
    translate(0, 0);

    popMatrix();   
  }
  
  void specialPowerEffects()
  {
    //special efx
    
    switch(special)
    {
      case 0: //Hood of the Skeletonwitch
          //just draw a circle aroud the ship. Should do a, if not the, job
          ellipse(0, 0, 35, 35);
      break;
      case 1: //Thor's Might
        //random rectangles to simulate healing powers (or something)
        for(int p = 0; p < 10; p++)
        {
          float size = random(2,7);
          
          float posx = random(2,30);
          float posy = random(2,30);
          
          int invx = (int)round(random(-1,1));
          int invy = (int)round(random(-1,1));
                            
          rect(((posx * 2) / 2) * invx, ((posy * 2) / 2) * invy, size * 2, size * 2);                 
        }     
      break;
      case 4: 
      break;
      default:
      break;
    }
  }
  
  public void mousePressed()
  {
    //activate the SPECIAL POWER! \m/
    if(specialActive == false && specialCooldown == 0)
    {
      specialActive = true;
      specialTimer = 1; //reset the special timer, this only remains active for some time
      
      //if power is thors might, add 1 to health
      if(special == 1)
        player.health += 1;      
      
      
      specialCooldown = 240;
    }    
  }

  public void keyPressed()
  {
    switch(keyCode)
    {
    case 37:
      //      posx--;
      break;
    case 38:
      //      posy--;      
      break;
    case 39: 
      //      posx++;
      break;
    case 40:
      //      posy++;
      break;
    }
  }
}

