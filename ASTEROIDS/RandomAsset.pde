class AssetManager
{    
  //so we can keep track of used indices, we dont want double messages
  ArrayList<Integer> firstIndices = new ArrayList<Integer>(); //waarom werkt int eigenlijk niet? is 'int' geen primitive ofzo? gezien de hoofdletters, misschien wel 
  ArrayList<Integer> secondIndices = new ArrayList<Integer>();  
  ArrayList<Integer> fullIndices = new ArrayList<Integer>();  

  protected String[] firstParts = new String[] { 
    "Generating", 
    "Sorting out", 
    "Fiddling with", 
    "Figuring out", 
    "Wrestling", 
    "Manhandling", 
    "Lugging", 
    "Lumping", 
    "Dragging", 
    "Toting", 
    "Hauling", 
    "Finalizing", 
    "Tuning", 
    "Warming up", 
    "Fixing", 
    "Sizing up", 
    "Powering", 
    "Priming", 
    "Shuffling", 
    "Dividing",
    "Enboldening", 
    "Cleaning", 
    "Polishing", 
    "Laying down"
  };

  protected String[] secondParts = new String[] { 
    "10-string guitars", 
    "giant amplifiers", 
    "Death Metal rumbles", 
    "Black Metal screeches", 
    "falsetto voices", 
    "leather jackets", 
    "leather pants", 
    "the Harley Davidson", 
    "the Hot Rod",
    "waraxes", 
    "Thor's hammer", 
    "microphones", 
    "flying V's", 
    "elevator cables", 
    "guitar pedals", 
    "drum skins"
  };

  protected String[] fullEvents = new String[] {
    "Finding Lemmy a drink", 
    "Cleaning Ozzie's glasses", 
    "Polishing Slash' top hat", 
    "Stealing Tompa's trucker cap", 
    "Punching Rob Flynn in the face", 
    "Rugbytackling Tobias Sammet", 
    "Forcing Chris Alvestam to use death-growls", 
    "Using lyrics from the bassist", 
    "Fishing for bass", 
    "Waiting for the drummer to set up", 
    "Gurgling milk to lubricate throat", 
    "Drinking all the remaining beer", 
    "Screaming at the moon"
  };

  protected String[] arnieEvents = new String[] {
    "Getting to the choppa", 
    "Looking for Sarah Connor", 
    "If it bleeds, you can kill it!", 
    "Pointing out that there is no bathroom", 
    "Lying to the bad guy", 
    "Kindly asking to get in the car", 
    "Promising that i'll be back", 
    "Letting off some steam", 
    "Wishing someone goodbye in Spanish", 
    "Getting my ass to Mars", 
    "Explaining that it's not a tumor", 
    "Hitting like a vegetarian", 
    "Wondering what the fuck i did wrong", 
    "Attempting not to look stupid", 
    "Not beign very user-friendly"
  };

  protected String[] specialPower = new String[] {
    "Hood of the Skeletonwitch", 
    "Thor's Might", 
    "Compass of the Labyrinth",
    "Chance's Timepiece"
  };

  protected String[] specialDesc = new String[] {
    "This hood allows you to become temporarily unhittable.", 
    "Thor's Might allows the player to regain health.", 
    "The compass allows the player to speed up.", 
    "Chance's Timepiece allows the player to stop time."
  }; 

  protected String[] mutations = new String[] {
    "Moshpit of Doom", 
    "Fanboys & Groupies", 
    "Pentatonic Scale", 
    "Death Rock"
  };

  protected String[] mutationDesc = new String[] {
    "The asteroids have become involved the epic Moshpit of\nDoom! When bouncing off each other,\nthey will speed up a tad before slowing down again.", 
    "As with all annoying fanboys, the asteroids act eratically\nwhen they get closer! No rest for the wicked!", 
    "The ever popular pentatonic scale has, uhm, caused the\nasteroids to speed up when closing in! Be careful!", 
    "The asteroids have become even more brutal. You\nhave a chance to take more damage when they hit you."
  };

  protected String[] DiffDesc = new String[] {    
    "Heavy Metal is where it all began, it is the primal form of METAL, all started by Black Sabbath.\nThis translates in the easiest difficulty, where the weird projectiles aren't trying too\nhard to kill you. So go for this if you dislike getting battered!", 
    "Next was Trash Metal. The Big Four (Metallica, Anthrax, Megadeath, Slayer) revolutionized\nMETAL with brutal speed, deafening drums and riffs that do the Gods of Metal proud.\nThis is where it gets a bit harder. You actually have to do something here to stay alive! ", 
    "Death Metal. Created by the band Death and expanded upon by bands like At The Gates,\nis among the heaviest of metals, the most gruesome and hard-hitting forms of METAL.\nYou might as well quit now. Or pick another difficulty. Either way, save yourself the trouble!", 
    "Black Metal is the most extreme form of METAL. It is impossible to understand\nthe lyrics, the speed is comical and the production is usually terrible. Black Metal bands\nlove a terrible production. That is why they didn't bother implementing this difficulty level."
  };

  protected String[] OrnamentG = new String[] {
    "img/gui/ornaments/corner/CO1", 
    "img/gui/ornaments/corner/CO2", 
    "img/gui/ornaments/corner/CO3", 
    "img/gui/ornaments/corner/CO4"
  };

  protected String[] DividerG = new String[] {
    "img/gui/ornaments/dividers/D01.png", 
    "img/gui/ornaments/dividers/D02.png", 
    "img/gui/ornaments/dividers/D03.png"
  };

  protected String[] BackgroundG = new String[] {
    "img/gui/background/B01.png", 
    "img/gui/background/B02.png", 
    "img/gui/background/B03.png", 
    "img/gui/background/B04.png", 
    "img/gui/background/B05.png", 
    "img/gui/background/B06.png",
    "img/gui/background/B07.png", 
    "img/gui/background/B08.png"
  };

  String getRandomEvent(Boolean ArnieMode)
  {         
    int generateword = (int)ceil(random(6));    
    boolean gotWord = false; 
    String event = "";

    if (generateword < 4)
    {          
      while (!gotWord)
      {        
        int firstindex = (int)random(firstParts.length);
        int secondindex = (int)random(secondParts.length);

        boolean stop = false;

        for (int i = 0; i< firstIndices.size (); i++)
        {
          if (firstIndices.get(i) == firstindex)
          {
            stop = true;
            break;
          }
        }

        for (int i = 0; i< secondIndices.size (); i++)
        {
          if (secondIndices.get(i) == secondindex)
          {
            stop = true;
            break;
          }
        }

        if (stop)
          continue;
        else
        {    
          firstIndices.add(firstindex);
          secondIndices.add(secondindex);          

          gotWord = true;

          event = firstParts[firstindex] + " " + secondParts[secondindex];
        }
      }

      return event;
    } else
    {
      while (!gotWord)
      {
        int fullIndice = 0;
        if (!ArnieMode)        
          fullIndice = (int)random(fullEvents.length);
        else
          fullIndice = (int)random(arnieEvents.length);

        boolean stop = false;

        for (int i = 0; i< fullIndices.size (); i++)
        {
          if (fullIndices.get(i) == fullIndice)
          {
            stop = true;
            break;
          }
        }

        if (stop)
          continue;
        else
        {        
          if (!ArnieMode)
            event = fullEvents[fullIndice];
          else
            event = arnieEvents[fullIndice];

          fullIndices.add(fullIndice);         

          gotWord = true;
        }
      }

      return event;
    }
  }

  String getDiffDesc(int index)
  {
    return DiffDesc[index];
  }
  

  Object[] getRandomSpecialPower()
  {
    Object[] r = new Object[2];

    int index = (int)random(specialPower.length);    

    r[0] = specialPower[index];

    r[1] = index;
    return r;
  }  

  Object[] getRandomMutation()
  {
    Object[] r = new Object[2];

    int index = (int)random(mutations.length);      
    r[0] = mutations[index];

    r[1] = index;
    return r;
  }

  Object[] getRandomOrnaments()
  {
    Object[] r = new Object[3];

    String ornament = OrnamentG[(int)random(OrnamentG.length)];    
    r[0] = ornament;
    PImage divider = loadImage(DividerG[(int)random(DividerG.length)]); 
    r[1] = divider;
    PImage bg = loadImage(BackgroundG[(int)random(BackgroundG.length)]); 
    r[2] = bg;

    return r;
  }

  String getMutationDesc(int index)
  {
    return mutationDesc[index];
  }

  String getPowerDescription(int index)
  {
    return specialDesc[index];
  }
}

