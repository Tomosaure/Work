package Tests;
import Cluedo.*;

public class testPlateau {

    public static void main(String[] args)  {
        Plateau plateau = new Plateau();       
        Joueur j1 = new Joueur("joueur1", new Position(1, 1));
        Joueur j2 = new Joueur("joueur 2", new Position(20,20));
        Joueur j3 = new Joueur("joueur 3", new Position(21,20));
        System.out.println(j1.getNom()+ " : " +j1.getPos().toString());
        j1.setPos(new Position(5, 6));
        System.out.println(j1.getNom()+ " : " + j1.getPos().toString());
        System.out.println(plateau.getCase(new Position(1, 1)));
        plateau.getCase(new Position(1, 1)).ajouterJoueur(j1);
        System.out.println(plateau.getCase(new Position(1, 1)).joueurPresent());
        System.out.println(plateau.getCase(new Position(2, 1)).joueurPresent());
        plateau.getCase(new Position(1, 1)).ajouterJoueur(j2);
        plateau.getCase(new Position(1, 1)).ajouterJoueur(j3);
        System.out.println(j1.getNom()+ " : " +j1.getPos().toString());
        System.out.println(j2.getNom()+ " : " +j2.getPos().toString());
        System.out.println(j3.getNom()+ " : " +j3.getPos().toString());
    }
}
