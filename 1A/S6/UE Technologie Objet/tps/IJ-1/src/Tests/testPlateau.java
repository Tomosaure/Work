package Tests;
import Cluedo.*;

public class testPlateau {
    
    /* test du plateau */
    public static void main(String[] args)  {
        Plateau plateau1 = new Plateau();       
        Joueur j1 = new Joueur("joueur 1", new Position(1, 1));
        Joueur j2 = new Joueur("joueur 2", new Position(20,20));
        Joueur j3 = new Joueur("joueur 3", new Position(21,20));
        System.out.println(j1.getNom()+ " : " +j1.getPos().toString());
        j1.setPos(new Position(5, 6));
        System.out.println(j1.getNom()+ " : " + j1.getPos().toString());
        System.out.println(plateau1.getCase(new Position(1, 1)));
        plateau1.getCase(new Position(1, 1)).ajouterJoueur(j1);
        System.out.println(plateau1.getCase(new Position(1, 1)).joueurPresent());
        System.out.println(plateau1.getCase(new Position(2, 1)).joueurPresent());
        plateau1.getCase(new Position(1, 1)).ajouterJoueur(j2);
        plateau1.getCase(new Position(1, 1)).ajouterJoueur(j3);
        System.out.println(j1.getNom()+ " : " +j1.getPos().toString());
        System.out.println(j2.getNom()+ " : " +j2.getPos().toString());
        System.out.println(j3.getNom()+ " : " +j3.getPos().toString());
        Position p = new Position(23,8);
        System.out.println(plateau1.getCase(p).getClass());
        System.out.println(plateau1.getCase(new Position(6, 4)).getClass());
        System.out.println(plateau1.getCase(new Position(7, 1)).getClass());
        System.out.println(plateau1.getCase(new Position(0, 8)).getClass());
        System.out.println(plateau1.getCase(new Position(0, 6)).getClass());
        int[][] map = new int[2][5];
        for (int i = 0; i < plateau1.getLargeur(); i++) {
            for (int k = 0; k < plateau1.getHauteur(); k++) {
                if (plateau1.getCase(new Position(k,i)).getClass() == plateau1.getCase(p).getClass()) {
                    System.out.print("S ");
                }
                if (plateau1.getCase(new Position(k,i)).getClass() == plateau1.getCase(new Position(6, 4)).getClass()) {
                    System.out.print("P ");
                }
                if (plateau1.getCase(new Position(k,i)).getClass() == plateau1.getCase(new Position(7, 0)).getClass()) {
                    System.out.print("C ");
                }
            }
            System.out.println();
        }
        System.out.println(plateau1.getCase(new Position(7,24)).getClass().getName());
    }
}
