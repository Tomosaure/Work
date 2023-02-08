public class ExempleSchema1 {

  public static void main(String[] args) {
    Point p1 = new Point(3.0 , 2.0);
    Point p2 = new Point(11.0 , 4.0);
    Point p3 = new Point(6.0 , 9.0);
    Segment s1 = new Segment(p1, p2);
    Segment s2 = new Segment(p2, p3);
    Segment s3 = new Segment(p1, p3);


    System.out.print("\nSegment 1 : = ");
    s1.afficher();
    System.out.print("\nSegment 2 : = ");
    s2.afficher();;
    System.out.print("\nSegment 3 : = ");
    s3.afficher();
    System.out.println();

   Point barycentre = new Point((p1.getX()+p2.getX()+p3.getX())/3 ,(p1.getY()+p2.getY()+p3.getY())/3);
   System.out.print("barycentre : = ");
   barycentre.afficher();
  }

}
