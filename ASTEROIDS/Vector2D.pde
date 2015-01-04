/**
  Original class by MARK AUSTIN
  Additional functions by ME
*/

import java.lang.Math;

public class Vector2D {

   protected float dX;
   protected float dY;

   // Aka Vector2D.Empty;
   public Vector2D() {
      dX = dY = 0.0;
   }

   public Vector2D( float dX, float dY ) {
      this.dX = dX;
      this.dY = dY;
   }

   // Convert vector to a string ...
    
   public String toString() {
      return "Vector2D(" + dX + ", " + dY + ")";
   }

   // Compute magnitude of vector ....
 
   public double length() {
      return Math.sqrt ( dX*dX + dY*dY );
   }

   // Sum of two vectors ....

   public Vector2D addv( Vector2D v1 ) {
       Vector2D v2 = new Vector2D( this.dX + v1.dX, this.dY + v1.dY );
       return v2;
   }

   // Subtract vector v1 from v .....

   public Vector2D subv( Vector2D v1 ) {
       Vector2D v2 = new Vector2D( this.dX - v1.dX, this.dY - v1.dY );
       return v2;
   }

   // Scale vector by a constant ...

   public Vector2D scalev( float scaleFactor ) {
       Vector2D v2 = new Vector2D( this.dX*scaleFactor, this.dY*scaleFactor );
       return v2;
   }
   
   public Vector2D timesv(Vector2D v1)
   {
       Vector2D v2 = new Vector2D( this.dX*v1.dX, this.dY*v1.dY );
       return v2;
   }
    
   public Vector2D dividev( Vector2D v1 ) {
       Vector2D v2 = new Vector2D( this.dX/v1.dX, this.dY/v1.dY );
       return v2;
   }
   // Normalize a vectors length....

   public Vector2D normalizev() {
      Vector2D v2 = new Vector2D();

      double length = Math.sqrt( this.dX*this.dX + this.dY*this.dY );
      if (length != 0) {
        v2.dX = this.dX/ (float)length;
        v2.dY = this.dY/ (float)length;
      }

      return v2;
   }   

   // Dot product of two vectors .....

   public float dotProduct ( Vector2D v1 ) {
        return this.dX*v1.dX + this.dY*v1.dY;
   }

   // Exercise methods in Vector2D class

   public void Debug ( String args[] ) {
      Vector2D vA = new Vector2D( 1.0, 2.0);
      Vector2D vB = new Vector2D( 2.0, 2.0);
      
      System.out.println( "Vector vA =" + vA.toString() );
      System.out.println( "Vector vB =" + vB.toString() );

      System.out.println( "Vector vA-vB =" + vA.subv(vB).toString() );
      System.out.println( "Vector vB-vA =" + vB.subv(vA).toString() );

      System.out.println( "vA.normalize() =" + vA.normalizev().toString() );
      System.out.println( "vB.normalize() =" + vB.normalizev().toString() );

      System.out.println( "Dot product vA.vB =" + vA.dotProduct(vB) );
      System.out.println( "Dot product vB.vA =" + vB.dotProduct(vA) );
   }
}
