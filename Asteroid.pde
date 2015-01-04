class Asteroid
{
  int TYPE;
  int SIZE;
  int UID;
  
  float SPEED;
  float INITSPEED;
  float px;
  float py;
  float rotangle;    
  float direction;

  float CollisionDiameter;
  float OldCollisionVY;
  float OldCollisionVX;
  float CollisionVX;
  float CollisionVY;
  float CollisionSpring = 0.05;
  
  float friction = -1.0;
  float gravity = 0.03;
  
  Boolean ArnieMode;
  Boolean Nudged;
  Boolean Stopped = false;
  
  ArrayList<Asteroid> OtherAsteroids;
  Vector2D Position = new Vector2D();
  
  Asteroid(int type, int size, int minsize, int speed, int mindspeed, Boolean ARNIE_MODE, ArrayList<Asteroid> Other, int id)
  {    
    OtherAsteroids = Other;
    
    Nudged = false;

    UID = id;
    TYPE = type;
    
    SIZE = size;
    SIZE = (int)ceil(random(minsize, size)); 
    
    SPEED = speed;
    INITSPEED = speed;
    
    CollisionDiameter = 50 * SIZE;
    
    ArnieMode = ARNIE_MODE;  

    if (random(3) < 1.5)      
      Position.dY = height - (50 * SIZE);  
    else
      Position.dY = 50 * SIZE;

    if (random(3) < 1.5)
      Position.dX = (width / (int)ceil(random(5))) + (50 * SIZE);
    else
      Position.dX = 50 * SIZE;      

    rotangle = random(0, PI+PI);
  }

  void draw(boolean stopanimate)
  {    
    Stopped = stopanimate;
    
    pushMatrix(); 
    translate(Position.dX + ((50 * SIZE) / 2), Position.dY + ((50 * SIZE) / 2));
    rotate(rotangle);

    animate();
 
    if (!ArnieMode)
    {
      switch(TYPE)
      {
      case 1:
        image(AsteroidImage1, -((50 * SIZE) / 2), -((50 * SIZE) / 2), 50*SIZE, 50*SIZE);
        break;
      case 2:
        image(AsteroidImage2, -((50 * SIZE) / 2), -((50 * SIZE) / 2), 50*SIZE, 50*SIZE);
        break;
      case 3:
        image(AsteroidImage3, -((50 * SIZE) / 2), -((50 * SIZE) / 2), 50*SIZE, 50*SIZE);
        break;
      }
    } 
    else
    {
      switch(TYPE)
      {
      case 1:
        image(ArnieImage1, -((50 * SIZE) / 2), -((50 * SIZE) / 2), 50*SIZE, 50*SIZE);
        break;
      case 2:
        image(ArnieImage2, -((50 * SIZE) / 2), -((50 * SIZE) / 2), 50*SIZE, 50*SIZE);
        break;
      case 3:
        image(ArnieImage3, -((50 * SIZE) / 2), -((50 * SIZE) / 2), 50*SIZE, 50*SIZE);
        break;
      }
    } 
    
    translate(0, 0);
    popMatrix();    
  }

  void animate()
  {    
    if(!Stopped)
    {
      if (rotangle > PI+PI)
        rotangle = PI / (10 * SPEED);
      else
        rotangle += PI / (10 * SPEED);
  
      if (Nudged)
      {      
        CollisionVY += -(0.00005 * SPEED);
        CollisionVX += -(0.00005 * SPEED);
       
        if(CollisionVX < OldCollisionVX)
        {
          CollisionVX = OldCollisionVX;
          CollisionVY = OldCollisionVY;
          
          OldCollisionVX = CollisionVX;
          OldCollisionVY = CollisionVY;
          
          Nudged = false;
        }
      }
      else
      {            
        CollisionVY += (0.00005 * SPEED);
        CollisionVX += (0.00005 * SPEED);
      }
      
      //add velocity
      Position.dX += CollisionVX;
      Position.dY += CollisionVY;
  
      if (Position.dX + CollisionDiameter / 2 > width) {
        Position.dX = width - CollisionDiameter / 2;
        CollisionVX *= friction;
      } else if (Position.dX - CollisionDiameter/2 < 0) {
        Position.dX = CollisionDiameter/2;
        CollisionVX *= friction;
      }
      if (Position.dY + CollisionDiameter/2 > height) {
        Position.dY = height - CollisionDiameter/2;
        CollisionVY *= friction;
      } else if (Position.dY - CollisionDiameter/2 < 0) {
        Position.dY = CollisionDiameter/2;
        CollisionVY *= friction;
      }
    }
  }

  void nudge()
  { 
    if(!Nudged && !Stopped)
    {
      OldCollisionVX = CollisionVX;
      OldCollisionVY = CollisionVY;
      
      CollisionVX *= 1.3;
      CollisionVY *= 1.3;
      
      Nudged = true;
    }
  }
  
  void speedup()
  {   
    if(!Stopped)
    {
      CollisionVY += (0.00005 * (1.5 * SPEED));
      CollisionVX += (0.00005 * (1.5 * SPEED));
    }
  }
}

