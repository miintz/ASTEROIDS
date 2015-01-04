class CollisionManager
{
  Rectangle[] BoundingBox = new Rectangle[4];
  int CurrentPlayerCollision = -1;
  Player player;

  CollisionManager(Player p)
  {  
    player = p;

    BoundingBox[0] = new Rectangle(0, 0, width, 5); //topleft topright
    BoundingBox[1] = new Rectangle(0, 0, 5, height); //topleft bottomleft  
    BoundingBox[2] = new Rectangle(width, 0, 5, height); //topright bottomright
    BoundingBox[3] = new Rectangle(0, height, width, 5); //bottomright bottomleft
  }

  int AsteroidWithBounds(Asteroid A)
  {
    float Axi = A.Position.dX;      
    float Ayi = A.Position.dY;

    Rectangle Ar = new Rectangle((int)Axi, (int)Ayi, 50*A.SIZE, 50*A.SIZE);

    //check collisions with bounds
    for (int bi = 0; bi < BoundingBox.length; bi++)     
    {        
      //collision with one of the walls
      Rectangle Bound = BoundingBox[bi];
      if (Ar.intersects(Bound))
      {
        return bi;
      }
    }

    return -1;
  }

  //collision was a bit weird, so now its more of a pushing thing, works better
  void AsteroidWithAsteroid(Asteroid A, int mutation)
  {
    //A == this
    if (!A.Stopped)
    {
      for (int i = A.UID + 1; i < A.OtherAsteroids.size (); i++) {

        Asteroid Other = A.OtherAsteroids.get(i);

        float dx = Other.Position.dX - A.Position.dX;
        float dy = Other.Position.dY - A.Position.dY;

        float distance = sqrt(dx*dx + dy*dy);      
        float minDist = Other.CollisionDiameter/2 + A.CollisionDiameter/2;

        if (distance < minDist) 
        {        
          float angle = atan2(dy, dx);

          float targetX = A.Position.dX + cos(angle) * minDist;
          float targetY = A.Position.dY + sin(angle) * minDist;

          float ax = (targetX - Other.Position.dX) * A.CollisionSpring;
          float ay = (targetY - Other.Position.dY) * A.CollisionSpring;

          A.CollisionVX -= ax;
          A.CollisionVY -= ay;

          Other.CollisionVX += ax;
          Other.CollisionVY += ay;

          // moshpit of doom is active, nudge the asteroids         
          if (mutation == 0)
          {          
            A.nudge();
            Other.nudge();
          }
        }
      }
    }
  }

  boolean AsteroidWithPlayer(Asteroid A, int index)
  { 
    boolean hasCollision = false;

    Rectangle Ar = new Rectangle((int)A.Position.dX, (int)A.Position.dY, 50 * A.SIZE, 50 * A.SIZE);  
    Rectangle Pr = new Rectangle((int)player.posx, (int)player.posy, 12, 12);

    if (Ar.intersects(Pr)) //zo, veel makkelijker
    {   
      hasCollision = true;      
      if (CurrentPlayerCollision != index)
      {                
        CurrentPlayerCollision = index;
        return true;
      }
    } else
    {
      if (CurrentPlayerCollision == index)
      {
        Rectangle Ar1 = new Rectangle((int)A.Position.dX, (int)A.Position.dY, 50 * A.SIZE, 50 * A.SIZE);  
        Rectangle Pr1 = new Rectangle((int)player.posx, (int)player.posy, 12, 12);

        if (!Ar1.intersects(Pr1)) 
          CurrentPlayerCollision = -1;
      }
    }

    return false;
  }
}

